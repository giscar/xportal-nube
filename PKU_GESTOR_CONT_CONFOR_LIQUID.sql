set scan off
CREATE OR REPLACE PACKAGE "PKU_GESTOR_CONT_CONFOR_LIQUID" is

  -- Author  : GMILLONES
  -- Created : 27/05/2009 11:34:32 a.m.
  -- Purpose : 
  
      --consultoria nube migracion
  url_azure_app    varchar2(250):= 'https://zonasegura2.seace.gob.pe/documentos';
  
  gpk_coddoc_liquidacion          number:= 700;
  gpk_directorio_liquidacion      varchar2(50):= 'mon\docs\contratos';
  type ref_cursor is ref cursor;

  PROCEDURE uspLisConformidadLiq
     ( 
       session__N_CONVOCA         varchar2,
       session__cod_contrato      varchar2,
       session__PUBLICADO         varchar2
     );
       
PROCEDURE uspNewLiquidacionDoEdit(
    session__N_CONVOCA       varchar2,
    session__COD_CONTRATO    varchar2,
    --para el archivo
    session__FileSingedHTTP      varchar2,
    session__FileSinged          varchar2,
    ag_ind_ope                   varchar2,
    session__PUBLICADO           varchar2,
    ag_cod_contrato              varchar2,
    ag_accion                    varchar2);
    
PROCEDURE uspLiquidacionDoUpdate(
    ag_n_convoca                 varchar2 DEFAULT Null,
    ag_cod_contrato              varchar2 DEFAULT Null,
    ag_f_liquidacion             varchar2,
    ag_plazo_real                varchar2,
    ag_obs_liquidacion           varchar2,
    ag_cod_tipo_resultado        varchar2,
    ag_cod_mecanismo             varchar2,
    ag_mon_codigo                varchar2,
    ag_monto_liquida             varchar2,
    ag_doc_nombre                varchar2,
    ag_ape_pat_aprobador         varchar2,
    ag_ape_mat_aprobador         varchar2,
    ag_nom_aprobador             varchar2,
    ag_cargo_aprobador           varchar2,
    ag_fec_aprob                 varchar2,
    ag_doc_obs                   varchar2,
    ag_cod_doc                   varchar2,
    pfiletoupload1               VARCHAR2,
    pfiletoupload_file1          VARCHAR2,
    session__userid              varchar2,
    WriteFileDirectoryDynamic    varchar2,
    ag_monto_adicional           varchar2,
    ag_monto_reajuste            varchar2,
    ag_monto_gastos              varchar2,
    ag_monto_penalidades         varchar2,
    ag_monto_contrato            varchar2,
    ag_moneda_contrato           varchar2,
    ag_saldo                     varchar2,
    ag_ind_ope                   varchar2,
    docname__size          VARCHAR2,
    iisenv__remote_host          VARCHAR2
    );

end PKU_GESTOR_CONT_CONFOR_LIQUID;
/


CREATE OR REPLACE PACKAGE BODY "PKU_GESTOR_CONT_CONFOR_LIQUID" is



  PROCEDURE uspLisConformidadLiq
     ( 
       session__N_CONVOCA      varchar2,
       session__cod_contrato   varchar2,
       session__PUBLICADO      varchar2) IS
   
   ------- Listado de Contrato ------
   Cursor c_contratos(p_n_convoca in number, p_n_cod_contrato in number) is
    select distinct
            co.n_convoca,
            c.n_cod_contrato,
            c.n_contrato, 
            c.n_cod_contrato_de_renovac, 
            to_char(c.f_vigencia_ini,'dd/mm/yyyy') f_contrato,
            to_char(pku_ss_utiles.f_get_fecha_fin_amp(c.n_cod_contrato) ,'dd/mm/yyyy') f_culminacion,
            to_char(c.f_liquidacion,'dd/mm/yyyy') f_liquidacion,
            m.descripcion,
            c.m_contratado,
            c.monto_liquidacion,
            c.des_contrato,
            c.plazo, 
            c.cod_operacion_contrato
        from REG_PROCESOS.convocatorias co,
             REG_PROCESOS.contrato c,
             REG_PROCESOS.monedas m,
             REG_PROCESOS.CONTRATO_LIQUIDACION liq
        where c.n_convoca              = p_n_convoca
          and c.n_cod_contrato         = p_n_cod_contrato
          and co.n_convoca             = c.n_convoca
          and c.codmoneda_contrato     = m.codmoneda(+)
          and c.n_cod_contrato         = liq.n_cod_contrato;

   ------- Listado de Complementarios ------
   Cursor c_complements(p_n_convoca in number,
                        p_n_cod_contrato in number) is
    select distinct
            co.n_convoca,
            c.n_cod_contrato,
            c.n_contrato, 
            c.n_cod_contrato_de_renovac, 
            to_char(c.f_Contrato,'dd/mm/yyyy') f_contrato,
            to_char(pku_ss_utiles.f_get_fecha_fin_amp(c.n_cod_contrato) ,'dd/mm/yyyy') f_culminacion,
            to_char(c.f_liquidacion,'dd/mm/yyyy') f_liquidacion,
            m.descripcion,
            c.m_contratado,
            c.monto_liquidacion,
            c.des_contrato,
            c.plazo, 
            c.cod_operacion_contrato
        from REG_PROCESOS.convocatorias co,
             REG_PROCESOS.contrato c,
             REG_PROCESOS.monedas m,
             REG_PROCESOS.CONTRATO_LIQUIDACION liq
        where c.n_convoca                  = p_n_convoca
          and c.n_cod_contrato_de_renovac  = p_n_cod_contrato
          and co.n_convoca                 = c.n_convoca
          and c.codmoneda_contrato         = m.codmoneda(+)
          and c.n_cod_contrato             = liq.n_cod_contrato;

   ------- Variables ------
   e_ArgumentosMalos    exception;
   ln_n_convoca         number;
   ln_cod_contrato      number;
   lv_fecmax_complem    varchar2(50);
   ln_modulo number;        -- (1/3) 12.09.2020 , permite verificar si las acciones sobre el contrato deben estas habilitados

  Begin
  
    if(session__COD_CONTRATO is not null)then
        ln_n_convoca    := session__N_CONVOCA;
        ln_cod_contrato := session__COD_CONTRATO;
    else
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...',
                '')
        );
        return;
    end if;
  -- (2/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
  select F_CON_CONTRATO_MOD('DESACTIVAR', 'ACCIONES',sysdate, session__COD_CONTRATO  ) into ln_modulo from dual;

    if( session__PUBLICADO <> 1 ) then
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Publique el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...',
                '')
     );
       return;    
    end if;
        
    -------- Java Script -------

 PKU_SS_FUNCIONES_JS.js_script('
 function Crear()
    {
      thisform.scriptdo.value = "doViewLiquidacionAmpliacion";
      thisform.submit();
    }
 ');   

    -------- Titulos ------------
    
    usp_print('
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato ( session__COD_CONTRATO, 'Conformidad/Liquidación' )
            || '<td align="right" valign=top width="50%">');
            -- (3/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
            if ln_modulo = 1 then 
               usp_print('<input type="button" value="Crear Liquidación / Conformidad" onclick=Crear()>');
            end if;
    usp_print('</td>');
    usp_print('
            
        </tr>
    </table>
    <br>');
    
  

    ------ Cabecera de Columnas --------
    usp_print('
    <table width=100% class="table table-bordered">
        <tr>
            <td colspan=8>
              <h3>Contrato</h3>
            </td>
        </tr>
        <tr>
            <td class="th1">Nro</td>  
            <td class="th1">Fecha de Inicio</td>  
            <td class="th1">Fecha de Culminaci&oacute;n</td>
            <td class="th1">Fecha de Liquidaci&oacute;n / Conformidad</td>
            <td class="th1">Moneda</td>  
            <td class="th1">Monto Contratado</td>  
            <td class="th1">Monto de Liquidaci&oacute;n / Conformidad</td>  
            <td class="th1">Objeto del Contrato</td>
            
        </tr>
    ');

   for cp in c_contratos(ln_n_convoca,ln_cod_contrato) loop
      begin
         usp_print('
         <tr>
            <td>
              <b>'||makea('scriptdo=doViewLiquidacionAmpliacion&ag_accion=ver&ag_cod_operacion=2&ag_ini_editar=1&ag_n_contrato='||cp.n_contrato||'&ag_n_convoca='||ln_n_convoca||'&ag_cod_contrato='||cp.n_cod_contrato||'&ag_cod_contrato_ren='||cp.n_cod_contrato_de_renovac,cp.n_contrato)||'</b>
            </td>
            <td>'||cp.f_contrato||'</td>
            <td>'||cp.f_culminacion||'</td>
            <td>'||cp.f_liquidacion||'</td>
            <td>'||cp.descripcion||'</td>
            <td>'||cp.m_contratado||'</td>
            <td>'||cp.monto_liquidacion||'</td>            
            <td align="left">'||cp.des_contrato||'</td>

           </tr>
            ');
       end;
   end loop;

   usp_print('
        </table>
        <br/>
        <br/>
        ');

   ------ COMPLEMENTARIO --------
   if (ln_n_convoca is not null) then
       begin
           usp_print('
                <table width=100% class="table table-bordered">
                    <tr>
                        <td colspan=8>
                          <h3>Contrato Complementario</h3>
                        </td>
                    </tr>
                    <tr>
                      <td class="th1">Nro</td>  
                      <td class="th1">Fecha de Inicio</td>  
                      <td class="th1">Fecha de Culminaci&oacute;n</td>
                      <td class="th1">Fecha de Liquidaci&oacute;n / Conformidad</td>
                      <td class="th1">Moneda</td>  
                      <td class="th1">Monto Contratado</td>  
                      <td class="th1">Monto de Liquidaci&oacute;n / Conformidad</td>  
                      <td class="th1">Objeto del Contrato</td>
                    </tr>
                ');

            ------ Obtener la ultima fecha de Complementario ---------------
            select to_char(max(f_contrato), 'dd/mm/yyyy')
            into lv_fecmax_complem
            from REG_PROCESOS.convocatorias co, REG_PROCESOS.contrato c
            where co.n_convoca                   = c.n_convoca
              and c.n_convoca                    = ln_n_convoca
              and c.n_cod_contrato_de_renovac    = ln_cod_contrato
              and c.cod_operacion_contrato       = 6;

              for cc in c_complements(ln_n_convoca,ln_cod_contrato) loop
                begin
                    usp_print('<tr class="TabFilMan" align="center">');
                    if (lv_fecmax_complem!= cc.f_contrato) then
                        usp_print('<td></td>');
                    else
                    usp_print('
                        <td>
                          <b>'||makea('scriptdo=doViewLiquidacionAmpliacion&ag_accion=ver&ag_cod_operacion=6&ag_f_culminacion='||cc.f_culminacion||'&ag_ini_editar=1&ag_n_contrato='||cc.n_contrato||'&ag_n_convoca='||ln_n_convoca||'&ag_cod_contrato='||cc.n_cod_contrato||'&ag_cod_contrato_ren='||cc.n_cod_contrato_de_renovac,cc.n_contrato)||'</b>
                        </td>');
                    end if;
                    usp_print('
                        <td>'||cc.f_contrato||'</td>
                        <td>'||cc.f_culminacion||'</td>
                        <td>'||cc.f_liquidacion||'</td>
                        <td align="left">'||cc.des_contrato||'</td>
                        <td>'||cc.m_contratado||'</td>
                        <td>'||cc.monto_liquidacion||'</td>
                        <td>'||cc.des_contrato||'</td>
                       </tr>
                        ');
                 end;
              end loop;
              usp_print('
                    </table>
                    <br/>
                    <br/>
                    ');
         end;
    end if;

   ---------- Java Script ---------------
    usp_print('
       <script language="javascript">
              function Editar(obj,nconvoca,codcontrato,objScrdo){
                thisform.ag_n_convoca.value=nconvoca;
                thisform.ag_cod_contrato.value=codcontrato;
                thisform.ag_ini_editar.value="1";
                thisform.scriptdo.value=objScrdo;
                thisform.submit();
                return true;
              }

       </script>
     ');

    exception
        when e_ArgumentosMalos then
            raise_application_error(-20000,'Se detecto una incorrecta asignacion de valores en los argumentos');

  End;

/**********************************************************************/
/**********************************************************************/
PROCEDURE uspNewLiquidacionDoEdit(
    session__N_CONVOCA           varchar2,
    session__COD_CONTRATO        varchar2,
    --para el archivo
    session__FileSingedHTTP      varchar2,
    session__FileSinged          varchar2,
    ag_ind_ope                   varchar2,
    session__PUBLICADO           varchar2,
    ag_cod_contrato              varchar2,
    ag_accion                    varchar2)
IS
    ------------ Cursores -------------
   ---- Documentos ------
    Cursor c_docs(pn_convoca in number, pn_cod_doc number) is
    Select
            --datos para mostrar el documento
            to_char(pn_convoca) n_convoca,
            convocatoria_doc.cod_doc,
            tipo_documento.cod_tipo_doc,
            convocatoria_doc.doc_url,
            convocatoria_doc.nro_doc,
            tipo_documento.des_tipo_doc,
            tipo_archivo.des_tipo_file,
            tipo_archivo.icon_tipo_file,
            to_char(convocatoria_doc.fec_upload,'dd/mm/yyyy hh:mi AM') fec_upload,
            convocatoria_doc.user_upload,
            --datos para mostrar los campos guardados en convocatoria_doc
            convocatoria_doc.ape_pat_aprobador,
            convocatoria_doc.ape_mat_aprobador,
            convocatoria_doc.nom_aprobador,
            convocatoria_doc.cargo_aprobador,
            convocatoria_doc.doc_obs
   from tipo_documento
   left outer join convocatoria_doc  on tipo_documento.cod_tipo_doc  = convocatoria_doc.cod_tipo_doc and convocatoria_doc.n_convoca  = pn_convoca and convocatoria_doc.cod_doc    = pn_cod_doc
   left outer join tipo_archivo on convocatoria_doc.cod_tipo_file = tipo_archivo.cod_tipo_file
  where tipo_documento.cod_tipo_doc = gpk_coddoc_liquidacion
  order by tipo_documento.cod_tipo_doc;

 

    ------------ Variables ------------
    ln_n_convoca           number;
    ln_cod_contrato        number;
    ln_objeto              number;
    -------
    lv_anhoentidad         varchar2(50);
    lv_eue_codigo          varchar2(50);
    lv_proc_num            varchar2(15);
    lvdirectorio           varchar2(100);
    lv_ruta_file           varchar2(250);
    --del documento
    ln_ape_pat_aprobador   varchar2(100);
    ln_ape_mat_aprobador   varchar2(100);
    ln_nom_aprobador       varchar2(100);
    ln_cargo_aprobador     varchar2(100);
    ln_doc_obs             varchar2(300);
    ln_doc_url             varchar2(100);
    ln_icon_tipo_file      varchar2(100);
    ln_fec_upload          varchar2(100);
    ln_cod_doc             varchar2(10);
    -- datos del contrato 
    row_contrato           reg_procesos.contrato%rowtype;

    -- Combos
    lv_combo_operacion            varchar2(4000);
    lv_combo_moneda               varchar2(4000);      
    lv_combo_tipomecanismo        varchar2(4000);      
    lv_tipo_resultadoLiq          varchar2(4000);
    lv_Contratos                  varchar2(4000);

    -- Cursores
    ctipooperacion                ref_cursor;
    ctipomecanismo                ref_cursor;
    ctiporesultadoLiq             ref_cursor;
    cmoneda                       ref_cursor;
    cContratos                    ref_cursor;
    

    ln_codmoneda_sel              NUMBER;
    ln_objeto_sel                 NUMBER;
    
    -- Montos sumarizados
    ln_monto_adicional            NUMBER;
    ln_monto_contrato             NUMBER;
    ln_monto_reajuste             NUMBER;
    ln_monto_gastos               NUMBER;
    ln_monto_penalidades          NUMBER;
    
    
    ls_monto_adicional            varchar2(24);
    ls_monto_contrato             varchar2(24);
    ls_monto_reajuste             varchar2(24);
    ls_monto_gastos               varchar2(24);    
    ls_monto_penalidades          varchar2(24);
    
Begin


    ---------- Java Script -------------
    usp_print('
    <script language="javascript">
    
           
    function goSubmit(jscriptdo)
    {
           thisform.scriptdo.value = jscriptdo;
           thisform.submit();
    };
         
    function cambiarEtiqueta(valor){
    
       document.getElementById(''dFecha'').innerHTML = "(*)Fecha"
       document.getElementById(''dMonto'').innerHTML = "(*)Monto"
       document.getElementById(''dCopia'').innerHTML = "(*)Adjuntar Copia";
          
       if (valor== 7){
          document.getElementById(''dFecha'').innerHTML = "(*)Fecha de la Conformidad"
          document.getElementById(''dMonto'').innerHTML = "(*)Monto de la Conformidad"
          document.getElementById(''dCopia'').innerHTML = "(*)Adjuntar Copia de la Conformidad";
       }
       
       if (valor== 8){
          document.getElementById(''dFecha'').innerHTML = "(*)Fecha de la Liquidacion"
          document.getElementById(''dMonto'').innerHTML = "(*)Monto de la Liquidacion"
          document.getElementById(''dCopia'').innerHTML = "(*)Adjuntar Copia de la Liquidacion";      
       }
        
    }
    
    function diasEntre2( as_fec1, as_fec2 )
    {
      fec1 = getDateObject(as_fec1)
      fec2 = getDateObject(as_fec2)
      
      ls_dias = Math.round( fec2.getTime()/86400000 - fec1.getTime()/86400000 ) ;
      return ls_dias;
    }
      
    function dias(obj)
    {
        if ( thisform.f_contrato.value != "" && thisform.ag_f_liquidacion.value != "" && ValidarFechas1( thisform.f_contrato, thisform.ag_f_liquidacion, "Liquidación", "Contrato" ) )
        {
            thisform.ag_plazo_real.value = diasEntre2(thisform.f_contrato.value, thisform.ag_f_liquidacion.value);
            return true;
        }
        else
        {
            alert("Ingrese correctamente la fecha de Liquidación");
            return false;
        }
    }

    function grabar(obj,objScrdo)
    {
        if ( dias(thisform) )
        {
            if ( ValidarBlanco  (thisform.ag_plazo_real      ,"Plazo real") &&  ValidarBlanco  (thisform.ag_obs_liquidacion ,"Observaciones") &&  ValidarBlanco  (thisform.ag_f_liquidacion   ,"Fecha de Liquidación"))
            {
               if ( thisform.ag_ind_ope.value == "-1" || thisform.ag_ind_ope.value == "")
                {
                    alert("Debe seleccionar el Tipo de Operación.");
                    thisform.ag_ind_ope.focus();
                    return false;
                }

                if ( thisform.ag_cod_tipo_resultado.value == "-1" )
                {
                    alert("Debe seleccionar el resultado de las Observaciones.");
                    thisform.ag_cod_tipo_resultado.focus();
                    return false;
                }

                if ( thisform.ag_cod_mecanismo.value == "-1" )
                {
                    alert("Debe seleccionar el mecanismo de solución de la Controversia.");
                    thisform.ag_cod_mecanismo.focus();
                    return false;
                }

                if ( thisform.ag_mon_codigo.value == "-1" )
                {
                    alert("Debe seleccionar la moneda de la Liquidación.");
                    thisform.ag_mon_codigo.focus();
                    return false;
                }

                if( thisform.ag_monto_liquida.value == 0 )
                {
                    alert("Debe ingresar el Monto de la Liquidación");
                    thisform.ag_monto_liquida.focus();
                    return false;
                }

                if (!ValidarBlanco(thisform.ag_ape_pat_aprobador,"Apellido Paterno del Responsable")){
                    return false;
                }
                if (!ValidarBlanco(thisform.ag_ape_mat_aprobador,"Apellido Materno del Responsable")){
                    return false;
                }
                if (!ValidarBlanco(thisform.ag_nom_aprobador,"Nombre del Responsable")){
                    return false;
                }

/*
                if (!ValidarBlanco(thisform.ag_fec_aprob,"Fecha de la Liquidación de Contrato")){
                    return false;
                }
*/

                if ( thisform.ag_ind_archivo.value == 0 )
                {
                    var extension = thisform.pfiletoupload1.value.substring(thisform.pfiletoupload1.value.length-4);
                    extension = extension.replace(".","");
                    if (!ValidarBlanco(thisform.pfiletoupload1,"Documento de Liquidación de Contrato")){
                        return false;
                    }
                    if ( extension == "exe" || extension == "jsp" || extension == "java" || extension == "asp" || extension == "cgi" || extension == "com" || extension == "js" || extension == "class" || extension == "jar" || extension == "vbs" || extension == "aspx" || extension == "dll" || extension == "mp3" || extension == "xml" || extension =="xls" ||extension == "sql" || extension == "txt" )
                    {
                        alert("Lo sentimos, el tipo de archivo que intenta grabar no esta permitido");
                        return false;
                    }
                    var namearchive = "'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'."+extension;
                    thisform.pfiletoupload_file1.value = namearchive;
                    thisform.extension.value = extension;
                }

                thisform.scriptdo.value = objScrdo;
                thisform.submit();


/*
                var lv_f_liquidacion        = thisform.ag_f_liquidacion.value;
                var lv_plazo_real           = thisform.ag_plazo_real.value;
                var lv_obs_liquidacion      = thisform.ag_obs_liquidacion.value;
                var lv_cod_tipo_resultado   = thisform.ag_cod_tipo_resultado.value;
                var lv_cod_mecanismo        = thisform.ag_cod_mecanismo.value;
                var lv_mon_codigo           = thisform.ag_mon_codigo.value;
                var lv_monto_liquida        = thisform.ag_monto_liquida.value;

                window.open(''portlet5open.asp?_portletid_=mod_liquidacion&scriptdo=''+objScrdo+''&ag_n_convoca='||ln_n_convoca||'&ag_cod_contrato='||ln_cod_contrato||'&ag_f_liquidacion='' + lv_f_liquidacion + ''&ag_plazo_real='' + lv_plazo_real + ''&ag_obs_liquidacion='' + lv_obs_liquidacion + ''&ag_cod_tipo_resultado='' + lv_cod_tipo_resultado + ''&ag_cod_mecanismo='' + lv_cod_mecanismo + ''&ag_mon_codigo='' + lv_mon_codigo + ''&ag_monto_liquida='' + lv_monto_liquida,''Archivo_Liquidacion'',''toolbar=no,Width=600,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised'');
*/
            }
        }
    }
    </script>');
    
    
    IF session__COD_CONTRATO IS NOT NULL THEN
    
        ln_n_convoca            := session__N_CONVOCA;
        ln_cod_contrato         := nvl(ag_cod_contrato,session__COD_CONTRATO);
        
    ELSE
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...',
                '')
        );
        return;
    END IF;


    if( session__PUBLICADO <> 1 ) then
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Publique el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...',
                '')
     );
       return;    
    end if;
    
   -------- Funciones Script para Validaciones -------
      pku_procesos_comun.dojscript;
      pku_ss_funciones_js.fFechasGeneral;



    begin
        select * into row_contrato from REG_PROCESOS.contrato c where c.n_cod_contrato = ln_cod_contrato;
    exception
        when no_data_found then
             row_contrato := null;
           
    end;

   ln_monto_adicional      := PKU_SS_UTILES.f_get_sum_monto_adicional(ln_cod_contrato);      
   ln_monto_contrato       := row_contrato.m_contratado;      
   ln_monto_reajuste       := PKU_SS_UTILES.f_get_sum_monto_reajustes(ln_cod_contrato);      
   ln_monto_gastos         := PKU_SS_UTILES.f_get_sum_monto_gastos(ln_cod_contrato);
   ln_monto_penalidades    := PKU_SS_UTILES.f_get_sum_monto_penalidades(ln_cod_contrato);
     
   ls_monto_adicional      := trim(to_char(ln_monto_adicional,pku_ss_constantes.gv_formato_dinero));
   ls_monto_contrato       := trim(to_char(ln_monto_contrato,pku_ss_constantes.gv_formato_dinero));
   ls_monto_reajuste       := trim(to_char(ln_monto_reajuste,pku_ss_constantes.gv_formato_dinero));
   ls_monto_gastos         := trim(to_char(ln_monto_gastos,pku_ss_constantes.gv_formato_dinero));
   ls_monto_penalidades    := trim(to_char(ln_monto_penalidades,pku_ss_constantes.gv_formato_dinero));

  
   --------- Obtener datos de la convocatoria -------
    if (ln_n_convoca is not null) then
        begin
        
         Select 
                convocatorias.anhoentidad,
                convocatorias.codconsucode,
                convocatorias.proc_num,
                convocatorias.codobjeto,
                convocatorias.codmoneda
           into  
                lv_anhoentidad,
                lv_eue_codigo, 
                lv_proc_num,
                ln_objeto,
                ln_codmoneda_sel
            from REG_PROCESOS.convocatorias
            left outer join sease.tipo_proceso on tipo_proceso.tip_codigo = proc_tipo
           where n_convoca = ln_n_convoca;
            
        exception
            when no_data_found then
                lv_anhoentidad:= null;
        end;
    end if;

   --lvdirectorio := gpk_directorio_liquidacion;
   --lv_ruta_file := '\'||lvdirectorio||'\'||lv_anhoentidad||'\'||lv_eue_codigo||'\'||ln_n_convoca;
   lv_ruta_file :=  '\'||gpk_directorio_liquidacion||'\'||lv_anhoentidad||'\'||lv_eue_codigo||'\'||ln_n_convoca;
  

   ------- Convenio Marco -------
   usp_print('
   <input type="hidden" name="ag_n_convoca"                value="'||ln_n_convoca||'"/>');
   --<input type="hidden" name="ag_cod_contrato"             value="'||ln_cod_contrato||'"/>
   usp_print('
   <input type="hidden" name="ag_anhoentidad"              value="'||lv_anhoentidad||'"/>
   <input type="hidden" name="ag_codconsucode"             value="'||lv_eue_codigo||'"/>
   <input type="hidden" name="WriteFileDirectory"          value="FileSinged"/>
   <input type="hidden" name="WriteFileDirectoryDynamic"   value="'||lv_ruta_file||'"/>
   <input type="hidden" name="extension"/>');

   usp_print('
   <input type="hidden" name="ag_monto_adicional"          value="'||ln_monto_adicional||'"/>
   <input type="hidden" name="ag_monto_reajuste"           value="'||ln_monto_reajuste ||'"/>
   <input type="hidden" name="ag_monto_gastos"             value="'||ln_monto_gastos||'"/>
   <input type="hidden" name="ag_monto_penalidades"        value="'||ln_monto_penalidades||'"/>
   <input type="hidden" name="ag_monto_contrato"           value="'||ln_monto_contrato ||'"/>
   <input type="hidden" name="ag_moneda_contrato"          value="'||row_contrato.codmoneda_contrato ||'"/>
   ');
   
   
  -------- Titulos ------------
    usp_print('
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
    
            PKU_SS_UTILES.f_get_titulo_contrato ( session__COD_CONTRATO, 'Conformidad/Liquidación Consentida' )
    );
    usp_print('
            <td align="right" valign=top width="45%">
                <input type="button" value="Volver" onclick="goSubmit(''LisConformidadLiq'')">
                <input type="button" value="Grabar" onclick="grabar(this,''doInsertarLiquidacionAmpliacion'')">
            </td>
        </tr>
  
    </table>
    <br>');

  
           
   ------- Titulo de Cabecera -----
   -- uspConOpeTituloDoView(nvl(ag_cod_contrato,session__COD_CONTRATO),row_contrato.f_liquidacion);

   ------- Se valida si le corresponde una liquidacion o a una Conformidad deacuerdo al tipo de objeto -----
   If (ln_objeto in (1,2,5,6,7,8,9)) Then
        ln_objeto_sel:=7;
   elsif (ln_objeto in (3,4)) Then
        ln_objeto_sel := 8;
   End If;

   ctipooperacion         := pku_ss_utiles.f_tipo_operacion_contrato(ln_objeto_sel);
   ctipomecanismo         := pku_ss_utiles.f_ctipo_mecanismo;
   cmoneda                := pku_ss_utiles.f_cmonedas;
   ctiporesultadoLiq      := pku_ss_utiles.f_ctipo_resultado_liq;
   cContratos             := pku_ss_utiles.f_list_contratos(session__COD_CONTRATO);
       
   lv_combo_operacion     := PKU_SS_UTILES.f_retorna_combo(ctipooperacion, 'ag_ind_ope', nvl(row_contrato.cod_operacion_contrato,ag_ind_ope),'-- Seleccionar --',' style="width:99%" onchange="cambiarEtiqueta(this.value)" ');
   lv_combo_moneda        := PKU_SS_UTILES.f_retorna_combo(cmoneda, 'ag_mon_codigo', nvl(row_contrato.codmoneda_liquidacion,ln_codmoneda_sel),'-- Seleccionar moneda --',' style="width:99%" onclick="dias(this)" disabled ');
   lv_combo_tipomecanismo := PKU_SS_UTILES.f_retorna_combo(ctipomecanismo, 'ag_cod_mecanismo', row_contrato.cod_mecanismo,'-- Seleccionar mecanismo --',' style="width:99%" onclick="dias(this)"  '); 
   lv_tipo_resultadoLiq   := PKU_SS_UTILES.f_retorna_combo(ctiporesultadoLiq, 'ag_cod_tipo_resultado', row_contrato.cod_resultado_liq,'-- Seleccionar resultado --',' style="width:99%" onclick="dias(this)"  ');
   lv_Contratos           := PKU_SS_UTILES.f_retorna_combo(cContratos, 'ag_cod_contrato', to_number(nvl(ag_cod_contrato,session__COD_CONTRATO)),'-- Seleccionar --',' style="width:99%" onchange=" thisform.scriptdo.value =''doViewLiquidacionAmpliacion''; thisform.submit();"  ');
   
   ------- Número del Contrato --------
   usp_print('
    <table width=100% class="table table-striped">');
/*   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero del Contrato (u Orden de Compra o Servicio)',
                '<input type="text" name="n_contrato" readonly style="width:98%" value="'||row_contrato.n_contrato||'"/>',
                '.'));*/
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Tipo de Contrato',
                lv_Contratos,
                '.'));     
                
  if row_contrato.f_liquidacion is not null and  ag_accion is null then
    
   
     IF row_contrato.cod_operacion_contrato = 7 THEN
        usp_print(
            pku_procesos_comun.f_putMensaje(
                '<font color="red">Contrato con Conformidad</font>','')
        );
        usp_print(' </table>');
        return;
        
      ELSIF   row_contrato.cod_operacion_contrato = 8 THEN
        usp_print(
            pku_procesos_comun.f_putMensaje(
                '<font color="red">Contrato con liquidaci&oacute;n consentida</font>','')
        );
                usp_print(' </table>');
        return;
      END IF;
    end if;
                    
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Tipo Operacion',
                lv_combo_operacion,
                'Seleccione el Tipo de Operación'));     

                                                
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('<div id=dFecha>(*)Fecha</div>',
                '<input type="hidden" name="f_contrato" value="'||to_char(row_contrato.f_contrato,'dd/mm/yyyy')||'"/>'||
                '<div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_f_liquidacion" value="'||to_char(row_contrato.f_liquidacion,'dd/mm/yyyy')||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control"/>
          </div>',
                'Seleccione la fecha de liquidaci&oacute;n del contrato.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Plazo Real',
                '<input type="text" name="ag_plazo_real" readonly style="width:98%" value="'||row_contrato.plazo_real||'" style="text-align: right" />',
                'Plazo real del contrato.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Anotaci&oacute;n de Observaciones',
                '<input type="text" name="ag_obs_liquidacion" style="width:98%" maxlenght="90" value="'||row_contrato.obs_liquidacion||'" onclick="dias(this)"/>',
                'Ingrese las anotaciones correspondientes.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Resultado de las observaciones',
                lv_tipo_resultadoLiq,
                'Seleccione el resultado de las observaciones.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Mecanismo de solución de la controversia',
                lv_combo_tipomecanismo,
                'Seleccione el mecanismo de soluci&oacute;n de la controversia.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Moneda',
               lv_combo_moneda,
                'Seleccione la moneda.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Monto del Contrato',
                '<input type="text" name="ag_monto_contrato" readOnly=true style="width:98%" value="'||ls_monto_contrato||'" style="text-align: right" />',
                'Monto del Contrato'));
                
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Adicionales',
                '<input type="text" name="ag_monto_adic" readOnly=true style="width:98%" value="'||ls_monto_adicional||'" style="text-align: right"/>',
                'Monto de Adicionales.'));
    
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Reajustes',
                '<input type="text" name="ag_monto_reajustes" readOnly=true style="width:98%" value="'||ls_monto_reajuste||'" style="text-align: right" />',
                'Monto de Reajustes'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Gastos Generales',
                '<input type="text" name="ag_monto_gastosg" readOnly=true style="width:98%" value="'||ls_monto_gastos||'" style="text-align: right"/>',
                'Monto de Gastos Generales.'));
    
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Penalidades',
                '<input type="text" name="ag_monto_penalidades" readOnly=true style="width:98%" value="'||ls_monto_penalidades||'" style="text-align: right" />',
                'Monto de Penalidades.'));
        
   --inicio ahuanca
   /*
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('<div id=dMonto>(*)Monto</div>',
                '<input type="text" name="ag_monto_liquida" style="width:98%" value="'||row_contrato.monto_liquidacion||'"  style="text-align: right" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this)"/>',
                'Monto de la liquidación.'));
                
   */

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Monto de la Liquidacion',
                '<input type="text" name="ag_monto_liquida" style="width:98%" value="'||row_contrato.monto_liquidacion||'"  style="text-align: right" />',
                'Monto de la liquidación.'));
--fin ahuancac 
   
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Saldo',
                '<input type="text" name="ag_saldo" style="width:98%" value="'||row_contrato.saldo||'" style="text-align: right" />',
                'Monto del Saldo.'));
                
                
                     
   for cd in c_docs(ln_n_convoca,row_contrato.cod_documento_liquidacion) loop
        ln_ape_pat_aprobador    := cd.ape_pat_aprobador;
        ln_ape_mat_aprobador    := cd.ape_mat_aprobador;
        ln_nom_aprobador        := cd.nom_aprobador;
        ln_cargo_aprobador      := cd.cargo_aprobador;
        ln_doc_obs              := cd.doc_obs;
        ln_doc_url              := cd.doc_url;
        ln_icon_tipo_file       := cd.icon_tipo_file;
        ln_fec_upload           := cd.fec_upload;
        ln_cod_doc              := cd.cod_doc;
   end loop;
    -----------------------
    usp_print(
                PKU_PROCESOS_COMUN.f_get_subTitulo('Responsable') );
    
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Apellido Paterno',
                '<input type="text" name="ag_ape_pat_aprobador" style="width:98%" size="60" value="'||ln_ape_pat_aprobador||'"/>',
                'Ingrese el apellido paterno del aprobador.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Apellido Materno',
                '<input type="text" name="ag_ape_mat_aprobador" style="width:98%" size="60" value="'||ln_ape_mat_aprobador||'"/>',
                'Ingrese el apellido materno del aprobador.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Nombre',
                '<input type="text" name="ag_nom_aprobador" style="width:98%" size="60" value="'||ln_nom_aprobador||'"/>',
                'Ingrese el nombre del aprobador.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Cargo',
                '<input type="text" name="ag_cargo_aprobador" style="width:98%" size="50" value="'||ln_cargo_aprobador||'"/>',
                'Ingrese el cargo del aprobador.'));
    usp_print(
                PKU_PROCESOS_COMUN.f_get_subTitulo('Archivo') );

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('<div id=dCopia>(*)Adjuntar Copia</div>',
                '<input type=file name=pfiletoupload1 style="width:100%">
                <input type="hidden" name="pfiletoupload_file1" value="" />'||
                case when ln_doc_url is not null then
                '<br>
                <a target=_blank  href="'||url_azure_app||session__FileSingedHTTP||replace(ln_doc_url,'\','/')||'">
                    <img src="bootstrap/'||replace(ln_icon_tipo_file, 'jpg', 'png')||'" border="0" width="25" height="25"/>
                </a>' end ||
                case when ln_fec_upload is not null then
                ' Registrado el '||ln_fec_upload end,
                'Seleccione el archivo conteniendo la liquidaci&oacute;n del contrato.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaci&oacute;n',
                '<input type="text" name="ag_doc_obs" style="width:98%" size="50" value="'||ln_doc_obs||'"/>',
                'Ingrese las observaciones.'));
    ------------------------
    usp_print('
    </table>
    ');
    if ln_doc_url is not null then
        usp_print('
    <input type="hidden" name="ag_ind_archivo" value="1"/>
    <input type="hidden" name="ag_cod_doc" value="'||ln_cod_doc||'"/>
        ');
    else
        usp_print('
    <input type="hidden" name="ag_ind_archivo" value="0"/>
    <input type="hidden" name="ag_cod_doc" value=""/>
        ');
    end if;

/*
    ------- Documento de Liquidacion --------
    usp_print('
    <br/>
    <Center>');
    for cd in c_docs(ln_n_convoca) loop
    begin
        if cd.doc_url is not null then
            usp_print('
        <a target=_blank href="'||session__FileSingedHTTP||cd.doc_url||'">
            <img src="'||cd.icon_tipo_file||'" border="0" width="30" height="30"/>
        </a>');
            if cd.fec_upload is not null then
                usp_print('
        <br/>Registrado el<br/>'||cd.fec_upload);
            end if;
            usp_print('
        <br/>');
        end if;
    end;
    end loop;
    usp_print('
    </Center>');
*/

End;




/****************************************************************/
PROCEDURE uspLiquidacionDoUpdate(
    ag_n_convoca                 varchar2 DEFAULT Null,
    ag_cod_contrato              varchar2 DEFAULT Null,
    ag_f_liquidacion             varchar2,
    ag_plazo_real                varchar2,
    ag_obs_liquidacion           varchar2,
    ag_cod_tipo_resultado        varchar2,
    ag_cod_mecanismo             varchar2,
    ag_mon_codigo                varchar2,
    ag_monto_liquida             varchar2,
    ag_doc_nombre                varchar2,
    ag_ape_pat_aprobador         varchar2,
    ag_ape_mat_aprobador         varchar2,
    ag_nom_aprobador             varchar2,
    ag_cargo_aprobador           varchar2,
    ag_fec_aprob                 varchar2,
    ag_doc_obs                   varchar2,
    ag_cod_doc                   varchar2,
    pfiletoupload1               VARCHAR2,
    pfiletoupload_file1          VARCHAR2,
    session__userid              varchar2,
    WriteFileDirectoryDynamic    varchar2,
    ag_monto_adicional           varchar2,
    ag_monto_reajuste            varchar2,
    ag_monto_gastos              varchar2,
    ag_monto_penalidades         varchar2,
    ag_monto_contrato            varchar2,
    ag_moneda_contrato           varchar2,
    ag_saldo                     varchar2,
    ag_ind_ope                   varchar2,
    docname__size                VARCHAR2,
    iisenv__remote_host          VARCHAR2
    )
Is
    
    ln_n_convoca              number;
    ln_plazo_real             reg_procesos.contrato.plazo_real%type;
    ln_cod_resultado_liq      reg_procesos.contrato.cod_resultado_liq%type;
    ln_cod_mecanismo          reg_procesos.contrato.cod_mecanismo%type;
    ln_codmoneda_liquidacion  reg_procesos.contrato.codmoneda_liquidacion%type;
    ln_monto_liquidacion      reg_procesos.contrato.monto_liquidacion%type;
    ld_f_liquidacion          reg_procesos.contrato.f_contrato%type;
    lv_codtipofile            VARCHAR2(10);
    ln_convoca_origen         number;
    lv_cod_doc                number;
    lv_codentidad             varchar2(6);
    lvtipodocumento           varchar2(5);
    LN_DOC_LIQ_OLD            number;
Begin



    reg_procesos.pku_ss_funciones_js.js_script('var _error = 0;');

    IF pfiletoupload_file1 IS NOT NULL THEN
        lvtipodocumento := upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));

        BEGIN
            SELECT cod_tipo_file INTO lv_codtipofile FROM Reg_procesos.tipo_archivo WHERE ext_tipo_file = lvtipodocumento;
        EXCEPTION
            WHEN OTHERS THEN
               reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar hallar el tipo de archivo','''doViewLiquidacionAmpliacion''');
        END;

    END IF;

    if ag_n_convoca is not null then
        ln_n_convoca := to_number(ag_n_convoca);
    else
        ln_n_convoca := Null;
    end if;

    if ag_plazo_real is null then
        ln_plazo_real := Null;
    else
        ln_plazo_real:= to_number(ag_plazo_real);
    end if;

    if ag_cod_tipo_resultado is null then
        ln_cod_resultado_liq := Null;
    else
        ln_cod_resultado_liq := to_number(ag_cod_tipo_resultado);
    end if;

    if ag_cod_mecanismo is null then
        ln_cod_mecanismo := Null;
    else
        ln_cod_mecanismo := to_number(ag_cod_mecanismo);
    end if;

    if ag_mon_codigo is null then
        ln_codmoneda_liquidacion := Null;
    else
        ln_codmoneda_liquidacion := to_number(ag_mon_codigo);
    end if;

    if ag_monto_liquida is null then
        ln_monto_liquidacion := Null;
    else
        ln_monto_liquidacion := to_number(ag_monto_liquida);
    end if;

    if ag_f_liquidacion is null then
        ld_f_liquidacion := Null;
    else
        ld_f_liquidacion := to_date(ag_f_liquidacion,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_fecha);
    end if;

    IF ln_n_convoca IS NOT NULL THEN
      BEGIN
          Select n_convoca_origen, codconsucode into  ln_convoca_origen, lv_codentidad from REG_PROCESOS.convocatorias  where n_convoca = ln_n_convoca;
      EXCEPTION
          WHEN OTHERS THEN
             reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar hallar el tipo de archivo','''doViewLiquidacionAmpliacion''');

      END;
    END IF;


    SELECT COUNT(1) INTO LN_DOC_LIQ_OLD FROM CONVOCATORIA_DOC WHERE N_CONVOCA = ag_n_convoca AND N_COD_CONTRATO = ag_cod_contrato AND COD_TIPO_DOC = 700;
    
    IF LN_DOC_LIQ_OLD = 0 THEN
      BEGIN
        INSERT INTO REG_PROCESOS.convocatoria_doc (n_convoca, cod_tipo_doc, doc_url, cod_tipo_file, doc_nombre,user_upload, ip_from_upload, nro_doc, ape_pat_aprobador,ape_mat_aprobador, nom_aprobador, cargo_aprobador, fec_aprob,doc_obs, tamano_bytes,N_COD_CONTRATO )
        VALUES( ln_n_convoca, gpk_coddoc_liquidacion, WriteFileDirectoryDynamic||pfiletoupload_file1,lv_codtipofile, pfiletoupload_file1, session__userid, iisenv__remote_host, pfiletoupload_file1,ag_ape_pat_aprobador, ag_ape_mat_aprobador, ag_nom_aprobador, ag_cargo_aprobador, to_date(ag_f_liquidacion,'dd/mm/yyyy'), ag_doc_obs, docname__size,ag_cod_contrato );
      EXCEPTION
          WHEN OTHERS THEN
             reg_procesos.pku_ss_mod_contratos.f_msg_error('Error al intentar registrar el documento','''doViewLiquidacionAmpliacion''');

      END;    
    ELSE


      UPDATE REG_PROCESOS.convocatoria_doc
         SET ape_pat_aprobador   = ag_ape_pat_aprobador,
             ape_mat_aprobador   = ag_ape_mat_aprobador,
             nom_aprobador       = ag_nom_aprobador,
             cargo_aprobador     = ag_cargo_aprobador,
             fec_aprob           = to_date(ag_f_liquidacion,'dd/mm/yyyy'),
             doc_obs             = ag_doc_obs
       WHERE cod_doc             = ag_cod_doc;
        
      IF pfiletoupload_file1 IS NOT NULL THEN 
        UPDATE REG_PROCESOS.convocatoria_doc
             SET doc_url             = WriteFileDirectoryDynamic||pfiletoupload_file1, 
                 cod_tipo_file       = lv_codtipofile,
                 doc_nombre          = pfiletoupload_file1,
                 user_upload         = session__userid,        
                 ip_from_upload      = iisenv__remote_host,     
                 nro_doc             = pfiletoupload_file1, 
                 tamano_bytes        = docname__size                 
           WHERE cod_doc             = ag_cod_doc;       
       
     END IF;
    END IF;

    SELECT doc.cod_doc cod_doc INTO lv_cod_doc
                FROM reg_procesos.CONVOCATORIA_DOC doc         
                  WHERE doc.cod_tipo_doc = 700
                    AND doc.n_convoca = ln_n_convoca
                    AND doc.n_cod_contrato = TO_NUMBER(ag_cod_contrato);
                    
    UPDATE REG_PROCESOS.contrato
       SET f_liquidacion             = ld_f_liquidacion,
           plazo_real                = ln_plazo_real,
           obs_liquidacion           = ag_obs_liquidacion,
           cod_resultado_liq         = ln_cod_resultado_liq,
           cod_mecanismo             = ln_cod_mecanismo,
           codmoneda_liquidacion     = ln_codmoneda_liquidacion,
           monto_liquidacion         = ln_monto_liquidacion,
           cod_documento_liquidacion = TO_NUMBER(lv_cod_doc),
           saldo                     = ag_saldo,
           cod_operacion_contrato    = ag_ind_ope
     WHERE n_cod_contrato            = TO_NUMBER(ag_cod_contrato);

   -- Historial de liquidaciones
   INSERT INTO REG_PROCESOS.CONTRATO_LIQUIDACION
          (n_cod_contrato, monto_liquidacion, m_contratado, monto_adicionales, monto_reajustes, m_gastos, m_penalidades, f_registro, codmoneda)
   VALUES
          (TO_NUMBER(ag_cod_contrato),ag_monto_liquida,ag_monto_contrato,ag_monto_adicional,ag_monto_reajuste,ag_monto_gastos, ag_monto_penalidades,sysdate, ag_moneda_contrato);

   COMMIT;

    
    usp_print('
    <input type="hidden" name="ag_n_convoca"            value="'||ag_n_convoca||'"/>
    <input type="hidden" name="ag_cod_contrato"         value="'||ag_cod_contrato||'"/>
    <input type="hidden" name="ag_doc_obs"              value="'||ag_doc_obs||'"/>
    <input type="hidden" name="ag_f_liquidacion"        value="'||ag_f_liquidacion||'"/>
    <input type="hidden" name="ag_plazo_real"           value="'||ag_plazo_real||'"/>
    <input type="hidden" name="ag_obs_liquidacion"      value="'||ag_obs_liquidacion||'"/>
    <input type="hidden" name="ag_cod_tipo_resultado"   value="'||ag_cod_tipo_resultado||'"/>
    <input type="hidden" name="ag_cod_mecanismo"        value="'||ag_cod_mecanismo||'"/>
    <input type="hidden" name="ag_mon_codigo"           value="'||ag_mon_codigo||'"/>
    <input type="hidden" name="ag_monto_liquida"        value="'||ag_monto_liquida||'"/>
    <input type="hidden" name="ag_doc_nombre"           value="'||ag_doc_nombre||'"/>
    <input type="hidden" name="ag_ape_pat_aprobador"    value="'||ag_ape_pat_aprobador||'"/>
    <input type="hidden" name="ag_ape_mat_aprobador"    value="'||ag_ape_mat_aprobador||'"/>
    <input type="hidden" name="ag_nom_aprobador"        value="'||ag_nom_aprobador||'"/>
    <input type="hidden" name="ag_fec_aprob"            value="'||ag_fec_aprob||'"/>
    <input type="hidden" name="pfiletoupload_file1"                 value="'||pfiletoupload_file1||'"/>
    <input type="hidden" name="ag_grabo_liquidacion"    value="1"/>
    
    <script>
        thisform.scriptdo.value = "LisConformidadLiq";
        if (_error ==0 ) thisform.submit();
    </script>');

End;


/*******************************************************************/
PROCEDURE uspUplFileLiqConDoEdit(
    ag_n_convoca                 varchar2 DEFAULT Null,
    ag_cod_contrato              varchar2 DEFAULT Null,
    ag_f_liquidacion             varchar2,
    ag_plazo_real                varchar2,
    ag_obs_liquidacion           varchar2,
    ag_cod_tipo_resultado        varchar2,
    ag_cod_mecanismo             varchar2,
    ag_mon_codigo                varchar2,
    ag_monto_liquida             varchar2,
    pfiletoupload1               VARCHAR2,
    pfiletoupload_file1          VARCHAR2,
    session__maxMBUploadFileSize varchar2,
    docname__mime                varchar,
    session__FileSingedHTTP      varchar2,
    session__FileSinged          varchar2,
    WriteFileDirectoryDynamic    varchar2,
    session__userid              varchar2)
IS
    -------- Variables ---------
    ln_n_convoca      number;
    ln_cod_contrato   number;
    lv_anhoentidad    varchar2(50);
    lv_eue_codigo     varchar2(50);
    lv_proc_sigla_m   varchar2(50);
    lv_tip_abrev      varchar2(30);
    lv_proc_num       varchar2(15);
    lvdirectorio      varchar2(100);
    lv_ruta_file      varchar2(250);

BEGIN
   
    ln_n_convoca        := to_number(ag_n_convoca);
    ln_cod_contrato     := to_number(ag_cod_contrato);

    --------- Obtener datos de la convocatoria -------
    if (ln_n_convoca is not null) then
        begin
            Select
                REG_PROCESOS.F_RENAME_SIGLA(convocatorias.proc_sigla),
                tipo_proceso.tip_abrev, convocatorias.anhoentidad,
                convocatorias.codconsucode,convocatorias.proc_num
            into
                lv_proc_sigla_m, lv_tip_abrev, lv_anhoentidad,
                lv_eue_codigo, lv_proc_num
            from
                REG_PROCESOS.convocatorias
                left outer join sease.tipo_proceso
                    on tipo_proceso.tip_codigo = proc_tipo
            where
                n_convoca = ln_n_convoca;
        exception
            when no_data_found then
                lv_proc_sigla_m:= null;
        end;
    end if;

--    lvdirectorio := gpk_directorio_liquidacion;
--    lv_ruta_file := lvdirectorio||'\'||lv_anhoentidad||'\'||lv_eue_codigo||'\'||ln_n_convoca;
    lv_ruta_file := '\'||gpk_directorio_liquidacion||'\'||lv_anhoentidad||'\'||lv_eue_codigo||'\'||ln_n_convoca;    
          

    -------- Funciones Script para Validaciones -------
    REG_PROCESOS.PKU_SS_FUNCIONES_JS.fValidaCadenas_JS;
    ------------ Campos ocultos ------------
    usp_print('
    <input type="hidden" name="ag_n_convoca"               value="'||ln_n_convoca||'"/>
    <input type="hidden" name="ag_cod_contrato"            value="'||ln_cod_contrato||'"/>
    <input type="hidden" name="ag_anhoentidad"             value="'||lv_anhoentidad||'"/>
    <input type="hidden" name="ag_codconsucode"            value="'||lv_eue_codigo||'"/>
    <input type="hidden" name="ag_f_liquidacion"           value="'||ag_f_liquidacion||'"/>
    <input type="hidden" name="ag_plazo_real"              value="'||ag_plazo_real||'"/>
    <input type="hidden" name="ag_obs_liquidacion"         value="'||ag_obs_liquidacion||'"/>
    <input type="hidden" name="ag_cod_tipo_resultado"      value="'||ag_cod_tipo_resultado||'"/>
    <input type="hidden" name="ag_cod_mecanismo"           value="'||ag_cod_mecanismo||'"/>
    <input type="hidden" name="ag_mon_codigo"              value="'||ag_mon_codigo||'"/>
    <input type="hidden" name="ag_monto_liquida"           value="'||ag_monto_liquida||'"/>
    <input type="hidden" name="WriteFileDirectory"         value="FileSinged"/>
    <input type="hidden" name="WriteFileDirectoryDynamic"  value="'||lv_ruta_file||'"/>
    <input type="hidden" name="extension"/>');
    
    ------------- Campos de Datos ----------
    usp_print('
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>
            <td colspan="2">
                <h3>Registro de la Liquidación de Contratos</h3>
            </td>
        </tr>
        <tr><td>&nbsp;</td></tr>');
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Convocatoria',
                lv_tip_abrev||'-'||lv_proc_num||'-'||lv_anhoentidad||'-'||lv_proc_sigla_m,
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Liquidación de Contrato',
                '<input type="text" name="ag_doc_nombre" style="width:98%" size="50"/>',
                '.'));
    usp_print(
                PKU_PROCESOS_COMUN.f_get_subTitulo('Responsable') );
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Apellido Paterno',
                '<input type="text" name="ag_ape_pat_aprobador" style="width:98%" size="60"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Apellido Materno',
                '<input type="text" name="ag_ape_mat_aprobador" style="width:98%" size="60"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Nombre',
                '<input type="text" name="ag_nom_aprobador" style="width:98%" size="60"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Cargo',
                '<input type="text" name="ag_cargo_aprobador" style="width:98%" size="50"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Fecha de la Liquidación de Contrato',
                '<input readonly name="ag_fec_aprob" style="width:90%" class=CalSelect onclick="calendario(this)">',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaci&oacute;n',
                '<input type="text" name="ag_doc_obs" style="width:98%" size="50"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Adjuntar Copia de la Liquidación de Contratos',
                '<input type=file name=pfiletoupload1 style="width:100%">',
                'Seleccione el archivo conteniendo la liquidaci&oacute;n del contrato.'));
    usp_print('
          <tr valign="MIDDLE">
               <td colspan="2" align="center">
               '||REG_PROCESOS.PKU_XPORTAL_UTILS.UFUTIL_MKBTM('PKU_SS_CONFORMIDAD_LIQ.uspLiquidacionDoUpdate','enviar','enviar(this,')||'
               </td>
          </tr>
        </table>
     ');

     --------------- Java Script -------------
     usp_print('
         <script LANGUAGE="Javascript">
                function enviar(obj,objScrdo)
                {
                     var extension = thisform.pfiletoupload_file1.value.substring(thisform.pfiletoupload_file1.value.length-4);
                     extension = extension.replace(".","");
                     if (!ValidarBlanco(thisform.ag_ape_pat_aprobador,"Apellido Paterno del Responsable")){
                          return false;
                     }
                     if (!ValidarBlanco(thisform.ag_ape_mat_aprobador,"Apellido Materno del Responsable")){
                          return false;
                     }
                     if (!ValidarBlanco(thisform.ag_nom_aprobador,"Nombre del Responsable")){
                          return false;
                     }
                     if (!ValidarBlanco(thisform.ag_fec_aprob,"Fecha de la Liquidación de Contrato")){
                          return false;
                     }
                     if (!ValidarFecha(thisform.ag_fec_aprob,"Fecha de la Liquidación de Contrato")){
                          return false;
                     }
                     if (!ValidarBlanco(thisform.pfiletoupload_file1,"Seleccione un documento")){
                          return false;
                     }
                     if ( extension == "exe" || extension == "jsp" || extension == "java" ||
                         extension == "asp" || extension == "cgi" || extension == "com" ||
                         extension == "js" || extension == "class" || extension == "jar" ||
                         extension == "vbs" || extension == "aspx" || extension == "dll" ||
                         extension == "mp3" || extension == "xml" || extension =="xls" ||
                         extension == "sql" || extension == "txt"
                        )
                    {
                        alert("Lo sentimos, el tipo de archivo que intenta grabar no esta permitido");
                        return false;
                    }
                    else  
                    {
                        thisform.extension.value = extension;
                        thisform.scriptdo.value = objScrdo;
                        thisform.submit();
                        
                    }
                }
                </script>');

   END;

  
end PKU_GESTOR_CONT_CONFOR_LIQUID;
/
