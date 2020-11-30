set scan off
CREATE OR REPLACE PACKAGE PKU_GESTOR_CONT_GARANTIAS is

 --consultoria nube migracion
  url_azure_app    varchar2(250):= 'https://zonasegura2.seace.gob.pe/documentos/';
  
  type ref_cursor is ref cursor;

  FUNCTION f_valida_inicio(ag_nconvoca number) RETURN NUMBER;
  
  FUNCTION f_existe_declaracion(ag_contrato number) RETURN NUMBER;
  
  FUNCTION f_valida_declaracion(ag_contrato NUMBER) RETURN NUMBER;

  PROCEDURE usp_del_garantia(ag_garantia VARCHAR2, ag_documento VARCHAR2);

  PROCEDURE uspGarantiaDoInsert(
    ag_n_convoca         varchar2 DEFAULT Null,
    session__COD_CONTRATO      varchar2 DEFAULT Null,
    ag_cod_tipo_gar      varchar2 DEFAULT Null,
    ag_fecha_emision     varchar2 DEFAULT Null,
    ag_fecha_vencim      varchar2 DEFAULT Null,
    ag_cod_banco         varchar2 DEFAULT Null,
    ag_mon_codigo        varchar2 DEFAULT Null,
    ag_monto_contrato    varchar2 DEFAULT Null,
    ag_ind_fiel_cump     varchar2 DEFAULT Null,
    ag_ind_adelanto      varchar2 DEFAULT Null,
    ag_ind_monto_dif     varchar2 DEFAULT Null,
    ag_anhoentidad       varchar2,
    ag_proc_tipo         varchar2,
    ag_proc_desc         varchar2,
    ag_proc_sigla        varchar2,
    ag_currenpage        varchar2,
    ag_tipo_fiel_cumpl   varchar2,
    pfiletoupload1        VARCHAR2,
    pfiletoupload_file1         VARCHAR2,
    pfiletoupload__size           VARCHAR2,
    iisenv__remote_host           VARCHAR2,
    WriteFileDirectoryDynamic     VARCHAR2,
    session__userid               VARCHAR2,
    ag_clase_garantia             VARCHAR2,
    session__PUBLICADO            VARCHAR2,
    ag_banco_extranjero           VARCHAR2,
    ag_tipo_ee_ff_ext             varchar2);
  
  
  PROCEDURE usp_add_declarcion (
      cbGarantiaFielCump     varchar2,
      cbGarantiaFielPA       varchar2,
      cbGarantiaFielMD       varchar2,
      ag_fiel_cumpl          varchar2,
      ag_fiel_cump2          varchar2,
      ag_fiel_cump3          varchar2,
      session__COD_CONTRATO  varchar2
);
    
  PROCEDURE uspManGarantiaDoView(
    ag_n_convoca         varchar2 DEFAULT Null,
    ag_cod_garantia      varchar2,
    ag_anhoentidad       varchar2,
    ag_proc_tipo         varchar2,
    ag_proc_desc         varchar2,
    ag_proc_sigla        varchar2,
    ag_currenpage        varchar2,
    session__userid      varchar2,
    session__FileSingedHTTP varchar2);
      
  PROCEDURE uspNewGarantiaDoEdit(
    ag_cm_opc                   varchar2,
    ag_cm_oper_compra           varchar2,
    ag_anhoentidad              varchar2,
    ag_proc_tipo                varchar2,
    ag_proc_desc                varchar2,
    ag_proc_sigla               varchar2,
    ag_currenpage               varchar2,
    session__N_CONVOCA          varchar2,
    session__COD_CONTRATO       varchar2,
    session__anhoentidad        varchar2,
    session__eue_codigo         varchar2);
      
      function f_valida_procesov3 (
ag_cod_contrato             varchar2
) return number;
   PROCEDURE uspLisGarantiasDoView(
    ag_n_convoca                varchar2,
    ag_cod_contrato             varchar2,
    ag_ncor_orden_pedido        varchar2,
    ag_cm_opc                   varchar2,
    ag_cm_oper_compra           varchar2,
    ag_anhoentidad              varchar2,
    ag_proc_tipo                varchar2,
    ag_proc_desc                varchar2,
    ag_proc_sigla               varchar2,
    ag_currenpage               varchar2,
    session__n_convoca          varchar2,
    session__cod_contrato       varchar2,
    session__PUBLICADO           varchar2,
     session__FileSingedHTTP      varchar2);

   PROCEDURE usp_DeclaracionApp(
    session__n_convoca          varchar2,
    session__COD_CONTRATO       varchar2
    );
   function f_valida_directiva(ag_contrato number,ag_n_convoca number default null) return varchar2;
FUNCTION f_valida_inicio_v3(ag_nconvoca number)
return number;

END PKU_GESTOR_CONT_GARANTIAS;
/


CREATE OR REPLACE PACKAGE BODY "PKU_GESTOR_CONT_GARANTIAS" is
function f_valida_directiva(ag_contrato number,ag_n_convoca number default null)
return varchar2
is
  lv_fecha1 varchar2(10); -- fecha del corte
  lv_fecha2 date; -- fecha de la publicacion del contrato
  lv_fecha3 varchar2(10); --fecha del pase a produccion
  ln_publicado number;

  cursor c_contrato is
    select to_char(c.f_contrato, 'dd/mm/yyyy')f_contrato,IND_CONTRATO_PUB  /*into lv_fecha2*/
   from reg_procesos.contrato c
  where c.n_cod_contrato = ag_contrato;

  ln_count_declaracion number;

begin

    lv_fecha1  := '21/10/2010';
    lv_fecha3  := '13/02/2011';

 for xrow in c_contrato loop
     lv_fecha2 := to_date(xrow.f_contrato, 'dd/mm/yyyy');
     ln_publicado := xrow.IND_CONTRATO_PUB;
 end loop;

 select count(1) into  ln_count_declaracion from GARANTIA_DECLARACION  where n_cod_contrato = ag_contrato;

  if trunc(lv_fecha2) >= trunc(to_date(lv_fecha1,'dd/mm/yyyy')) and trunc(lv_fecha2) <= trunc(to_date(lv_fecha3,'dd/mm/yyyy')) then
  return 1;
  elsif  f_valida_inicio (ag_n_convoca)> 0  and ln_publicado > 0 /* and ln_count_declaracion = 0*/ then
  return 1;
  else
  return 0;
  end if;

end;

-- Funcion que valida la fecha de publicacion de la convocatoria contra la fecha de quiebre de la directiva
FUNCTION f_valida_inicio(ag_nconvoca number)
return number
is
       ln_cont number;
       lv_fecha varchar2(10);
begin
       lv_fecha  := '21/10/2010';

       select count(1) into ln_cont
       from convocatorias c
       inner join convocatoria_pub o on c.n_convoca = o.n_convoca
       where c.n_convoca = reg_procesos.f_get_min_n_convoca(ag_nconvoca)
/*       and IND_CONV_ULTIMO_PUB = 1 */
       and trunc(c.f_publica) >= trunc(to_date(lv_fecha,'dd/mm/yyyy'));

       return ln_cont;
end;

FUNCTION f_valida_inicio_v3(ag_nconvoca number)
return number
is
       ln_cont number;
       lv_fecha varchar2(10);
begin
       lv_fecha  := '21/10/2010';

       select count(1) into ln_cont
       from convocatorias c
       where c.n_convoca = ag_nconvoca
       and trunc(c.f_publica) >= trunc(to_date(lv_fecha,'dd/mm/yyyy'));

       return ln_cont;
end;
FUNCTION f_existe_declaracion(ag_contrato number)
return number
is
       ln_cont number:=0;
begin


           select count(1) into ln_cont
           from reg_procesos.garantia_declaracion d
           where d.n_cod_contrato = ag_contrato;


       return ln_cont;
end;


FUNCTION f_valida_declaracion(ag_contrato number)
return number
is
  ln_cont number;
begin


select count(1) into ln_cont
from reg_procesos.garantia_declaracion d
left outer join (
    select (
            case
                 when  g.IND_FIEL_CUMPLI = 1 then 1
                 when  g.IND_FIEL_CUMPLI_PA = 1 then 2
                 when  g.IND_MONTO_DIF = 1 then 3
                 when  g.IND_ADELANTO = 1 then 4
                 when  g.IND_BUEN_RENDIMIENTO = 1 then 5

            end
            ) cod_clase,
            g.*
    from garantia g
    where n_Cod_Contrato = ag_contrato
)  clase on d.n_cod_contrato = clase.n_cod_Contrato and d.cod_clase = clase.cod_clase
where d.n_cod_Contrato =  ag_contrato
and d.ind_presento = 1
and clase.cod_garantia is null;


return ln_cont;
end;

PROCEDUre usp_del_garantia(ag_garantia varchar2, ag_documento varchar2)
is
begin


      if ag_documento <> 0 then
              delete from convocatoria_doc where cod_doc = to_number(ag_documento);
      end if;

      delete from garantia where COD_GARANTIA = to_number(ag_garantia);
      commit;
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('

         thisform.scriptdo.value = "doViewGarantias"
         thisform.submit();
      ');

end;

PROCEDURE usp_add_declarcion (
      cbGarantiaFielCump     varchar2,
      cbGarantiaFielPA       varchar2,
      cbGarantiaFielMD       varchar2,
      ag_fiel_cumpl          varchar2,
      ag_fiel_cump2          varchar2,
      ag_fiel_cump3          varchar2,
      session__COD_CONTRATO  varchar2
)is
      ln_cont                NUMBER;
begin

      delete from GARANTIA_DECLARACION where n_cod_contrato = session__COD_CONTRATO;

      insert into GARANTIA_DECLARACION (N_COD_CONTRATO, COD_CLASE,IND_PRESENTO,COD_RAZON,F_REGISTRO)
      values (session__COD_CONTRATO,1,cbGarantiaFielCump,ag_fiel_cumpl,sysdate);


      insert into GARANTIA_DECLARACION (N_COD_CONTRATO, COD_CLASE,IND_PRESENTO,COD_RAZON,f_Registro)
      values (session__COD_CONTRATO,2,cbGarantiaFielPA,ag_fiel_cump2,sysdate);


      insert into GARANTIA_DECLARACION (N_COD_CONTRATO, COD_CLASE,IND_PRESENTO,COD_RAZON,f_Registro)
      values (session__COD_CONTRATO,3,cbGarantiaFielMD,ag_fiel_cump3,sysdate);

      SELECT COUNT(1) INTO ln_cont
      FROM GARANTIA_DECLARACION G WHERE N_COD_CONTRATO = session__COD_CONTRATO
      AND G.IND_PRESENTO = 1;

      if ln_cont > 0 then
            reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('
             alert("Ahora debe registrar la(s) Garantia(s) \npresentadas para la suscripcion del \ncontrato y adjuntar el archivo digitalizado ");
             ');
      end if;

      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('
             thisform.scriptdo.value = "doViewGarantias"
             thisform.submit();
      ');

end;


PROCEDURE usp_DeclaracionApp(
    session__n_convoca          varchar2,
    session__COD_CONTRATO       varchar2
)
IS

      -- Cursores
      cclaserazon1                  ref_cursor;
      cclaserazon2                  ref_cursor;
      cclaserazon3                  ref_cursor;

      --  Variables combos
      lv_combo_claserazon1          varchar2(4000);
      lv_combo_claserazon2          varchar2(4000);
      lv_combo_claserazon3          varchar2(4000);

BEGIN

   reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('

     function grabar(){

        if ( thisform.cbGarantiaFielCump.value == 2 ) {
            if (thisform.ag_fiel_cumpl.value == ""){
               thisform.ag_fiel_cumpl.focus();
               alert("Seleccione la razon de no presentar la Garantia de Fiel Cumplimiento. ");
               return;
            }
        }


        if ( thisform.cbGarantiaFielPA.value == 2 ) {
            if (thisform.ag_fiel_cump2.value == ""){
               thisform.ag_fiel_cump2.focus();
               alert("Seleccione la razon de no presentar la Garantia de Fiel Cumplimiento por prestaciones accesorias. ");
               return;
            }
        }


        if ( thisform.cbGarantiaFielMD.value == 2 ) {
            if (thisform.ag_fiel_cump3.value == ""){
               thisform.ag_fiel_cump3.focus();
               alert("Seleccione la razon de no presentar la Garantia por monto diferencial de propuesta. ");
               return;
            }
        }

        if ( thisform.cbGarantiaFielCump.value == 2 &&   thisform.cbGarantiaFielPA.value == 2 && thisform.cbGarantiaFielMD.value == 2  ) {
           alert("Ahora que ha declarado la aplicacion del \nrequisito Garantias puede publicar el \nContrato ");
        }

        thisform.scriptdo.value = "doAddApp"
        thisform.submit();
     }

     function muestra(obj,obj2){
        if ( obj.value == 1 ) {
           obj2.value=""
           obj2.style.visibility = "hidden"
        }
        else{
           obj2.value=""
           obj2.style.visibility = "visible"
        }

     }
   ');

   -- Inicializacion de Cursores
   cclaserazon1               := reg_procesos.pku_ss_utiles.f_cClaseGarRazon(1);
   cclaserazon2               := reg_procesos.pku_ss_utiles.f_cClaseGarRazon(2);
   cclaserazon3               := reg_procesos.pku_ss_utiles.f_cClaseGarRazon(3);

   -- Inicializamos los combos
   lv_combo_claserazon1       := reg_procesos.pku_ss_mod_contratos.f_retorna_combo( cclaserazon1, 'ag_fiel_cumpl', '','SELECCIONE LA RAZON DE NO PRESENTAR',' style= "font-size:0.9em;width:85%;visibility:hidden"');
   lv_combo_claserazon2       := reg_procesos.pku_ss_mod_contratos.f_retorna_combo( cclaserazon2, 'ag_fiel_cump2', '','SELECCIONE LA RAZON DE NO PRESENTAR',' style= "font-size:0.9em;width:85%;visibility:hidden"');
   lv_combo_claserazon3       := reg_procesos.pku_ss_mod_contratos.f_retorna_combo( cclaserazon3, 'ag_fiel_cump3', '','SELECCIONE LA RAZON DE NO PRESENTAR',' style= "font-size:0.9em;width:85%;visibility:hidden"');

   usp_print('
       <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
          <tr>');
   usp_print(
              PKU_SS_UTILES.f_get_titulo_contrato ( session__COD_CONTRATO, 'Garant&iacute;as' )
      );

   usp_print('
              <td align="right" valign=top width="50%">
               <input type="button" value="Grabar" OnClick="grabar();"/>
                  <input type="button" value="Volver" OnClick="thisform.scriptdo.value=''doViewGarantias'';thisform.submit();"/>
              </td>
          </tr>
      </table>');

   usp_print('
     <table border="0" cellpadding="3" cellspacing="0" width="100%" class="tableform">
     <tr><td colspan=3><h4>Declarar aplicacion del requisito Garantias para la suscripcion del contrato</h4></td></tr>
     <tr><td colspan=3 class=c1b>&nbsp;</td></tr>');

   usp_print('<br>
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>');


    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Garantia de fiel cumplimiento',
                '<select id="cbGarantiaFielCump"  name="cbGarantiaFielCump"  onchange=muestra(this,thisform.ag_fiel_cumpl)>
                         <option value=1>SI</option>
                         <option value=2>NO</option>
                 </select>
                 '||lv_combo_claserazon1||'',
                 '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Garantia de fiel cumplimiento por prestaciones accesorias',
                '<select id="cbGarantiaFielPA"  name="cbGarantiaFielPA"   onchange=muestra(this,thisform.ag_fiel_cump2)>
                         <option value=1>SI</option>
                         <option value=2>NO</option>
                 </select>
                 '||lv_combo_claserazon2||'',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Garantia por monto diferencial de propuesta',
                '<select id="cbGarantiaFielMD"  name="cbGarantiaFielMD"  onchange=muestra(this,thisform.ag_fiel_cump3) >
                         <option value=1>SI</option>
                         <option value=2>NO</option>
                 </select>
                 '||lv_combo_claserazon3||'',
                '.'));

    usp_print('
                </table>');

END;

PROCEDURE uspManGarantiaDoView(
    ag_n_convoca         varchar2 DEFAULT Null,
    ag_cod_garantia      varchar2,
    ag_anhoentidad       varchar2,
    ag_proc_tipo         varchar2,
    ag_proc_desc         varchar2,
    ag_proc_sigla        varchar2,
    ag_currenpage        varchar2,
    session__userid      varchar2,
    session__FileSingedHTTP varchar2)
IS
    ------- Cursores ------
    cClaseGarantia              ref_cursor;

    lv_combo_claseGarantia      varchar2(4000);


    ln_IND_FIEL_CUMPLI              NUMBER := 0 ;
    ln_IND_FIEL_CUMPLI_PA           NUMBER := 0;
    ln_IND_MONTO_DIF                NUMBER := 0;
    ln_IND_ADELANTO                 NUMBER := 0;
    ln_IND_BUEN_RENDIMIENTO         NUMBER := 0;

    ln_seleccionado                 NUMBER := 0;

    lv_doc_url                      VARCHAR2(250);
    lv_fec_upload                   VARCHAR2(25);
    ln_cod_doc                      NUMBER;
    lv_icon_tipo_file               VARCHAR2(250);

    cursor c_garantia (ag_garantia NUMBER)
    IS
    SELECT
            g.n_cod_contrato,
            tg.des_tipo_garantia,
            g.tipo_garantia_otro,
            m.mon_desc,
            to_char(g.monto_garantia,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) monto_garantia,
            to_char(g.fec_emision, 'dd/mm/yyyy') fec_emision,
            to_char(g.fec_vencimiento, 'dd/mm/yyyy') fec_vencimiento,
            g.cod_banco_seguro, t.desc_banco_seguro, t.ind_banco_seguro,
            g.IND_FIEL_CUMPLI,
            g.IND_FIEL_CUMPLI_PA,
            g.IND_MONTO_DIF,
            g.IND_ADELANTO,
            g.IND_BUEN_RENDIMIENTO,
            doc.doc_url,
            doc.fec_upload,
            doc.cod_doc,
            t.icon_tipo_file,
            g.banco_extranjero
        FROM
            reg_procesos.garantia g
            left outer join reg_procesos.tipo_banco_seguro t on  g.cod_banco_seguro = t.cod_banco_seguro
            left outer join reg_procesos.t_tipo_garantia  tg on g.cod_tipo_garantia = tg.cod_tipo_garantia
            left outer join sease.moneda m on g.cod_moneda = m.mon_codigo
            left outer join reg_procesos.convocatoria_Doc doc on g.cod_doc = doc.cod_doc
            left outer join REG_PROCESOS.tipo_archivo t ON doc.COD_TIPO_FILE = T.COD_TIPO_FILE
        WHERE
            cod_garantia = ag_garantia;

    ------- Variables ------
    e_ArgumentosMalos     exception;
    ln_cod_garantia       number;
    ln_n_convoca          number;
    lv_eue_codigo         varchar2(6);
    lv_anhoentidad        varchar2(4);
    lv_proc_sigla         varchar2(60);
    lv_proc_tipo_sigla    varchar2(60);
    lv_proc_num           varchar2(6);
    ln_proc_tipo          number;
    ln_n_proceso          number;
    ln_cod_contrato       number;
    ln_n_contrato         REG_PROCESOS.contrato.n_contrato%type;
    lv_ruc_contratista    REG_PROCESOS.contrato.ruc_contratista%type;
    lv_nom_contratista    REG_PROCESOS.contrato.nom_contratista%type;
    lv_des_tipo_garantia  REG_PROCESOS.t_tipo_garantia.des_tipo_garantia%type;
    lv_tipo_garantia_otro REG_PROCESOS.garantia.tipo_garantia_otro%type;
    lv_monto_garantia     varchar2(50);
    lv_mon_desc           SEASE.moneda.mon_desc%type;
    lv_cod_banco_seguro   REG_PROCESOS.garantia.cod_banco_seguro%type;
    lv_desc_banco_seguro  REG_PROCESOS.tipo_banco_seguro.desc_banco_seguro%type;
    lv_ind_banco_seguro   REG_PROCESOS.tipo_banco_seguro.ind_banco_seguro%type;
    lv_cod_tbanco_seguro  REG_PROCESOS.tipo_banco_seguro.cod_banco_seguro%type;
    lv_desc_tbanco_seguro REG_PROCESOS.tipo_banco_seguro.desc_banco_seguro%type;
    lv_fec_emision        varchar2(10);
    lv_fec_vencimiento    varchar2(10);
    lv_maxi               varchar2(10);
    lv_ee_ff_ext          varchar2(80);

begin

    if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
    end if;

    ln_cod_garantia:= to_number(ag_cod_garantia);
    ln_n_convoca:= to_number(ag_n_convoca);



    -------- Obtener datos de la garantia-----
    for xrow in c_garantia(ln_cod_garantia) loop
            ln_cod_contrato          :=  xrow.n_cod_contrato;
            lv_des_tipo_garantia     :=  xrow.des_tipo_garantia;
            lv_tipo_garantia_otro    :=  xrow.des_tipo_garantia;
            lv_mon_desc              :=  xrow.mon_desc;
            lv_monto_garantia        :=  xrow.monto_garantia;
            lv_fec_emision           :=  xrow.fec_emision;
            lv_fec_vencimiento       :=  xrow.fec_vencimiento;
            lv_cod_banco_seguro      :=  xrow.cod_banco_seguro;
            lv_desc_banco_seguro     :=  xrow.desc_banco_seguro;
            lv_ind_banco_seguro      :=  xrow.ind_banco_seguro ;
            ln_IND_FIEL_CUMPLI       :=  xrow.IND_FIEL_CUMPLI;
            ln_IND_FIEL_CUMPLI_PA    :=  xrow.IND_FIEL_CUMPLI_PA;
            ln_IND_MONTO_DIF         :=  xrow.IND_MONTO_DIF ;
            ln_IND_ADELANTO          :=  xrow.IND_ADELANTO ;
            ln_IND_BUEN_RENDIMIENTO  :=  xrow.IND_BUEN_RENDIMIENTO;
            lv_doc_url               :=  xrow.Doc_Url;
            lv_fec_upload            :=  to_char(xrow.fec_upload,'dd/mm/yyyy hh24:mi');
            ln_cod_doc               :=  xrow.cod_doc;
            lv_icon_tipo_file        :=  replace(xrow.icon_tipo_file,'jpg','png');
            
            if lv_cod_banco_seguro = 180 then
            lv_desc_banco_seguro             :=  xrow.banco_extranjero;
            else 
            lv_desc_banco_seguro             :=  xrow.desc_banco_seguro;
            end if;
            
    end loop;


    if ln_IND_FIEL_CUMPLI      = 1 then ln_seleccionado := 1;  end if;
    if ln_IND_FIEL_CUMPLI_PA   = 1 then ln_seleccionado := 2;  end if;
    if ln_IND_MONTO_DIF        = 1 then ln_seleccionado := 3;  end if;
    if ln_IND_ADELANTO         = 1 then ln_seleccionado := 4;  end if;
    if ln_IND_BUEN_RENDIMIENTO = 1 then ln_seleccionado := 5;  end if;

    -- Carga de cursores
    cClaseGarantia            := pku_ss_utiles.f_cClasesGarantia;

    lv_combo_claseGarantia    := PKU_SS_UTILES.f_retorna_combo(cClaseGarantia, 'ag_clase_garantia', ln_seleccionado,'SIN GARANTIA ',' style="width:99%" disabled');


    -------- Al Cargar la Pagina -------
    usp_print('
    <body onload="init('||lv_cod_banco_seguro||')">');

    ----- Obtener Datos de la Convocatoria-------
    if (ln_n_convoca is not null) then
        begin
            Select
                c.codconsucode,c.n_proceso,
                c.anhoentidad,c.proc_tipo,c.proc_num,
                c.proc_sigla,t.proc_tipo_sigla
            into
                lv_eue_codigo,ln_n_proceso,
                lv_anhoentidad,ln_proc_tipo,lv_proc_num,
                lv_proc_sigla,lv_proc_tipo_sigla
            from
                REG_PROCESOS.convocatorias c,
                REG_PROCESOS.tipo_procesos t
            where
                t.proc_tipo =c.proc_tipo
                and c.n_convoca = ln_n_convoca;
        exception
            when no_data_found then
                lv_eue_codigo:= null;
        end;
    else  --------- Convenio Marco -----------
        begin
            Select
                o.codconsucode,'' n_convoca,
                o.anhoentidad,'' proc_tipo,'' proc_num,
                '' proc_sigla,'' proc_tipo_sigla
            into
                lv_eue_codigo,ln_n_convoca,
                lv_anhoentidad,ln_proc_tipo,lv_proc_num,
                lv_proc_sigla,lv_proc_tipo_sigla
            from
                reg_procesos.cm_orden_pedido o,
                REG_PROCESOS.contrato c
            where
                o.ncor_orden_pedido = c.ncor_orden_pedido
                and c.n_cod_contrato = ln_cod_contrato;
        exception
            when no_data_found then
                lv_eue_codigo:= null;
        end;
    end if;

    ----- Obtener Datos del Contrato ----
    begin
        Select c.n_contrato, c.ruc_contratista, c.nom_contratista
        into ln_n_contrato, lv_ruc_contratista, lv_nom_contratista
        from REG_PROCESOS.contrato c
        where c.n_cod_contrato = ln_cod_contrato;
    exception
        when no_data_found then
            ln_n_contrato:= null;
    end;

    -------- item del contrato -------
    select max(trim(to_char(c.proc_item, '99999999'))) into lv_maxi
    from reg_procesos.item_contrato c
    where c.n_cod_contrato = ln_cod_contrato;

    -------- Tipo Banco ---------
    begin
        select cod_banco_seguro, desc_banco_seguro
        into   lv_cod_tbanco_seguro, lv_desc_tbanco_seguro
        from reg_procesos.tipo_banco_seguro
        where cod_banco_seguro = lv_ind_banco_seguro;
    exception
        when no_data_found then
            lv_cod_banco_seguro:= null;
    end;

    -------- Titulos ------------
    usp_print('
    <input type="hidden" name="ag_n_convoca"    value="'||ln_n_convoca||'"/>
    <input type="hidden" name="ag_cod_contrato" value="'||ln_cod_contrato||'"/>
    <input type="hidden" name="ag_cod_banco"    value=""/>
    <input type="hidden" name="ag_anhoentidad"  value="'||ag_anhoentidad||'"/>
    <input type="hidden" name="ag_proc_tipo"    value="'||ag_proc_tipo||'" />
    <input type="hidden" name="ag_proc_desc"    value="'||ag_proc_desc||'"/>
    <input type="hidden" name="ag_proc_sigla"   value="'||ag_proc_sigla||'"/>
    <input type="hidden" name="ag_currenpage"   value="'||ag_currenpage||'" />

    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato ( ln_cod_contrato, 'Garant&iacute;as' )
    );
    usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Volver" OnClick="thisform.scriptdo.value=''doViewGarantias'';thisform.submit();"/>
            </td>
        </tr>
    </table>
    <br>
    <table width=100% class="table table-striped">');
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero del Contrato (u Orden de Compra o Servicio)',
                '<input type="text" name="n_contrato" readonly style="width:98%" value="'||ln_n_contrato||'"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero de Garantia',
                '<input type="text" name="cod_garantia" readonly style="width:98%" value="'||ln_cod_garantia||'"/>',
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Clases de Garantias',
                 lv_combo_claseGarantia ,
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Tipo de Garantia',
                '<input type="text" name="tipo_garantia" readonly style="width:98%" value="'||lv_des_tipo_garantia||'"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Tipo Entidad Financiera',
                '<input type="text" name="cod_banco_seguro" readonly style="width:98%" value="'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(lv_desc_tbanco_seguro)||'"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Entidad Financiera',
                '<input type="text" name="cod_banco_seguro2" readonly style="width:98%" value="'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(lv_desc_banco_seguro)||'"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Moneda',
                '<input type="text" name="cod_garantia" readonly style="width:98%" value="'||lv_mon_desc||'"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Monto',
                '<input type="text" name="monto" readonly style="width:98%" value="'||trim(lv_monto_garantia)||'"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Fecha de Emisi&oacute;n',
                '<input type="text" name="fec_emision" readonly style="width:98%" value="'||trim(lv_fec_emision)||'"/>',
                '.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Fecha de Vencimiento',
                '<input type="text" name="fec_vencimiento" readonly style="width:98%" value="'||trim(lv_fec_vencimiento)||'"/>',
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Archivo de la Garantia',
                case when lv_DOC_URL is not null then '<br><a target=_blank   href="'||url_azure_app||session__FileSingedHTTP||replace(lv_DOC_URL,'\','/')||'" ><img src="bootstrap/'||lv_ICON_TIPO_FILE||'" border="0" width="30" height="30"/></a>' end || case when lv_FEC_UPLOAD is not null then ' Registrado el '||lv_FEC_UPLOAD end
                ,
                '.'));





/*    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Clases de Garant&iacute;as',
                '<input type="checkbox" name="ind_fiel_cump" value="1" border="0"'||case when lv_ind_fiel_cump = 1 then 'checked="true"' end||' disabled /> Fiel Cumplimiento<br>'||
                '<input type="checkbox" name="ind_adelanto"  value="1" border="0"'||case when lv_ind_adelanto  = 1 then 'checked="true"' end||' disabled /> Adelanto<br>'||
                '<input type="checkbox" name="ind_monto_dif" value="1" border="0"'||case when lv_ind_monto_dif = 1 then 'checked="true"' end||' disabled /> Monto Diferencial',
                '.'));
    if lv_ind_fiel_cump = 1 then
        usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Garantia de Fiel Cumplimiento',
                case
                    when lv_tipo_fiel_cumpl = 1 then
                        '<input type=text name="tipo_fiel_cumpl" value="Fiel Cumplimiento" style="width:98%" readonly/>'
                    when lv_tipo_fiel_cumpl = 2 then
                        '<input type=text name="tipo_fiel_cumpl" value="Fiel Cumplimiento por Prestaciones Accesorias" style="width:98%" readonly/>'
                end,
                '.'));
    end if;*/
    usp_print('
    </table>');
    ---------- Java Script ---------------
    usp_print('
    <script language="javascript">
        /**************************************/
        /******  CLASES DE ESTRUCTURAS  *******/
        /**************************************/
        function init(cod){
            if( cod == 85 )
            {
                Visible("hidden");
                thisform.cod_banco_seguro.value = thisform.cod_banco_seguro2.value;
            }
        }

        function Visible( flag )
        {
            thisform.cod_banco_seguro2.style.visibility = flag;
            thisform.financiera.style.visibility        = flag;
        }
    </script>');
End;


PROCEDURE uspGarantiaDoInsert(
    ag_n_convoca                  varchar2 DEFAULT Null,
    session__COD_CONTRATO         varchar2 DEFAULT Null,
    ag_cod_tipo_gar               varchar2 DEFAULT Null,
    ag_fecha_emision              varchar2 DEFAULT Null,
    ag_fecha_vencim               varchar2 DEFAULT Null,
    ag_cod_banco                  varchar2 DEFAULT Null,
    ag_mon_codigo                 varchar2 DEFAULT Null,
    ag_monto_contrato             varchar2 DEFAULT Null,
    ag_ind_fiel_cump              varchar2 DEFAULT Null,
    ag_ind_adelanto               varchar2 DEFAULT Null,
    ag_ind_monto_dif              varchar2 DEFAULT Null,
    ag_anhoentidad                varchar2,
    ag_proc_tipo                  varchar2,
    ag_proc_desc                  varchar2,
    ag_proc_sigla                 varchar2,
    ag_currenpage                 varchar2,
    ag_tipo_fiel_cumpl            varchar2,
    pfiletoupload1                VARCHAR2,
    pfiletoupload_file1           VARCHAR2,
    pfiletoupload__size           VARCHAR2,
    iisenv__remote_host           VARCHAR2,
    WriteFileDirectoryDynamic     VARCHAR2,
    session__userid               VARCHAR2,
    ag_clase_garantia             VARCHAR2,
    session__PUBLICADO            VARCHAR2,
    ag_banco_extranjero           VARCHAR2,
    ag_tipo_ee_ff_ext             varchar2)
IS
    -------- Variables --------
    ln_cod_garantia                 number;
    lv_codtipofile                  VARCHAR2(20);
    ln_publicado                    number;

    ln_IND_FIEL_CUMPLI              NUMBER := 0 ;
    ln_IND_FIEL_CUMPLI_PA           NUMBER := 0;
    ln_IND_MONTO_DIF                NUMBER := 0;
    ln_IND_ADELANTO                 NUMBER := 0;
    ln_IND_BUEN_RENDIMIENTO         NUMBER := 0;

    ln_reg_clase_garantia           NUMBER;
    ln_cod_banco_seguro             NUMBER;
    
Begin
    ln_publicado := session__PUBLICADO;

    if ag_clase_garantia = 1 then ln_IND_FIEL_CUMPLI := 1;  end if;
    if ag_clase_garantia = 2 then ln_IND_FIEL_CUMPLI_PA := 1;  end if;
    if ag_clase_garantia = 3 then ln_IND_MONTO_DIF := 1;  end if;
    if ag_clase_garantia = 4 then ln_IND_ADELANTO := 1;  end if;
    if ag_clase_garantia = 5 then ln_IND_ADELANTO := 1;  end if;
    
    if ag_cod_banco = '-1' then 
       ln_cod_banco_seguro  := ag_tipo_ee_ff_ext;
       else 
       ln_cod_banco_seguro  := ag_cod_banco; 
    end if;
    

    ------ Obtener cod_garantia ---------
    select REG_PROCESOS.s_garantia.NEXTVAL into ln_cod_garantia
    from dual;
    ------- insertar el nuevo registro -------
    insert into REG_PROCESOS.garantia (
        cod_garantia, 
        cod_tipo_garantia, 
        tipo_garantia_otro, 
        n_cod_contrato,
        monto_garantia, 
        cod_moneda, 
        fec_emision, 
        fec_vencimiento,
        cod_banco_seguro,
        ind_fiel_cumpli,
        ind_fiel_cumpli_pa,
        ind_monto_dif,
        ind_adelanto,
        ind_buen_rendimiento,
        F_REGISTRA,
        BANCO_EXTRANJERO
    ) values (
        ln_cod_garantia, 
        replace(ag_cod_tipo_gar, 'A', ''),
        Null, 
        session__COD_CONTRATO,
      --  to_number(ag_monto_contrato,'99999999.99'), 
      to_number(replace(ag_monto_contrato, '.', ',')), 
      --TO_NUMBER(replace(ag_monto_contrato, '.', ','), '999999999999.99'),
        ag_mon_codigo,
        to_date(ag_fecha_emision,'dd/mm/yyyy'), 
        to_date(ag_fecha_vencim,'dd/mm/yyyy'),
        ln_cod_banco_seguro,
        ln_IND_FIEL_CUMPLI,
        ln_IND_FIEL_CUMPLI_PA,
        ln_IND_MONTO_DIF,
        ln_IND_ADELANTO,
        ln_IND_BUEN_RENDIMIENTO ,
        SYSDATE,
        ag_banco_extranjero
    );




   ------------------------- Obtiene el tipo de archivo -------------------------------------

   BEGIN
        --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
        select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
   EXCEPTION
        when others then
             REG_PROCESOS.Pku_Ss_Mod_Contratos.f_msg_error('Error: Al intentar hallar el tipo de documento','''doNewContrato''');
             return;
   END;

  INSERT INTO reg_procesos.convocatoria_doc (
                  N_CONVOCA,
                  COD_TIPO_DOC,
                  COD_TIPO_FILE,
                  DOC_URL,
                  DOC_NOMBRE,
                  FEC_UPLOAD,
                  USER_UPLOAD,
                  IP_FROM_UPLOAD,
                  TAMANO_BYTES,
                  N_COD_CONTRATO )

                  VALUES (
                  reg_procesos.f_get_min_n_convoca(ag_n_convoca),
                  2450,
                  lv_codtipofile,
                  WriteFileDirectoryDynamic||'\'||pfiletoupload_file1 ,
                  pfiletoupload_file1,
                  sysdate,
                  session__userid,
                  iisenv__remote_host,
                  pfiletoupload__size,
                  session__COD_CONTRATO);


   update garantia set cod_doc = pk_convocatoria.gn_cod_documento
   where COD_GARANTIA = ln_cod_garantia;

    Commit;

    -------  Regresa al Listado de Garantias -------
    usp_print('
    <input type="hidden" name="ag_n_convoca"    value="'||ag_n_convoca||'"/>
    <input type="hidden" name="ag_anhoentidad"  value="'||ag_anhoentidad||'"/>
    <input type="hidden" name="ag_proc_tipo"    value="'||ag_proc_tipo||'"/>
    <input type="hidden" name="ag_proc_desc"    value="'||ag_proc_desc||'"/>
    <input type="hidden" name="ag_proc_sigla"   value="'||ag_proc_sigla||'"/>
    <input type="hidden" name="ag_currenpage"   value="'||ag_currenpage||'"/>
    ');

    SELECT COUNT(1) INTO ln_reg_clase_garantia FROM GARANTIA_DECLARACION WHERE COD_CLASE = ag_clase_garantia and N_COD_CONTRATO = session__COD_CONTRATO and ind_Estado = 1 and ind_presento = 1;
    IF  ln_reg_clase_garantia  > 0 and nvl(ln_publicado,0)  <>  1 THEN
        reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('
               alert("Asegurese de haber registrado todas las \nGarantias declaradas, luego proceda a \npublicar el Contrato");
        ');
    END IF;

    SELECT COUNT(1) INTO ln_publicado from contrato where n_cod_contrato =  session__COD_CONTRATO;
    IF f_valida_declaracion(session__COD_CONTRATO) = 0 and f_valida_inicio(ag_n_convoca)> 0 and ln_publicado  <>  1 THEN
       reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('
            alert("Ahora que ha declarado la aplicacion del \nrequisito y/o registrado la(s) Garantia(s) \ndeclaradas puede publicar el Contrato");
       ');
    END IF;

    usp_print('
    <script>
        thisform.scriptdo.value = "doViewGarantias";
        thisform.submit();
    </script>');

END;

PROCEDURE uspNewGarantiaDoEdit(
    ag_cm_opc                   varchar2,
    ag_cm_oper_compra           varchar2,
    ag_anhoentidad              varchar2,
    ag_proc_tipo                varchar2,
    ag_proc_desc                varchar2,
    ag_proc_sigla               varchar2,
    ag_currenpage               varchar2,
    session__N_CONVOCA          varchar2,
    session__COD_CONTRATO       varchar2,
    session__anhoentidad        varchar2,
    session__eue_codigo         varchar2)
IS

    ------- Variables ------
    e_ArgumentosMalos           exception;
    ln_n_convoca                number;
    ln_cod_contrato             number;

    row_contrato                reg_procesos.contrato%rowtype;

    -- Collections
    Type tb_tipogarantia        is table of reg_procesos.t_tipo_garantia%Rowtype;
    Type tb_tipoentidad1        is table of reg_procesos.tipo_banco_seguro%Rowtype;
    Type tb_tipoentidad2        is table of reg_procesos.tipo_banco_seguro%Rowtype;
    Type tb_itemcontrato        is table of reg_procesos.item_contrato%Rowtype;
    Type tb_entfinanciera1      is table of reg_procesos.tipo_banco_seguro%Rowtype;


    -- Variables
    --vtb_tipogarantias           tb_tipogarantia;
    --vtb_tipoentidad1            tb_tipoentidad1;
    --vtb_tipoentidad2            tb_tipoentidad2;
    --vtb_itemcontrato            tb_itemcontrato;
    --vtb_entfinanciera1          tb_entfinanciera1;

    --lv_trama_tipogarantia       varchar2(4000);
    --lv_trama_tipoeeff1          varchar2(4000);
    --lv_trama_tipoeeff2          varchar2(4000);
    --lv_trama_eeff               long;

    cmoneda                     ref_cursor;
    cClaseGarantia              ref_cursor;

    lv_combo_moneda             varchar2(4000);
    lv_combo_claseGarantia      varchar2(4000);

    lv_ruta_file                varchar2(300);
    
    i                     number;
    
    cursor cTipoGarantia is
       SELECT * From reg_procesos.t_tipo_garantia 
          Where ind_activo = 1
          order by des_tipo_garantia asc;
          
    cursor cTipoAseguradora(tipo number) is      
       SELECT * From reg_procesos.tipo_banco_seguro 
          Where ind_banco_seguro = 0 
          and COD_TIPO_GARANTIA = tipo
          and IND_ACTIVO = 1 
          order by desc_banco_seguro asc;  
          
    cursor cTipoAseguradoraTotal is      
       SELECT * From reg_procesos.tipo_banco_seguro 
          Where ind_banco_seguro = 0 
          --and COD_TIPO_GARANTIA = tipo
          and IND_ACTIVO = 1 
          order by desc_banco_seguro asc;      
          
    cursor ctipoBanco(cod number) is      
       SELECT * From reg_procesos.tipo_banco_seguro
          Where ind_banco_seguro  not in (0)
          and ind_banco_seguro  = cod 
          and activo_carta_fianza = '1'  
          and ind_activo = 1  
           -- Inicio KMerma SM-281-2019-SGFS
          order by desc_banco_seguro asc;
           -- Fin KMerma SM-281-2019-SGFS

Begin

    -- Carga de cursores
    cmoneda                   := pku_ss_utiles.f_cmonedas;
    cClaseGarantia            := pku_ss_utiles.f_cClasesGarantia;

    -- Tipo de garantias
     /*SELECT * BULK COLLECT INTO vtb_tipogarantias  
     From reg_procesos.t_tipo_garantia 
     Where ind_activo = 1
     order by des_tipo_garantia asc;*/
     /*SELECT * BULK COLLECT INTO vtb_tipoentidad1 
    From reg_procesos.tipo_banco_seguro 
    Where ind_banco_seguro = 0 
    and COD_TIPO_GARANTIA = 1 
    and IND_ACTIVO = 1 
    order by desc_banco_seguro asc;*/
    /* SELECT * BULK COLLECT INTO vtb_tipoentidad2 
    From reg_procesos.tipo_banco_seguro 
    Where ind_banco_seguro = 0 
    and COD_TIPO_GARANTIA = 2 
    and IND_ACTIVO = 1 
    order by desc_banco_seguro asc;*/
    -- Items del Contrato
    --SELECT * BULK COLLECT INTO vtb_itemcontrato From reg_procesos.item_contrato c Where c.n_cod_contrato = ln_cod_contrato order by proc_item;
     ------- Entidad Financiera : Si Tipo de Garantia = Carta Fianza
 /*    SELECT * BULK COLLECT INTO vtb_entfinanciera1 From reg_procesos.tipo_banco_seguro
    Where ind_banco_seguro  not in (0)
     and ind_banco_seguro  = ag_tipo_ent_fin 
      and activo_carta_fianza = '1'  
      and ind_activo = 1  
      order by desc_banco_seguro desc;*/
    ln_cod_contrato   := session__COD_CONTRATO;
    ln_n_convoca      := session__N_CONVOCA;
    lv_ruta_file      := 'mon\docs\contratos'||'\'||session__anhoentidad||'\'||session__eue_codigo||'\'||session__N_CONVOCA;


   -------- Funciones Script para Validaciones -------
    PKU_PROCESOS_COMUN.doJScriptFechas;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.fXml;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.fNumeros;
    ----- Obtener Datos del Contrato ----
    begin
        Select * into row_contrato
          from REG_PROCESOS.contrato c
         where c.n_cod_contrato = ln_cod_contrato;
    exception
        when no_data_found then
           row_contrato := null;
    end;

  -- Inicializamos los combos
    lv_combo_moneda           := PKU_SS_UTILES.f_retorna_combo(cmoneda, 'ag_mon_codigo_vi', row_contrato.CODMONEDA_CONTRATO,'Seleccione moneda ...',' style="width:99%" disabled');
    lv_combo_claseGarantia    := PKU_SS_UTILES.f_retorna_combo(cClaseGarantia, 'ag_clase_garantia', 1,'Seleccione la clase de garantia',' style="width:99%"');


    /* Armamos la Trama del Tipo de garantia */
   -- lv_trama_tipogarantia := lv_trama_tipogarantia || '<xml id="xmlTipoGarantia">';
   -- lv_trama_tipogarantia := lv_trama_tipogarantia ||' <root>';

    /*For i in vtb_tipogarantias.first .. vtb_tipogarantias.last Loop
        lv_trama_tipogarantia := lv_trama_tipogarantia||'<tipogarantia>';
        lv_trama_tipogarantia := lv_trama_tipogarantia||'<codigo>'||vtb_tipogarantias(i).cod_tipo_garantia||'</codigo>';
        lv_trama_tipogarantia := lv_trama_tipogarantia||'<descripcion>'||vtb_tipogarantias(i).des_tipo_garantia||'</descripcion>';
        lv_trama_tipogarantia := lv_trama_tipogarantia||'</tipogarantia>';
    End Loop;
*/
  --  lv_trama_tipogarantia := lv_trama_tipogarantia ||' </root></xml>';

  --  usp_print(lv_trama_tipogarantia);

    /* Armamos la Trama del Tipo de EEFF1 */
  --  lv_trama_tipoeeff1 := lv_trama_tipoeeff1 || '<xml id="xmlTipoEEFF1">';
  --  lv_trama_tipoeeff1 := lv_trama_tipoeeff1 ||' <root>';
/*
    For i in vtb_tipoentidad1.first .. vtb_tipoentidad1.last Loop
        lv_trama_tipoeeff1 := lv_trama_tipoeeff1 ||'<tipoeeff>';
        lv_trama_tipoeeff1 := lv_trama_tipoeeff1 ||'<codigo>'||vtb_tipoentidad1(i).cod_banco_seguro||'</codigo>';
        lv_trama_tipoeeff1 := lv_trama_tipoeeff1 ||'<descripcion>'||vtb_tipoentidad1(i).desc_banco_seguro||'</descripcion>';
        lv_trama_tipoeeff1 := lv_trama_tipoeeff1 ||'</tipoeeff>';
    End Loop;
*/
  --  lv_trama_tipoeeff1 := lv_trama_tipoeeff1 ||' </root></xml>';

  --  usp_print(lv_trama_tipoeeff1);

    /* Armamos la Trama del Tipo de EEFF2 */
 --   lv_trama_tipoeeff2 := lv_trama_tipoeeff2 || '<xml id="xmlTipoEEFF2">';
  --  lv_trama_tipoeeff2 := lv_trama_tipoeeff2 ||' <root>';
/*
    For i in vtb_tipoentidad2.first .. vtb_tipoentidad2.last Loop
        lv_trama_tipoeeff2 := lv_trama_tipoeeff2 ||'<tipoeeff>';
        lv_trama_tipoeeff2 := lv_trama_tipoeeff2 ||'<codigo>'||vtb_tipoentidad2(i).cod_banco_seguro||'</codigo>';
        lv_trama_tipoeeff2 := lv_trama_tipoeeff2 ||'<descripcion>'||vtb_tipoentidad2(i).desc_banco_seguro||'</descripcion>';
        lv_trama_tipoeeff2 := lv_trama_tipoeeff2 ||'</tipoeeff>';
    End Loop;
*/
  --  lv_trama_tipoeeff2 := lv_trama_tipoeeff2 ||' </root></xml>';

  --  usp_print(lv_trama_tipoeeff2);

--    usp_print('<xml id="xmlEEFF">');
--    usp_print('<root>');
/*
    For i in vtb_entfinanciera1.first .. vtb_entfinanciera1.last Loop
        usp_print('<eeff>');
        usp_print('<codigo>'||vtb_entfinanciera1(i).cod_banco_seguro||'</codigo>');
        usp_print('<descripcion>'||vtb_entfinanciera1(i).desc_banco_seguro||'</descripcion>');
        usp_print('<ind_banco_seguro>'||vtb_entfinanciera1(i).ind_banco_seguro||'</ind_banco_seguro>');
        usp_print('</eeff>');
    End Loop;
*/
--    usp_print(' </root></xml>');

--    usp_print(lv_trama_eeff);


    usp_print('<xml id="xmlActual"></xml>');
    usp_print('<input type="hidden" name="WriteFileDirectory"          value="FileSinged">');
    usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"   value="'||lv_ruta_file||'"></input>');

    usp_print('
    <input type="hidden" name="ag_n_convoca"                           value="'||ln_n_convoca||'"/>
    <input type="hidden" name="ag_mon_codigo"                          value="'||row_contrato.CODMONEDA_CONTRATO||'"/>
    <input type="hidden" name="ag_cod_banco"                           value=""/>
    <input type="hidden" name="ag_ncor_orden_pedido"                   value="'||row_contrato.ncor_orden_pedido||'"/>
    <input type="hidden" name="ag_cm_opc"                              value="'||ag_cm_opc||'"/>
    <input type="hidden" name="ag_cm_oper_compra"                      value="'||ag_cm_oper_compra||'"/>
    <input type="hidden" name="ag_anhoentidad"                         value="'||ag_anhoentidad||'"/>
    <input type="hidden" name="ag_proc_tipo"                           value="'||ag_proc_tipo||'"/>
    <input type="hidden" name="ag_proc_desc"                           value="'||ag_proc_desc||'"/>
    <input type="hidden" name="ag_proc_sigla"                          value="'||ag_proc_sigla||'"/>
    <input type="hidden" name="ag_currenpage"                          value="'||ag_currenpage||'"/>
    <input type="hidden" name="ag_tipo_ee_ff_ext"                      value=""/>

    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato ( session__COD_CONTRATO, 'Garant&iacute;as' )
    );

    usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Grabar" OnClick="grabar(this,''doInsertGarantias'')"/>&nbsp;&nbsp;&nbsp;
                <input type="button" value="Volver" OnClick="thisform.scriptdo.value=''doViewGarantias'';thisform.submit();"/>
            </td>
         </tr>
    </table>
    <br>');
    
    
    usp_print('<script language="javascript">

function array_sector(texto,valor){
this.texto = texto
this.valor = valor}

function array_sector2(texto,valor){
this.texto = texto
this.valor = valor}

');


        for xrow1 in cTipoGarantia loop 
            i := 1;
            usp_print('var A'||xrow1.cod_tipo_garantia||'= new Array();');
            usp_print('A'||xrow1.cod_tipo_garantia||'[0]=new array_sector("Seleccione tipo de entidad financiera ...","-1");');
            for xrow2 in cTipoAseguradora(xrow1.cod_tipo_garantia) loop
                usp_print('A'||xrow1.cod_tipo_garantia||'['||i||'] = new array_sector("'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow2.desc_banco_seguro)||'","B'||xrow2.cod_banco_seguro||'"); ');
                i := i+1;
            end loop;
        end loop;
        
        
        for xrow3 in cTipoAseguradoraTotal loop 
            i := 1;
            usp_print('var B'||xrow3.cod_banco_seguro||'= new Array();');
            usp_print('B'||xrow3.cod_banco_seguro||'[0]=new array_sector2("Seleccione tipo de entidad financiera ...","-1");');
            for xrow4 in ctipoBanco(xrow3.cod_banco_seguro) loop
                usp_print('B'||xrow3.cod_banco_seguro||'['||i||'] = new array_sector2("'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow4.desc_banco_seguro)||'","'||xrow4.cod_banco_seguro||'"); ');
                i := i+1;
            end loop;
        end loop;

    
    usp_print('
    function mostrar_array(cual,donde, cam){
        if(cual.selectedIndex != 0){
        donde.length=0
        cual = eval(cual.value)
        for(m=0;m<cual.length;m++){
            var nuevaOpcion = new Option(cual[m].texto);
            donde.options[m] = nuevaOpcion;
   
    if(cual[m].valor != null){
      donde.options[m].value = cual[m].valor
      }
    else{
      donde.options[m].value = cual[m].texto
      }
    }
  }
 
  mostrarMensaje(cam);
}

function f_validaCampoNumerico()
        {
            escribe=1;
            var key=window.event.keyCode;            //codigo de tecla.
            if (key <46 || key > 57 || key==47){     //si no es numero o punto decimal "."
                window.event.keyCode=0;                  //anula la entrada de texto.
            }
        }
        
function ValidarDecimal (ls_obj,ls_mensage)
        {
            if ( ls_obj.value != "" )
            {
                if (!isDecimal(ls_obj.value))
                {
                    ls_obj.select();
                    alert("Ingrese Numero decimal correcto en el campo " + ls_mensage )
                    ls_obj.focus()
                    return false
                }
                else
                    if ( !parseFloat(ls_obj.value) )
                    {
                        alert("Ingrese Numero decimal correcto en el campo " + ls_mensage )
                        ls_obj.focus()
                        return false
                    }
                    else
                        return true;
              }
        }        
    
    </script>');
    usp_print('<table width=100% class="table table-striped">');
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero del Contrato (u Orden de Compra o Servicio)',
                '<input type="text" name="n_contrato" readonly style="width:98%" value="'||row_contrato.n_contrato||'"/>',
                '.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Clases de Garantias',
                 lv_combo_claseGarantia ,
                'Clases de Garantias.'));


    /*cleonv 
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Tipo de Garantia',
                '<select name="ag_cod_tipo_gar" style="width:99%" onchange="javascript:tipoGarantia(this.value);inicializaselect(''ag_entidad_fin'',''Seleccione entidad financiera ...'',''-1'');"></select>',
                'Seleccione el tipo de garant&iacute;a a crear.'));*/
                
    usp_print('<tr><td class=c1>(*)Tipo de Garantia</td><td class=c2><select name="ag_cod_tipo_gar" class="cag_cod_tipo_gar" style="width:99%" onchange="mostrar_array(this,thisform.ag_tipo_ent_fin, this.value)">');    
    usp_print('<option  value="-1">Seleccione tipo de garantia ...</option>');
    for xrow in cTipoGarantia loop
        usp_print('<option  value="A'||xrow.cod_tipo_garantia||'">'||xrow.des_tipo_garantia||'</option>');
    end loop;
    usp_print('</select></td><td class=c3>Seleccione el tipo de garant&iacute;a a crear.</td></tr>');   

   -- usp_print('<script language=javascript>loadOptions("ag_cod_tipo_gar","xmlTipoGarantia","root/tipogarantia/codigo","root/tipogarantia/descripcion","Seleccione tipo de garantia ...","-1")</script>');


    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Tipo Entidad Financiera',
                '<select name="ag_tipo_ent_fin" style="width:99%" onchange="mostrar_array(this,thisform.ag_entidad_fin, this.value)">
                 <option value="-1">Seleccione tipo de entidad financiera ...</option>
                 </select>',
                'Seleccione el tipo de entidad financiera.'));


    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Entidad Financiera',
                '<div id=dvCbEntidad>
                      <select name="ag_entidad_fin" style="width:99%">
                          <option value="-1">Seleccione entidad financiera ...</option>
                      </select>
                 </div>
                 <div id=dvBancoExt><input type=text name=ag_banco_extranjero  id=ag_banco_extranjero value=""  style="width:98%"></div>',
                '<div id=dvBancoNac>Seleccione la entidad.</div>
                 <div id=dvTBancoExt>Escriba el nombre del banco. (Verifique la relacion de bancos de primera categor&iacute;a que publica el Banco Central de Reserva del Per&uacute;).</div>'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Moneda',
                 lv_combo_moneda ,
                'Seleccione la moneda.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Monto',
                '<input name="ag_monto_contrato" value="" class="form-control" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this)"/>',
                'Ingrese el monto de la garant&iacute;a.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha de Emisi&oacute;n',
                '<div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fecha_emision" value="" style="width:98%" data-format="dd/MM/yyyy" class="form-control"/>
          </div>',
                'Ingrese la fecha de emisi&oacute;n de la garant&iacute;a.'));
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha de Vencimiento',
                '<div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fecha_vencim" value="" style="width:98%" data-format="dd/MM/yyyy" class="form-control"/>
          </div>',
                'Ingrese la fecha de vencimiento de la garant&iacute;a.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjuntar Archivo',
                '<input type="file" class="form-control"  name="pfiletoupload1" size="48"  value="">
                <input type="hidden" name="pfiletoupload_file1" value="" />',
                'Seleccione el archivo que contiene la garantia, solo se permiten archivos *.doc, *.pdf o *.zip'));

usp_print('<tr><td class=c1>(*)Tipo de Garantia</td><td class=c2>');

usp_print('</td><td class=c3>Seleccione el tipo de garant&iacute;a a crear.</td></tr>'); 

    usp_print('
    </table>');

    usp_print('<br>
               <div id=dvMensaje >
               <table border="1" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
                   <tr><td align="center"><i><b> Toda Entidad Publica debera verificar, bajo responsabilidad, que el Banco Extranjero que otorga la garantia se encuentre en el Listado de Bancos de primera categor&iacute;a que publica el Banco Central de Reserva del Per&uacute;</b></i></td></tr>
               </table><br/>
               </div>
               <table border="1" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
                   <tr><td align="center"><i><b>Las Entidades P&uacute;blicas deben verificar la Relaci&oacute;n de Empresas que se encuentran autorizadas a emitir Cartas Fianza,<br>dicho listado se encuentra en el portal p&uacute;blico de la Superintendencia de Banca, Seguros y AFP </b></i></td></tr>
               
               
               </table>');

usp_print('<input type="hidden" name=extension value="">');
    ------------ Script ------------
    usp_print('
    <script language="javascript">
            document.all("dvMensaje").style.display="none"
            document.all("dvBancoExt").style.display="none"
            document.all("dvTBancoExt").style.display="none"
            
            
    function mostrarMensaje(valor){
   
             if (valor == "B110"){
                document.all("dvMensaje").style.display   = ""
                document.all("dvBancoExt").style.display  = ""
                document.all("dvTBancoExt").style.display = ""
                document.all("dvBancoNac").style.display  = "none"
                document.all("dvCbEntidad").style.display = "none"
                document.all("ag_tipo_ee_ff_ext").value = 180;
                
             }
             else{
                document.all("dvMensaje").style.display   = "none"
                document.all("dvBancoExt").style.display  = "none"
                document.all("dvTBancoExt").style.display = "none"
                document.all("dvBancoNac").style.display  = ""
                document.all("dvCbEntidad").style.display = ""
             }
    }

    function tipoGarantia(codigo){

       if (codigo==1){
          loadOptions("ag_tipo_ent_fin","xmlTipoEEFF1","root/tipoeeff/codigo","root/tipoeeff/descripcion","Seleccione tipo de entidad Financiera ...","-1")
          return;
          }

       if (codigo==2){
          loadOptions("ag_tipo_ent_fin","xmlTipoEEFF2","root/tipoeeff/codigo","root/tipoeeff/descripcion","Seleccione tipo de entidad Financiera ...","-1")
           return;
          }

       //inicializaselect("ag_tipo_ent_fin","Seleccione tipo de entidad Financiera ...","-1");

  }

    function activarFielCumpl()
    {
        if ( thisform.ag_ind_fiel_cump.checked )
            thisform.ag_tipo_fiel_cumpl.disabled = false;
        else
            thisform.ag_tipo_fiel_cumpl.disabled = true;
    }

    function ValidarItems( thisform )
    {
        if ( thisform.ag_ind_fiel_cump.checked == false &&
             thisform.ag_ind_adelanto.checked == false &&
             thisform.ag_ind_monto_dif.checked == false )
        {
            alert("Por favor seleccione algun tipo de Ejecucion");
                return false;
        }
        else
        {
            return true;
        }
    }

    /*************************************************************************
      Verifica  que una de las fecha de ingreso sea mayor a la otra
    **************************************************************************/

    function ValidarFechas1(fec1,fec2, text1, text2)
      {
       fec1 = getDateObject(fec1.value)
       fec2 = getDateObject(fec2.value)
      if(fec1.getTime()>fec2.getTime())
        {
        alert("La fecha de "+text1+" debe ser mayor a la fecha de "+text2);
        //fec1.focus();
        return false;
        }
    //  alert("retornando true")
      return true
      }

    function ValidarCheck( thisform )
    {
        var msg = "";
        if ( thisform.ag_ind_fiel_cump.checked == true )
            msg += "Fiel Cumplimiento";
        if ( ( thisform.ag_ind_fiel_cump.checked == true && thisform.ag_ind_adelanto.checked == true ) ||
             ( thisform.ag_ind_fiel_cump.checked == true && thisform.ag_ind_monto_dif.checked == true )
           )
        {
            msg += ",";
        }
        if ( thisform.ag_ind_adelanto.checked == true )
            msg += "Adelanto";
        if ( thisform.ag_ind_adelanto.checked == true && thisform.ag_ind_monto_dif.checked == true )
            msg += ",";
        if ( thisform.ag_ind_monto_dif.checked == true )
            msg += "Monto Diferencial";

        if ( thisform.ag_ind_fiel_cump.checked )
        {
            if ( thisform.ag_tipo_fiel_cumpl.value == "-1" )
            {
                alert("Seleccione el tipo de Garantia de Fiel Cumplimiento");
                thisform.ag_ind_fiel_cump.focus();
                return false;
            }
        }

        if ( window.confirm("Esta seguro de que la garantia sea grabada por " + msg + "?") )
            return true;
        else
            return false;
    }
      //------------------------------quita caracteres en blanco en la cadena-------------
        function trim(psString)
        {
            return String(psString).replace(/[\s]/g,"");
        }

        //------- Verifica si una cadena es vacia -------
        function vacio(ls_cadena) {
            if (ls_cadena == " " || ls_cadena == null || ls_cadena.length == 0)
                return true;
            else return false;
        }

    function Blanco(ls_cadena)
        {   var i;
            if (vacio(ls_cadena)) return true;
            for (i = 0; i < ls_cadena.length; i++)
            {
                if (ls_cadena.charAt(i) != " ") return false;
            }
            return true;
        }
    function ValidarBlanco(ls_obj,ls_mensage)
        {
            if (Blanco(trim( ls_obj.value )))
            {
                alert("Por favor ingrese " + ls_mensage);
                ls_obj.value="";
                ls_obj.focus();
                return false;
            }
            return true;
        }



   function grabar( obj, objScrdo )
    {
        var f_emision = thisform.ag_fecha_emision;
        var f_venc    = thisform.ag_fecha_vencim;

        if ( thisform.ag_tipo_ent_fin.value.substr(1) == 85 )
            thisform.ag_cod_banco.value = thisform.ag_tipo_ent_fin.value;
        else
            thisform.ag_cod_banco.value = thisform.ag_entidad_fin.value;

        if ( thisform.ag_cod_tipo_gar.value.substr(1) == "-1" )
        {
            alert("Seleccione el tipo de garantia.");
            thisform.ag_cod_tipo_gar.focus();
            return false;
        }
        if ( thisform.ag_tipo_ent_fin.value.substr(1) == "-1" )
        {
            alert( "Seleccione el tipo de entidad financiera." );
            thisform.ag_tipo_ent_fin.focus();
            return false;
        }
        if ( thisform.ag_entidad_fin.value == "-1"  && thisform.ag_tipo_ent_fin.value.substr(1) != 110  /* thisform.ag_tipo_ent_fin.value.substr(1) != 85*/ )
        {
            alert( "Seleccione la entidad financiera." );
            thisform.ag_entidad_fin.focus();
            return false;
        }

        if ( thisform.ag_mon_codigo.value == "-1" )
        {
            alert( "Seleccione la moneda." );
            thisform.ag_mon_codigo.focus();
            return false;
        }

        if ( !ValidarBlanco(thisform.ag_monto_contrato,"Monto de la Garantia") )
            return false;

        if ( !ValidarBlanco(thisform.ag_fecha_emision,"Fecha de Emision") )
            return false;

        if ( !ValidarBlanco(thisform.ag_fecha_vencim,"Fecha de Vencimiento") )
            return false;

        if ( !ValidarFechas1(thisform.ag_fecha_emision,thisform.ag_fecha_vencim,"vencimiento","emision") )
            return false;
            
        var extension = thisform.pfiletoupload1.value.substring(thisform.pfiletoupload1.value.length-4);
        extension = extension.replace(".","");
        var namearchive = "'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'."+extension;
            thisform.pfiletoupload_file1.value = namearchive;
            thisform.extension.value = extension;
        thisform.scriptdo.value=objScrdo;
        thisform.submit();
        return true;
    }
    </script>');


End;

function f_valida_procesov3 (
ag_cod_contrato             varchar2
)
return number
is
cant number;
begin
select count(*) into cant
from reg_procesos.procesos p
where p.n_id_expede is not null
and p.n_proceso in
( select cc.n_proceso
from reg_procesos.convocatorias cc
where cc.n_convoca = ag_cod_contrato
);


return cant;

end;
    PROCEDURE uspLisGarantiasDoView(
    ag_n_convoca                varchar2,
    ag_cod_contrato             varchar2,
    ag_ncor_orden_pedido        varchar2,
    ag_cm_opc                   varchar2,
    ag_cm_oper_compra           varchar2,
    ag_anhoentidad              varchar2,
    ag_proc_tipo                varchar2,
    ag_proc_desc                varchar2,
    ag_proc_sigla               varchar2,
    ag_currenpage               varchar2,
    session__n_convoca          varchar2,
    session__cod_contrato       varchar2,
    session__PUBLICADO          varchar2,
    session__FileSingedHTTP     varchar2)
IS
    ------- Cursores -------
    --- Listado de la App
    Cursor c_app(p_contrato number) is
    select d.n_cod_contrato,d.cod_clase,cl.str_clase,
    ( case d.ind_presento when 1 then 'SI'
                          when 2 then 'NO' end ) presento
    ,d.cod_razon,ra.str_razon
    from GARANTIA_DECLARACION d
    INNER JOIN REG_PROCESOS.GARANTIA_CLASE cl on d.cod_clase = cl.cod_clase
    left outer join reg_procesos.garantia_razon ra on d.cod_razon = ra.cod_razon
    where d.n_cod_contrato = p_contrato
    order by d.cod_clase;

    ------- Listado de Garantias -------
    Cursor c_garantias(p_n_cod_contrato in number) is
    Select distinct
        c.n_convoca, c.n_contrato, g.n_cod_contrato, g.cod_garantia,
        g.tipo_garantia_otro, tg.des_tipo_garantia,
        to_char(g.monto_garantia,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) monto_garantia,
        m.descripcion,
        to_char(g.fec_emision,'dd/mm/yyyy') fec_emision,
        to_char(g.fec_vencimiento,'dd/mm/yyyy') fec_vencimiento,
        to_char(g.f_ejec_garantia,'dd/mm/yyyy') f_ejec_garantia,
        ind_fiel_cump, ind_adelanto, ind_monto_dif,
        doc.doc_url,
        doc.fec_upload,
        doc.cod_doc,
        t.icon_tipo_file,
        (
        case
             when  g.IND_FIEL_CUMPLI = 1 then 'GARANTIA DE FIEL CUMPLIMENTO'
             when  g.IND_FIEL_CUMPLI_PA = 1 then 'GARANTIA DE FIEL CUMPLIMIENTO POR PRESTACIONES ACCESORIAS'
             when  g.IND_MONTO_DIF = 1 then 'GARANTIA POR MONTO DIFERENCIAL DE PROPUESTA'
             when  g.IND_ADELANTO = 1 then 'GARANTIA POR ADELANTO'
             when  g.IND_BUEN_RENDIMIENTO = 1 then 'GARANTIA POR BUEN RENDIMIENTO'

        end
        ) clase
    from
        REG_PROCESOS.contrato c
        inner join REG_PROCESOS.garantia g on c.n_cod_contrato = g.n_cod_contrato
        inner join REG_PROCESOS.t_tipo_garantia tg on  g.cod_tipo_garantia   = tg.cod_tipo_garantia
        inner join REG_PROCESOS.monedas m on  g.cod_moneda = m.codmoneda
        left outer join reg_procesos.convocatoria_doc doc on g.cod_doc = doc.cod_doc
        left outer join REG_PROCESOS.tipo_archivo t ON doc.COD_TIPO_FILE = T.COD_TIPO_FILE
    where
        g.n_cod_contrato      = p_n_cod_contrato
        and ( c.ind_contrato_pub <> 1
            or  (
                    c.ind_contrato_pub = 1
                    and g.f_registra < c.f_publica
                    and g.f_registra is not null
                    and c.f_publica is not null
                )
            )

    order by
        to_char(g.cod_garantia, '99999999');


   Cursor c_garantias_after(p_n_cod_contrato in number) is
    Select distinct
        c.n_convoca, c.n_contrato, g.n_cod_contrato, g.cod_garantia,
        g.tipo_garantia_otro, tg.des_tipo_garantia,
        to_char(g.monto_garantia,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) monto_garantia,
        m.descripcion,
        to_char(g.fec_emision,'dd/mm/yyyy') fec_emision,
        to_char(g.fec_vencimiento,'dd/mm/yyyy') fec_vencimiento,
        to_char(g.f_ejec_garantia,'dd/mm/yyyy') f_ejec_garantia,
        ind_fiel_cump, ind_adelanto, ind_monto_dif,
        doc.doc_url,
        doc.fec_upload,
        doc.cod_doc,
        t.icon_tipo_file,
        (
        case
             when  g.IND_FIEL_CUMPLI = 1 then 'GARANTIA DE FIEL CUMPLIMENTO'
             when  g.IND_FIEL_CUMPLI_PA = 1 then 'GARANTIA DE FIEL CUMPLIMIENTO POR PRESTACIONES ACCESORIAS'
             when  g.IND_MONTO_DIF = 1 then 'GARANTIA POR MONTO DIFERENCIAL DE PROPUESTA'
             when  g.IND_ADELANTO = 1 then 'GARANTIA POR ADELANTO'
             when  g.IND_BUEN_RENDIMIENTO = 1 then 'GARANTIA POR BUEN RENDIMIENTO'

        end
        ) clase
    from
        REG_PROCESOS.contrato c
        inner join REG_PROCESOS.garantia g on c.n_cod_contrato = g.n_cod_contrato
        inner join REG_PROCESOS.t_tipo_garantia tg on  g.cod_tipo_garantia   = tg.cod_tipo_garantia
        inner join REG_PROCESOS.monedas m on  g.cod_moneda = m.codmoneda
        inner join reg_procesos.convocatorias conv on conv.n_convoca = c.n_convoca
        left outer join reg_procesos.convocatoria_doc doc on g.cod_doc = doc.cod_doc
        left outer join REG_PROCESOS.tipo_archivo t ON doc.COD_TIPO_FILE = T.COD_TIPO_FILE
    where
        g.n_cod_contrato      = p_n_cod_contrato
        and ( c.ind_contrato_pub = 1  and g.f_registra > nvl(c.f_publica,c.f_registro) -- cuando no tiene fecha de pub toma la fecha de registro del contrato 11/03/2011 -- :)
           /* casos anteriores f_publica y g.f_registra no existian */
           --or  ( c.ind_contrato_pub = 1  and (  reg_procesos.pku_ss_garantias.f_valida_inicio(conv.n_convoca)) = 0 )
           or  ( c.ind_contrato_pub = 1  and (  reg_procesos.pku_ss_garantias.f_valida_inicio_v3(conv.n_convoca)) = 0 )
        )
    order by
        to_char(g.cod_garantia, '99999999');

    ------- Variables ------
    e_ArgumentosMalos   exception;
    ln_n_convoca        number;
    ln_cod_contrato     number;
    lv_maxi             varchar2(10);
    ln_Cont_Fila        number;
    ln_color            varchar2(50);
    ln_app              number;
    ln_count_declara    number;
    ln_proc_tipo        number;
    ln_modulo number;        -- (1/3) 12.09.2020 , permite verificar si las acciones sobre el contrato deben estas habilitados

Begin


    if( session__cod_contrato is not null ) then
        ln_n_convoca    := session__n_convoca;
        ln_cod_contrato := session__cod_contrato;
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

/*usp_print('<br>ln_cod_contrato:'||ln_cod_contrato);*/
/*usp_print('<br>ln_cod_contrato:'||ln_cod_contrato);
*/  select count(1) into ln_app
    from GARANTIA_DECLARACION d
    INNER JOIN REG_PROCESOS.GARANTIA_CLASE cl on d.cod_clase = cl.cod_clase
    left outer join reg_procesos.garantia_razon ra on d.cod_razon = ra.cod_razon
    where d.n_cod_contrato  = ln_cod_contrato;

    select count(1) into ln_count_declara
    from GARANTIA_DECLARACION d
    INNER JOIN REG_PROCESOS.GARANTIA_CLASE cl on d.cod_clase = cl.cod_clase
    left outer join reg_procesos.garantia_razon ra on d.cod_razon = ra.cod_razon
    where d.n_cod_contrato  = ln_cod_contrato
    and d.ind_presento = 1;

    select proc_tipo into ln_proc_tipo from convocatorias where n_convoca = session__n_convoca;

    -------- Java Script -------
    REG_PROCESOS.PKU_GESTOR_CONT_FUNCIONES_JS_3.fEfecto_Imagenes_JS;

    reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('
       function eliminar(garantia,documento){
        if ( window.confirm("?Esta seguro de que desea eliminar la garantia?") ){

                thisform.ag_garantia.value = garantia
                thisform.ag_documento.value = documento
                thisform.scriptdo.value = "doDelGarantia"
                thisform.submit();
            }
        else
            return false;

       }

    ');

    select max( trim(to_char(c.proc_item, '99999999')) ) into lv_maxi
    from reg_procesos.item_contrato c
    where  c.n_cod_contrato = ln_cod_contrato;

    --- declaracion de valiables de entorno
    usp_print('
    <input type="hidden" name="ag_n_convoca"            value="'||ag_n_convoca||'"/>
    <input type="hidden" name="ag_cod_contrato"         value="'||ag_cod_contrato||'"/>
    <input type="hidden" name="ag_cod_garantia"         value=""/>
    <input type="hidden" name="ag_ncor_orden_pedido"    value="'||ag_ncor_orden_pedido||'"/>
    <input type="hidden" name="ag_cm_opc"               value="'||ag_cm_opc||'"/>
    <input type="hidden" name="ag_cm_oper_compra"       value="'||ag_cm_oper_compra||'"/>
    <input type="hidden" name="ag_anhoentidad"          value="'||ag_anhoentidad||'"/>
    <input type="hidden" name="ag_proc_tipo"            value="'||ag_proc_tipo||'"/>
    <input type="hidden" name="ag_proc_desc"            value="'||ag_proc_desc||'"/>
    <input type="hidden" name="ag_proc_sigla"           value="'||ag_proc_sigla||'"/>
    <input type="hidden" name="ag_currenpage"           value="'||ag_currenpage||'"/>
    <input type="hidden" name="ag_garantia"             value=""/>
    <input type="hidden" name="ag_documento"            value=""/>
     <input type="hidden" name="PUBLICX"            value="'||session__PUBLICADO||'"/>
     <input type="hidden" name="indicador"            value="'||f_valida_procesov3(session__n_convoca)||'"/>


    <table border="0" width=100% align=center  cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato ( session__COD_CONTRATO, 'Garant&iacute;as' )
    );

    if( session__PUBLICADO <> 1 ) then
          if f_valida_procesov3(session__n_convoca) = 0 then
          
        if PKU_SS_UTILES.f_get_tipo_validos(session__n_convoca) > 0 and f_valida_inicio(session__n_convoca) > 0 then

            usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Declarar Aplicacion" OnClick="thisform.scriptdo.value=''doViewApp'';thisform.submit();"/>
            </td>

        ');


       else

        usp_print('</table>');
        usp_print(
            pku_procesos_comun.f_putMensaje(
                '<br><br><br>Publique el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...<br><br><br><br>',
                '')
     );
       return;
       end if;
       else
        if PKU_SS_UTILES.f_get_tipo_validos_v3(session__n_convoca) > 0 and f_valida_inicio_v3(session__n_convoca) > 0 then

            usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Declarar Aplicacion" OnClick="thisform.scriptdo.value=''doViewApp'';thisform.submit();"/>
            </td>

        ');


       else

        usp_print('</table>');
        usp_print(
            pku_procesos_comun.f_putMensaje(
                '<br><br><br>Publique el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...<br><br><br><br>',
                '')
     );
       return;
       end if;
       end if;
    end if;



/*     usp_print('<br>ln_app:'||ln_app);
usp_print('<br>ln_count_declara:'||ln_count_declara);
usp_print('<br>ln_proc_tipo:'||ln_proc_tipo);
usp_print('<br>f_valida_inicio:'||f_valida_inicio(ln_n_convoca));
usp_print('<br>f_valida_directiva:'||f_valida_directiva(ln_cod_contrato));
usp_print('<br>ln_cod_contrato:'||ln_cod_contrato);*/

 -- (3/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
 if ln_modulo = 1 then 
      if f_valida_procesov3(session__n_convoca) = 0 then
        if( ( ln_app > 0 and ln_count_declara >= 0 ) or ln_proc_tipo in (11,23,40) or  (f_valida_inicio(ln_n_convoca) = 0)  or (f_valida_directiva(ln_cod_contrato,ln_n_convoca)=1) ) then
          usp_print('
                  <td align="right" valign=top width="50%">
                      <input type="button" value="Crear Garantia" OnClick="thisform.scriptdo.value=''doNewGarantias'';thisform.submit();"/>
                  </td>');
        end if;
        else
        
         if( ( ln_app > 0 and ln_count_declara >= 0 ) or ln_proc_tipo in (11,23,40) or  (f_valida_inicio_v3(ln_n_convoca) = 0)  or (f_valida_directiva(ln_cod_contrato,ln_n_convoca)=1) ) then
          usp_print('
                  <td align="right" valign=top width="50%">
                      <input type="button" value="Crear Garantia" OnClick="thisform.scriptdo.value=''doNewGarantias'';thisform.submit();"/>
                  </td>');
        end if;
    end if;
 end if;
    /*if f_valida_inicio(ln_n_convoca) = 0 then
      usp_print('
              <td align="right" valign=top width="50%">
                  <input type="button" value="Crear Garantia" OnClick="thisform.scriptdo.value=''doNewGarantias'';thisform.submit();"/>
              </td>');
    end if;
*/
    usp_print('</tr>
    </table>
    <br>');


    if ln_app > 0 then
      usp_print('<table border="0" width=100% align=center class="table table-striped" cellpadding=3 cellspacing=0>');
      usp_print('<tr><td colspan=3><h3>Declarar aplicaci&oacute;n del requisito Garant&iacute;as para la suscripci&oacute;n del contrato:</h3></td></tr>');

      for xrow in c_app(ln_cod_contrato) loop
      usp_print('<tr><td>'||xrow.str_clase||'</td>
                     <td>'||xrow.presento||'</td>
                     <td>'||xrow.str_razon||'</td></tr>');

      end loop;

      usp_print('</table>');
    end if;

     -- Declarar aplicaci?n del requisito Garant?as para la suscripci?n del contrato
    usp_print('<br><br>
    <table width=100% class="table table-striped table-bordered table-hover data Table no-footer">');

    usp_print('<tr><td colspan=8><h3>Garantias registradas para la suscripci&oacute;n del Contrato</h3></td></tr>');

    usp_print('<th class="th1">Garantia Nro</th>
        <th class="th1">Tipo de Garantia</th>
        <th class="th1">Moneda</th>
        <th class="th1">Monto</th>
        <th class="th1">Fecha de Emisi&oacute;n</th>
        <th class="th1">Fecha de Vencimiento</th>
        <th class="th1">Clase de Garantia</th>
        <th class="th1">Garantia</th>
        <tr class="th1">&nbsp;&nbsp;&nbsp;</th>
    ');



    ------ Listado de Garantias ---
    ln_Cont_Fila:=1;
    for cg in c_garantias(ln_cod_contrato) loop
        
        usp_print('
        <tr>
            <td align="center" width="90">
                <b>'||makea('ag_n_convoca='||ln_n_convoca||'&ag_cod_garantia='||cg.cod_garantia||'&scriptdo=doViewGarantiaDetalle',cg.cod_garantia)||'<b>
            </td>
            <td align="center" width="125">'||cg.des_tipo_garantia||'</td>
            <td align="center" width="80">'||cg.descripcion||'</td>
            <td align="right"  width="90">'||cg.monto_garantia||'</td>
            <td align="center" width="100">'||cg.fec_emision||'</td>
            <td align="center" width="100">'||cg.fec_vencimiento||'</td>
            <td align="left" >'||cg.clase||'</td>
            <td align="center" width="90" >');
              if cg.doc_url is not null then
                  usp_print(' <a target=_blank href="'||url_azure_app||session__FileSingedHTTP||replace(cg.doc_url,'\','/') ||'" >
                    <img src="bootstrap/'||replace(cg.icon_tipo_file, 'jpg', 'png')||'" border="0" width="30" height="30"/>
                 </a></td>');
              end if;
      if( session__PUBLICADO <> 1 ) then
      usp_print('
              <td valign=middle> <img src=img/eliminar.gif alt=Elimnar onclick="eliminar('||trim(cg.cod_garantia)||','||nvl(cg.cod_doc,0)||')"></td>
              ');
      end if;

      usp_print('</tr>');
        ln_Cont_Fila:= ln_Cont_Fila + 1;
    end loop;
    usp_print('
    </table>');

  -- Garantias registradas durante la ejecuci?n Contractual
  usp_print('<br><br>
    <table width=100% class="table table-striped table-bordered table-hover data Table no-footer">');

    usp_print('<tr><td colspan=8><h3>Garantias registradas durante la ejecuci&oacute;n Contractual</h3></td></tr>');

    usp_print('<th class="th1">Garantia Nro</th>
        <th class="th1">Tipo de Garantia</th>
        <th class="th1">Moneda</th>
        <th class="th1">Monto</th>
        <th class="th1">Fecha de Emisi&oacute;n</th>
        <th class="th1">Fecha de Vencimiento</th>
        <th class="th1">Clase de Garantia</th>
        <th class="th1">Garantia</th>
        <tr class="th1">&nbsp;&nbsp;&nbsp;</th>
    ');



    ------ Listado de Garantias ---
    ln_Cont_Fila:=1;
    for cg in c_garantias_after(ln_cod_contrato) loop
        if mod(ln_Cont_Fila,2) = 0 then
            ln_color := 'bgcolor="#ECE9D8"';
        else
            ln_color := '';
        end if;
        usp_print('
        <tr '||ln_color||'>
            <td align="center" width="90">
                <b>'||makea('ag_n_convoca='||ln_n_convoca||'&ag_cod_garantia='||cg.cod_garantia||'&scriptdo=doViewGarantiaDetalle',cg.cod_garantia)||'<b>
            </td>
            <td align="center" width="125">'||cg.des_tipo_garantia||'</td>
            <td align="center" width="80">'||cg.descripcion||'</td>
            <td align="right"  width="90">'||cg.monto_garantia||'</td>
            <td align="center" width="100">'||cg.fec_emision||'</td>
            <td align="center" width="100">'||cg.fec_vencimiento||'</td>
            <td align="left">'||cg.clase||'</td>
            <td align="center" width="90">');
              if cg.doc_url is not null then
                  usp_print(' <a target=_blank  href="'||url_azure_app||session__FileSingedHTTP||replace(cg.doc_url,'\','/')||'" >
                    <img src="bootstrap/'||replace(cg.icon_tipo_file, 'jpg', 'png')||'" border="0" width="30" height="30"/>
                 </a></td>');
              end if;
      if( session__PUBLICADO <> 1 ) then
        usp_print('
                <td valign=middle> <img src=images/Eliminar.gif alt=Elimnar onclick="eliminar('||trim(cg.cod_garantia)||','||nvl(cg.cod_doc,0)||')"></td>
                ');
      end if;
      usp_print('</tr>');
        ln_Cont_Fila:= ln_Cont_Fila + 1;
    end loop;
    usp_print('
    </table>');


exception
    when e_ArgumentosMalos then
        raise_application_error(-20000,'Se detecto una incorrecta asignacion de valores en los argumentos');
End;

end PKU_GESTOR_CONT_GARANTIAS;
/
