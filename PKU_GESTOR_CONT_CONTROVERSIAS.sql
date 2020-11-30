set scan off
CREATE OR REPLACE PACKAGE                "PKU_GESTOR_CONT_CONTROVERSIAS" IS

    --consultoria nube migracion
  url_azure_app    varchar2(250):= 'https://zonasegura2.seace.gob.pe/documentos/';
  
 TYPE ref_cursor IS REF CURSOR;
 
 
  PROCEDURE dojscript;
 
 

PROCEDURE uspHistorialDetalle (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
    session__USERID VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_arbitraje                  VARCHAR2 ,
  ag_tipo_arbitro                    VARCHAR2 ,
    ag_numero_registro                   number ,
    ag_cod                                VARCHAR2,
    ag_f_autoriza                           VARCHAR2,
    ag_num                                  VARCHAR2
  );
    
 
  PROCEDURE uspHistorial (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
      session__USERID VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_arbitraje                  VARCHAR2 ,
  ag_tipo_arbitro                    VARCHAR2 ,        
    ag_numero_registro                   number ,
    ag_cod                                VARCHAR2,
    ag_f_autoriza                           VARCHAR2
  )  ;
 
 
 PROCEDURE uspArbitrajeEdit( 
   session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
    session__USERID VARCHAR2 DEFAULT NULL,
     session__IIS_REMOTE_ADDR   VARCHAR2,  
      iisenv__REMOTE_HOST varchar2,
ag_tipo_demandante        varchar2,
ag_mecanismo              varchar2,
ag_tipo_arbitraje         varchar2,
ag_tipo_arbitro           varchar2,
ag_f_autoriza             varchar2,
ag_ruc_presidente         varchar2,
ag_nombre_presidente      varchar2,
ag_sunat_presidente       varchar2,
ag_ruc_arbitro_ent        varchar2,
ag_mom_arbitro_ent        varchar2,
ag_sunat_arbitro_ent      varchar2,
ag_ruc_arbitro_cont       varchar2, 
ag_nombre_arbitro_cont    varchar2,
ag_sunat_arbitro_cont     varchar2,
ag_ruc_arb_unico          varchar2,                                       
ag_nom_nom_unico          varchar2,
ag_num_reg                number,
ag_motivo_presidente      varchar2,
ag_motivo_arbitro_ent     varchar2,
ag_motivo_arbitro_cont    varchar2,

ag_nombres_presidente     varchar2,
ag_apePat_presidente      varchar2,
ag_apeMat_presidente      varchar2,
ag_nombres_ent            varchar2,
ag_apePat_ent             varchar2,
ag_apeMat_ent             varchar2,
ag_nombres_cont           varchar2,
ag_apePat_cont            varchar2,
ag_apeMat_cont            varchar2,
--Inicio mlaura Req 55
ag_nombres_secretario     varchar2, 
ag_apepat_secretario      varchar2, 
ag_apemat_secretario      varchar2,
ag_ruc_secretario         varchar2,
ag_nombre_secretario      varchar2,
ag_sunat_secretario       varchar2,
ag_motivo_secretario      varchar2,
--Fin mlaura Req 55
ag_tipo_seleccion                number -- ddrodriguez Req 55
 );
 
 PROCEDURE uspLisControversiasdoview ( 
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL, 
  session__user_id  VARCHAR2 DEFAULT NULL 
  );
  
   PROCEDURE uspCreaControversias (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2,
  ag_mecanismo                       VARCHAR2  
  );
  
  
 
 PROCEDURE uspCreaArbitraje (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_arbitraje                  VARCHAR2 ,
  ag_tipo_arbitro                    VARCHAR2 ,
  sunat                                VARCHAR2,
  ag_f_autoriza                          VARCHAR2
  )  ;
  
  
  
  PROCEDURE uspArbitrajeInsert( 
   session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
    session__USERID VARCHAR2 DEFAULT NULL,
   session__IIS_REMOTE_ADDR   VARCHAR2,
   iisenv__REMOTE_HOST varchar2,
ag_tipo_demandante        varchar2,
ag_mecanismo              varchar2,
ag_tipo_arbitraje         varchar2,
ag_tipo_arbitro           varchar2,
ag_f_autoriza             varchar2,
ag_ruc_presidente         varchar2,
ag_nombre_presidente      varchar2,
ag_sunat_presidente       varchar2,
ag_ruc_arbitro_ent        varchar2,
ag_mom_arbitro_ent        varchar2,
ag_sunat_arbitro_ent      varchar2,
ag_ruc_arbitro_cont       varchar2,
ag_nombre_arbitro_cont    varchar2,
ag_sunat_arbitro_cont     varchar2,
ag_ruc_arb_unico          varchar2,
ag_nom_nom_unico          varchar2,

ag_nombres_presidente      varchar2,
ag_apePat_presidente       varchar2,
ag_apeMat_presidente       varchar2,
ag_nombres_ent             varchar2,
ag_apePat_ent              varchar2,
ag_apeMat_ent              varchar2,
ag_nombres_cont            varchar2,
ag_apePat_cont             varchar2,
ag_apeMat_cont             varchar2,

--Inicio mlaura Req 55
ag_nombres_secretario     varchar2, 
ag_apepat_secretario      varchar2, 
ag_apemat_secretario      varchar2,
ag_ruc_secretario         varchar2,
ag_nombre_secretario      varchar2,
ag_sunat_secretario       varchar2,
ag_motivo_secretario      varchar2
--Fin mlaura Req 55
 );
 
 
 
  PROCEDURE uspCreaConciliacion(
   session__eue_codigo      VARCHAR2,
    session__anhoentidad     VARCHAR2,
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_estado                      VARCHAR2,
  ag_archivo                          varchar2,
  ag_c_conciliacion                   number, 
    session__maxMBUploadFileSize   varchar2 default null,
    docname__mime                  varchar2 default null,
    session__FileSinged            varchar2 default null  
  )   ;
 

 
PROCEDURE uspConciliacionInsert( 
   session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
ag_tipo_demandante        varchar2,
ag_mecanismo              varchar2,
ag_tipo_estado            varchar2,
ag_f_audiencia            varchar2,
ag_fs_acta_conciliacion   varchar2, -- manuel Req 55
ag_ruc_conciliador        varchar2, 
ag_nombre_conciliador     varchar2,
ag_c_conciliacion         number,            

        pfiletoupload1                 varchar2,
    pfiletoupload_file1            varchar2,
    WriteFileDirectoryDynamic    varchar2,
    session__seacedocument                  varchar2,
            session__seacedocumentosdwn             varchar2,
            session__maxMBUploadFileSize            varchar2,
            docname_mimetype                        varchar2,
            iisenv__remote_host                varchar
   
 );  
 
  
   PROCEDURE uspEditArbitraje (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_arbitraje                  VARCHAR2 ,
  ag_tipo_arbitro                    VARCHAR2 ,
    ag_numero_registro               number ,
    ag_cod                              VARCHAR2,
    ag_f_autoriza                         VARCHAR2 ,
  sunat                                VARCHAR2,
	ag_tipo_seleccion                number -- manuel Req 55
    
  )  ;
 
 
PROCEDURE uspEditArbitro (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ruc                      VARCHAR2 DEFAULT NULL,
  ag_nombre                   VARCHAR2 DEFAULT NULL,
  cod                        VARCHAR2 DEFAULT NULL,
  ag_motivo                     VARCHAR2 DEFAULT NULL,
  sunat                     VARCHAR2 DEFAULT NULL

 
  )  ;
  
  
   
  PROCEDURE uspNuevoArbitro (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ruc                      VARCHAR2 DEFAULT NULL,
  ag_nombre                   VARCHAR2 DEFAULT NULL,
  cod                        VARCHAR2 DEFAULT NULL,
  ag_motivo                     VARCHAR2 DEFAULT NULL,
  sunat                        VARCHAR2 DEFAULT NULL
 
  ) ;
  
    PROCEDURE uspBuscaCentro (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL, 
  ag_departamento         VARCHAR2 DEFAULT NULL,
  ag_centro               VARCHAR2 DEFAULT NULL

 
  ) ;
   PROCEDURE usp_ValidarRUC (
   session__cod_contrato    VARCHAR2 DEFAULT NULL,
  session__filesingedhttp  VARCHAR2 DEFAULT NULL,
  ruc                      VARCHAR2 DEFAULT NULL,
  ag_nombre                VARCHAR2 DEFAULT NULL,
  cod                      VARCHAR2 DEFAULT NULL,
  ag_motivo                VARCHAR2 DEFAULT NULL,
  ventana                  VARCHAR2 DEFAULT NULL 
  
  )    ; 
  

 PROCEDURE uspNuevoCentro (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_departamento         VARCHAR2 DEFAULT NULL,
  ag_centro               VARCHAR2 DEFAULT NULL
  ) ;
  
  
  PROCEDURE uspNuevoCentroInsert( 
 session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_departamento         VARCHAR2 DEFAULT NULL,
  ag_centro               VARCHAR2 DEFAULT NULL
   
 );
  
  
end PKU_GESTOR_CONT_CONTROVERSIAS;
/


CREATE OR REPLACE PACKAGE BODY                "PKU_GESTOR_CONT_CONTROVERSIAS" IS

 PROCEDURE dojscript  is

 --MMAUTINO:
 --DIA: 22/05/2015
 --FORMATO: 1576_OP_SEACE2_CON
 --ASUNTO: VALIDA LOS CARACTERES ESPECIALES Y RECONOCE LA LETRA Ñ Y TILDES
 BEGIN
  usp_print('
  <script languaje=javascript>
  function alpha(e) {
    var tecla = document.all ? e.keyCode : e.which; 
    if (tecla==8) 
    return true; 
    patron =/[A-Za-zñÑáéíóúÁÉÍÓÚ\s]/;
    te = String.fromCharCode(tecla); 
    return patron.test(te); 
    }  
  <!--FIN  -->     
    
    
function trim(stringToTrim) {
    return stringToTrim.replace(/\s/g,"");
}

    
    
       </script> 
  ');

 END;    

PROCEDURE uspHistorialDetalle (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
    session__USERID VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_arbitraje                  VARCHAR2 ,
  ag_tipo_arbitro                    VARCHAR2 ,
    ag_numero_registro                   number ,
    ag_cod                                VARCHAR2,
    ag_f_autoriza                           VARCHAR2,
    ag_num                                  VARCHAR2
  )    
    
 IS 
 lv_codtipofile                VARCHAR2(100); 
 lvtipodocumento               VARCHAR2(100); 
 cod_tipo_file                 VARCHAR2(100); 
 lv_combo_arbitraje           varchar2(4000);   
 lv_combo_arbitro             varchar2(4000);
  lv_combo_demandante           varchar2(4000);   
 lv_combo_mecanismo            varchar2(4000); 
 montoTotal                    number;
 ln_num_contrato               varchar2(4000);  
 ctipoArbitraje               ref_cursor;
   ctipoarbitro                 ref_cursor;  
    ctipodemandante               ref_cursor;
 ctipomecanismo                ref_cursor;  
 ln_fecha                       date;  
 ln_tipoArbitraje               VARCHAR2(100);
 ln_tipoarbitro                 VARCHAR2(100);
 ln_cod                         VARCHAR2(100);
 ln_RUC_PRESIDENTE                   VARCHAR2(100);
 ln_NOMBRE_PRESIDENTE                  VARCHAR2(4000);
 ln_MOTIVO_PRESIDENTE                  VARCHAR2(100);
 ln_RUC_ARBITRO_ENTIDAD                VARCHAR2(100);
 ln_NOMBRE_ARBITRO_ENTIDAD               VARCHAR2(4000);
 ln_MOTIVO_ARBITRO_ENTIDAD                 VARCHAR2(100);
 ln_RUC_ARBITRO_CONTRATISTA              VARCHAR2(100);
 ln_NOMBRE_ARBITRO_CONTRATISTA             VARCHAR2(4000);
 ln_MOTIVO_ARBITRO_CONTRATISTA              VARCHAR2(100);
 ln_NUMERO_REGISTRO                         NUMBER;
 ln_RUC_SECRETARIO  VARCHAR2(100); -- DDRODRIGUEZ REQ 55
 ln_NOMBRE_SECRETARIO VARCHAR2(4000); -- DDRODRIGUEZ REQ 55


   ------- Cursores -------
   
    Cursor c_cursor( p_n_cod_contrato in number , p_n_num_registro in varchar2) is
    SELECT N_COD_CONTRATO,
    NUMERO_REGISTRO,
    FECHA_INSTALACION,
    TIPO_ARBITRAJE,
    TIPO_ARBITRO,
    RUC_PRESIDENTE,
    NOMBRE_PRESIDENTE,
    MOTIVO_PRESIDENTE,
    RUC_ARBITRO_ENTIDAD,
    NOMBRE_ARBITRO_ENTIDAD,
    MOTIVO_ENTIDAD,
    RUC_ARBITRO_CONTRATISTA,
    NOMBRE_ARBITRO_CONTRATISTA,
    MOTIVO_CONTRATISTA,
	RUC_SECRETARIO, -- ddrodriguez req 55
	NOMBRE_SECRETARIO -- ddrodriguez req 55
    --from reg_procesos.contrato_arbitraje where n_cod_contrato =  p_n_cod_contrato and  NUMERO = p_n_num_registro ;
	from reg_procesos.contrato_arbitraje_hist where n_cod_contrato =  p_n_cod_contrato and  COD_HISTORIAL = p_n_num_registro ;
    
     

   
   ------- Listado de Prorrogas ------  
 BEGIN PKU_SS_CONTROVERSIAS.dojscript  ;
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;
  
  select  n_contrato into ln_num_contrato  from reg_procesos.contrato where N_COD_CONTRATO = session__cod_contrato  ; 








    open ctipoarbitraje for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 6;

    open ctipoarbitro for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 23;
    
    
   /*Falta en el maestro de arbitraje*/
    open ctipodemandante for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 12;
   
 
    /*Falta en el maestro de Arbitraje*/ 
    open ctipomecanismo for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 30;
     
  
 
       
     
         
         for xrow in c_cursor(session__cod_contrato,ag_num) loop
      begin

         
              ln_fecha :=   xrow.FECHA_INSTALACION  ;
              ln_tipoArbitraje := xrow.TIPO_ARBITRAJE;
              ln_tipoarbitro   :=   xrow.TIPO_ARBITRO;
              ln_RUC_PRESIDENTE     := xrow.RUC_PRESIDENTE;                
              ln_NOMBRE_PRESIDENTE :=  xrow.NOMBRE_PRESIDENTE ;
              ln_RUC_ARBITRO_ENTIDAD  := xrow.RUC_ARBITRO_ENTIDAD;
              ln_NOMBRE_ARBITRO_ENTIDAD :=  xrow.NOMBRE_ARBITRO_ENTIDAD;
              ln_RUC_ARBITRO_CONTRATISTA := xrow.RUC_ARBITRO_CONTRATISTA;
              ln_NOMBRE_ARBITRO_CONTRATISTA := xrow.NOMBRE_ARBITRO_CONTRATISTA; 
              ln_MOTIVO_PRESIDENTE := xrow.MOTIVO_PRESIDENTE;
              ln_MOTIVO_ARBITRO_ENTIDAD := xrow.MOTIVO_ENTIDAD;
              ln_MOTIVO_ARBITRO_CONTRATISTA := xrow.MOTIVO_CONTRATISTA;
              ln_NUMERO_REGISTRO := xrow.NUMERO_REGISTRO;
			  ln_RUC_SECRETARIO  :=xrow.RUC_SECRETARIO; -- ddrodriguez req 55
			  ln_NOMBRE_SECRETARIO :=  xrow.NOMBRE_SECRETARIO; -- ddrodriguez req 55
              
       end;
   end loop;  
   
   
        
               
       if  ag_f_autoriza is not null  then
          ln_fecha := ag_f_autoriza; 
       end if;
      
       if  ag_tipo_arbitraje is not null  then
           ln_tipoArbitraje := ag_tipo_arbitraje; 
       end if;
       
          if  ag_tipo_arbitro is not null  then
           ln_tipoarbitro := ag_tipo_arbitro;     
         end if;
     
       
    lv_combo_demandante  := PKU_SS_UTILES.f_retorna_combo(ctipodemandante, 'ag_tipo_demandante', ag_tipo_demandante,'Seleccione...','style="width:260px" disabled = "disabled"');
     
    lv_combo_mecanismo   := PKU_SS_UTILES.f_retorna_combo(ctipomecanismo, 'ag_mecanismo', '316','Seleccione...','style="width:260px" onchange="arbitraje();"  disabled = "true"'); 
    
    lv_combo_arbitraje  := PKU_SS_UTILES.f_retorna_combo(ctipoArbitraje, 'ag_tipo_arbitraje', ln_tipoArbitraje,'Seleccione...','style="width:260px"  disabled = "true" ' );
     
    lv_combo_arbitro :=   PKU_SS_UTILES.f_retorna_combo(ctipoarbitro, 'ag_tipo_arbitro', ln_tipoarbitro,'Seleccione...','style="width:260px" onchange="arbitraje();" disabled = "true"'); 
  

----------- CABECERA --------------------
 USP_PRINT('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>'
          || PKU_SS_UTILES.f_get_titulo_contrato(session__cod_contrato,'Controversias')
          || '<td align="right" valign=top width="50%">
          <input type=button value="Volver" onclick="thisform.scriptdo.value=''Historial'';thisform.submit();"></td></tr>
          </table>');
 USP_PRINT('</TD></TR>');
 USP_PRINT('</TABLE><br>');



 usp_print('
  <table class="table table-striped">');    
 
 usp_print(' <td align = "center" colspan = 3><h3>Ficha Electr&oacute;nica</h3></td>');

  usp_print(' <td align = "center" colspan = 3><br></td>'
  );
  
    usp_print(' <tr><td align = "center" colspan = 3><h3>Detalle Historial de Ficha Electr&oacute;nica</h3></td></tr>');

      
      
         usp_print('
    <tr>
      <td class=c1>(*)Motivo</td>
    <td class=c2>'||lv_combo_mecanismo||'</td>
    </tr>
    ');  
    
        usp_print('
    <tr>
        
        <td class=c1>(*)Nro. de Registro de Proceso Arbitral </td>
        <td class=c2><input type="text" name="ag_cod" value="'|| ag_cod  ||'" size=54 readonly ></td>
    </tr>
  '); 
  
    usp_print('
    <tr>
        <td class=c1>(*)Fecha en la que se llev&oacute; a cabo la Audiencia de  Instalaci&oacute;n</td>
        <td class=c2><input  type="text" name="ag_f_autoriza"  value="'||  to_char(ln_fecha, 'dd/mm/yyyy')  ||'" size=30 readonly></td>
    </tr>
  '); 
  

    usp_print('
    <tr>
      <td class=c1>(*)Tipo de Arbitraje</td>
    <td class=c2>'||lv_combo_arbitraje||'</td>
    </tr>'); 
      
      
         usp_print('
    <tr>
      <td class=c1>(*)Tipo de &Aacute;rbitro</td>
    <td class=c2>'||lv_combo_arbitro||'</td>
    </tr>');   

    
   if   ln_tipoarbitro = 221  then
    
      usp_print('<tr><td><h3>Identificaci&oacute;n de los miembros del Tribunal Arbitral <br></h3></td></tr>');
    
      usp_print('
      <tr> <td><h4>Presidente del Tribunal Arbitral</h4></td></tr>
   
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input type="text" name="ag_ruc_presidente" value="'|| ln_RUC_PRESIDENTE ||'" size=54 readonly></td>
    </tr>
  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" name="ag_nombre_presidente" value="'|| ln_NOMBRE_PRESIDENTE ||'" size=54 readonly></td>
    </tr>
    <tr> <td><br><input  type="hidden" name="ag_motivo_presidente" value="'|| ln_MOTIVO_PRESIDENTE ||'" size=54></td></tr>
  '); 
  
  
        usp_print('
<tr><td></td></tr>
   <tr> <td><h4>Arbitro designado por la Entidad</h4></td></tr>
    <tr>
       
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" name="ag_ruc_arbitro_ent" value="'|| ln_RUC_ARBITRO_ENTIDAD  ||'" size=54 readonly ></td>
    </tr>
  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" name="ag_mom_arbitro_ent" value="'|| ln_NOMBRE_ARBITRO_ENTIDAD  ||'" size=54 readonly ></td>
    </tr>
    <tr> <td><br><input  type="hidden" name="ag_motivo_arbitro_ent" value="'||ln_MOTIVO_ARBITRO_ENTIDAD||'" size=54></td></tr>
  '); 
  
          usp_print('
       <tr> <td><h4>Atbitro designado por el contratista</h4></td></tr>
    <tr>
       
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" name="ag_ruc_arbitro_cont" value="'|| ln_RUC_ARBITRO_CONTRATISTA  ||'" size=54 readonly></td>
    </tr>
  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input type="text" name="ag_nombre_arbitro_cont" value="'|| ln_NOMBRE_ARBITRO_CONTRATISTA  ||'" size=54 readonly></td>
    </tr>
     <tr> <td><br><input  type="hidden" name="ag_motivo_arbitro_cont" value="'|| ln_MOTIVO_ARBITRO_CONTRATISTA ||'" size=54></td></tr>
  ');
  
 end if;
  
  if  ln_tipoarbitro = 220 then
        usp_print('
        <tr><td><h3>Identificaci&oacute;n del &Aacute;rbitro &Uacute;nico</h3></td></tr>
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" name="ag_ruc_presidente" value="'|| ln_RUC_PRESIDENTE ||'" size=54 readonly = "true"></td>
    </tr>
  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" name="ag_nombre_presidente" value="'|| ln_NOMBRE_PRESIDENTE ||'" size=54 readonly = "true"></td>
    </tr>

  '); 
  
  end if;
  
  usp_print('
	<tr>
		<td colspan= "3" ><h3>Identificaci&oacute;n del Secretario Arbitral</h3></td>
	</tr>
	  
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" class="form-control" name="ag_ruc_secretario" value="'|| ln_RUC_SECRETARIO ||'" size=54 readonly class="InpReadOnly"></td>
    </tr>

    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" class="form-control" name="ag_nombre_secretario" value="'|| ln_NOMBRE_SECRETARIO ||'" size=54 readonly class="InpReadOnly"></td>
    </tr>
	
	</table>');  

 usp_print(' </table><br><tr><td><input type = "hidden" value = "'|| ag_cod ||'" name = "ag_cod" ></td></tr>
            <tr><td><input type = "hidden" value = "'|| ln_NUMERO_REGISTRO ||'" name = "ag_num_reg" ></td></tr> 
 
  
  
  
  </table><br>');

   usp_print('

        </table>
        <br/>
        <br/>
        ');
        
 END;



 PROCEDURE uspHistorial (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  session__USERID VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_arbitraje                  VARCHAR2 ,
  ag_tipo_arbitro                    VARCHAR2 ,
  ag_numero_registro                 number ,
  ag_cod                             VARCHAR2,
  ag_f_autoriza                      VARCHAR2
  )   
    
 IS
 lv_combo_arbitraje           varchar2(4000);  
 lv_combo_arbitro             varchar2(4000);
  lv_combo_demandante           varchar2(4000);  
 lv_combo_mecanismo            varchar2(4000); 

 ctipoArbitraje               ref_cursor;
   ctipoarbitro                 ref_cursor;  
    ctipodemandante               ref_cursor;
 ctipomecanismo                ref_cursor;  
 ln_fecha                       date;  
 ln_tipoArbitraje               VARCHAR2(100);
 ln_tipoarbitro                 VARCHAR2(100);
 ln_cod                         VARCHAR2(100);
 ln_RUC_PRESIDENTE                   VARCHAR2(100);
 ln_NOMBRE_PRESIDENTE                  VARCHAR2(4000);
 ln_MOTIVO_PRESIDENTE                  VARCHAR2(100);
 ln_RUC_ARBITRO_ENTIDAD                VARCHAR2(100);
 ln_NOMBRE_ARBITRO_ENTIDAD               VARCHAR2(4000);
 ln_MOTIVO_ARBITRO_ENTIDAD                 VARCHAR2(100);
 ln_RUC_ARBITRO_CONTRATISTA              VARCHAR2(100);
 ln_NOMBRE_ARBITRO_CONTRATISTA             VARCHAR2(4000);
 ln_MOTIVO_ARBITRO_CONTRATISTA              VARCHAR2(100);
 ln_NUMERO_REGISTRO                         number;
 num_hist number;
 --INICIO ddrodriguez req 55
  ln_RUC_SECRETARIO               VARCHAR2(11 BYTE);         
  ln_NOMBRE_SECRETARIO            VARCHAR2(200 BYTE);
 --FINAL ddrodriguez req 55
   ------- Cursores -------
   
    Cursor c_cursor( p_n_cod_contrato in number , p_n_num_registro in varchar2) is
    SELECT N_COD_CONTRATO,
    NUMERO_REGISTRO,
    FECHA_INSTALACION,
    TIPO_ARBITRAJE,
    TIPO_ARBITRO,
    RUC_PRESIDENTE,
    NOMBRE_PRESIDENTE,
    MOTIVO_PRESIDENTE,
    RUC_ARBITRO_ENTIDAD,
    NOMBRE_ARBITRO_ENTIDAD,
    MOTIVO_ENTIDAD,
    RUC_ARBITRO_CONTRATISTA,
    NOMBRE_ARBITRO_CONTRATISTA,
    MOTIVO_CONTRATISTA,
	RUC_SECRETARIO, -- ddrodriguez req 55
	NOMBRE_SECRETARIO -- ddrodriguez req 55
    from reg_procesos.contrato_arbitraje where n_cod_contrato =  p_n_cod_contrato and  NUMERO_REGISTRO = p_n_num_registro and ind_ultimo = 1 ;
    
    
        Cursor c_cursor_historico( p_n_cod_contrato in number , p_n_num_registro in varchar2, p_n_tipo_grupo in number) is
    SELECT N_COD_CONTRATO,
    COD_HISTORIAL,--NUMERO, ddrodriguez req 55
    NUMERO_REGISTRO,
    FECHA_INSTALACION,
    TIPO_ARBITRAJE,
    TIPO_ARBITRO,
    RUC_PRESIDENTE,
    NOMBRE_PRESIDENTE,
    MOTIVO_PRESIDENTE,
    RUC_ARBITRO_ENTIDAD,
    NOMBRE_ARBITRO_ENTIDAD,
    MOTIVO_ENTIDAD,
    RUC_ARBITRO_CONTRATISTA,
    NOMBRE_ARBITRO_CONTRATISTA,
    MOTIVO_CONTRATISTA,
    FECHA_PUBLICA,
    USUARIO_PUBLICA,
    IP_PUBLICA
    --from reg_procesos.contrato_arbitraje where n_cod_contrato =  p_n_cod_contrato and  NUMERO_REGISTRO = p_n_num_registro  order by  FECHA_PUBLICA  asc;  ddrodriguez req 55
	from reg_procesos.contrato_arbitraje_hist where n_cod_contrato =  p_n_cod_contrato and  NUMERO_REGISTRO = p_n_num_registro and tipo_grupo_hist in (0,p_n_tipo_grupo)  order by  FECHA_PUBLICA  asc;

   
   ------- Listado de Prorrogas ------  
 BEGIN
  PKU_SS_CONTROVERSIAS.dojscript  ;
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;

    open ctipoarbitraje for
    select n_id_maestro,c_descripcion
    from  ARBITRAJE.TBL_ARB_MAESTRO  where n_id_tipomaestro = 6;   
   
     
    open ctipoarbitro for
    select n_id_maestro,c_descripcion
    from  ARBITRAJE.tbl_arb_maestro  where n_id_tipomaestro = 23;
    
      
    
    open ctipodemandante for
    select n_id_maestro,c_descripcion
    from  ARBITRAJE.tbl_arb_maestro  where n_id_tipomaestro = 12;
    
    
    open ctipomecanismo for
    select n_id_maestro,c_descripcion
    from  ARBITRAJE.tbl_arb_maestro  where n_id_tipomaestro = 30;
     
  
       
     
         
         for xrow in c_cursor(session__cod_contrato,ag_cod) loop
      begin

         
              ln_fecha :=   xrow.FECHA_INSTALACION  ;
              ln_tipoArbitraje := xrow.TIPO_ARBITRAJE;
              ln_tipoarbitro   :=   xrow.TIPO_ARBITRO;
              ln_RUC_PRESIDENTE     := xrow.RUC_PRESIDENTE;                
              ln_NOMBRE_PRESIDENTE :=  xrow.NOMBRE_PRESIDENTE ;
              ln_RUC_ARBITRO_ENTIDAD  := xrow.RUC_ARBITRO_ENTIDAD;
              ln_NOMBRE_ARBITRO_ENTIDAD :=  xrow.NOMBRE_ARBITRO_ENTIDAD;
              ln_RUC_ARBITRO_CONTRATISTA := xrow.RUC_ARBITRO_CONTRATISTA;
              ln_NOMBRE_ARBITRO_CONTRATISTA := xrow.NOMBRE_ARBITRO_CONTRATISTA; 
              ln_MOTIVO_PRESIDENTE := xrow.MOTIVO_PRESIDENTE;
              ln_MOTIVO_ARBITRO_ENTIDAD := xrow.MOTIVO_ENTIDAD;
              ln_MOTIVO_ARBITRO_CONTRATISTA := xrow.MOTIVO_CONTRATISTA;
              ln_NUMERO_REGISTRO := xrow.NUMERO_REGISTRO;
              ln_RUC_SECRETARIO  :=xrow.RUC_SECRETARIO; -- ddrodriguez req 55
			  ln_NOMBRE_SECRETARIO :=  xrow.NOMBRE_SECRETARIO; -- ddrodriguez req 55
              
       end;
   end loop;  
   
   
        
               
       if  ag_f_autoriza is not null  then
          ln_fecha := ag_f_autoriza; 
       end if;
      
       if  ag_tipo_arbitraje is not null  then
           ln_tipoArbitraje := ag_tipo_arbitraje; 
       end if;
       
          if  ag_tipo_arbitro is not null  then
           ln_tipoarbitro := ag_tipo_arbitro;     
         end if;
     
       
    lv_combo_demandante  := PKU_SS_UTILES.f_retorna_combo(ctipodemandante, 'ag_tipo_demandante', ag_tipo_demandante,'Seleccione...','style="width:260px" disabled = "disabled"');
     
    lv_combo_mecanismo   := PKU_SS_UTILES.f_retorna_combo(ctipomecanismo, 'ag_mecanismo', '316','Seleccione...','style="width:260px" onchange="arbitraje();"  disabled = "true"'); 
    
    lv_combo_arbitraje  := PKU_SS_UTILES.f_retorna_combo(ctipoArbitraje, 'ag_tipo_arbitraje', ln_tipoArbitraje,'Seleccione...','style="width:260px"  disabled = "true" ' );
     
    lv_combo_arbitro :=   PKU_SS_UTILES.f_retorna_combo(ctipoarbitro, 'ag_tipo_arbitro', ln_tipoarbitro,'Seleccione...','style="width:260px" onchange="arbitraje();" disabled = "true"'); 
          
          

		  usp_print('
    <script language="javascript"> 
	
	function HistorialDetalle(cod) {
 
         thisform.ag_num.value =  cod
         thisform.scriptdo.value = "HistorialDetalle";
         thisform.submit();
	}

    </script>');   
 
 
----------- CABECERA --------------------
 USP_PRINT('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>'
          || PKU_SS_UTILES.f_get_titulo_contrato(session__cod_contrato,'Controversias')
          || '<td align="right" valign=top width="50%">
          <input type=button value="Volver" onclick="thisform.scriptdo.value=''DoView'';thisform.submit();"></td></tr>
          </table>');
 USP_PRINT('</TD></TR>');
 USP_PRINT('</TABLE><br>');



 usp_print('
  <table class="table table-striped">');    
 
 usp_print(' <td align = "center" colspan = 3><h3>Ficha Electr&oacute;nica</h3></td>');

  usp_print(' <td align = "center" colspan = 3><br></td>');
  
    usp_print(' <tr><td align = "center" colspan = 3><h3>Historial de Ficha Electr&oacute;nica</h3></td></tr>');
  
  
  usp_print(' <tr><td align = "left" colspan = 3><h3>Declaraci&oacute;n de Arbitraje</h3></td></tr>');
      
      
         usp_print('
    <tr>
      <td class=c1>(*)Tipo de mecanismo de soluci&oacute;n de Controversia</td>
    <td class=c2>'||lv_combo_mecanismo||'</td>
	</tr>
    ');  
    
        usp_print('
    <tr>
        
        <td class=c1>(*)Nro. de Registro de Proceso Arbitral </td>
        <td class=c2><input type="text" name="ag_cod" value="'|| ag_cod  ||'" size=54 readonly ></td>
    </tr>
  '); 
  
    usp_print('
    <tr>
        <td class=c1>(*)Fecha de la Audiencia de Instalaci&oacute;n</td>
        <td class=c2><input  type="text" name="ag_f_autoriza"  value="'||  to_char(ln_fecha, 'dd/mm/yyyy')  ||'" size=30 readonly></td>
    </tr>
  '); 
  

    usp_print('
    <tr>
      <td class=c1>(*)Tipo de Arbitraje</td>
    <td class=c2>'||lv_combo_arbitraje||'</td>
    </tr>'); 
      
      
         usp_print('
    <tr>
      <td class=c1>(*)Tipo de &Aacute;rbitro</td>
    <td class=c2>'||lv_combo_arbitro||'</td>
    </tr>');  
    
	usp_print('</table><table align = "center" class="table table-hover" style="width:800px" ><tr><td align = "center" colspan = 4>Historial Declaraci&oacute;n de Arbitraje</td></tr>
            <tr><td><b>Nro.</b></td><td><b>Fecha de publicaci&oacute;n</b></td><td><b>Usuario que public&oacute;</b></td><td><b>IP</b></td></tr> ');
  
	  num_hist := 0;
		for xrow1 in c_cursor_historico(session__cod_contrato,ag_cod,1) loop
		  begin
			num_hist := num_hist +  1;
			usp_print('<tr><td> <a  onclick = "HistorialDetalle('|| xrow1.COD_HISTORIAL||');">'|| num_hist||'</a></td><td >'|| xrow1.FECHA_PUBLICA ||'</td><td>'||xrow1.USUARIO_PUBLICA||'</td><td>'|| xrow1.IP_PUBLICA ||'</td></tr>');
		   end;
	   end loop; 
    usp_print('</table><br><table class="table table-striped">');
	
    
   if   ln_tipoarbitro = 221  then
    
    usp_print('<tr><td align = "left" colspan = 3 ><h3>Identificaci&oacute;n de los miembros del Tribunal Arbitral</h3></td></tr>');
    usp_print('
        <tr> <td align = "left" colspan = 3 ><br><h4>Presidente del Tribunal Arbitral</h4></td></tr>
   
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input type="text" name="ag_ruc_presidente" value="'|| ln_RUC_PRESIDENTE ||'" readonly></td>
    </tr>
  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" name="ag_nombre_presidente" value="'|| ln_NOMBRE_PRESIDENTE ||'" readonly></td>
    </tr>
  '); 
  
  
        usp_print('
    <tr> <td align = "left" colspan = 3 ><br><h4>Arbitro designado por la Entidad</h4></td></tr>
    <tr>
       
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" name="ag_ruc_arbitro_ent" value="'|| ln_RUC_ARBITRO_ENTIDAD  ||'" readonly ></td>
    </tr>
  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" name="ag_mom_arbitro_ent" value="'|| ln_NOMBRE_ARBITRO_ENTIDAD  ||'" readonly ></td>
    </tr>
  '); 
  
          usp_print('
      <tr> <td align = "left" colspan = 3 ><br><h4>Arbitro designado por el contratista</h4></td></tr>
    <tr>
       
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" name="ag_ruc_arbitro_cont" value="'|| ln_RUC_ARBITRO_CONTRATISTA  ||'"  readonly></td>
    </tr>
  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input type="text" name="ag_nombre_arbitro_cont" value="'|| ln_NOMBRE_ARBITRO_CONTRATISTA  ||'"  readonly></td>
    </tr>
  ');
  
 end if;
  
  if  ln_tipoarbitro = 220 then
        usp_print('
	<tr>
		<td align = "left" colspan = 3 ><h3>Identificaci&oacute;n del &Aacute;rbitro &Uacute;nico</h3></td>
	</tr>
	  
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" class="form-control" name="ag_ruc_presidente" value="'|| ln_RUC_PRESIDENTE ||'"  readonly ></td>
    </tr>

    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" class="form-control" name="ag_nombre_presidente" value="'|| ln_NOMBRE_PRESIDENTE ||'" readonly ></td>
    </tr>
	');
	
	end if;
	
	usp_print('</table><table align = "center" class="table table-hover" style="width:800px" ><tr><td align = "center" colspan = 4>Historial Arbitro</td></tr>
            <tr><td><b>Nro.</b></td><td><b>Fecha de publicaci&oacute;n</b></td><td><b>Usuario que public&oacute;</b></td><td><b>IP</b></td></tr> ');
  
	  num_hist := 0;
		for xrow2 in c_cursor_historico(session__cod_contrato,ag_cod,2) loop
		  begin
			num_hist := num_hist +  1;
			usp_print('<tr><td> <a  onclick = "HistorialDetalle('|| xrow2.COD_HISTORIAL||');">'|| num_hist||'</a></td><td >'|| xrow2.FECHA_PUBLICA ||'</td><td>'||xrow2.USUARIO_PUBLICA||'</td><td>'|| xrow2.IP_PUBLICA ||'</td></tr>');
		   end;
	   end loop; 
	usp_print('</table><br><table class="table table-striped">');
	
	
	usp_print('
	<tr>
		<td align = "left" colspan = 3 ><h3>Identificaci&oacute;n del Secretario Arbitral</h3></td>
	</tr>
	  
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" class="form-control" name="ag_ruc_secretario" value="'|| ln_RUC_SECRETARIO ||'"  readonly class="InpReadOnly"></td>
    </tr>

    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" class="form-control" name="ag_nombre_secretario" value="'|| ln_NOMBRE_SECRETARIO ||'" readonly class="InpReadOnly"></td>
    </tr>
	
	</table>');
  
  
  
   usp_print('<table align = "center" class="table table-hover" style="width:800px" ><tr><td align = "center" colspan = 4>Historial Secretario Arbitral</td></tr>
            <tr><td><b>Nro.</b></td><td><b>Fecha de publicaci&oacute;n</b></td><td><b>Usuario que public&oacute;</b></td><td><b>IP</b></td></tr> ');
  
	  num_hist := 0;
		for xrow3 in c_cursor_historico(session__cod_contrato,ag_cod,3) loop
		  begin
			num_hist := num_hist +  1;
			usp_print('<tr><td> <a  onclick = "HistorialDetalle('|| xrow3.COD_HISTORIAL||');">'|| num_hist||'</a></td><td >'|| xrow3.FECHA_PUBLICA ||'</td><td>'||xrow3.USUARIO_PUBLICA||'</td><td>'|| xrow3.IP_PUBLICA ||'</td></tr>');
		   end;
	   end loop; 
  usp_print('</table><br>');


  
 usp_print('<tr><td><input type = "hidden" value = "'|| ag_cod ||'" name = "ag_cod" ></td></tr>
            <tr><td><input type = "hidden" value = "'|| ln_NUMERO_REGISTRO ||'" name = "ag_num_reg" ></td></tr> 
			<tr><td><input type = "hidden" value = "" name = "ag_num" ></td></tr>
          

  </table><br>');

   usp_print('

        </table>
        <br/>
        <br/>
        ');
        
 END;

   

PROCEDURE uspArbitrajeEdit( 
   session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
    session__USERID VARCHAR2 DEFAULT NULL,
     session__IIS_REMOTE_ADDR   VARCHAR2,  
      iisenv__REMOTE_HOST varchar2,
ag_tipo_demandante        varchar2,
ag_mecanismo              varchar2,
ag_tipo_arbitraje         varchar2,
ag_tipo_arbitro           varchar2,
ag_f_autoriza             varchar2,
ag_ruc_presidente         varchar2,
ag_nombre_presidente      varchar2,
ag_sunat_presidente       varchar2,
ag_ruc_arbitro_ent        varchar2,
ag_mom_arbitro_ent        varchar2,
ag_sunat_arbitro_ent      varchar2,
ag_ruc_arbitro_cont       varchar2, 
ag_nombre_arbitro_cont    varchar2,
ag_sunat_arbitro_cont     varchar2,
ag_ruc_arb_unico          varchar2,                                       
ag_nom_nom_unico          varchar2,
ag_num_reg                number,
ag_motivo_presidente      varchar2, 
ag_motivo_arbitro_ent     varchar2,
ag_motivo_arbitro_cont    varchar2,

ag_nombres_presidente     varchar2,
ag_apePat_presidente      varchar2,
ag_apeMat_presidente      varchar2,
ag_nombres_ent            varchar2,
ag_apePat_ent             varchar2,
ag_apeMat_ent             varchar2,
ag_nombres_cont           varchar2,
ag_apePat_cont            varchar2,
ag_apeMat_cont            varchar2,
---Inicio mlaura Req 55
ag_nombres_secretario            varchar2, 
ag_apepat_secretario             varchar2, 
ag_apemat_secretario             varchar2,
ag_ruc_secretario                varchar2,
ag_nombre_secretario             varchar2,
ag_sunat_secretario              varchar2,
ag_motivo_secretario             varchar2,
---Fin mlaura Req 55
ag_tipo_seleccion                number
 ) is

idnumero                  number ;
idnumeroArbitro           number ;
   
  LN_NUMERO NUMBER;
    LN_NUMERO_REGISTRO NUMBER ;
    LN_TIPO_DEMANDANTE NUMBER;
    LN_TIPO_ARBITRAJE NUMBER ;
    LN_TIPO_ARBITRO NUMBER ;
    LN_COD_PRESIDENTE NUMBER ;
    LN_FECHA_INSTALACION DATE ;
    LN_COD_LAUDO NUMBER;
    LN_N_COD_CONTRATO NUMBER;
    LN_RUC_PRESIDENTE VARCHAR2(11 BYTE);
    LN_NOMBRE_PRESIDENTE VARCHAR2(200 BYTE);
    LN_RUC_ARBITRO_ENTIDAD VARCHAR2(11 BYTE) ;
    LN_NOMBRE_ARBITRO_ENTIDAD VARCHAR2(200 BYTE) ;
    LN_RUC_ARBITRO_CONTRATISTA VARCHAR2(11 BYTE); 
    LN_NOMBRE_ARBITRO_CONTRATISTA VARCHAR2(200 BYTE) ;
    LN_MOTIVO_PRESIDENTE VARCHAR2(200 BYTE) ;
    LN_MOTIVO_ENTIDAD VARCHAR2(200 BYTE) ;
    LN_MOTIVO_CONTRATISTA VARCHAR2(200 BYTE);
    LN_IND_ULTIMO VARCHAR2(1 BYTE);
  LN_SUNAT_PRESIDENTE       VARCHAR2(1 BYTE);
  LN_SUNAT_ARBITRO_ENT      VARCHAR2(1 BYTE);
  LN_SUNAT_ARBITRO_CONT     VARCHAR2(1 BYTE);
  ln_nombres_presidente     VARCHAR2(200 BYTE) ;    
  ln_apePat_presidente      VARCHAR2(200 BYTE) ;      
  ln_apeMat_presidente      VARCHAR2(200 BYTE) ;       
  ln_nombres_ent            VARCHAR2(200 BYTE) ;    
  ln_apePat_ent             VARCHAR2(200 BYTE) ;       
  ln_apeMat_ent             VARCHAR2(200 BYTE) ;      
  ln_nombres_cont           VARCHAR2(200 BYTE) ;       
  ln_apePat_cont           VARCHAR2(200 BYTE) ;       
  ln_apeMat_cont            VARCHAR2(200 BYTE) ;
  ---Inicio mlaura Req 55
  ln_RUC_SECRETARIO               VARCHAR2(11 BYTE);         
	ln_NOMBRE_SECRETARIO            VARCHAR2(200 BYTE);
	ln_SUNAT_SECRETARIO             VARCHAR2(1 BYTE);
	ln_MOTIVO_SECRETARIO            VARCHAR2(200 BYTE);
	ln_NOMBRES_SECRETARIO           VARCHAR2(200 BYTE);
	ln_APEPAT_SECRETARIO            VARCHAR2(200 BYTE);
	ln_APEMAT_SECRETARIO           VARCHAR2(200 BYTE);
  ---Fin mlaura Req 55

    Cursor c_cursor( p_n_cod_contrato in number , p_n_num_registro in number) is
    SELECT 
        "NUMERO" , 
      "NUMERO_REGISTRO" , 
      "TIPO_DEMANDANTE" , 
      "TIPO_ARBITRAJE" , 
      "TIPO_ARBITRO" , 
      "COD_PRESIDENTE" , 
      "FECHA_INSTALACION", 
      "COD_LAUDO" , 
      "N_COD_CONTRATO" , 
      "RUC_PRESIDENTE" , 
      "NOMBRE_PRESIDENTE" , 
      "RUC_ARBITRO_ENTIDAD" , 
      "NOMBRE_ARBITRO_ENTIDAD" , 
      "RUC_ARBITRO_CONTRATISTA", 
      "NOMBRE_ARBITRO_CONTRATISTA" , 
      "MOTIVO_PRESIDENTE" , 
      "MOTIVO_ENTIDAD" , 
      "MOTIVO_CONTRATISTA" , 
      "IND_ULTIMO" ,
      "SUNAT_ARBITRO_PRESIDENTE" ,
      "SUNAT_ARBITRO_ENTIDAD" , 
      "SUNAT_ARBITRO_CONTRATISTA",
      nombres_presidente,
      apePat_presidente,
      apeMat_presidente,
      nombres_ent,
      apePat_ent,
      apeMat_ent,
      nombres_cont,
      apePat_cont,
      apeMat_cont,
      RUC_SECRETARIO,
      NOMBRE_SECRETARIO,
      MOTIVO_SECRETARIO,
      SUNAT_ARBITRO_SECRETARIO,
      NOMBRES_SECRETARIO,
      APEPAT_SECRETARIO,
      APEMAT_SECRETARIO
      
 ---Adicionando campos de secretario al cursor Req 55    
      
      
    from reg_procesos.contrato_arbitraje where n_cod_contrato =  p_n_cod_contrato and  NUMERO_REGISTRO = p_n_num_registro and ind_ultimo = 1 ;


 BEGIN

 /*       select max(numero) into idnumero  from (
            select  numero  from   reg_procesos.contrato_arbitraje 
            Union   
            select numero  from   reg_procesos.contrato_conciliacion
       );
 
        if idnumero is null then
          idnumero := 1;
       else
          idnumero := idnumero + 1 ;
       end if;
*/
       



        
        
             for xrow in c_cursor(session__cod_contrato,ag_num_reg) loop
      begin

           LN_NUMERO                          :=         xrow.NUMERO;
            LN_NUMERO_REGISTRO                :=         xrow.NUMERO_REGISTRO;
            LN_TIPO_DEMANDANTE                :=         xrow.TIPO_DEMANDANTE;
            LN_TIPO_ARBITRAJE                 :=         xrow.TIPO_ARBITRAJE;
            LN_TIPO_ARBITRO                   :=         xrow.TIPO_ARBITRO;
            LN_COD_PRESIDENTE                 :=         xrow.COD_PRESIDENTE;
            LN_FECHA_INSTALACION              :=         xrow.FECHA_INSTALACION;
            LN_COD_LAUDO                      :=          xrow.COD_LAUDO;
            LN_N_COD_CONTRATO                 :=          xrow.N_COD_CONTRATO;
            LN_RUC_PRESIDENTE                 :=           xrow.RUC_PRESIDENTE;
            LN_NOMBRE_PRESIDENTE              :=          xrow.NOMBRE_PRESIDENTE;
            LN_RUC_ARBITRO_ENTIDAD            :=          xrow.RUC_ARBITRO_ENTIDAD;
            LN_NOMBRE_ARBITRO_ENTIDAD         :=          xrow.NOMBRE_ARBITRO_ENTIDAD;  
            LN_RUC_ARBITRO_CONTRATISTA        :=           xrow.RUC_ARBITRO_CONTRATISTA;
            LN_NOMBRE_ARBITRO_CONTRATISTA     :=           xrow.NOMBRE_ARBITRO_CONTRATISTA;
            LN_MOTIVO_PRESIDENTE              :=            xrow.MOTIVO_PRESIDENTE;
            LN_MOTIVO_ENTIDAD                 :=            xrow.MOTIVO_ENTIDAD;
            LN_MOTIVO_CONTRATISTA             :=            xrow.MOTIVO_CONTRATISTA;
            LN_SUNAT_PRESIDENTE               :=            xrow.SUNAT_ARBITRO_PRESIDENTE;
            LN_SUNAT_ARBITRO_ENT              :=            xrow.SUNAT_ARBITRO_ENTIDAD;
            LN_SUNAT_ARBITRO_CONT             :=            xrow.SUNAT_ARBITRO_CONTRATISTA;
            ln_nombres_presidente             :=             xrow.nombres_presidente;
            ln_apePat_presidente              :=             xrow.apePat_presidente;
            ln_apeMat_presidente              :=            xrow.apeMat_presidente;
            ln_nombres_ent                    :=            xrow.nombres_ent;
            ln_apePat_ent                     :=             xrow.apePat_ent;
            ln_apeMat_ent                     :=              xrow.apeMat_ent;
            ln_nombres_cont                   :=              xrow.nombres_cont;
            ln_apePat_cont                    :=              xrow.apePat_cont;
            ln_apeMat_cont                    :=              xrow.apeMat_cont;
            ln_RUC_SECRETARIO                 := xrow.RUC_SECRETARIO;         
            ln_NOMBRE_SECRETARIO              := xrow.NOMBRE_SECRETARIO;
            ln_MOTIVO_SECRETARIO              := xrow.MOTIVO_SECRETARIO;
            ln_NOMBRES_SECRETARIO             := xrow.NOMBRES_SECRETARIO;
            ln_SUNAT_SECRETARIO               := xrow.SUNAT_ARBITRO_SECRETARIO;
            ln_APEPAT_SECRETARIO              := xrow.APEPAT_SECRETARIO;
            ln_APEMAT_SECRETARIO              := xrow.APEMAT_SECRETARIO;
 ----mlaura Req 55
              
       end;
   end loop;  
        
    /*          update reg_procesos.contrato_arbitraje 
      set
        MOTIVO_SECRETARIO = ag_motivo_secretario,
        MOTIVO_PRESIDENTE =  ag_motivo_presidente,
        MOTIVO_ENTIDAD = ag_motivo_arbitro_ent,
        MOTIVO_CONTRATISTA =  ag_motivo_arbitro_cont,
        ind_ultimo = '0'
      where 
        NUMERO_REGISTRO = ag_num_reg  
        and IND_ULTIMO = 1;
  */
            if (ag_tipo_seleccion=1) then
              ln_tipo_arbitraje     :=    ag_tipo_arbitraje;
              ln_tipo_arbitro       :=    ag_tipo_arbitro;
            end if;
            
            if (ag_tipo_seleccion=1 or ag_tipo_seleccion=2) then
              ln_nombres_presidente :=    ag_nombres_presidente;
              ln_apePat_presidente  :=    ag_apePat_presidente;
              ln_apeMat_presidente  :=    ag_apeMat_presidente;
              ln_nombres_ent        :=    ag_nombres_ent;
              ln_apePat_ent         :=    ag_apePat_ent;
              ln_apeMat_ent         :=    ag_apeMat_ent;
              ln_nombres_cont       :=    ag_nombres_cont;
              ln_apepat_cont        :=    ag_apepat_cont;
              ln_apemat_cont        :=    ag_apemat_cont;
            end if;
            
            if (ag_tipo_seleccion=3) then
            ln_nombres_secretario :=    ag_nombres_secretario;            
            ln_apepat_secretario  :=    ag_apepat_secretario;            
            ln_apemat_secretario  :=    ag_apemat_secretario;           
            end if;
       
        
        if ag_motivo_secretario is not null then
            ln_RUC_SECRETARIO     :=    ag_ruc_secretario ;
            ln_NOMBRE_SECRETARIO  :=    ag_nombre_secretario ;
            ln_SUNAT_SECRETARIO   :=    ag_sunat_secretario ;
        end if;
            
        if ag_motivo_presidente is not null then
            LN_RUC_PRESIDENTE     :=    ag_ruc_presidente   ;       
            LN_NOMBRE_PRESIDENTE  :=    ag_nombre_presidente  ;  
            LN_SUNAT_PRESIDENTE   :=    ag_sunat_presidente ;
        end if;
        
        if ag_motivo_arbitro_ent is not null then
            LN_RUC_ARBITRO_ENTIDAD    :=    ag_ruc_arbitro_ent   ;       
            LN_NOMBRE_ARBITRO_ENTIDAD :=    ag_mom_arbitro_ent  ;   
            LN_SUNAT_ARBITRO_ENT :=         ag_sunat_arbitro_ent;
        end if;
        
        if ag_motivo_arbitro_cont is not null then
          
            LN_RUC_ARBITRO_CONTRATISTA    :=  ag_ruc_arbitro_cont    ;
            LN_NOMBRE_ARBITRO_CONTRATISTA :=   ag_nombre_arbitro_cont ; 
            LN_SUNAT_ARBITRO_CONT  :=         ag_sunat_arbitro_cont ;
        
        end if;
         
      update reg_procesos.contrato_arbitraje 
      set
      tipo_demandante = ln_tipo_demandante,
      tipo_arbitraje = ln_tipo_arbitraje,
      tipo_arbitro = ln_tipo_arbitro,
      fecha_instalacion = ln_fecha_instalacion,
      n_cod_contrato = ln_n_cod_contrato,
      ruc_presidente = ln_ruc_presidente,
      nombre_presidente = ln_nombre_presidente,
      ruc_arbitro_entidad = ln_ruc_arbitro_entidad,
      nombre_arbitro_entidad = ln_nombre_arbitro_entidad,
      ruc_arbitro_contratista = ln_ruc_arbitro_contratista,
      nombre_arbitro_contratista = ln_nombre_arbitro_contratista,
      fecha_publica = sysdate,
      usuario_publica = session__userid,
      ip_publica = iisenv__remote_host,
      sunat_arbitro_presidente = ln_sunat_presidente,
      sunat_arbitro_entidad = ln_sunat_arbitro_ent,
      sunat_arbitro_contratista = ln_sunat_arbitro_cont,
      nombres_presidente = ln_nombres_presidente,
      apepat_presidente = ln_apepat_presidente,
      apemat_presidente = ln_apemat_presidente,
      nombres_ent = ln_nombres_ent,
      apepat_ent = ln_apepat_ent,
      apemat_ent = ln_apemat_ent,
      nombres_cont = ln_nombres_cont,
      apepat_cont = ln_apepat_cont,
      apemat_cont = ln_apemat_cont,
      ruc_secretario = ln_ruc_secretario,
      nombre_secretario = ln_nombre_secretario,
      sunat_arbitro_secretario = ln_SUNAT_SECRETARIO,
      nombres_secretario = ln_nombres_secretario,
      apepat_secretario = ln_APEPAT_SECRETARIO,
      APEMAT_SECRETARIO = ln_APEMAT_SECRETARIO        
      where 
        numero_registro = ag_num_reg  
        and IND_ULTIMO = 1;
      
     update reg_procesos.contrato_arbitraje_hist 
      set
        MOTIVO_SECRETARIO = ag_motivo_secretario,
        motivo_presidente =  ag_motivo_presidente,
        motivo_entidad = ag_motivo_arbitro_ent,
        motivo_contratista =  ag_motivo_arbitro_cont,
        ind_ultimo = '0'
      where 
        numero_registro = ag_num_reg  
        and IND_ULTIMO = 1;
        
       commit;

      insert into contrato_arbitraje_hist
      (SELECT REG_PROCESOS.SQ_ID_HIST_ARB.NEXTVAL,--COD_HISTORIAL,
      ag_tipo_seleccion,
      --NUMERO,
      ag_num_reg,
      TIPO_DEMANDANTE,
      TIPO_ARBITRAJE,
      TIPO_ARBITRO,
      COD_PRESIDENTE,
      FECHA_INSTALACION,
      COD_LAUDO,
      N_COD_CONTRATO,
      RUC_PRESIDENTE,
      NOMBRE_PRESIDENTE,
      RUC_ARBITRO_ENTIDAD,
      NOMBRE_ARBITRO_ENTIDAD,
      RUC_ARBITRO_CONTRATISTA,
      NOMBRE_ARBITRO_CONTRATISTA,
      motivo_presidente,
      MOTIVO_ENTIDAD, 
      motivo_contratista,
      1, -- indicador siempre activo
      FECHA_PUBLICA,
      USUARIO_PUBLICA,
      IP_PUBLICA,
      SUNAT_ARBITRO_PRESIDENTE,
      SUNAT_ARBITRO_ENTIDAD,
      SUNAT_ARBITRO_CONTRATISTA,
      NOMBRES_PRESIDENTE,
      APEPAT_PRESIDENTE,
      APEMAT_PRESIDENTE,
      NOMBRES_ENT,
      APEPAT_ENT,
      APEMAT_ENT,
      NOMBRES_CONT,
      APEPAT_CONT,
      APEMAT_CONT,
      RUC_SECRETARIO,
      NOMBRE_SECRETARIO,
      MOTIVO_SECRETARIO,
      SUNAT_ARBITRO_SECRETARIO,
      nombres_secretario,
      apepat_secretario,
      apemat_secretario from reg_procesos.contrato_arbitraje where numero_registro = ag_num_reg and ind_ultimo = 1);
      COMMIT;
       /*insert into  reg_procesos.contrato_arbitraje 
       (
      "NUMERO" , 
      "NUMERO_REGISTRO" , 
      "TIPO_DEMANDANTE" , 
      "TIPO_ARBITRAJE" , 
      "TIPO_ARBITRO" , 
      "COD_PRESIDENTE" , 
      "FECHA_INSTALACION", 
      "COD_LAUDO" , 
      "N_COD_CONTRATO" , 
      "RUC_PRESIDENTE" , 
      "NOMBRE_PRESIDENTE" , 
      "RUC_ARBITRO_ENTIDAD" , 
      "NOMBRE_ARBITRO_ENTIDAD" , 
      "RUC_ARBITRO_CONTRATISTA", 
      "NOMBRE_ARBITRO_CONTRATISTA" , 
      "IND_ULTIMO",
      FECHA_PUBLICA,
      USUARIO_PUBLICA,
      IP_PUBLICA   ,
      SUNAT_ARBITRO_PRESIDENTE,
      SUNAT_ARBITRO_ENTIDAD,
      SUNAT_ARBITRO_CONTRATISTA,
      nombres_presidente,
      apePat_presidente,
      apeMat_presidente,
      nombres_ent,
      apePat_ent,
      apeMat_ent,
      nombres_cont,
      apePat_cont,
      apeMat_cont,
      RUC_SECRETARIO,
      NOMBRE_SECRETARIO,
      SUNAT_ARBITRO_SECRETARIO,
      NOMBRES_SECRETARIO,
      APEPAT_SECRETARIO,
      APEMAT_SECRETARIO

      
       )
       values 
       (
       
                  LN_NUMERO                   ,
            LN_NUMERO_REGISTRO              ,
            LN_TIPO_DEMANDANTE                ,
            LN_TIPO_ARBITRAJE                ,
            LN_TIPO_ARBITRO                  ,
            LN_COD_PRESIDENTE                ,
            LN_FECHA_INSTALACION             ,
            LN_COD_LAUDO                      ,
            LN_N_COD_CONTRATO                ,
            LN_RUC_PRESIDENTE                ,
            LN_NOMBRE_PRESIDENTE              ,
            LN_RUC_ARBITRO_ENTIDAD            ,
            LN_NOMBRE_ARBITRO_ENTIDAD         ,
            LN_RUC_ARBITRO_CONTRATISTA       ,
            LN_NOMBRE_ARBITRO_CONTRATISTA     ,
              '1',
              sysdate(),
              session__USERID,
             iisenv__REMOTE_HOST ,
                         LN_SUNAT_PRESIDENTE   ,
            LN_SUNAT_ARBITRO_ENT ,
            LN_SUNAT_ARBITRO_CONT ,      
            ln_nombres_presidente,
            ln_apePat_presidente,
            ln_apeMat_presidente,
            ln_nombres_ent,
            ln_apePat_ent,
            ln_apeMat_ent,
            ln_nombres_cont,
            ln_apePat_cont,
            ln_apeMat_cont,
            ln_RUC_SECRETARIO,
            ln_NOMBRE_SECRETARIO,
            ln_SUNAT_SECRETARIO,
            ln_NOMBRES_SECRETARIO,
            ln_APEPAT_SECRETARIO,
            ln_APEMAT_SECRETARIO
            
            
            );
        
       commit;*/
        

    usp_print('
    <script language=javascript>
 
       thisform.scriptdo.value="doView";
       thisform.submit();
    </script>
    ');

 END; 



 

 PROCEDURE uspArbitrajeInsert( 
   session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
    session__USERID VARCHAR2 DEFAULT NULL,
   session__IIS_REMOTE_ADDR   VARCHAR2,
   iisenv__REMOTE_HOST varchar2,
ag_tipo_demandante        varchar2,
ag_mecanismo              varchar2,
ag_tipo_arbitraje         varchar2,
ag_tipo_arbitro           varchar2,
ag_f_autoriza             varchar2,
ag_ruc_presidente         varchar2,
ag_nombre_presidente      varchar2,
ag_sunat_presidente       varchar2,
ag_ruc_arbitro_ent        varchar2,
ag_mom_arbitro_ent        varchar2,
ag_sunat_arbitro_ent      varchar2,
ag_ruc_arbitro_cont       varchar2,
ag_nombre_arbitro_cont    varchar2,
ag_sunat_arbitro_cont     varchar2,
ag_ruc_arb_unico          varchar2,
ag_nom_nom_unico          varchar2,

ag_nombres_presidente      varchar2,
ag_apePat_presidente       varchar2,
ag_apeMat_presidente       varchar2,
ag_nombres_ent             varchar2,
ag_apePat_ent              varchar2,
ag_apeMat_ent              varchar2,
ag_nombres_cont            varchar2,
ag_apePat_cont             varchar2,
ag_apeMat_cont             varchar2,

--vpt
ag_nombres_secretario     varchar2, 
ag_apepat_secretario      varchar2, 
ag_apemat_secretario      varchar2,
ag_ruc_secretario         varchar2,
ag_nombre_secretario      varchar2,
ag_sunat_secretario       varchar2,
ag_motivo_secretario      varchar2
--vpt
 ) Is  
 
idnumero                  number ;
idnumeroArbitro           number ;

 BEGIN
   PKU_SS_CONTROVERSIAS.dojscript  ;
        select max(numero) into idnumero  from (
            select  numero  from   reg_procesos.contrato_arbitraje 
            Union   
            select numero  from   reg_procesos.contrato_conciliacion
       );
 
        if idnumero is null then
          idnumero := 1;
       else
          idnumero := idnumero + 1 ;
       end if;


        select  max(NUMERO_REGISTRO) into idnumeroArbitro  from   reg_procesos.contrato_arbitraje;
     
       if idnumeroArbitro is null then
          idnumeroArbitro := 1;
       else
          idnumeroArbitro := idnumeroArbitro + 1 ;
       end if;




      
       insert into  reg_procesos.contrato_arbitraje 
       (numero,
       NUMERO_REGISTRO,
       TIPO_DEMANDANTE,
       TIPO_ARBITRAJE,
       TIPO_ARBITRO,
       FECHA_INSTALACION,
       N_COD_CONTRATO,
       RUC_PRESIDENTE,
       NOMBRE_PRESIDENTE,
       RUC_ARBITRO_ENTIDAD,
       NOMBRE_ARBITRO_ENTIDAD,
       RUC_ARBITRO_CONTRATISTA,
       NOMBRE_ARBITRO_CONTRATISTA,
       IND_ULTIMO,
       FECHA_PUBLICA,
       USUARIO_PUBLICA,
       IP_PUBLICA,
       SUNAT_ARBITRO_PRESIDENTE,
       SUNAT_ARBITRO_ENTIDAD,
       SUNAT_ARBITRO_CONTRATISTA,
       nombres_presidente,
       apePat_presidente,
       apeMat_presidente,
       nombres_ent,
       apePat_ent,
       apeMat_ent,
       nombres_cont,
       apePat_cont,
       apeMat_cont,
       --vpt
      RUC_SECRETARIO,
      NOMBRE_SECRETARIO,
      MOTIVO_SECRETARIO,
      SUNAT_ARBITRO_SECRETARIO,
      NOMBRES_SECRETARIO,
      APEPAT_SECRETARIO,
      APEMAT_SECRETARIO
       --vpt

       
       
       )
       values
       (idnumero,
       idnumeroArbitro,
       ag_tipo_demandante,
       ag_tipo_arbitraje,
       ag_tipo_arbitro,
       ag_f_autoriza,
       session__cod_contrato,
       ag_ruc_presidente,
       ag_nombre_presidente,
       ag_ruc_arbitro_ent,
       ag_mom_arbitro_ent,
       ag_ruc_arbitro_cont,
       ag_nombre_arbitro_cont,
       '1',
       sysdate,
       session__USERID,
        iisenv__REMOTE_HOST,
        ag_sunat_presidente ,
        ag_sunat_arbitro_ent ,
        ag_sunat_arbitro_cont,
      
        ag_nombres_presidente,
        ag_apePat_presidente,
        ag_apeMat_presidente,
        ag_nombres_ent,
        ag_apePat_ent,
        ag_apeMat_ent,
        ag_nombres_cont,
        ag_apePat_cont,
        ag_apeMat_cont,
        
        --
        ag_ruc_secretario,
        ag_nombre_secretario,
        ag_motivo_secretario, 
        ag_sunat_secretario, 
        ag_nombres_secretario, 
        ag_apepat_secretario,
        ag_apemat_secretario
        --
        
        
       )
       ;
        
        
      INSERT INTO CONTRATO_ARBITRAJE_HIST
      (SELECT REG_PROCESOS.SQ_ID_HIST_ARB.NEXTVAL,
      0, -- INDICADOR QUE ES NUEVO REGISTRO
      NUMERO_REGISTRO,
      TIPO_DEMANDANTE,
      TIPO_ARBITRAJE,
      TIPO_ARBITRO,
      COD_PRESIDENTE,
      FECHA_INSTALACION,
      COD_LAUDO,
      N_COD_CONTRATO,
      RUC_PRESIDENTE,
      NOMBRE_PRESIDENTE,
      RUC_ARBITRO_ENTIDAD,
      NOMBRE_ARBITRO_ENTIDAD,
      RUC_ARBITRO_CONTRATISTA,
      NOMBRE_ARBITRO_CONTRATISTA,
      MOTIVO_PRESIDENTE,
      MOTIVO_ENTIDAD,
      MOTIVO_CONTRATISTA,
      IND_ULTIMO,
      FECHA_PUBLICA,
      USUARIO_PUBLICA,
      IP_PUBLICA,
      SUNAT_ARBITRO_PRESIDENTE,
      SUNAT_ARBITRO_ENTIDAD,
      SUNAT_ARBITRO_CONTRATISTA,
      NOMBRES_PRESIDENTE,
      APEPAT_PRESIDENTE,
      APEMAT_PRESIDENTE,
      NOMBRES_ENT,
      APEPAT_ENT,
      APEMAT_ENT,
      NOMBRES_CONT,
      APEPAT_CONT,
      APEMAT_CONT,
      RUC_SECRETARIO,
      NOMBRE_SECRETARIO,
      MOTIVO_SECRETARIO,
      SUNAT_ARBITRO_SECRETARIO,
      NOMBRES_SECRETARIO,
      APEPAT_SECRETARIO,
      APEMAT_SECRETARIO FROM REG_PROCESOS.CONTRATO_ARBITRAJE WHERE NUMERO=IDNUMERO AND NUMERO_REGISTRO=IDNUMEROARBITRO);
      COMMIT;
    

    usp_print('
    <script language=javascript>
 
       thisform.scriptdo.value="doView";
       thisform.submit();
    </script>
    ');

 END; 

 

PROCEDURE uspConciliacionInsert( 
session__cod_contrato   VARCHAR2 DEFAULT NULL,
session__filesingedhttp VARCHAR2 DEFAULT NULL,
ag_tipo_demandante        varchar2,
ag_mecanismo              varchar2,
ag_tipo_estado            varchar2,
ag_f_audiencia            varchar2,
ag_fs_acta_conciliacion   varchar2,
ag_ruc_conciliador        varchar2,
ag_nombre_conciliador     varchar2,
ag_c_conciliacion         number,


        pfiletoupload1                 varchar2,
    pfiletoupload_file1            varchar2,
    WriteFileDirectoryDynamic    varchar2,
    session__seacedocument                  varchar2,
            session__seacedocumentosdwn             varchar2,
            session__maxMBUploadFileSize            varchar2,
            docname_mimetype                        varchar2,
            iisenv__remote_host                varchar
   
 ) Is 

idnumero                  number ;
idnumeroConciliacion           number ;

 BEGIN
  
   PKU_SS_CONTROVERSIAS.dojscript  ;
        select max(numero) into idnumero  from (
            select  numero  from   reg_procesos.contrato_arbitraje 
            Union   
            select numero  from   reg_procesos.contrato_conciliacion
       );
 
        if idnumero is null then
          idnumero := 1;
       else
          idnumero := idnumero + 1 ;
       end if;


        select  max(NUM_REGISTRO) into idnumeroConciliacion  from   reg_procesos.contrato_conciliacion;
     
       if idnumeroConciliacion is null then
          idnumeroConciliacion := 1;
       else
          idnumeroConciliacion := idnumeroConciliacion + 1 ;
       end if;
       

      --insert into reg_procesos.contrato_conciliacion (numero,num_registro,tipo_demandante,cod_centro_conciliacion,ruc_conciliador,nombre_conciliador,fecha_audiencia,nombre_doc_acta,tipo_estado_conciliacion,n_cod_contrato,url_doc_acta)
 
      insert into reg_procesos.contrato_conciliacion (
      numero,
      num_registro,
      tipo_demandante,
      ruc_conciliador,
      nombre_conciliador,
      fecha_audiencia,
      fecha_acta_conciliacion,
      FECHA_REGISTRO,-->vpt 12-05-2016
      tipo_estado_conciliacion,
      n_cod_contrato,
      URL_DOC_ACTA,
      NOMBRE_DOC_ACTA,
      COD_CENTRO_CONCILIACION
      )
      values(
      idnumero,
      idnumeroConciliacion,
      ag_tipo_demandante,
      ag_ruc_conciliador,
      ag_nombre_conciliador,
      ag_f_audiencia,
      ag_fs_acta_conciliacion,
      sysdate,--vpt 12-05-2016
      ag_tipo_estado,
      session__cod_contrato,
       WriteFileDirectoryDynamic,   
       pfiletoupload_file1  ,
       ag_c_conciliacion
      );
          
  commit;

    usp_print('
    <script language=javascript>
    
       thisform.scriptdo.value="doView";
       thisform.submit();
    </script>
    ');

 END; 




PROCEDURE uspLisControversiasdoview (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL, 
  session__user_id  VARCHAR2 DEFAULT NULL  
  )  
  
 IS
 lv_codtipofile     VARCHAR2(100); 
  lvtipodocumento    VARCHAR2(100); 
  cod_tipo_file       VARCHAR2(100); 
  montoTotal          number;
  num_arb             number;
  num_cons            number; 
   impedimento varchar2 (150);
  
   ------- Cursores -------
   
Cursor c_cursor( p_n_cod_contrato in number) is
SELECT  c.numero, c.NUM_REGISTRO,
c.RUC_CONCILIADOR,
c.NOMBRE_CONCILIADOR,
to_char(c.FECHA_AUDIENCIA, 'dd/mm/yyyy') FECHA_AUDIENCIA,
to_char(c.FECHA_ACTA_CONCILIACION, 'dd/mm/yyyy') FECHA_ACTA_CONCILIACION,
to_char(c.FECHA_REGISTRO, 'dd/mm/yyyy') FECHA_REGISTRO,
c.nombre_doc_acta,
c.url_doc_acta,
c.N_COD_CONTRATO,
ec.descripcion estado,
cc.descripcion centro,
td.c_descripcion demandante
from  reg_procesos.contrato_conciliacion c left join reg_procesos.estado_conciliacion ec on c.TIPO_ESTADO_CONCILIACION = ec.cod_estado_conciliacion left join
reg_procesos.centros_conciliacion cc on c.COD_CENTRO_CONCILIACION = cc.COD_CENTRO_CONCILIACION left join  (    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 12) td on c.tipo_demandante = td.n_id_maestro
WHERE c.N_COD_CONTRATO = p_n_cod_contrato
order by  c.NUM_REGISTRO asc
;
    


Cursor c_cursor_arbitraje( p_n_cod_contrato in number) is
SELECT 
numero, 
numero_registro,
tipo_arbitro, -- ddrodriguez req 55
td.c_descripcion demandante, 
taa.c_descripcion arbitraje, 
tab.c_descripcion arbitro,
nombre_presidente, 
to_char(fecha_instalacion, 'dd/mm/yyyy')  fecha_instalacion,
to_char(l.d_registro_laudo_SEACE, 'dd/mm/yyyy') fecha_publica 

 
from  contrato_arbitraje a left join (
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 12) td on a.tipo_demandante = td.n_id_maestro 
left join (    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 6) taa on  a.tipo_arbitraje = taa.n_id_maestro
left join (    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 23) tab on a.tipo_arbitro = tab.n_id_maestro
    
left join tbl_arb_laudo_local l on  a.numero_registro = l.CODIGO_CONTROVERSIA_SEACE    
 
   
    
WHERE a.N_COD_CONTRATO = p_n_cod_contrato and a.ind_ultimo = '1'
AND (l.C_ESTADO_REGISTRO IS NULL
    OR l.C_ESTADO_REGISTRO = 1 or l.C_ESTADO_REGISTRO =  2 or l.C_ESTADO_REGISTRO = 3 or l.C_ESTADO_REGISTRO = 4 ) --Deacuerdo al Sistema de Arbitraje: 0=Cancelado, 1=Nuevo, 2=Borrador, 3=Mofificado, 4=Publicado
order by numero_registro asc
;


      
 BEGIN

 
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;
  



          
 PKU_SS_FUNCIONES_JS.js_script('
 
 function detalle(cod,tipoSel) 
 {
      thisform.ag_tipo_seleccion.value = tipoSel ;
      thisform.ag_cod.value = cod ;
      thisform.scriptdo.value = "EditArbitraje"   ;
      thisform.submit();
 }
 
 
  function historial(cod)
 {
     thisform.ag_cod.value = cod ;
      thisform.scriptdo.value = "Historial"   ;
      thisform.submit();
 }
 
 
 function Crear()
    {
      thisform.scriptdo.value = "creaControversia";
      thisform.submit();
    }
 ');   
 
 

----------- CABECERA --------------------
 USP_PRINT('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>'
          || PKU_SS_UTILES.f_get_titulo_contrato(session__cod_contrato,'Controversias')
          || '<td align="right" valign=top width="50%">
                 <input type="button" value="Crear Controversia" onclick=Crear()></td>                 
                 </tr>
         </table>');
 USP_PRINT('</TD></TR>');
 USP_PRINT('</TABLE><br>');

 ------ Cabecera de Columnas --------
    usp_print('
    <h3>Conciliaci&oacute;n</h3>
    <table class="table table-striped">
        <tr>
            <td>Nro</td>  
            <td class="hide">Nro de registro de Conciliaci&oacute;n</td>
            <td>Solicitante</td>  
            <td>Centro de Conciliaci&oacute;n</td>  
            <td>Conciliador</td> 
            <td>Fecha en que se llev&oacute; a cabo la Audiencia de Instalaci&oacute;n</td>  
            <td>Acta de Conciliaci&oacute;n</td> 
            <td>Fecha Suscripci&oacute;n del Acta de Conciliaci&oacute;n</td>
            <td>Estado</td> 
         </tr>
    ');

  montoTotal := 0;
  num_cons := 0;
   for xrow in c_cursor(session__cod_contrato) loop
      begin
      
      num_cons := num_cons + 1;
  /*    
    if  (xrow.tipo_reajuste  = 1) then
       montoTotal := montoTotal +  xrow.monto_reajuste ;
    end if;
    
    if (xrow.tipo_reajuste  =  2) then
       montoTotal := montoTotal -  xrow.monto_reajuste ; 
    end if ; 
    
   
         */
            
    lvtipodocumento:=upper(substr(xrow.nombre_doc_acta,length(xrow.nombre_doc_acta)-2,length(xrow.nombre_doc_acta)));

    
    begin
        select replace(icon_tipo_file, 'jpg', 'png') into lv_codtipofile
        from Reg_procesos.tipo_archivo
        where ext_tipo_file=lvtipodocumento;
    exception
        when no_data_found then
            lv_codtipofile:= Null; 
    end;
   

         usp_print('
         <tr>
        
            <td align="center">'||num_cons||'</td>
            <td align="center" class="hide">'||xrow.NUM_REGISTRO||'</td>
            <td align="center">'||xrow.demandante||'</td>
            <td align="center">'||xrow.centro||'</td>
            <td align="center">'||xrow.NOMBRE_CONCILIADOR||  '</td>
            <td align="center">'||xrow.FECHA_AUDIENCIA||'</td>
            <td align="center">
            <a href="'||url_azure_app||xrow.url_doc_acta|| xrow.nombre_doc_acta ||'" target="_BLANK"> 
              <img width="30" height="30" src="bootstrap/'|| lv_codtipofile  ||'" border="0" style="cursor:hand" /><br></a>        
            ');
            -->inicio vpt 13-05-2016
            if(f_get_cant_dias_habiles(xrow.fecha_acta_conciliacion,xrow.fecha_registro))>10 then
            usp_print('<br ><h5><p style="color: red">Registro Extempor&aacuteneo</p></h5>');
            end if;
            -->final vpt 13-05-2016
            usp_print('
            </td>
            <td align="center">'||xrow.FECHA_ACTA_CONCILIACION||'</td>
            <td align="center">'||xrow.estado||'</td>

           </tr>  
            ');
            
            
            
            
            
         
       end;
   end loop;
   
   usp_print('</table>');
   
   
   
    ------ Cabecera de Columnas --------
    usp_print('
    <h3>Arbitraje</h3>
    <table width=100% class="table table-striped">
        <tr>
            <td class="th1">Nro</td>  
            <td class="hide">Nro de Registro de Proceso Arbitral</td>  
            <td class="th1">Demandante</td>  
            <td class="th1">Tipo de Arbitraje</td>  
            <td class="th1">Tipo de Arbitro</td> 
            <td class="th1">Presidente/Arbitro &Uacute;nico</td>  
            <td class="th1">Fecha de Instalaci&oacute;n</td> 
            <td class="th1">Fecha de Publicaci&oacute;n de Laudo</td> 
            <td class="th1">Actualizacion de Arbitraje</td> <!--vpt-11-05-2016-->
            <td class="th1">Actualizaci&oacute;n de &Aacute;rbitros</td> 
            <td class="th1">Actualizaci&oacute;n de Secretario Arbitral</td>
            <td class="th1">Detalle/Historial</td> 
         </tr>
    ');

  montoTotal := 0;
  num_arb :=  0;
   for xrow1 in c_cursor_arbitraje(session__cod_contrato) loop
      begin
      
      num_arb := num_arb + 1;
      

      
         usp_print('
         <tr>
            <td align="center">'||num_arb||'</td>
            <td align="center" class="hide">'||xrow1.numero_registro||'</td>
            <td align="center">'||xrow1.demandante||'</td>
            <td align="center">'||xrow1.arbitraje||'</td>
            <td align="center">'||xrow1.arbitro||'</td>
            <td align="center">'||xrow1.nombre_presidente||'</td>
            <td align="center">'||xrow1.fecha_instalacion||'</td>
            <td align="center">'|| xrow1.fecha_publica   ||'</td>
                <td align="center"> <input type=button value="..." onclick="detalle('||xrow1.numero_registro||',1);"> </td> 
                <td align="center"> <input type=button value="..." onclick="detalle('||xrow1.numero_registro||',2);"> </td> 
                <td align="center"> <input type=button value="..." onclick="detalle('||xrow1.numero_registro||',3);"> </td>
                <td align="center"> <input type=button value="..."  onclick="historial('||xrow1.numero_registro||');"></td>
            </tr>  
           
 
            ');
            
             
            
            
            
         
       end;
   end loop;
   
   
   
   
  
   usp_print('
        </table><table>          <tr><td>
           <input type = "hidden" name = "ag_cod">
           <input type = "hidden" name = "ag_tipo_seleccion">
           <input type = "hidden" name = "ag_tipo_arbitro_env">
          </td> </tr></table>
        <br/>
        <br/>
        ');
        
 END;
 
 
  
   
      
 
  PROCEDURE uspCreaConciliacion(
   session__eue_codigo      VARCHAR2,
    session__anhoentidad     VARCHAR2,
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_estado                      VARCHAR2,
  ag_archivo                          varchar2,
  ag_c_conciliacion                   number, 
    session__maxMBUploadFileSize   varchar2 default null,
    docname__mime                  varchar2 default null,
    session__FileSinged            varchar2 default null  
  )   
     
 IS
 lv_codtipofile                VARCHAR2(100); 
 lvtipodocumento               VARCHAR2(100); 
 cod_tipo_file                 VARCHAR2(100); 
  lv_combo_demandante           varchar2(4000);  
 lv_combo_mecanismo            varchar2(4000); 
  lv_combo_estado               VARCHAR2(4000);
 montoTotal                    number;
 ln_num_contrato               varchar2(4000);  
    ctipodemandante               ref_cursor;
 ctipomecanismo                ref_cursor;  
 ctipoestado                    ref_cursor;
     lv_ruta_file                  varchar2(2000); 
   ------- Cursores -------
   ------- Listado de Prorrogas ------  
 BEGIN
  PKU_SS_CONTROVERSIAS.dojscript  ;
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;
  
  select  n_contrato into ln_num_contrato  from reg_procesos.contrato where N_COD_CONTRATO = session__cod_contrato  ; 


 
    
    open ctipodemandante for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 12;
     
     
    open ctipomecanismo for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 30;
    
    
    open ctipoestado for
    select cod_estado_conciliacion,descripcion
    from reg_procesos.estado_conciliacion; 
     
       

        lv_combo_demandante  := PKU_SS_UTILES.f_retorna_combo(ctipodemandante, 'ag_tipo_demandante', ag_tipo_demandante,'Seleccione...','style="width:260px"');
     
    lv_combo_mecanismo   :=     PKU_SS_UTILES.f_retorna_combo(ctipomecanismo, 'ag_mecanismo', ag_mecanismo,'Seleccione...','style="width:260px" onchange="arbitraje();"'); 
    
     lv_combo_estado :=   PKU_SS_UTILES.f_retorna_combo(ctipoestado, 'ag_tipo_estado', ag_tipo_estado,'Seleccione...','style="width:260px" '); 
    
          
 PKU_SS_FUNCIONES_JS.js_script('
 
 function ValidaRuc1(obj){
SoloNumerosNoDec();
                    if  (obj.value.length >= 11)
                    {
                    
                        window.event.keyCode = 0;
                    }   
                    else
                    {
                        return;
                    }


}



function busquedacentroConc()
{

//       ventanaHija =   window.open(''portlet5open.asp?_portletid_=mod_controversia&scriptdo=BuscaCentro'','''',''toolbar=no,Width=700,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised'')
       ventanaHija =   window.open(''ControllerServletOpen?portletid=mod_controversia&scriptdo=BuscaCentro'','''',''toolbar=no,Width=700,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised'')

}

 function RtnCodSniop(codigo,descripcion){
             
    thisform.ag_c_conciliacion.value = codigo;              
    thisform.ag_c_conciliacion_desc.value  =   descripcion;
}










function SoloNumerosNoDec(){

//Solo permite ingreso de numeros del teclado superior, derecho sin punto decimal
//inicio, fin, shift, control, etc

    var x = window.event.keyCode;   
    switch (x){
        case 8: case 9: case 48: case 49: case 50: case 51: case 52: case 53: case 54: case 55: case 56: case 57: 
            return;
        default:
            window.event.keyCode = 0;
            break;
    }
}

 
 function Crear()
 {
    
      thisform.scriptdo.value = "doNewControversia";
      thisform.submit();
    
    
 }   
    
     function arbitraje()
    {
      if (thisform.ag_mecanismo.value == 316)
        {
          thisform.scriptdo.value = "creaArbitraje";
          thisform.submit();
        }
        
      if (thisform.ag_mecanismo.value == 315)  
       { 
          thisform.scriptdo.value = "creaConciliacion";
          thisform.submit();
      }
      
    }
    
    
    
    
    function  publicar()
    
    {
    

           if (thisform.ag_tipo_demandante.value == ""  )
        {
              alert("Ingrese el tipo de demandante");
              return;
        }

            if (thisform.ag_mecanismo.value == ""  )
        {
              alert("Ingrese el mecanismo de solución de Controversia");
              return;
        }
    
            if (thisform.ag_f_audiencia.value == ""  )
        {
              alert("Seleccione la fecha en que se llevó a cabo la audiencia");
              return;
        }
        
        
        if (thisform.ag_fs_acta_conciliacion.value == ""  )
        {
              alert("Seleccione la fecha en la que suscribio el acta de conciliacion");
              return;
        }
        
        
            if (thisform.ag_c_conciliacion.value == ""  )
        {
              alert("Seleccione el Centro de Conciliación autorizado por el Ministerio de Justicia");
              return;
        } 
        
            if (thisform.ag_c_conciliacion.value == ""  )
        {
              alert("Seleccione el Centro de Conciliación autorizado por el Ministerio de Justicia");
              return;
        } 
        
        
          if (thisform.ag_ruc_conciliador.value == ""  )
        {
              alert("Ingrese el número de RUC del Conciliador");
              return;
        }
        
      
           if (thisform.ag_nombre_conciliador.value == ""  )
        {
              alert("Ingrese los Apellidos y Nombres  del Conciliador");
              return;
        }
        
 
            if (thisform.pfiletoupload1.value == ""  )
        {
              alert("Ingrese el archivo");
              return;
        }
        
            if (thisform.ag_tipo_estado.value == ""  )
        {
              alert("Seleccione el estado de la Conciliación");
              return;
        }
        
        
        
        
            if(thisform.pfiletoupload1.value != ""){
    
      extencion1 = thisform.pfiletoupload1.value
      
      extencion1 = extencion1.substring((extencion1.length)-4,extencion1.length)
      
      if (extencion1 != ".doc" && extencion1 != ".zip" && extencion1 != ".pdf")
            {
               alert("El archivo de extensi\xf3n "+extencion1+" no est\xe1 permitido.");
               thisform.pfiletoupload1.focus();    
               return false;
            }
              var namearchive = "'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'"+extencion1;
              thisform.pfiletoupload_file1.value = namearchive;
      }
 
 
          thisform.scriptdo.value = "conciliacionInsert";
          
                 if ( confirm("¿Esta Ud. seguro de publicar los cambios realizados?") )
        {
             thisform.submit();
        }
    
    
    }

   
   
    
    
 ');   
 

----------- CABECERA --------------------
 USP_PRINT('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>'
          || PKU_SS_UTILES.f_get_titulo_contrato(session__cod_contrato,'Controversias')
          || '<td align="right" valign=top width="50%">
                 <input type=button value="Publicar" onclick="publicar();"> <input type=button value="Volver" onclick="thisform.scriptdo.value=''doView'';thisform.submit();"></td></tr>
         </table>');
 USP_PRINT('</TD></TR>');
 USP_PRINT('</TABLE><br>');



 usp_print('
  <table class="table table-striped">');    
 
 usp_print(' <td align = "center" colspan = 3><h3>Ficha Electr&oacute;nica</h3></td>');
  usp_print(' <td align = "center" colspan = 3><br></td>');
  
  
  
      usp_print('
    <tr>
      <td class=c1>(*)Solicitante</td>
    <td class=c2>'||lv_combo_demandante||'</td>
    <td class=c3>Seleccione al Solicitante.</td>
    </tr>'); 
      
      
         usp_print('
    <tr>
      <td class=c1>(*)Tipo de mecanismo de soluci&oacute;n de Controversia</td>
    <td class=c2>'||lv_combo_mecanismo||'</td>
    <td class=c3>Seleccione el tipo de mecanismo de soluci&oacute;n de Controversia.</td>
    </tr> <tr><td> <br></td></tr>'
    
    
    );  
    
  
  
    usp_print('
    <tr>
        <td class=c1>(*)Fecha en que se llev&oacute; a cabo la Audiencia de Instalaci&oacute;n</td>
        <td class=c2>
        <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_f_audiencia" style="width:98%" id="txtFechaIni" data-format="dd/MM/yyyy" class="form-control"/>
          </div>
          </td>
        <td class=c3>Seleccione la fecha en que se llev&oacute; a cabo la audiencia </td>
    </tr>
  '); 
  
        usp_print('

    <tr>
        
        <td class=c1>(*)Centro de Conciliaci&oacute;n</td>
        <td class=c2><input type="text" name="ag_c_conciliacion_desc" style="width:85%" value="" readonly = "true"><input type=button value="..." onclick="busquedacentroConc();"><input type="hidden" name="ag_c_conciliacion" value="'||  ag_c_conciliacion ||'" ></td>
        <td class=c3>Seleccione  el Centro de Conciliaci&oacute;n  autorizado por el Ministerio de Justicia</td>
    </tr>
  '); 
  
      usp_print('

      <tr><td><h4>Identificaci&oacute;n del Conciliador</h4></td>
      <td></td><td></td></tr>
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input type="text" name="ag_ruc_conciliador" value="" size=54 onkeypress = "ValidaRuc1(thisform.ag_ruc_conciliador)" ></td>
        <td class=c3>Ingrese el número de RUC del Conciliador</td>
    </tr>
  ');
   
           usp_print('
     
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" name="ag_nombre_conciliador" value="" size=54 
onkeypress= "return alpha(event)"></td>
        <td class=c3>Muestra los Apellidos y Nombres del Presidente del Conciliador</td>
       
    </tr>
    
          <tr><td colspan = 3><h4>Acta de Conciliaci&oacute;n</h4></td></tr>
          
  ');
 
  usp_print('
    <tr>
        <td class=c1>(*)Fecha de suscripción del Acta de Conciliación</td>
        <td class=c2>
        <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fs_acta_conciliacion" style="width:98%" id="txtFechaIni" data-format="dd/MM/yyyy" class="form-control"/>
          </div>
          </td>
        <td class=c3>Seleccione la fecha en que sucribió el acta de conciliación</td>
    </tr>
  ');

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Archivo',
                '<input type="file"  id = "pfiletoupload1"  name="pfiletoupload1" size="40"  value="'||ag_archivo||'"  > 
                <input type="hidden" name="pfiletoupload_file1" value="" />
                <br>  Tipos de archivo permitidos: *.doc, *.pdf, *.zip ',
                'Seleccione el Archivo a Adjuntar'));
       
                                                                           
           usp_print('
    
      <tr><td colspan=3><h4>Estado</h4></td></tr>
    <tr>
      <td class=c1>(*)Estado de la Conciliaci&oacute;n</td>
    <td class=c2>'||lv_combo_estado||'</td>
    <td class=c3>Seleccione el estado de la Conciliaci&oacute;n</td>
    </tr>'); 
   
  usp_print('</table><br>');

   usp_print('
        </table>
        <br/>
        <br/>
        ');   
    lv_ruta_file    := 'mon/docs/contratos/reajustes/'  || session__anhoentidad||'/'||session__eue_codigo||'/';      
        

  usp_print('<input type="hidden" name="WriteFileDirectory"          value="FileSinged">');
  usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"   value="'||lv_ruta_file||'"></input>');   
   usp_print
             (   '<input name="session__FileSingedHTTP" type="hidden" value="'
              || session__filesingedhttp
              || '"></input>'   );
      
    usp_print('<input type="hidden"  value="'||ag_archivo||'"  id="ag_archivo" name="ag_archivo">');
    
 END;
  
   
 
  PROCEDURE uspEditArbitraje (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_arbitraje                  VARCHAR2 ,
  ag_tipo_arbitro                    VARCHAR2 ,
    ag_numero_registro                   number ,
    ag_cod                                varchar2,
    ag_f_autoriza                           varchar2,
  sunat                                varchar2,
  ag_tipo_seleccion                number -- manuel
  )    
    
 IS
 lv_codtipofile                VARCHAR2(100); 
 lvtipodocumento               VARCHAR2(100); 
 cod_tipo_file                 VARCHAR2(100); 
 lv_combo_arbitraje           varchar2(4000);  
 lv_combo_arbitro             varchar2(4000);
  lv_combo_demandante           varchar2(4000);  
 lv_combo_mecanismo            varchar2(4000); 
 montoTotal                    number;
 ln_num_contrato               varchar2(4000);  
 ctipoArbitraje               ref_cursor;
   ctipoarbitro                 ref_cursor;  
    ctipodemandante               ref_cursor;
 ctipomecanismo                ref_cursor;  
 ln_fecha                       date;  
 ln_tipoArbitraje               VARCHAR2(100);
 ln_tipoarbitro                 varchar2(100);
 LN_TIPOARBITRO_EVAL            varchar2(100);
 ln_cod                         VARCHAR2(100);
 ln_RUC_PRESIDENTE                   VARCHAR2(100);
 ln_NOMBRE_PRESIDENTE                  VARCHAR2(4000);
 ln_MOTIVO_PRESIDENTE                  VARCHAR2(100);
 ln_RUC_ARBITRO_ENTIDAD                VARCHAR2(100);
 ln_NOMBRE_ARBITRO_ENTIDAD               VARCHAR2(4000);
 ln_MOTIVO_ARBITRO_ENTIDAD                 VARCHAR2(100);
 ln_RUC_ARBITRO_CONTRATISTA              VARCHAR2(100);
 ln_NOMBRE_ARBITRO_CONTRATISTA             VARCHAR2(4000);
 ln_MOTIVO_ARBITRO_CONTRATISTA              VARCHAR2(100);
 ln_NUMERO_REGISTRO                         number;
  ln_nombres_presidente     VARCHAR2(200 BYTE) ;    
  ln_apePat_presidente      VARCHAR2(200 BYTE) ;      
  ln_apeMat_presidente      VARCHAR2(200 BYTE) ;       
  ln_nombres_ent            VARCHAR2(200 BYTE) ;    
  ln_apePat_ent             VARCHAR2(200 BYTE) ;       
  ln_apeMat_ent             VARCHAR2(200 BYTE) ;      
  ln_nombres_cont           VARCHAR2(200 BYTE) ;       
  ln_apePat_cont           VARCHAR2(200 BYTE) ;       
  ln_apeMat_cont            VARCHAR2(200 BYTE) ;
  ln_RUC_SECRETARIO               VARCHAR2(11 BYTE);         
  ln_NOMBRE_SECRETARIO            VARCHAR2(200 BYTE);
  ln_SUNAT_SECRETARIO             VARCHAR2(1 BYTE);
  ln_MOTIVO_SECRETARIO            VARCHAR2(200 BYTE);
  ln_NOMBRES_SECRETARIO           VARCHAR2(200 BYTE);
  ln_APEPAT_SECRETARIO            VARCHAR2(200 BYTE);
  ln_APEMAT_SECRETARIO           VARCHAR2(200 BYTE);
  ln_campotitulo                 varchar2 (800); --ddrodriguez Req 55
 

   ------- Cursores -------
   
    Cursor c_cursor( p_n_cod_contrato in number , p_n_num_registro in varchar2) is
    SELECT N_COD_CONTRATO,
    NUMERO_REGISTRO,
    FECHA_INSTALACION,
    TIPO_ARBITRAJE,
    TIPO_ARBITRO,
    TIPO_ARBITRO as TIPO_ARBITRO_EVAL,
    RUC_PRESIDENTE,
    NOMBRE_PRESIDENTE,
    MOTIVO_PRESIDENTE,
    RUC_ARBITRO_ENTIDAD,
    NOMBRE_ARBITRO_ENTIDAD,
    MOTIVO_ENTIDAD,
    RUC_ARBITRO_CONTRATISTA,
    NOMBRE_ARBITRO_CONTRATISTA,
    MOTIVO_CONTRATISTA,
    nombres_presidente,
    apePat_presidente,
    apeMat_presidente,
    nombres_ent,
    apePat_ent,
    apeMat_ent,
    nombres_cont,
    apePat_cont,
    apeMat_cont,
    RUC_SECRETARIO,
    NOMBRE_SECRETARIO,
    MOTIVO_SECRETARIO,
    SUNAT_ARBITRO_SECRETARIO,
    NOMBRES_SECRETARIO,
    APEPAT_SECRETARIO,
    APEMAT_SECRETARIO
    
    from reg_procesos.contrato_arbitraje where n_cod_contrato =  p_n_cod_contrato and  NUMERO_REGISTRO = p_n_num_registro and ind_ultimo = 1 ;

   
   ------- Listado de Prorrogas ------  
 BEGIN
  PKU_SS_CONTROVERSIAS.dojscript  ;
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;
  
  select  n_contrato into ln_num_contrato  from reg_procesos.contrato where N_COD_CONTRATO = session__cod_contrato  ; 

   usp_print('<body onload="init('||ag_tipo_seleccion||')">');

       ------- Tablero titulo -------
   if (ag_tipo_seleccion = 1) then
       ln_campotitulo := 'Actualizaci&oacute;n de datos de Arbitraje';
   else if (ag_tipo_seleccion = 2) then
         ln_campotitulo := 'Actualizaci&oacute;n de datos de &Aacute;rbitros';
        else if (ag_tipo_seleccion = 3) then
             ln_campotitulo := 'Actualizaci&oacute;n de datos de Secretario Arbitral';
             end if;
        end if;
   end if;
   ------- Tablero titulo -------

   
    open ctipoarbitraje for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 6;

    open ctipoarbitro for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 23;
    
    
    open ctipodemandante for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 12;
     
     
    open ctipomecanismo for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 30;
     
  
       
     
         
         for xrow in c_cursor(session__cod_contrato,ag_cod) loop
      begin
      
              LN_FECHA :=   XROW.FECHA_INSTALACION  ;
              LN_TIPOARBITRAJE := XROW.TIPO_ARBITRAJE;
              LN_TIPOARBITRO   :=   XROW.TIPO_ARBITRO;
              LN_TIPOARBITRO_EVAL   :=   XROW.TIPO_ARBITRO_EVAL;
              LN_RUC_PRESIDENTE     := XROW.RUC_PRESIDENTE;                
              LN_NOMBRE_PRESIDENTE :=  XROW.NOMBRE_PRESIDENTE ;
              LN_RUC_ARBITRO_ENTIDAD  := XROW.RUC_ARBITRO_ENTIDAD;
              LN_NOMBRE_ARBITRO_ENTIDAD :=  XROW.NOMBRE_ARBITRO_ENTIDAD;
              LN_RUC_ARBITRO_CONTRATISTA := XROW.RUC_ARBITRO_CONTRATISTA;
              LN_NOMBRE_ARBITRO_CONTRATISTA := XROW.NOMBRE_ARBITRO_CONTRATISTA; 
              LN_MOTIVO_PRESIDENTE := XROW.MOTIVO_PRESIDENTE;
              LN_MOTIVO_ARBITRO_ENTIDAD := XROW.MOTIVO_ENTIDAD;
              LN_MOTIVO_ARBITRO_CONTRATISTA := XROW.MOTIVO_CONTRATISTA;
              LN_NUMERO_REGISTRO := XROW.NUMERO_REGISTRO;
              LN_NOMBRES_PRESIDENTE     :=        XROW.NOMBRES_PRESIDENTE;
              LN_APEPAT_PRESIDENTE      :=        XROW.APEPAT_PRESIDENTE;
              LN_APEMAT_PRESIDENTE      :=        XROW.APEMAT_PRESIDENTE;
              LN_NOMBRES_ENT            :=        XROW.NOMBRES_ENT;
              LN_APEPAT_ENT             :=        XROW.APEPAT_ENT;
              LN_APEMAT_ENT             :=        XROW.APEMAT_ENT;
              LN_NOMBRES_CONT           :=        XROW.NOMBRES_CONT;
              LN_APEPAT_CONT            :=        XROW.APEPAT_CONT;
              LN_APEMAT_CONT            :=        XROW.APEMAT_CONT;
              LN_RUC_SECRETARIO             := XROW.RUC_SECRETARIO;         
              LN_NOMBRE_SECRETARIO          := XROW.NOMBRE_SECRETARIO;
              LN_MOTIVO_SECRETARIO          := XROW.MOTIVO_SECRETARIO;
              LN_NOMBRES_SECRETARIO         := XROW.NOMBRES_SECRETARIO;
              LN_SUNAT_SECRETARIO           := XROW.SUNAT_ARBITRO_SECRETARIO;
              LN_APEPAT_SECRETARIO          := XROW.APEPAT_SECRETARIO;
              LN_APEMAT_SECRETARIO          := XROW.APEMAT_SECRETARIO;


       end;
   end loop;  
   
   
        
               
       if  ag_f_autoriza is not null  then
          ln_fecha := ag_f_autoriza; 
       end if;
      
       if  ag_tipo_arbitraje is not null  then
           ln_tipoArbitraje := ag_tipo_arbitraje; 
       end if;
       
          if  ag_tipo_arbitro is not null  then
           ln_tipoarbitro := ag_tipo_arbitro;     
         end if;

    lv_combo_demandante  := PKU_SS_UTILES.f_retorna_combo(ctipodemandante, 'ag_tipo_demandante', ag_tipo_demandante,'Seleccione...','style="width:260px" disabled = "disabled"');
     
    lv_combo_mecanismo   := PKU_SS_UTILES.f_retorna_combo(ctipomecanismo, 'ag_mecanismo', '316','Seleccione...','style="width:260px" onchange="arbitraje();"  disabled = "true"'); 
    
    lv_combo_arbitraje  := PKU_SS_UTILES.f_retorna_combo(ctipoArbitraje, 'ag_tipo_arbitraje', ln_tipoArbitraje,'Seleccione...','style="width:260px"  disabled = "true" ' );
     
    lv_combo_arbitro :=   PKU_SS_UTILES.f_retorna_combo(ctipoarbitro, 'ag_tipo_arbitro', ln_tipoarbitro,'Seleccione...','style="width:260px" onchange="arbitraje();" disabled = "true"'); 
    
         
   
          
          
 pku_ss_funciones_js.js_script('
  // inicio ddrodriguez req 55
  function verificar_cambios(){
  
    if (thisform.ag_tipo_arbitraje.value != thisform.nh_ag_tipo_arbitraje.value) {
        return false;
    }

    if (thisform.ag_tipo_arbitro.value != thisform.nh_ag_tipo_arbitro.value) {
        return false;
    }
    
    var sAux1=""; var name_hidden="";
    var frm = document.getElementById("thisform");
    for (i=0;i<frm.elements.length;i++)  
    {
      if(frm.elements[i].type == "text") {	
        sAux1 = frm.elements[i].value.trim();
        name_hidden = "nh_" + frm.elements[i].name;
        var sAux2 = document.getElementById(name_hidden).value.trim();
        if (sAux1 != sAux2) {
        return false;
        }
     }   
    }
    alert("Para grabar debe realizar una modificación");
    return true;
  }
  
  function crear_hidden(){
    var sAux="";
    var frm = document.getElementById("thisform");
    for (i=0;i<frm.elements.length;i++)
    {
      if(frm.elements[i].type == "text") {	
      sAux = "nh_" + frm.elements[i].name;
      addHidden(sAux,frm.elements[i].value);
      }
    }
  }
  
  function addHidden(key, value) {
      // Create a hidden input element, and append it to the form:
      var input = document.createElement("input");
      input.type = "hidden";
      input.id = key;
      input.name = key;
      input.value = value;
      thisform.appendChild(input);
  } 
  // fin ddrodriguez req 55
  
 function RtnArbitro(nombre,ruc,tipo,motivo,pub,sunat)
 {
 
  
     if (tipo == 1)      
        { 
          thisform.ag_ruc_presidente.value=ruc;
          thisform.ag_nombre_presidente.value=nombre;
          thisform.ag_motivo_presidente.value= motivo;
          thisform.ag_sunat_presidente.value=sunat ;
          thisform.ag_nombres_presidente.value = "";
          thisform.ag_apeMat_presidente.value = "";
          thisform.ag_apePat_presidente.value = "";
        }
     if (tipo == 2)
        {
          thisform.ag_ruc_arbitro_ent.value=ruc;
          thisform.ag_mom_arbitro_ent.value=nombre;
          thisform.ag_motivo_arbitro_ent.value=motivo;
          thisform.ag_sunat_arbitro_ent.value=sunat ;
          thisform.ag_nombres_ent.value = "" ;
          thisform.ag_apePat_ent.value = "" ;
          thisform.ag_apeMat_ent.value = "" ;
          
          
          
        }
     if (tipo == 3)
        {
          thisform.ag_ruc_arbitro_cont.value=ruc;
          thisform.ag_nombre_arbitro_cont.value=nombre;
            thisform.ag_motivo_arbitro_cont.value=motivo;
             thisform.ag_sunat_arbitro_cont.value=sunat ;
             thisform.ag_nombres_cont.value = "" ;
              thisform.ag_apePat_cont.value = "";
                thisform.ag_apeMat_cont.value =  "";
        }
      if (tipo == 4)      
        { 
          thisform.ag_ruc_secretario.value=ruc;
          thisform.ag_nombre_secretario.value=nombre;
          thisform.ag_motivo_secretario.value= motivo;
          thisform.ag_sunat_secretario.value=sunat ;
          thisform.ag_nombres_secretario.value = "";
          thisform.ag_apemat_secretario.value = "";
          thisform.ag_apepat_secretario.value = "";
        }
        
    if (pub == 1)
     
     {
     div = document.getElementById("div_pub");


     div.style.display = ""; 
     
     }
        
 }
 
 
 function modArbitro(cod)
 {
        if (cod == 1)
        { 
          ruc = thisform.ag_ruc_presidente.value
          nombre = thisform.ag_nombre_presidente.value
          motivo = thisform.ag_motivo_presidente.value
        }
        if (cod == 2)
        {
          ruc = thisform.ag_ruc_arbitro_ent.value
          nombre = thisform.ag_mom_arbitro_ent.value
          motivo = thisform.ag_motivo_arbitro_ent.value
        }
        if (cod==3)
        {
          ruc = thisform.ag_ruc_arbitro_cont.value
          nombre = thisform.ag_nombre_arbitro_cont.value
          motivo = thisform.ag_motivo_arbitro_cont.value
        }
        if (cod==4)
        {
          ruc = thisform.ag_ruc_secretario.value
          nombre = thisform.ag_nombre_secretario.value
          motivo = thisform.ag_motivo_secretario.value
        }
 
 
 
//       ventanaHija =   window.open(''portlet5open.asp?_portletid_=mod_controversia&scriptdo=uspEditArbitro'' +''&motivo=''+ motivo + ''&cod=''+cod,'''',''toolbar=no,Width=700,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised'')
       ventanaHija =   window.open(''ControllerServletOpen?portletid=mod_controversia&scriptdo=uspEditArbitro'' +''&motivo=''+ motivo + ''&cod=''+cod,'''',''toolbar=no,Width=700,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised'')       
 }


 
     function RtnCodSniop(ruc,nombre,motivo,tipo,pub){
             
     if (pub == 1)
     
     {
     div = document.getElementById("div_pub");


     div.style.display = ""; 
     
     }
     
  
     
          
    if (tipo == 1)      
        {
          thisform.ag_ruc_presidente.value=ruc;
          thisform.ag_nombre_presidente.value=nombre;
          thisform.ag_motivo_presidente.value= motivo;
        }
     if (tipo == 2)
        {
          thisform.ag_ruc_arbitro_ent.value=ruc;
          thisform.ag_mom_arbitro_ent.value=nombre;
          thisform.ag_motivo_arbitro_ent.value=motivo;
        }
          if (tipo == 3)
        {
          thisform.ag_ruc_arbitro_cont.value=ruc;
          thisform.ag_nombre_arbitro_cont.value=nombre;
          thisform.ag_motivo_arbitro_cont.value=motivo;
        }
    if (tipo == 4)
        {
          thisform.ag_ruc_secretario.value=ruc;
          thisform.ag_nombre_secretario.value=nombre;
          thisform.ag_motivo_secretario.value=motivo;
        }
        
          ventanaHija.close();
         
    }

function init(cod){
            
            
            if( cod == 1 )
            { 
                thisform.ag_tipo_arbitraje.disabled = false;
                thisform.ag_tipo_arbitro.disabled = false;
                
                  var frm = document.getElementById("thisform");
                  for (i=0;i<frm.elements.length;i++)
                  {
                    if(frm.elements[i].type == "text") {
                        if (frm.elements[i].name != "ag_cod" && frm.elements[i].name != "ag_f_autoriza") {
                        
                            if (thisform.ag_tipo_arbitro.value == thisform.nh_ag_tipo_arbitro.value) {
                                frm.elements[i].readOnly = true;
                                frm.elements[i].className = "form-control";
                            } else {
                                frm.elements[i].value = "";
                            }
                        }
                    }
                  }
            }
           
            crear_hidden(); // creando campos ocultos para text
            addHidden("nh_ag_tipo_arbitraje", thisform.ag_tipo_arbitraje.value); // Para Tipo de Arbitraje

}
 

 
 function Crear()
    {
      thisform.scriptdo.value = "doNewControversia";
      thisform.submit();
    }
    
     function arbitraje()
    {
      if (thisform.ag_mecanismo.value == 316)
      {
        thisform.scriptdo.value = "editArbitraje";
        thisform.submit();
      }
      

    
    }
    
    
    
    
    function  publicar()
    
    {
        if (verificar_cambios()) {
            return;
        }

        if (document.getElementById("ag_ruc_presidente") )
        {
              if (thisform.ag_ruc_presidente.value == null || thisform.ag_ruc_presidente.value == "")
              {
                  alert("Ingrese el número de RUC del Presidente del Tribunal Arbitral");
                   return;
              }
        }

        if (document.getElementById("ag_nombre_presidente") )
        {
              if (thisform.ag_nombre_presidente.value == null || thisform.ag_nombre_presidente.value == "")
              {
                  alert("Ingrese el nombre del Presidente del Tribunal Arbitral");
                   return;
              }
        }
        
        
        
                if (document.getElementById("ag_apePat_presidente") )
        {
              if (thisform.ag_apePat_presidente.value == null || thisform.ag_apePat_presidente.value == "")
              {
                  alert("Ingrese el apellido paterno del Presidente del Tribunal Arbitral");
                  thisform.ag_apePat_presidente.focus ();
                  
                   return;
              }
        }
        
                if (document.getElementById("ag_apeMat_presidente") )
        {
              if (thisform.ag_apeMat_presidente.value == null || thisform.ag_apeMat_presidente.value == "")
              {
                  alert("Ingrese el apellido materno del Presidente del Tribunal Arbitral");
                  thisform.ag_apeMat_presidente.focus();
                   return;
              }
        }
        
        
                if (document.getElementById("ag_nombres_presidente") )
        {
              if (thisform.ag_nombres_presidente.value == null || thisform.ag_nombres_presidente.value == "")
              {
                  alert("Ingrese los nombres del Presidente del Tribunal Arbitral");
                   thisform.ag_nombres_presidente.focus();
                  
                   return;
              }
        }
        
     
              if(document.getElementById("ag_nombre_presidente"))
        
        {
     
        nombreCompleto =  trim(thisform.ag_nombre_presidente.value);
        concatenacion  =  trim(thisform.ag_apePat_presidente.value + thisform.ag_apeMat_presidente.value  + thisform.ag_nombres_presidente.value);    
        nombreCompleto = nombreCompleto.toUpperCase();
        concatenacion = concatenacion.toUpperCase();
  
             if ( nombreCompleto != concatenacion    )
        
              {
              
                    alert("Ingrese correctamente los Apellidos y Nombres del Presidente del Tribunal Arbitral");

                    return;
              
              }
        }
        


                if (document.getElementById("ag_ruc_arbitro_ent") )
        {
              if (thisform.ag_ruc_arbitro_ent.value == null || thisform.ag_ruc_arbitro_ent.value == "")
              {
                  alert("Ingrese el número de RUC del Arbitro designado por la entidad");
                   return;
              }
        }
    
        
        
                        if (document.getElementById("ag_mom_arbitro_ent") )
        {
              if (thisform.ag_mom_arbitro_ent.value == null || thisform.ag_mom_arbitro_ent.value == "")
              {
                  alert("Ingrese el nombre del Arbitro designado por la entidad");
                   return;
              }
        }
        
        
                
                if (document.getElementById("ag_apePat_ent") )
        {
              if (thisform.ag_apePat_ent.value == null || thisform.ag_apePat_ent.value == "")
              {
                  alert("Ingrese el apellido paterno del Arbitro designado por la entidad");
                  thisform.ag_apePat_ent.focus ();
                  
                   return;
              }
        }
        
                if (document.getElementById("ag_apeMat_ent") )
        {
              if (thisform.ag_apeMat_ent.value == null || thisform.ag_apeMat_ent.value == "")
              {
                  alert("Ingrese el apellido materno del Arbitro designado por la entidad");
                  thisform.ag_apeMat_ent.focus();
                   return;
              }
        }
        
        
                if (document.getElementById("ag_nombres_ent") )
        {
              if (thisform.ag_nombres_ent.value == null || thisform.ag_nombres_ent.value == "")
              {
                  alert("Ingrese los nombres del Arbitro designado por la entidad");
                   thisform.ag_nombres_ent.focus();
                  
                   return;
              }
        }
        
        
        
        
         if(document.getElementById("ag_mom_arbitro_ent"))  
        {
        
            nombreCompleto =  trim(thisform.ag_mom_arbitro_ent.value);
            concatenacion  =  trim(thisform.ag_apePat_ent.value + thisform.ag_apeMat_ent.value  + thisform.ag_nombres_ent.value);    
            nombreCompleto = nombreCompleto.toUpperCase();
            concatenacion = concatenacion.toUpperCase();
      
                 if ( nombreCompleto != concatenacion    )
            
                  {
                  
                        alert("Ingrese correctamente los Apellidos y Nombres del Arbitro designado por la Entidad");
    
                        return;
                  
                  }
         
       }
              
        
                                if (document.getElementById("ag_ruc_arbitro_cont") )
        {
              if (thisform.ag_ruc_arbitro_cont.value == null || thisform.ag_ruc_arbitro_cont.value == "")
              {
                  alert("Ingrese el número de RUC del Arbitro designado por el contratista");
                   return;
              }
        }
        
        
                                if (document.getElementById("ag_nombre_arbitro_cont") )
        {
              if (thisform.ag_nombre_arbitro_cont.value == null || thisform.ag_nombre_arbitro_cont.value == "")
              {
                  alert("Ingrese el nombre del Arbitro designado por el Contratista");
                   return;
              }
        }
        
      
        
                      
                if (document.getElementById("ag_apePat_cont") )
        {
              if (thisform.ag_apePat_cont.value == null || thisform.ag_apePat_cont.value == "")
              {
                  alert("Ingrese el apellido paterno del Arbitro designado por el Contratista");
                  thisform.ag_apePat_cont.focus ();
                  
                   return;
              }
        }
        
                if (document.getElementById("ag_apeMat_cont") )
        {
              if (thisform.ag_apeMat_cont.value == null || thisform.ag_apeMat_cont.value == "")
              {
                  alert("Ingrese el apellido materno del Arbitro designado por el Contratista");
                  thisform.ag_apeMat_cont.focus();
                   return;
              }
        }
        
        
                if (document.getElementById("ag_nombres_cont") )
        {
              if (thisform.ag_nombres_cont.value == null || thisform.ag_nombres_cont.value == "")
              {
                  alert("Ingrese los nombres del Arbitro designado por el Contratista");
                   thisform.ag_nombres_cont.focus();
                  
                   return;
              }
        }
        
        
            if(document.getElementById("ag_nombre_arbitro_cont"))  
        
            {
              nombreCompleto =  trim(thisform.ag_nombre_arbitro_cont.value);
              concatenacion  =  trim(thisform.ag_apePat_cont.value + thisform.ag_apeMat_cont.value  + thisform.ag_nombres_cont.value);    
              nombreCompleto = nombreCompleto.toUpperCase();
              concatenacion = concatenacion.toUpperCase();
              
                   if ( nombreCompleto != concatenacion    )
              
                    {
                    
                          alert("Ingrese correctamente los Apellidos y Nombres del Arbitro designado por el Contratista");
      
                          return;
                    
                    }
                  
        
            } 
        
        <!--Inicio mlaura Req 55 -->
        
            if (document.getElementById("ag_ruc_secretario") )
        {
              if (thisform.ag_ruc_secretario.value == null || thisform.ag_ruc_secretario.value == "")
              {
                  alert("Ingrese el número de RUC del Secretario Arbitral");
                   return;
              }
        }

        if (document.getElementById("ag_nombre_secretario") )
        {
              if (thisform.ag_nombre_secretario.value == null || thisform.ag_nombre_secretario.value == "")
              {
                  alert("Ingrese el nombre del Secretario Arbitral");
                   return;
              }
        }
        
        
        
                if (document.getElementById("ag_apepat_secretario") )
        {
              if (thisform.ag_apepat_secretario.value == null || thisform.ag_apepat_secretario.value == "")
              {
                  alert("Ingrese el apellido paterno del Secretario Arbitral");
                  thisform.ag_apepat_secretario.focus ();
                  
                   return;
              }
        }
        
                if (document.getElementById("ag_apemat_secretario") )
        {
              if (thisform.ag_apemat_secretario.value == null || thisform.ag_apemat_secretario.value == "")
              {
                  alert("Ingrese el apellido materno del Secretario Arbitral");
                  thisform.ag_apemat_secretario.focus();
                   return;
              }
        }
        
        
                if (document.getElementById("ag_nombres_secretario") )
        {
              if (thisform.ag_nombres_secretario.value == null || thisform.ag_nombres_secretario.value == "")
              {
                  alert("Ingrese los nombres del Secretario Arbitral");
                   thisform.ag_nombres_secretario.focus();
                  
                   return;
              }
        }
        
     
              if(document.getElementById("ag_nombre_secretario"))
        
        {
     
        nombreCompleto =  trim(thisform.ag_nombre_secretario.value);
        concatenacion  =  trim(thisform.ag_apepat_secretario.value + thisform.ag_apemat_secretario.value  + thisform.ag_nombres_secretario.value);    
        nombreCompleto = nombreCompleto.toUpperCase();
        concatenacion = concatenacion.toUpperCase();
  
             if ( nombreCompleto != concatenacion    )
        
              {
              
                    alert("Ingrese correctamente los Apellidos y Nombres del Secretario Arbitral");

                    return;
              
              }
        }
        
          thisform.scriptdo.value = "arbitrajeEdit";
 
                  if ( confirm("¿Esta Ud. seguro de publicar los cambios realizados?") )
        {
             thisform.submit();
        }
    
    }

   
    
    
 ');   
 
 

----------- CABECERA --------------------
 USP_PRINT('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>'
          || PKU_SS_UTILES.f_get_titulo_contrato(session__cod_contrato,'Controversias')
          || '<td align="right" valign=top width="50%">
                 <div  id = "div_pub"   >  
                 <input type=button value="Publicar" onclick="publicar();"> 
                  </div></td>
              <td align="right" valign=top width="50%">
          <input type=button value="Volver" onclick="thisform.scriptdo.value=''doView'';thisform.submit();"></td></tr>
          </table>');
 USP_PRINT('</TD></TR>');
 USP_PRINT('</TABLE><br>');



 usp_print('
  <table class="table table-striped">');    
 
 usp_print(' <td align = "center" colspan = 3><h3>Ficha Electr&oacute;nica</h3></td>');

  usp_print(' <td align = "center" colspan = 3><br></td>');
  
  usp_print(' <tr><td align = "center" colspan = 3><h3>'||ln_campotitulo||'<br></h3></td></tr>');
      
      
         usp_print('
    <tr>
      <td class=c1>(*)Tipo de mecanismo de soluci&oacute;n de Controversia</td>
    <td class=c2>'||lv_combo_mecanismo||'</td>
    <td class=c3>Muestra el tipo de  soluci&oacute;n de Controversia.</td>
    '
    );  
    
        usp_print('
    <tr>
        
        <td class=c1>(*)Nro. de Registro de Proceso Arbitral </td>
        <td class=c2><input type="text" name="ag_cod" value="'|| ag_cod  ||'" size=54 readonly ></td>
        <td class=c3>Muestra el n&uacute;mero de Registro de Proceso Arbitral</td>
    </tr>
  '); 
  
    usp_print('
    <tr>
        <td class=c1>(*)Fecha en la que se llev&oacute; acabo la Audiencia de Instalaci&oacute;n</td>
        <td class=c2><input  type="text" name="ag_f_autoriza"  value="'|| to_char( ln_fecha, 'dd/mm/yyyy')  ||'" size=30 readonly></td>
        <td class=c3>Muestra la fecha en que se llev&oacute; a cabo la instalaci&oacute;n</td>
    </tr>
  '); 
  

    usp_print('
    <tr>
      <td class=c1>(*)Tipo de Arbitraje</td>
      <td class=c2>'||lv_combo_arbitraje||'</td>
      <td class=c3>Muestra el tipo de Arbitraje.</td>
    </tr>'); 
      
      
         usp_print('
    <tr>
      <td class=c1>(*)Tipo de &Aacute;rbitro</td>
    <td class=c2>'||lv_combo_arbitro||'</td>
    <td class=c3>Muestra el tipo de &Aacute;rbitro</td>
    </tr>');   

  if   (ag_tipo_seleccion = 1 or ag_tipo_seleccion = 2)   then
       if   ln_tipoarbitro = 221  then
        
        usp_print ('<tr><td colspan = 3 align = center ><h3>Identificaci&oacute;n de los miembros del Tribunal Arbitral</h3></td></tr>');
          usp_print('
          <tr><td><h4>Presidente del Tribunal Arbitral</h4></td><td colspan = 2 ><input type=button name="idTipoArbitro" value="..." onclick="modArbitro(1);" /></td></tr>
        <tr>
            
            <td class=c1>RUC Nro.</td>
            <td class=c2><input type="text" class="form-control" id="ag_ruc_presidente" name="ag_ruc_presidente" value="'|| ln_RUC_PRESIDENTE ||'" size=54 readonly class="InpReadOnly" /><input type="hidden" name="ag_sunat_presidente" value="'|| sunat ||'" size=54 readonly></td>
            <td class=c3>Ingrese el número de RUC del Presidente del Tribunal Arbitral</td>
        </tr>
      '); 
      
      
            usp_print('
        <tr>
            <td class=c1>(*)Apellidos y Nombres</td>
            <td class=c2><input  type="text" class="form-control"  id="ag_nombre_presidente" name="ag_nombre_presidente" value="'|| ln_NOMBRE_PRESIDENTE ||'" size=54 readonly class="InpReadOnly" /></td>
            <td class=c3>Muestra los Apellidos y Nombres del Presidente del Tribunal Arbitral</td>
           
        </tr>
        
                <tr>
            <td class=c1>(*)Apellido Paterno</td>
            <td class=c2><input  type="text" id="ag_apePat_presidente" name="ag_apePat_presidente" value="'|| ln_apePat_presidente ||'" size=54 onkeypress= "return alpha(event)" ></td>
           <td class=c3>Muestra el apellido paterno del Presidente del Tribunal Arbitral</td>
           
        </tr>
        
        
                <tr>
            <td class=c1>(*)Apellido Materno</td>
            <td class=c2><input  type="text" id="ag_apeMat_presidente" name="ag_apeMat_presidente" value="'|| ln_apeMat_presidente  ||'" size=54 
    onkeypress= "return alpha(event)" ></td>
            <td class=c3>Muestra el   apellido materno del Presidente del Tribunal Arbitral</td>
           
        </tr>
        
        
        
        <tr>
            <td class=c1>(*)Nombres</td>
            <td class=c2><input  type="text" id="ag_nombres_presidente" name="ag_nombres_presidente" value="' || ln_nombres_presidente ||'" size=54 
    onkeypress= "return alpha(event)"></td>
            <td class=c3>Muestra los nombres  del Presidente del Tribunal Arbitral</td>
           
        </tr>
       <input  type="hidden" name="ag_motivo_presidente" value="'|| ln_MOTIVO_PRESIDENTE ||'" size=54>
      '); 
      
      
            usp_print('
            <tr> <td><h4>Arbitro designado por la Entidad</h4></td><td td colspan = 2 ><input type=button value="..." onclick="modArbitro(2);"></td></tr>
        <tr>
           
            <td class=c1>RUC Nro.</td>
            <td class=c2><input  type="text" class="form-control"  id="ag_ruc_arbitro_ent" name="ag_ruc_arbitro_ent" value="'|| ln_RUC_ARBITRO_ENTIDAD  ||'" size=54 readonly class="InpReadOnly" /><input type="hidden" name="ag_sunat_arbitro_ent" value="'|| sunat ||'" size=54 readonly></td>
           <td class=c3>Ingrese el número de RUC del Arbitro designado por la entidad</td>
           
        </tr>
      '); 
      
      
            usp_print('
        <tr>
            <td class=c1>(*)Apellidos y Nombres</td>
            <td class=c2><input  type="text"  class="form-control"  id="ag_mom_arbitro_ent" name="ag_mom_arbitro_ent" value="'|| ln_NOMBRE_ARBITRO_ENTIDAD  ||'" size=54 readonly class="InpReadOnly" /></td>
           <td class=c3>Muestra los Apellidos y Nombres del Arbitro designado por la entidad</td>
            
        </tr>
        
                <tr>
            <td class=c1>(*)Apellido Paterno</td>
            <td class=c2><input  type="text" id="ag_apePat_ent" name="ag_apePat_ent" value="'|| ln_apePat_ent  ||'" size=54 
    onkeypress= "return alpha(event)" ></td>
       <td class=c3>Muestra el apellido paterno del Presidente del Tribunal Arbitral</td>
           
        </tr>
        
        
                <tr>
            <td class=c1>(*)Apellido Materno</td>
            <td class=c2><input  type="text" id="ag_apeMat_ent" name="ag_apeMat_ent" value="' || ln_apeMat_ent  ||'" size=54 
    onkeypress= "return alpha(event)"></td>
       <td class=c3>Muestra el   apellido materno del Presidente del Tribunal Arbitral</td>
           
        </tr>
        
        
            <tr>
            <td class=c1>(*)Nombres</td>
            <td class=c2><input  type="text" id="ag_nombres_ent" name="ag_nombres_ent" value="'|| ln_nombres_ent ||'" size=54 
    onkeypress= "return alpha(event)"></td>
         <td class=c3>Muestra los nombres  del Presidente del Tribunal Arbitral</td>
           
        </tr>
           <input  type="hidden" name="ag_motivo_arbitro_ent" value="'||ln_MOTIVO_ARBITRO_ENTIDAD||'" size=54>
      '); 
      
              usp_print('
              <tr> <td><h4>Arbitro designado por el Contratista</h4></td><td td colspan = 2 ><input type=button value="..." onclick="modArbitro(3);"></td>  </tr>
        <tr>
           
            <td class=c1>RUC Nro.</td>
            <td class=c2><input  type="text" class="form-control"  id="ag_ruc_arbitro_cont" name="ag_ruc_arbitro_cont" value="'|| ln_RUC_ARBITRO_CONTRATISTA  ||'" size=54 readonly class="InpReadOnly" /><input  type="hidden" name="ag_sunat_arbitro_cont" value="'|| sunat  ||'" size=54 readonly></td>
           <td class=c3>Ingrese el número de RUC del Arbitro designado por el contratista</td>
        </tr>
      '); 
      
      
            usp_print('
        <tr>
            <td class=c1>(*)Apellidos y Nombres</td>
            <td class=c2><input type="text" class="form-control"  id="ag_nombre_arbitro_cont" name="ag_nombre_arbitro_cont" value="'|| ln_NOMBRE_ARBITRO_CONTRATISTA  ||'" size=54 readonly class="InpReadOnly" /></td>
            <td class=c3>Muestra los Apellidos y Nombres del Arbitro designado por el contratista</td>
        </tr>
        
    
        
            <tr>
            <td class=c1>(*)Apellido Paterno</td>
            <td class=c2><input  type="text" id="ag_apePat_cont" name="ag_apePat_cont" value=" '  ||  ln_apePat_cont  ||' " size=54 
    onkeypress= "return alpha(event)"></td>
          <td class=c3>Muestra el apellido paterno del Presidente del Tribunal Arbitral</td> 
           
        </tr>
    
            <tr>
            <td class=c1>(*)Apellido Materno</td>
            <td class=c2><input  type="text" id="ag_apeMat_cont" name="ag_apeMat_cont" value="' || ln_apeMat_cont    || '" size=54 
    onkeypress= "return alpha(event)"></td>
          <td class=c3>Muestra el   apellido materno del Presidente del Tribunal Arbitral</td>    
           
        </tr>                   
        
        
               <tr>
            <td class=c1>(*)Nombres</td>
            <td class=c2><input  type="text" id="ag_nombres_cont" name="ag_nombres_cont" value="' || ln_nombres_cont ||'" size=54 
    onkeypress= "return alpha(event)"></td>
          <td class=c3>Muestra los nombres  del Presidente del Tribunal Arbitral</td>
           
        </tr>
        
        <input  type="hidden" name="ag_motivo_arbitro_cont" value="'|| ln_MOTIVO_ARBITRO_CONTRATISTA ||'" size=54>
      ');
      
     end if;
      
      if  ln_tipoarbitro = 220 then
            usp_print('
          <tr><td colspan = 1 align = left ><h3>Identificaci&oacute;n del &Aacute;rbitro &Uacute;nico</h3></td><td><input type=button name="idTipoArbitro" value="..." onclick="modArbitro(1);" ></td></tr>
        <tr>
            
            <td class=c1 id="t_ruc_presidente">RUC Nro.</td>
            <td class=c2><input  type="text" class="form-control" id="ag_ruc_presidente" name="ag_ruc_presidente" value="'|| ln_RUC_PRESIDENTE ||'" size=54 readonly class="InpReadOnly" /><input  type="hidden" class="form-control" name="ag_sunat_presidente" value="'|| sunat ||'" size=54 readonly class="InpReadOnly"></td>
            <td class=c3 name="d_ruc_presidente">Ingrese el n&uacute;mero de RUC del &Aacute;rbitro &Uacute;nico</td>
        </tr>
      '); 
      
      
            usp_print('
        <tr>
            <td class=c1 name="t_nombre_presidente">(*)Apellidos y Nombres</td>
            <td class=c2><input  type="text" class="form-control" id="ag_nombre_presidente" name="ag_nombre_presidente" value="'|| ln_NOMBRE_PRESIDENTE||'" size=54 readonly class="InpReadOnly" /></td>
            <td class=c3 name="d_nombre_presidente">Muestra los Apellidos y Nombres del &Aacute;rbitro &Uacute;nico</td>
           
        </tr>
        
            
            <tr>
            <td class=c1 name="t_apepat_presidente">(*)Apellido Paterno</td>
            <td class=c2><input type="text" id="ag_apePat_presidente" name="ag_apePat_presidente" value="' || ln_apePat_presidente  ||'" size=54 
    onkeypress= "return alpha(event)" /></td>
            <td class=c3 name="d_apepat_presidente">Muestra el apellido paterno del &Aacute;rbitro &Uacute;nico</td>
           
           
        </tr>
    
            <tr>
            <td class=c1>(*)Apellido Maternow</td>
            <td class=c2><input  type="text" id="ag_apeMat_presidente" name="ag_apeMat_presidente" value="'|| ln_apeMat_presidente  || '" size=54 
    onkeypress= "return alpha(event)" /></td>
            <td class=c3>Muestra el   apellido materno del &Aacute;rbitro &Uacute;nico</td>
        </tr>
    
        <tr>
            <td class=c1>(*)Nombres</td>
            <td class=c2><input  type="text" id="ag_nombres_presidente" name="ag_nombres_presidente" value="'|| ln_nombres_presidente ||'" size=54 onkeypress= "return alpha(event)"/></td>
            <td class=c3>Muestra los nombres  del &Aacute;rbitro &Uacute;nico</td>
           
        </tr>
        
     <tr> <td><br><input  type="hidden" name="ag_motivo_presidente" value="'|| ln_MOTIVO_PRESIDENTE ||'" size=54></td></tr>
      ');
      
         end if; 
    end if;
    -- inicio punto 3 vpt
  if  ag_tipo_seleccion = 3 then 
  usp_print('
        <tr> <td colspan = 1 align = left ><h3>Identificacion del Secretario Arbitral</h3></td>
        <td> <input type =button name ="idTipoSecretario" value="..." onclick="modArbitro(4);"></td></tr>
        <tr>
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" class="form-control" id="ag_ruc_secretario" name="ag_ruc_secretario" value="'|| ln_RUC_SECRETARIO  ||'" size=54 readonly class=InpReadOnly" ><input type="hidden" name="ag_sunat_secretario" value="'|| sunat ||'" size=54 readonly></td>
        <td class=c3>Ingrese el número de RUC del Secretario Arbitral</td>
       
        </tr>
        '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" class="form-control" id="ag_nombre_secretario" name="ag_nombre_secretario" value="'|| ln_NOMBRE_SECRETARIO  ||'" size=54 readonly class="InpReadOnly" /></td>
        <td class=c3>Muestra los Apellidos y Nombres del Secretario Arbitral</td>
        
    </tr>
    
        <tr>
        <td class=c1>(*)Apellido Paterno</td>
        <td class=c2><input  type="text" id="ag_apepat_secretario" name="ag_apepat_secretario" value="'|| ln_APEPAT_SECRETARIO  ||'" size=54 
        onkeypress= "return alpha(event)" ></td>
        <td class=c3>Muestra el apellido paterno del Secretario Arbitral</td>
       
    </tr>
    
    
        <tr>
        <td class=c1>(*)Apellido Materno</td>
        <td class=c2><input  type="text" id="ag_apemat_secretario" name="ag_apemat_secretario" value="' || ln_APEMAT_SECRETARIO  ||'" size=54 
        onkeypress= "return alpha(event)"></td>
        <td class=c3>Muestra el   apellido materno del Secretario Arbitral</td>
       
    </tr>
    
    
        <tr>
        <td class=c1>(*)Nombres</td>
        <td class=c2><input  type="text" id="ag_nombres_secretario" name="ag_nombres_secretario" value="'|| ln_NOMBRES_SECRETARIO ||'" size=54 
        onkeypress= "return alpha(event)"></td>
        <td class=c3>Muestra los nombres  del SeCretario Arbitral</td>
       
    </tr>
    
    <input  type="hidden" name="ag_motivo_secretario" value="'||ln_MOTIVO_SECRETARIO||'" size=54>
  '); 
  --final punto 3 vpt
 
  
  end if;
 
 usp_print('<input type = "hidden" value = "'|| ag_cod ||'" name = "ag_cod" >
            <input type = "hidden" value = "'|| ln_NUMERO_REGISTRO ||'" name = "ag_num_reg" > 
            <input type = "hidden" value = "'|| ag_tipo_seleccion ||'" name = "ag_tipo_seleccion" >
            <input type = "hidden" value = "'|| LN_TIPOARBITRO_EVAL ||'" name = "nh_ag_tipo_arbitro" >
  
  </table><br>');

   usp_print('

        </table>
        <br/>
        <br/>
        ');
        
 END;
 
 
 
 PROCEDURE uspCreaArbitraje (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 ,
  ag_tipo_arbitraje                  VARCHAR2 ,
  ag_tipo_arbitro                    VARCHAR2 ,
  sunat                                VARCHAR2,
  ag_f_autoriza                          VARCHAR2 
  )   
    
 IS
 lv_codtipofile                VARCHAR2(100); 
 lvtipodocumento               VARCHAR2(100); 
 cod_tipo_file                 VARCHAR2(100); 
 lv_combo_arbitraje           varchar2(4000);  
 lv_combo_arbitro             varchar2(4000);
  lv_combo_demandante           varchar2(4000);  
 lv_combo_mecanismo            varchar2(4000); 
 montoTotal                    number;
 ln_num_contrato               varchar2(4000);  
 ctipoArbitraje               ref_cursor;
   ctipoarbitro                 ref_cursor;  
    ctipodemandante               ref_cursor;
 ctipomecanismo                ref_cursor;  
 
   ------- Cursores -------
   ------- Listado de Prorrogas ------  
 BEGIN
 PKU_SS_CONTROVERSIAS.dojscript  ; 
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;
  
  select  n_contrato into ln_num_contrato  from reg_procesos.contrato where N_COD_CONTRATO = session__cod_contrato  ; 


  
    open ctipoarbitraje for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 6;

    open ctipoarbitro for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 23;
  
    
    open ctipodemandante for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 12;
     
     
    open ctipomecanismo for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 30;
     
       
    lv_combo_demandante  := PKU_SS_UTILES.f_retorna_combo(ctipodemandante, 'ag_tipo_demandante', ag_tipo_demandante,'Seleccione...','style="width:260px"');
     
    lv_combo_mecanismo   :=     PKU_SS_UTILES.f_retorna_combo(ctipomecanismo, 'ag_mecanismo', ag_mecanismo,'Seleccione...','style="width:260px" onchange="arbitraje();"'); 
    
    lv_combo_arbitraje  := PKU_SS_UTILES.f_retorna_combo(ctipoArbitraje, 'ag_tipo_arbitraje', ag_tipo_arbitraje,'Seleccione...','style="width:260px"');
     
    lv_combo_arbitro    :=     PKU_SS_UTILES.f_retorna_combo(ctipoarbitro, 'ag_tipo_arbitro', ag_tipo_arbitro,'Seleccione...','style="width:260px" onchange="arbitraje();"'); 
    
          
 PKU_SS_FUNCIONES_JS.js_script('
 
 
 
  function modArbitro(cod)
 {
        if (cod == 1)
        { 
          ruc = thisform.ag_ruc_presidente.value
          nombre = thisform.ag_nombre_presidente.value
        //  motivo = thisform.ag_motivo_presidente.value
        }
        if (cod == 2)
        {
          ruc = thisform.ag_ruc_arbitro_ent.value
          nombre = thisform.ag_mom_arbitro_ent.value
        //  motivo = thisform.ag_motivo_arbitro_ent.value
        }
        if (cod==3)
        {
          ruc = thisform.ag_ruc_arbitro_cont.value
          nombre = thisform.ag_nombre_arbitro_cont.value
       //   motivo = thisform.ag_motivo_arbitro_cont.value
        }
        if (cod == 4)
        {
          ruc = thisform.ag_ruc_secretario.value
          nombre = thisform.ag_nombre_secretario.value
        //  motivo = thisform.ag_motivo_secretario.value
        }
 
 
 
   //    ventanaHija =   window.open(''portlet5open.asp?_portletid_=mod_controversia&scriptdo=NuevoArbitro''+''&ruc=''+ ruc +''&nombre=''+ nombre  + ''&cod=''+cod,'''',''toolbar=no,Width=700,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised'')
       ventanaHija =   window.open(''ControllerServletOpen?portletid=mod_controversia&scriptdo=NuevoArbitro''+''&ruc=''+ ruc +''&nombre=''+ nombre  + ''&cod=''+cod,'''',''toolbar=no,Width=700,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised'')
 }
 
 
  function RtnArbitro(nombre,ruc,tipo,pub,sunat)
 {

 
     if (tipo == 1)      
        {
          thisform.ag_ruc_presidente.value=ruc;
          thisform.ag_nombre_presidente.value=nombre;
          thisform.ag_sunat_presidente.value=sunat ;
         
  
        }
     if (tipo == 2)
        {
          thisform.ag_ruc_arbitro_ent.value=ruc;
          thisform.ag_mom_arbitro_ent.value=nombre;
          thisform.ag_sunat_arbitro_ent.value=sunat ;
         
        }
     if (tipo == 3)
        {
          thisform.ag_ruc_arbitro_cont.value=ruc;
          thisform.ag_nombre_arbitro_cont.value=nombre;
          thisform.ag_sunat_arbitro_cont.value=sunat ;
           
        } 
      if (tipo == 4)
        {
          thisform.ag_ruc_secretario.value=ruc;
          thisform.ag_nombre_secretario.value=nombre;
          thisform.ag_sunat_secretario.value=sunat ;
           
        }
        
   
        
 }
 
 
 function Crear()
    {
      thisform.scriptdo.value = "doNewControversia";
      thisform.submit();
    }
    
     function arbitraje()
    {
         if (thisform.ag_mecanismo.value == 316)
      {
        thisform.scriptdo.value = "creaArbitraje";
        thisform.submit();
      }
      
    if (thisform.ag_mecanismo.value == 315)  
      {
        thisform.scriptdo.value = "creaConciliacion";
        thisform.submit();
      }
    
    }
    
    
    
    
    function  publicar()
    
    {

        if (thisform.ag_tipo_demandante.value == ""  )
        {
              alert("Ingrese el tipo de demandante");
              return;
        }

            if (thisform.ag_mecanismo.value == ""  )
        {
              alert("Ingrese el mecanismo de solución de Controversia");
              return;
        }
        
        
                    if (thisform.ag_f_autoriza.value == ""  )
        {
              alert("Ingrese la fecha del documento que autoriza la entidad");
              return;
        }
        if (thisform.ag_tipo_arbitraje.value == "" )
        {
              alert("Ingrese el Tipo de Arbitraje");
               return;
        }
        
        
                if (thisform.ag_tipo_arbitro.value == "" )
        {
              alert("Ingrese el Tipo de Árbitro");
               return;
        }
        
        if (document.getElementById("ag_ruc_presidente") )
        {
              if (thisform.ag_ruc_presidente.value == null || thisform.ag_ruc_presidente.value == "")
              {
                  alert("Ingrese el número de RUC del Presidente del Tribunal Arbitral");
                   return;
              }
        }

        if (document.getElementById("ag_nombre_presidente") )
        {
              if (thisform.ag_nombre_presidente.value == null || thisform.ag_nombre_presidente.value == "")
              {
                  alert("Ingrese el nombre del Presidente del Tribunal Arbitral");
                   return;
              }
        }
        
        
        
                if (document.getElementById("ag_apePat_presidente") )
        {
              if (thisform.ag_apePat_presidente.value == null || thisform.ag_apePat_presidente.value == "")
              {
                  alert("Ingrese el apellido paterno del Presidente del Tribunal Arbitral");
                  thisform.ag_apePat_presidente.focus ();
                  
                   return;
              }
        }
        
                if (document.getElementById("ag_apeMat_presidente") )
        {
              if (thisform.ag_apeMat_presidente.value == null || thisform.ag_apeMat_presidente.value == "")
              {
                  alert("Ingrese el apellido materno del Presidente del Tribunal Arbitral");
                  thisform.ag_apeMat_presidente.focus();
                   return;
              }
        }
        
        
                if (document.getElementById("ag_nombres_presidente") )
        {
              if (thisform.ag_nombres_presidente.value == null || thisform.ag_nombres_presidente.value == "")
              {
                  alert("Ingrese los nombres del Presidente del Tribunal Arbitral");
                   thisform.ag_nombres_presidente.focus();
                  
                   return;
              }
        }
        
     
              if(document.getElementById("ag_nombre_presidente"))
        
        {
     
        nombreCompleto =  trim(thisform.ag_nombre_presidente.value);
        concatenacion  =  trim(thisform.ag_apePat_presidente.value + thisform.ag_apeMat_presidente.value  + thisform.ag_nombres_presidente.value);    
        nombreCompleto = nombreCompleto.toUpperCase();
        concatenacion = concatenacion.toUpperCase();
  
             if ( nombreCompleto != concatenacion    )
        
              {
              
                    alert("Ingrese correctamente los Apellidos y Nombres del Presidente del Tribunal Arbitral");

                    return;
              
              }
        }
        


                if (document.getElementById("ag_ruc_arbitro_ent") )
        {
              if (thisform.ag_ruc_arbitro_ent.value == null || thisform.ag_ruc_arbitro_ent.value == "")
              {
                  alert("Ingrese el número de RUC del Arbitro designado por la entidad");
                   return;
              }
        }
    
        
        
                        if (document.getElementById("ag_mom_arbitro_ent") )
        {
              if (thisform.ag_mom_arbitro_ent.value == null || thisform.ag_mom_arbitro_ent.value == "")
              {
                  alert("Ingrese el nombre del Arbitro designado por la entidad");
                   return;
              }
        }
        
        
                
                if (document.getElementById("ag_apePat_ent") )
        {
              if (thisform.ag_apePat_ent.value == null || thisform.ag_apePat_ent.value == "")
              {
                  alert("Ingrese el apellido paterno del Arbitro designado por la entidad");
                  thisform.ag_apePat_ent.focus ();
                  
                   return;
              }
        }
        
                if (document.getElementById("ag_apeMat_ent") )
        {
              if (thisform.ag_apeMat_ent.value == null || thisform.ag_apeMat_ent.value == "")
              {
                  alert("Ingrese el apellido materno del Arbitro designado por la entidad");
                  thisform.ag_apeMat_ent.focus();
                   return;
              }
        }
        
        
                if (document.getElementById("ag_nombres_ent") )
        {
              if (thisform.ag_nombres_ent.value == null || thisform.ag_nombres_ent.value == "")
              {
                  alert("Ingrese los nombres del Arbitro designado por la entidad");
                   thisform.ag_nombres_ent.focus();
                  
                   return;
              }
        }
        
        
        
        
         if(document.getElementById("ag_mom_arbitro_ent"))  
        {
        
            nombreCompleto =  trim(thisform.ag_mom_arbitro_ent.value);
            concatenacion  =  trim(thisform.ag_apePat_ent.value + thisform.ag_apeMat_ent.value  + thisform.ag_nombres_ent.value);    
            nombreCompleto = nombreCompleto.toUpperCase();
            concatenacion = concatenacion.toUpperCase();
      
                 if ( nombreCompleto != concatenacion    )
            
                  {
                  
                        alert("Ingrese correctamente los Apellidos y Nombres del Arbitro designado por la Entidad");
    
                        return;
                  
                  }
         
       }
              
        
                                if (document.getElementById("ag_ruc_arbitro_cont") )
        {
              if (thisform.ag_ruc_arbitro_cont.value == null || thisform.ag_ruc_arbitro_cont.value == "")
              {
                  alert("Ingrese el número de RUC del Arbitro designado por el contratista");
                   return;
              }
        }
        
        
                                if (document.getElementById("ag_nombre_arbitro_cont") )
        {
              if (thisform.ag_nombre_arbitro_cont.value == null || thisform.ag_nombre_arbitro_cont.value == "")
              {
                  alert("Ingrese el nombre del Arbitro designado por el Contratista");
                   return;
              }
        }
        
      
        
                      
                if (document.getElementById("ag_apePat_cont") )
        {
              if (thisform.ag_apePat_cont.value == null || thisform.ag_apePat_cont.value == "")
              {
                  alert("Ingrese el apellido paterno del Arbitro designado por el Contratista");
                  thisform.ag_apePat_cont.focus ();
                  
                   return;
              }
        }
        
                if (document.getElementById("ag_apeMat_cont") )
        {
              if (thisform.ag_apeMat_cont.value == null || thisform.ag_apeMat_cont.value == "")
              {
                  alert("Ingrese el apellido materno del Arbitro designado por el Contratista");
                  thisform.ag_apeMat_cont.focus();
                   return;
              }
        }
        
        
                if (document.getElementById("ag_nombres_cont") )
        {
              if (thisform.ag_nombres_cont.value == null || thisform.ag_nombres_cont.value == "")
              {
                  alert("Ingrese los nombres del Arbitro designado por el Contratista");
                   thisform.ag_nombres_cont.focus();
                  
                   return;
              }
        }
        
        
            if(document.getElementById("ag_nombre_arbitro_cont"))  
        
            {
              nombreCompleto =  trim(thisform.ag_nombre_arbitro_cont.value);
              concatenacion  =  trim(thisform.ag_apePat_cont.value + thisform.ag_apeMat_cont.value  + thisform.ag_nombres_cont.value);    
              nombreCompleto = nombreCompleto.toUpperCase();
              concatenacion = concatenacion.toUpperCase();
              
                   if ( nombreCompleto != concatenacion    )
              
                    {
                    
                          alert("Ingrese correctamente los Apellidos y Nombres del Arbitro designado por el Contratista");
      
                          return;
                    
                    }
                  
        
            } 
        
        <!--Inicio mlaura Req 55 -->
        
            if (document.getElementById("ag_ruc_secretario") )
        {
              if (thisform.ag_ruc_secretario.value == null || thisform.ag_ruc_secretario.value == "")
              {
                  alert("Ingrese el número de RUC del Secretario Arbitral");
                   return;
              }
        }

        if (document.getElementById("ag_nombre_secretario") )
        {
              if (thisform.ag_nombre_secretario.value == null || thisform.ag_nombre_secretario.value == "")
              {
                  alert("Ingrese el nombre del Secretario Arbitral");
                   return;
              }
        }
        
        
        
                if (document.getElementById("ag_apepat_secretario") )
        {
              if (thisform.ag_apepat_secretario.value == null || thisform.ag_apepat_secretario.value == "")
              {
                  alert("Ingrese el apellido paterno del Secretario Arbitral");
                  thisform.ag_apepat_secretario.focus ();
                  
                   return;
              }
        }
        
                if (document.getElementById("ag_apemat_secretario") )
        {
              if (thisform.ag_apemat_secretario.value == null || thisform.ag_apemat_secretario.value == "")
              {
                  alert("Ingrese el apellido materno del Secretario Arbitral");
                  thisform.ag_apemat_secretario.focus();
                   return;
              }
        }
        
        
                if (document.getElementById("ag_nombres_secretario") )
        {
              if (thisform.ag_nombres_secretario.value == null || thisform.ag_nombres_secretario.value == "")
              {
                  alert("Ingrese los nombres del Secretario Arbitral");
                   thisform.ag_nombres_secretario.focus();
                  
                   return;
              }
        }
        
     
        if(document.getElementById("ag_nombre_secretario"))
        
        {
     
        nombreCompleto =  trim(thisform.ag_nombre_secretario.value);
        concatenacion  =  trim(thisform.ag_apepat_secretario.value + thisform.ag_apemat_secretario.value  + thisform.ag_nombres_secretario.value);    
        nombreCompleto = nombreCompleto.toUpperCase();
        concatenacion = concatenacion.toUpperCase();
  
             if ( nombreCompleto != concatenacion    )
        
              {
              
                    alert("Ingrese correctamente los Apellidos y Nombres del Secretario Arbitral");

                    return;
              
              }
        }
        
          thisform.scriptdo.value = "arbitrajeInsert";
           
              if ( confirm("¿Esta Ud. seguro de publicar los cambios realizados?") )
        {
             thisform.submit();
        }
    
    }

   
    
    
 ');   
 
 
 usp_print(session__cod_contrato);
----------- CABECERA --------------------
 USP_PRINT('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>'
          || PKU_SS_UTILES.f_get_titulo_contrato(session__cod_contrato,'Controversias')
          || '<td align="right" valign=top width="50%">
                 <input type=button value="Publicar" onclick="publicar();"> <input type=button value="Volver" onclick="thisform.scriptdo.value=''doView'';thisform.submit();"></td></tr>
         </table>');
 USP_PRINT('</TD></TR>');
 USP_PRINT('</TABLE><br>');



 usp_print('
  <table class="table table-striped">');    
 
 usp_print(' <td align = "center" colspan = 3><h3>Ficha Electr&oacute;nica</h3>  </td>');
  usp_print(' <td align = "center" colspan = 3><br></td>');
  
  
  

      
      
         usp_print('
    <tr>
      <td class=c1>(*)Tipo de mecanismo de soluci&oacute;n de Controversias</td>
    <td class=c2>'||lv_combo_mecanismo||'</td>
    <td class=c3>Seleccione el tipo de mecanismo de soluci&oacute;n de Controversia.</td>'
    
    );  
    
        usp_print('
    <tr>
      <td class=c1>(*)Demandante</td>
    <td class=c2>'||lv_combo_demandante||'</td>
    <td class=c3>Seleccione al demandante.</td>
    </tr>'); 
  
    usp_print('
    <tr>
        <td class=c1>(*)Fecha de Audiencia de Instalaci&oacute;n</td>
        <td class=c2>
        <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_f_autoriza" style="width:98%" value="'|| ag_f_autoriza ||'" data-format="dd/MM/yyyy" class="form-control"/>
          </div>
        </td>
        <td class=c3>Seleccione la fecha en la que se llev&oacute; acabo la audiencia de instalaci&oacute;n.</td>
    </tr>
  '); 
  

    usp_print('
    <tr>
      <td class=c1>(*)Tipo de Arbitraje</td>
    <td class=c2>'||lv_combo_arbitraje||'</td>
    <td class=c3>Seleccione el tipo de Arbitraje.</td>
    </tr>'); 
      
      
         usp_print('
    <tr>
      <td class=c1>(*)Tipo de &Aacute;rbitro</td>
    <td class=c2>'||lv_combo_arbitro||'</td>
    <td class=c3>Seleccione el tipo de &Aacute;rbitro.</td>
    </tr>');   
    
    
    
   if  ag_tipo_arbitro = 221 then
         usp_print('<tr><td colspan = 3 > <br><h3>Identificaci&oacute;n de los miembros del Tribunal Arbitral </h3></td></tr>');
    
      usp_print('
      
      <tr><td><h4>Presidente del Tribunal Arbitral</h4></td><td><input type=button value="..." onclick="modArbitro(1);"> </td></tr>
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input type="text" id="ag_ruc_presidente" name="ag_ruc_presidente" value="" size=54 readonly><input  type="hidden" name="ag_sunat_presidente" value="" size=54 readonly></td>
        <td class=c3>Ingrese el n&uacute;mero de RUC del Presidente del Tribunal Arbitral</td>
    </tr>
  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" id="ag_nombre_presidente" name="ag_nombre_presidente" value="" size=54 readonly></td>
        <td class=c3>Muestra los Apellidos y Nombres del Presidente del Tribunal Arbitral</td>
       
    </tr>
    

    
        <tr>
        <td class=c1>(*)Apellido Paterno</td>
        <td class=c2><input  type="text" id="ag_apePat_presidente" name="ag_apePat_presidente" value="" size=54></td>
        <td class=c3>Muestra el apellido paterno del Presidente del Tribunal Arbitral</td>
       
    </tr>

        <tr>
        <td class=c1>(*)Apellido Materno</td>
        <td class=c2><input  type="text" id="ag_apeMat_presidente" name="ag_apeMat_presidente" value="" size=54></td>
        <td class=c3>Muestra el   apellido materno del Presidente del Tribunal Arbitral</td>
       
    </tr>
    
    
            <tr>
        <td class=c1>(*)Nombres</td>
        <td class=c2><input  type="text" id="ag_nombres_presidente" name="ag_nombres_presidente" value="" size=54></td>
        <td class=c3>Muestra los nombres  del Presidente del Tribunal Arbitral</td>
       
    </tr>
  '); 
  
  
        usp_print('
        <tr> <td><h4>Arbitro designado por la Entidad</h4></td><td><input type=button value="..." onclick="modArbitro(2);"></tr>
    <tr>
       
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" id="ag_ruc_arbitro_ent" name="ag_ruc_arbitro_ent" value="" size=54 readonly><input  type="hidden" name="ag_sunat_arbitro_ent" value="" size=54 readonly></td>
        <td class=c3>Ingrese el n&uacute;mero de RUC del Arbitro designado por la entidad</td>
      
    </tr>
  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" id="ag_mom_arbitro_ent" name="ag_mom_arbitro_ent" value="" size=54 readonly></td>
        <td class=c3>Muestra los Apellidos y Nombres del Arbitro designado por la entidad</td>
        
    </tr>
    
        </tr>
    

    
        <tr>
        <td class=c1>(*)Apellido Paterno</td>
        <td class=c2><input  type="text" id="ag_apePat_ent" name="ag_apePat_ent" value="" size=54></td>
        <td class=c3>Muestra el apellido paterno del Arbitro designado por la entidadwww</td>
       
    </tr>

        <tr>
        <td class=c1>(*)Apellido Materno</td>
        <td class=c2><input  type="text" id="ag_apeMat_ent" name="ag_apeMat_ent" value="" size=54></td>
        <td class=c3>Muestra el   apellido materno del Arbitro designado por la entidad</td>
       
    </tr>
    
    <tr>
        <td class=c1>(*)Nombres</td>
        <td class=c2><input  type="text" id="ag_nombres_ent" name="ag_nombres_ent" value="" size=54></td>
        <td class=c3>Muestra los nombres  del Arbitro designado por la entidad</td>
       
    </tr>
  '); 
  
          usp_print('
          <tr> <td><h4>Arbitro designado por el Contratista</h4></td><td><input type=button value="..." onclick="modArbitro(3);">  </tr>
    <tr>
       
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" id="ag_ruc_arbitro_cont" name="ag_ruc_arbitro_cont" value="" size=54 readonly><input  type="hidden" name="ag_sunat_arbitro_cont" value="" size=54 readonly></td>
        <td class=c3>Ingrese el n&uacute;mero de RUC del Arbitro designado por el contratista</td>
    </tr>
  '); 
   
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input type="text" id="ag_nombre_arbitro_cont" name="ag_nombre_arbitro_cont" value="" size=54 readonly></td>
        <td class=c3>Muestra los Apellidos y Nombres del Arbitro designado por el contratista</td>
        
    </tr>
    

    
        <tr>
        <td class=c1>(*)Apellido Paterno</td>
        <td class=c2><input  type="text" id="ag_apePat_cont" name="ag_apePat_cont" value="" size=54></td>
        <td class=c3>Muestra el apellido paterno del Arbitro designado por el contratista</td>
       
    </tr>

        <tr>
        <td class=c1>(*)Apellido Materno</td>
        <td class=c2><input  type="text" id="ag_apeMat_cont" name="ag_apeMat_cont" value="" size=54></td>
        <td class=c3>Muestra el   apellido materno del Arbitro designado por el contratista</td>
       
    </tr>
    
                <tr>
        <td class=c1>(*)Nombres</td>
        <td class=c2><input  type="text" id="ag_nombres_cont" name="ag_nombres_cont" value="" size=54></td>
        <td class=c3>Muestra los nombres  del Arbitro designado por el contratista</td>
       
    </tr>
  ');
  
 end if;
  
  if  ag_tipo_arbitro = 220 then
        usp_print('
      <tr><td><h3>Identificaci&oacute;n del &Aacute;rbitro &Uacute;nico</h3></td><td><input type=button value="..." onclick="modArbitro(1);"></td></tr>
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" class="form-control" id="ag_ruc_presidente"  name="ag_ruc_presidente" value="" size=54 readonly><input  type="hidden" name="ag_sunat_presidente" value="" size=54 readonly class="InpReadOnly"></td>
        <td class=c3>Ingrese el n&uacute;mero de RUC del &Aacute;rbitro &Uacute;nico</td>
    </tr>

  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" class="form-control" id="ag_nombre_presidente" name="ag_nombre_presidente" value="" size=54 readonly class="InpReadOnly"> </td>
        <td class=c3>Muestra los Apellidos y Nombres del &Aacute;rbitro &Uacute;nico</td>
       
    </tr>
    
    <tr>
        <td class=c1>(*)Apellido Paterno</td>
        <td class=c2><input  type="text" id="ag_apePat_presidente" name="ag_apePat_presidente" value="" size=54 onkeypress= "return alpha(event)" /></td>
        <td class=c3>Muestra el apellido paterno del &Aacute;rbitro &Uacute;nico</td>
       
    </tr>
    
            <tr>
        <td class=c1>(*)Apellido Materno</td>
        <td class=c2><input  type="text" id="ag_apeMat_presidente" name="ag_apeMat_presidente" value="" size=54 onkeypress= "return alpha(event)"></td>
        <td class=c3>Muestra el apellido materno del &Aacute;rbitro &Uacute;nico</td>
       
    </tr>
    
    
            <tr>
        <td class=c1>(*)Nombres</td>
        <td class=c2><input  type="text" id="ag_nombres_presidente" name="ag_nombres_presidente" value="" size=54 onkeypress= "return alpha(event)"></td>
        <td class=c3>Muestra los nombres  del &Aacute;rbitro &Uacute;nico</td>
       
    </tr> 
     
  '); 
   
  end if;
  -->inicio vpt
  
        usp_print('
      <tr><td><h3>Identificacion del Secretario Arbitral</h3></td><td><input type=button value="..." onclick="modArbitro(4);"></td></tr>
    <tr>
        
        <td class=c1>RUC Nro.</td>
        <td class=c2><input  type="text" class="form-control" id="ag_ruc_secretario" name="ag_ruc_secretario" value="" size=54 readonly><input  type="hidden" name="ag_sunat_secretario" value="" size=54 readonly class="InpReadOnly"></td>
        <td class=c3>Ingrese el número de RUC del Secretario Arbitral</td>
    </tr>

  '); 
  
  
        usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input  type="text" class="form-control" id="ag_nombre_secretario" name="ag_nombre_secretario" value="" size=54 readonly class="InpReadOnly"> </td>
        <td class=c3>Muestra los Apellidos y Nombres del Secretario Arbitral</td>
       
    </tr>
    
    <tr>
        <td class=c1>(*)Apellido Paterno</td>
        <td class=c2><input  type="text" id="ag_apepat_secretario" name="ag_apepat_secretario" value="" size=54 onkeypress= "return alpha(event)" /></td>
        <td class=c3>Muestra el apellido paterno del Secretario Arbitral</td>
       
    </tr>
    
            <tr>
        <td class=c1>(*)Apellido Materno</td>
        <td class=c2><input  type="text" id="ag_apemat_secretario" name="ag_apemat_secretario" value="" size=54 onkeypress= "return alpha(event)"></td>
        <td class=c3>Muestra el apellido materno del Secretario Arbitral</td>
       
    </tr>
    
    
            <tr>
        <td class=c1>(*)Nombres</td>
        <td class=c2><input  type="text" id="ag_nombres_secretario" name="ag_nombres_secretario" value="" size=54 onkeypress= "return alpha(event)"></td>
        <td class=c3>Muestra los nombres  del Secretario Arbitral</td>
       
    </tr> 
     
  '); 
   
  -->final vpt
  
  
   
  usp_print('</table><br>');

   usp_print('
        </table>
        <br/>
        <br/>
        ');
        
 END;
  
 
 
  
 
 PROCEDURE uspCreaControversias (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_tipo_demandante                 VARCHAR2 ,
  ag_mecanismo                       VARCHAR2 
  
  )  
  
 IS
 lv_codtipofile                VARCHAR2(100); 
 lvtipodocumento               VARCHAR2(100); 
 cod_tipo_file                 VARCHAR2(100); 
 lv_combo_demandante           varchar2(4000);  
 lv_combo_mecanismo            varchar2(4000); 
 montoTotal                    number;
 ln_num_contrato               varchar2(4000);  
 ctipodemandante               ref_cursor;
 ctipomecanismo                ref_cursor;  
   
   ------- Cursores -------
   ------- Listado de Prorrogas ------  
 BEGIN
  PKU_SS_CONTROVERSIAS.dojscript  ;
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;
  
  select  n_contrato into ln_num_contrato  from reg_procesos.contrato where N_COD_CONTRATO = session__cod_contrato  ; 


    open ctipodemandante for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 12;
     
     
    open ctipomecanismo for
    select n_id_maestro,c_descripcion
    from arbitraje.tbl_arb_maestro where n_id_tipomaestro = 30;
     
     

    lv_combo_demandante  := PKU_SS_UTILES.f_retorna_combo(ctipodemandante, 'ag_tipo_demandante', ag_tipo_demandante,'Seleccione...','style="width:260px"');
     
    lv_combo_mecanismo   :=     PKU_SS_UTILES.f_retorna_combo(ctipomecanismo, 'ag_mecanismo', ag_mecanismo,'Seleccione...','style="width:260px" onchange="arbitraje();"'); 
    
    
    
          
 PKU_SS_FUNCIONES_JS.js_script('
 function Crear()
    {
      thisform.scriptdo.value = "doNewControversia";
      thisform.submit();
    }
    
    
     function arbitraje()
    {
    
        if (thisform.ag_mecanismo.value == 316)
          {
            thisform.scriptdo.value = "creaArbitraje";
            thisform.submit();
          }
          
        if (thisform.ag_mecanismo.value == 315)  
          { 
            thisform.scriptdo.value = "creaConciliacion";
            thisform.submit();
          }
    }
    
    
 ');   
 
 
 usp_print(session__cod_contrato);
----------- CABECERA --------------------
 USP_PRINT('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>'
          || PKU_SS_UTILES.f_get_titulo_contrato(session__cod_contrato,'Controversias')
          || '<td align="right" valign=top width="50%">
                 <input type=button value="Volver" onclick="thisform.scriptdo.value=''doView'';thisform.submit();"></td></tr>
         </table>');
 USP_PRINT('</TD></TR>');
 USP_PRINT('</TABLE><br>');



 usp_print('
  <table class="table table-striped">');    
 
 usp_print(' <td align = "center" colspan = 3>Ficha Electr&oacute;nica</td>');
  usp_print(' <td align = "center" colspan = 3><br></td>');
  usp_print('
    <tr>
        <td class=c1>N&uacute;mero del Contrato (u Orden de Compra o Servicio)</td>
        <td class=c2><input readOnly="true" type="text" name="ln_num_contrato" size=54  value = "'||ln_num_contrato||'" ></td>
        <td class=c3>N&uacute;mero del Contrato</td>
     </tr>
  ');  
/*
    usp_print('
    <tr>
      <td class=c1>(*)Demandante</td>
    <td class=c2>'||lv_combo_demandante||'</td>
    <td class=c3>Seleccione al demandante.</td>
    </tr>'); 
   */   
      
         usp_print('
    <tr>
      <td class=c1>(*)Tipo de mecanismo de soluci&oacute;n de Controversia</td>
    <td class=c2>'||lv_combo_mecanismo||'</td>
    <td class=c3>Seleccione el tipo de mecanismo de soluci&oacute;n de Controversia.</td>
    </tr>');   
 
   
  usp_print('</table><br>');

   usp_print('
        </table>
        <br/>
        <br/>
        ');
        
 END;
 
 
 
 
 
 
 PROCEDURE uspEditArbitro (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ruc                      VARCHAR2 DEFAULT NULL,
  ag_nombre                   VARCHAR2 DEFAULT NULL,
  cod                        VARCHAR2 DEFAULT NULL,
  ag_motivo                     VARCHAR2 DEFAULT NULL,
  sunat                     VARCHAR2 DEFAULT NULL 
 
  )      
  
 IS
 
 lv_codtipofile                VARCHAR2(100); 
 lvtipodocumento               VARCHAR2(100); 
 cod_tipo_file                 VARCHAR2(100); 
 ln_ruc                        VARCHAR2(100);   
 lv_combo_motivo           varchar2(4000); 
 montoTotal                    number;
 ln_num_contrato               varchar2(4000);     
 ln_nombre                     varchar2(4000);    
 ctipomotivo               ref_cursor; 
 
 ln_campotitulo                 varchar2 (800); --mlaura/ddrodriguez Req 55
 ln_camporuc                    varchar2 (800); --mlaura/ddrodriguez Req 55
 ln_camponomapel                varchar2 (800); --mlaura/ddrodriguez Req 55
   
   ------- Cursores -------
   
   
       Cursor c_cursor( ruc in varchar2 default null , ag_nombre in varchar2 default null) is
    
    SELECT c_paterno,c_materno,c_nombre,c_ruc
    from arbitraje.TBL_ARB_ARBITRO  
    where c_ruc  like  ruc and  c_nombre || ' '  || c_paterno  || ' '  ||  c_materno  like  '%' || ag_nombre || '%'  ; 

   ------- Listado de Prorrogas ------  
 BEGIN
  PKU_SS_CONTROVERSIAS.dojscript  ;
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;
  
  select  n_contrato into ln_num_contrato  from reg_procesos.contrato where N_COD_CONTRATO = session__cod_contrato  ; 


   ------- Tablero descripcion -------
   if (cod = 1) then
       ln_campotitulo := 'Ficha Electr&oacute;nica - Actualizaci&oacute;n del Presidente del Tribunal Arbitral / Arbitro Unico';
       ln_camporuc := 'Ingrese el n&uacute;mero de RUC del Presidente del Tribunal Arbitral / Arbitro Unico';
       ln_camponomapel := 'Muestra los apellidos y nombres  del Presidente del Tribunal Arbitral / Arbitro Unico';
   else if (cod = 2) then
         ln_campotitulo := 'Ficha Electr&oacute;nica - Actualizaci&oacute;n del Arbitro designado por la entidad';
         ln_camporuc := 'Ingrese el n&uacute;mero de RUC del Arbitro designado por la entidad';
         ln_camponomapel := 'Muestra los apellidos y nombres  del Arbitro designado por la entidad';
        else if (cod = 3) then
             ln_campotitulo := 'Ficha Electr&oacute;nica - Actualizaci&oacute;n del Arbitro designado por el contratista';
             ln_camporuc := 'Ingrese el n&uacute;mero de RUC del Arbitro designado por el contratista';
             ln_camponomapel := 'Muestra los apellidos y nombres  del Arbitro designado por el contratista';
             else if(cod = 4) then
                 ln_campotitulo := 'Ficha Electr&oacute;nica - Actualizaci&oacute;n del Secretario Arbitral';
                 ln_camporuc := 'Ingrese el n&uacute;mero de RUC del Secretario Arbitral';
                 ln_camponomapel := 'Muestra los apellidos y nombres del Secretario Arbitral';
                 end if;
             end if;
       end if;
   end if;

   ------- Tablero descripcion -------


     
    open ctipomotivo for
    select codigo, descripcion
    from reg_procesos.tipo_motivo_controversia;
     
     


lv_combo_motivo   :=     PKU_SS_UTILES.f_retorna_combo(ctipomotivo, 'ag_motivo', ag_motivo,'Seleccione...','style="width:260px" '); 
  
    
          
 PKU_SS_FUNCIONES_JS.js_script('
 
 
 
 
  function check(){

                  
               if ( thisform.manual.checked == false)
               
               {
                   thisform.sunat.value = "" ;
                   thisform.ag_nombre.value = "";
                   thisform.ag_nombre.readOnly = true;
                  
               }
               else
               {
                   thisform.sunat.value = 0 ; 
                   thisform.ag_nombre.readOnly = false;
                 
               }

 }
 
  function ValidaRUCSunat(){
                  

                 thisform.scriptdo.value = "usp_ValidarRUC";
                 thisform.submit();
 }
 
 
       function SoloNumerosNoDec(){

//Solo permite ingreso de numeros del teclado superior, derecho sin punto decimal
//inicio, fin, shift, control, etc

    var x = window.event.keyCode;   
    switch (x){
        case 8: case 9: case 48: case 49: case 50: case 51: case 52: case 53: case 54: case 55: case 56: case 57: 
            return;
        default:
            window.event.keyCode = 0;
            break;
    }
}
       
         function ValidaRuc(obj){
         
      
          SoloNumerosNoDec();
                    if  (obj.value.length >= 11)
                    {
                    
                        window.event.keyCode = 0;
                    }   
                    else
                    {
                        return;
                    }


}
    
 
        function retornaArbitro(nombre,ruc,tipo,motivo,pub,sunat){
       
         
       
           if (thisform.ag_motivo.value == null || thisform.ag_motivo.value == "" ) 
           {
            alert ("Debe seleccionar un motivo");
            thisform.ag_motivo.focus();
            return;
           
           }
           
                      if (thisform.ruc.value == null || thisform.ruc.value == "" ) 
           {
            alert ("Debe ingresar el RUC");
            thisform.ag_motivo.focus();
            return;
           
           }
           
                      if (thisform.ag_nombre.value == null || thisform.ag_nombre.value == "" ) 
           {
            alert ("Debe ingresar el nombre");
            thisform.ag_motivo.focus();
            return;
           
           }
           
           

             var wo = window.opener
  

                   
             wo.RtnArbitro(nombre,ruc,tipo,motivo,pub,sunat)
             window.close();
             
        }
  
              function busqueda()
          {
          
               
                thisform.scriptdo.value = "uspEditArbitro";
                thisform.submit();
         }
    
    
    
 ');   
 
 usp_print('
  <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>');    

 usp_print(' <td align = "center" colspan = 4><h3>'||ln_campotitulo||'</h3></td>');
  usp_print('
    <tr>

        
        
        

        <td style="width:20%">RUC Nro.</td>
        <td style="width:30%" class=c2>
           <input style="height:100px" type="text"  id="ruc" name="ruc" size=12  value = "'||ruc||'" onkeypress = "ValidaRuc(thisform.ruc);">                      
        </td>
        <td style="width:20%; text-align:right">
              <input type = "button" value = "Validar" onclick = "ValidaRUCSunat();"></input>
        </td>                        
        <td style="width:30%">'||ln_camporuc||'</td>

        
        
        
     </tr>
  ');  
  
  
    usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2><input type="text" name="ag_nombre" size=54  value = "'||ag_nombre||'"   readonly  onkeypress= "return alpha(event)"></br><div id = "DSunat"> </div></td>
        <td class=c3></td>
        <td class=c3>'||ln_camponomapel||'</td>
     </tr>
    <tr> <td colspan = "3"></td></tr>
    
    
    
  '); 
  
    usp_print('
    <tr>
    <td class=c1>(*)Motivo</td>
    <td class=c2>'||lv_combo_motivo||'</td>
    <td class=c3></td>
    <td class=c3>Circunstancia que origina la actualizaci&oacute;n de los datos</td>
    </tr>
    <input type="hidden"   name="sunat" size=12  value = "'||sunat||'"  >
    <input type="hidden" name="cod" size=54  value = "'||cod||'" >
     <script> 
          
              if (thisform.sunat.value == "1" && thisform.ag_nombre.value != "" ) 
              {
                document.getElementById("DSunat").style.visibility ="hidden"; 
              }
    </script>
    
    
    ');  
    
    
    usp_print('<tr><td colspan = "4" align = center><input type = "button" value = "Grabar" onclick="retornaArbitro(thisform.ag_nombre.value,thisform.ruc.value,'''|| cod||''',thisform.ag_motivo.value,''1'','''|| sunat||''')";  ></input><input type = "button" value = "Cancelar" onclick = "window.close();"></input></td></tr> ');
    
   
/*      
usp_print('
  <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
  <tr></td></tr>
  <tr><td><br></td></tr>
     <tr><td><br></td></tr>
   <tr><td><br></td><td>Nombre</td><td>RUC</td></tr>


  
   
  </tr>
<input type="hidden" name="cod" size=54  value = "'||cod||'" >
  ');    

      if ruc is null  then  ln_ruc := '%' ; else ln_ruc :=  ruc ; end if ;
      if ag_nombre is null  then  ln_nombre := '%' ; else ln_nombre :=  ag_nombre ; end if ;
 
      for xrow in c_cursor(ln_ruc,ln_nombre) loop
      begin

        usp_print('   <tr><td><input type=button value="..." onclick="retornaArbitro('''|| xrow.c_nombre || ' '  || xrow.c_paterno  || ' '  ||  xrow.c_materno ||''','''|| xrow.c_ruc||''','''|| cod||''','''|| ag_motivo||''',''1'')";></td><td>'|| xrow.c_nombre || ' '  || xrow.c_paterno || ' '  ||  xrow.c_materno ||'</td><td> '|| xrow.c_ruc ||' </td></tr> '); 
  
              
       end;
   end loop;  

   
  usp_print('</table><br>');
*/

   
  usp_print('</table><br>');

   usp_print('
        </table>
        <br/> 
        <br/>
        '); 
        
 END;
 
 
 
  PROCEDURE uspNuevoArbitro ( 
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ruc                      VARCHAR2 DEFAULT NULL,
  ag_nombre                   VARCHAR2 DEFAULT NULL,
  cod                        VARCHAR2 DEFAULT NULL,
  ag_motivo                     VARCHAR2 DEFAULT NULL,
  sunat                        VARCHAR2 DEFAULT NULL 
 
  )      
  
 IS
 
 lv_codtipofile                VARCHAR2(100); 
 lvtipodocumento               VARCHAR2(100); 
 cod_tipo_file                 VARCHAR2(100); 
 ln_ruc                        VARCHAR2(100);   
 lv_combo_motivo                varchar2(4000); 
 montoTotal                    number;
 ln_num_contrato                varchar2(4000);     
 ln_nombre                      varchar2(4000);
 ln_camporuc                   varchar2(2000);
 ln_camponomapel               varchar2(2000);
   
   ------- Listado de Prorrogas ------  
 BEGIN
  PKU_SS_CONTROVERSIAS.dojscript  ;
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  end if;
  
   ------- Tablero descripcion -------
   if (cod = 1) then
       ln_camporuc := 'Ingrese el n&uacute;mero de RUC del Presidente del Tribunal Arbitral / Arbitro Unico';
       ln_camponomapel := 'Muestra los apellidos y nombres  del Presidente del Tribunal Arbitral / Arbitro Unico';
   else if (cod = 2) then
         ln_camporuc := 'Ingrese el n&uacute;mero de RUC del Arbitro designado por la entidad';
         ln_camponomapel := 'Muestra los apellidos y nombres  del Arbitro designado por la entidad';
        else if (cod = 3) then
             ln_camporuc := 'Ingrese el n&uacute;mero de RUC del Arbitro designado por el contratista';
             ln_camponomapel := 'Muestra los apellidos y nombres  del Arbitro designado por el contratista';
             else if(cod = 4) then
                 ln_camporuc := 'Ingrese el n&uacute;mero de RUC del Secretario Arbitral';
                 ln_camponomapel := 'Muestra los apellidos y nombres del Secretario Arbitral';
                 end if;
             end if;
       end if;
   end if;

   ------- Tablero descripcion -------

     
          
 PKU_SS_FUNCIONES_JS.js_script('
 


 
 function ValidaRUCSunat(){
                  

                 thisform.scriptdo.value = "usp_ValidarRUC";
                 thisform.submit();
 }
 
 
  function check(){

                  
               if ( thisform.manual.checked == false)
               
               {
                   thisform.sunat.value = "" ;
                   thisform.ag_nombre.value = "";
                   thisform.ag_nombre.readOnly = true;
                  
               }
               else
               {
                   thisform.sunat.value = 0 ; 
                   thisform.ag_nombre.readOnly = false;
                 
               }

 }
 
 
       function SoloNumerosNoDec(){

//Solo permite ingreso de numeros del teclado superior, derecho sin punto decimal
//inicio, fin, shift, control, etc

    var x = window.event.keyCode;   
    switch (x){
        case 8: case 9: case 48: case 49: case 50: case 51: case 52: case 53: case 54: case 55: case 56: case 57: 
            return;
        default:
            window.event.keyCode = 0;
            break;
    }
}
       
         function ValidaRuc(obj){
         
      
          SoloNumerosNoDec();
                    if  (obj.value.length >= 11)
                    {
                    
                        window.event.keyCode = 0;
                    }   
                    else
                    {
                        return;
                    }


}
  
        function retornaArbitro(nombre,ruc,tipo,pub,sunat){
       
            if (ruc == "" ) 
            {alert ("Ingrese el ruc");
            return;
            
            }
            
                  if (nombre == "" ) 
            {alert ("Ingrese el nombre");
            return;
            
            }

             var wo = window.opener
             wo.RtnArbitro(nombre,ruc,tipo,pub,sunat)
             window.close();
             
        }
  
              function busqueda()
          {
          
               
                thisform.scriptdo.value = "NuevoArbitro";
                thisform.submit();
         }
    
    
    
 ');   
 
 usp_print('<script>
 .inputWidth{
   width:auto;      
 }
 </script>');
 
 usp_print('
   <center><h3>Ficha Electr&oacute;nica</h3></center>
  <table class="table table-striped" style="width:100%">');    
 
  usp_print('
    <tr>
        <td style="width:20%">RUC Nro </td>
        <td style="width:30%" class=c2>
           <input style="height:100px" type="text" name="ruc" size=12  value = "'||ruc||'" onkeypress = "ValidaRuc(thisform.ruc);"  >                      
        </td>
        <td style="width:20%; text-align:right">
              <input type = "button" value = "Validar" onclick = "ValidaRUCSunat();"></input>
        </td>                        
        <td style="width:30%">'||ln_camporuc||'</td>
     </tr>
    
  ');  
  
  
    usp_print('
    <tr>
        <td class=c1>(*)Apellidos y Nombres</td>
        <td class=c2 ><input type="text" name="ag_nombre" size=54  value = "'||ag_nombre||'" readonly  onkeypress= "return alpha(event)"></br><div id = "DSunat"> </div></td> 
        <td class=c3></td> 
        <td class=c3>'||ln_camponomapel||'</td>
        
 
     </tr>
      <input type="hidden"   name="sunat" size=12  value = "'||sunat||'"  >
     <script> 
          
              if (thisform.sunat.value == "1" && thisform.ag_nombre.value != "" ) 
              {
                document.getElementById("DSunat").style.visibility ="hidden"; 
              }
    </script>
     <tr><td colspan = "4" align = center><input type = "button" value = "Grabar" onclick="retornaArbitro(thisform.ag_nombre.value,thisform.ruc.value,'''|| cod||''',''1'',''' || sunat ||''')";  >&nbsp;</input><input type = "button" value = "Cancelar" onclick = "window.close();"></input></td></tr> 
 
    
  '); 
   
      
usp_print('
  <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
  <tr></td></tr>
  <tr><td><br></td></tr>
     <tr><td><br></td></tr>
  


  
   
  </tr>
<input type="hidden" name="cod" size=54  value = "'||cod||'" >
 <input type = "hidden" name = "ventana" value = "1" >
  ');    


  usp_print('</table><br>');


   
  usp_print('</table><br>');

   usp_print('
        </table>
        <br/> 
        <br/>
        ');
        
 END;
 
 
 
    PROCEDURE uspBuscaCentro (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_departamento         VARCHAR2 DEFAULT NULL,
  ag_centro               VARCHAR2 DEFAULT NULL
  )     
  
 IS
   lv_combo_Departamento           varchar2(4000); 
   cdepartamento                   ref_cursor; 
   departamento                    varchar2(4000); 
   centro                          varchar2(4000); 
   
   ------- Cursores -------
 
    Cursor c_cursor( ag_centro in varchar2 default null, ag_departamento varchar2 default null ) is
    
    SELECT cod_centro_conciliacion,c.descripcion descripcion,departamento,d.dep_desc
    from reg_procesos.centros_conciliacion  c left join sease.dep_ubigeo d on c.departamento = d.dep_codigo 
    where departamento  like   ag_departamento   and descripcion  like '%' ||  UPPER(ag_centro) || '%'
    order by descripcion
        
    ; 


   
   ------- Listado  ------ 
   

 BEGIN
  PKU_SS_CONTROVERSIAS.dojscript  ; 
 
     open cdepartamento for
    select dep_codigo, dep_desc
    from   sease.dep_ubigeo;
    
        lv_combo_Departamento   :=     PKU_SS_UTILES.f_retorna_combo(cdepartamento, 'ag_departamento', ag_departamento,'Seleccione...','style="width:260px" onchange=""'); 
    
   
 
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;
  

        
 PKU_SS_FUNCIONES_JS.js_script('
 

 
        function retornaCod_preupuestal(codigo,descripcion){

    
    
var cadena;

 cadena = descripcion.replace(/(^\s*)|(\s*$)/g,""); ;




             var wo = window.opener
             wo.RtnCodSniop(codigo,cadena)
             window.close();
             
        }
        
          function busqueda()
          {
          
               
                thisform.scriptdo.value = "BuscaCentro";
                thisform.submit();
        }
        
        function nuevoCentroConciliacion ()
{
            
                thisform.scriptdo.value = "uspNuevoCentro";
                thisform.submit();
}

 function RtnCentro(codigo,descripcion){
             
  //  thisform.ag_c_conciliacion.value = codigo;              
  //  thisform.ag_c_conciliacion_desc.value  =   descripcion;

}
    
    
 ');   
 


 usp_print('
 <h3>B&uacute;squeda de Centros de Conciliaci&oacute;n</h3>
  <table class="table table-striped">
     <tr>
        <td class=c1>(*)Descripci&oacute;n</td>
        <td class=c2><input type = "text" name = "ag_centro" value = "'||ag_centro||'"  
onkeypress= "return alpha(event)"></td>
        <td class=c3><input type=button value="Buscar" onclick="busqueda();"></td>
    </tr>
 
       <tr>
        <td class=c1>(*)Departamento</td>
        <td class=c2>'||lv_combo_Departamento||'</td>
        <td class=c3></td>
    </tr>
 
</table>
 
<br/>
<table class="table table-hover" style="font-size:0.9em">
   <tr><td align = "left" >Centros de Conciliaci&oacute;n</td><td>Departamento</td><td><br></td></tr>
  
   
  </tr>
 
  ');    
  
      if ag_departamento is null  then  departamento := '%' ; else departamento :=  ag_departamento ; end if ;
      if ag_centro is null then centro := '%' ; else centro := ag_centro ; end if ;
 
           usp_print('   <tr><td align = "left"><input type=button value=".." onclick="nuevoCentroConciliacion()";>Otros</td><td></td><td>''</td></tr> '); 
  
  
            for xrow in c_cursor(centro,departamento) loop
      begin

        usp_print('   <tr><td align = "left"><input type=button value=".." onclick="retornaCod_preupuestal('|| xrow.cod_centro_conciliacion||','''|| trim(xrow.descripcion)||''')";>'|| xrow.descripcion ||'</td><td>'|| xrow.dep_desc||'</td><td></td></tr> '); 
  
              
       end;
   end loop;  

   
  usp_print('</table><br>');

   usp_print('
        </table>
        <br/>
        <br/>
        ');
        
 END;
 
 
 
 
 
 
 
 
 
 
   PROCEDURE usp_ValidarRUC (
  session__cod_contrato    VARCHAR2 DEFAULT NULL,
  session__filesingedhttp  VARCHAR2 DEFAULT NULL,
  ruc                      VARCHAR2 DEFAULT NULL,
  ag_nombre                VARCHAR2 DEFAULT NULL,
  cod                      VARCHAR2 DEFAULT NULL,
  ag_motivo                VARCHAR2 DEFAULT NULL,
  ventana                  VARCHAR2 DEFAULT NULL
  )       
  
 IS
     nombre      varchar2(4000); 
      estado      varchar2(10);

 BEGIN 
 
 
 
  PKU_SS_FUNCIONES_JS.js_script('
  
  
  function cerrar() { 
                        ventana=window.self; 
                        ventana.opener=window.self; 
                        ventana.close(); } 
  
  
   document.write("<br>Validadndo Impedimentos...");  ');  
    
     select reg_procesos.FN_VALIDA_ARBITRO(ruc) into estado from dual ;
 
 
 
 
 
      
 
      if estado = 'impedido' then
 
 
                           USP_PRINT('
                <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
                <tr>
                  <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
                            <tr>
                            <td align = "center"><h3>Arbitro Impedido</h3></td>
                            </tr>
                            <tr>
                            <td align = "center"><h3><br></h3></td>
                            </tr>
                            
                             <tr>
                             <td align="center" valign=top width="50%">
                             </td>
                             </tr>
                             
                     </table>');
             USP_PRINT('</TD></TR>');
             USP_PRINT('</TABLE><br>');
             
          PKU_SS_FUNCIONES_JS.js_script('alert("Arbitro con Impedimento")'); 
          PKU_SS_FUNCIONES_JS.js_script('cerrar();');
             
 
      else
      
                  PKU_SS_FUNCIONES_JS.js_script('
   
                 
                 
                 document.write("<BR>Validadndo con Sunat...");  '); 
               
                   select f_ws_sunat_get_razon_social_2(ruc) into nombre from dual ;
      
      
 
                 usp_print('
                 <input  type="hidden" name="sunat" value="1" size=54 readonly>
                 <input  type="hidden" name="ruc" value="' || ruc || '" size=54 readonly>
                  <input  type="hidden" name="ag_nombre" value="' || nombre || '" size=54 readonly>
                  <input  type="hidden" name="cod" value="' || cod || '" size=54 readonly>
                  <input  type="hidden" name="ag_motivo" value="' || ag_motivo || '" size=54 readonly>
                   <input  type="hidden " name="ag_estado" value="' || estado || '" size=54 readonly>')
                   ;
               
      
   end if;
      
      
    if  ventana = '1' then
    
       PKU_SS_FUNCIONES_JS.js_script('
           thisform.scriptdo.value = "NuevoArbitro";
                thisform.submit();
      ');   
     else
            PKU_SS_FUNCIONES_JS.js_script('
           thisform.scriptdo.value = "uspEditArbitro";
                        thisform.submit();
      ');
     
     
     end if;
      
        
 END;
 



 PROCEDURE uspNuevoCentro (
  session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_departamento         VARCHAR2 DEFAULT NULL,
  ag_centro               VARCHAR2 DEFAULT NULL
  )     
  
 IS
   lv_combo_Departamento           varchar2(4000); 
   cdepartamento                   ref_cursor; 
   departamento                    varchar2(4000); 
   centro                          varchar2(4000); 
   
   ------- Cursores -------
 
    Cursor c_cursor( ag_centro in varchar2 default null, ag_departamento varchar2 default null ) is
    
    SELECT cod_centro_conciliacion,replace(descripcion,' ','') descripcion,departamento,d.dep_desc
    from reg_procesos.centros_conciliacion  c left join sease.dep_ubigeo d on c.departamento = d.dep_codigo 
    where departamento  like   ag_departamento   and descripcion  like '%' ||  UPPER(ag_centro) || '%'
    order by descripcion
        
    ; 


   
   ------- Listado  ------ 
   

 BEGIN
 
  PKU_SS_CONTROVERSIAS.dojscript  ;
     open cdepartamento for
    select dep_codigo, dep_desc
    from   sease.dep_ubigeo;
    
        lv_combo_Departamento   :=     PKU_SS_UTILES.f_retorna_combo(cdepartamento, 'ag_departamento', ag_departamento,'Seleccione...','style="width:260px" onchange=""'); 
    
   
 
   IF (session__cod_contrato IS NULL) THEN
     usp_print
        (pku_procesos_comun.f_putmensaje
            ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
     RETURN;
  END IF;
  

        
 PKU_SS_FUNCIONES_JS.js_script('
 

 
        function retornaCod_preupuestal(codigo,descripcion){

    
    
var cadena;

cadena= descripcion.replace(/\s/g,"");




             var wo = window.opener
             wo.RtnCodSniop(codigo,cadena)
             window.close();
             
        }
        
          function busqueda()
          {
          
               
                thisform.scriptdo.value = "BuscaCentro";
                thisform.submit();
        }
        
        function nuevoCentroConciliacion ()
{
            
                thisform.scriptdo.value = "uspNuevoCentro";
                thisform.submit();
}

function InsertCentro ()
{

                if (thisform.ag_centro.value == "" )
                {
                  alert ("Ingrese el nombre del centro de Conciliación");
                  return;
                }
                
                if (thisform.ag_departamento.value == "")
                {
                    alert("Ingrese el departamento");
                    return;
                
                }
            
                thisform.scriptdo.value = "uspNuevoCentroInsert";
                thisform.submit();
}


 function RtnCentro(codigo,descripcion){
             
  //  thisform.ag_c_conciliacion.value = codigo;              
  //  thisform.ag_c_conciliacion_desc.value  =   descripcion;
  alert("hola");
}
    
    
 ');   
 


 usp_print('
  <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
  <tr><td><br></td><td><br></td><td><br></td></tr>
  <tr><td><br></td><td><br></td><td><br></td></tr>
   <tr><td colspan = "3" ><h3> Nuevo Centro de Conciliaci&oacute;n </h3uspCreaArbitraje></td></tr>
 
 
 
     <tr>
        <td class=c1>(*)Descripci&oacute;n</td>
        <td class=c2><input type = "text" name = "ag_centro" value = "'||ag_centro||'" 
onkeypress= "return alpha(event)"></td>
        <td class=c3></td>
    </tr>
 
      <tr>
        <td class=c1>(*)Departamento</td>
        <td class=c2>'||lv_combo_Departamento||'</td>
        <td class=c3></td>
    </tr>
 

  <tr><td><br></td><td><br></td><td><br></td></tr>

 

   <tr><td colspan = "3" align = "center"><input type=button value="Guardar" onclick="InsertCentro();"></td></tr> 
      <tr><td><br></td><td><br></td><td><br></td></tr>

   
  </tr>
 
  ');    
  

         
  usp_print('</table><br>');

   usp_print('
        </table>
        <br/>
        <br/>
        ');
        
 END;
 


PROCEDURE uspNuevoCentroInsert( 
 session__cod_contrato   VARCHAR2 DEFAULT NULL,
  session__filesingedhttp VARCHAR2 DEFAULT NULL,
  ag_departamento         VARCHAR2 DEFAULT NULL,
  ag_centro               VARCHAR2 DEFAULT NULL
   
 ) Is 

 

 BEGIN
  
     
 PKU_SS_CONTROVERSIAS.dojscript  ;
      --insert into reg_procesos.contrato_conciliacion (numero,num_registro,tipo_demandante,cod_centro_conciliacion,ruc_conciliador,nombre_conciliador,fecha_audiencia,nombre_doc_acta,tipo_estado_conciliacion,n_cod_contrato,url_doc_acta)
 
      insert into reg_procesos.centros_conciliacion (
      cod_centro_conciliacion,
      descripcion,
      departamento
      
      )
      values(SEQUENCE_CEN_CONCIL.NEXTVAL,
      UPPER(ag_centro),
      ag_departamento 
      
      );
          
  commit;
usp_print('<input type = "text" name = "ag_centro" value = "'||ag_centro||'"  
onkeypress= "return alpha(event)">');
usp_print('<input type = "text" name = "ag_departamento" value = "'||ag_departamento||'"  
onkeypress= "return alpha(event)">');
    usp_print('
    <script language=javascript>
    
       thisform.scriptdo.value="BuscaCentro";
       thisform.submit();
    </script>
    ');

 END; 
 
END PKU_GESTOR_CONT_CONTROVERSIAS;
/
