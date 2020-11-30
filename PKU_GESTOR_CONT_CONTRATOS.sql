CREATE OR REPLACE PACKAGE PKU_GESTOR_CONT_CONTRATOS
  IS
 
       --consultoria nube migracion
  url_azure_app    varchar2(250):= 'https://zonasegura2.seace.gob.pe/documentos/';

  type ref_cursor is ref cursor;
  --------------------------------------------------
  pkname   varchar2(60) default 'PKU_SS_CONTRATOS2';
  pkUtiles varchar2(60) default 'PKU_SS_UTILES2';
  --------------------------------------------------
 /* gpk_logo           varchar2(200):='http://zonasegura.seace.gob.pe/images/logos/icono.gif';*/
  gpk_ImagenElectron varchar2(200):='img/electronica.gif';
  gpk_AdvancingR2    varchar2(200):='img/Advancing_Right_2.gif';
 /* gpk_crear01_gris   varchar2(200):='http://zonasegura.seace.gob.pe/images/crear01_gris.jpg';
  gpk_crear01_azul   varchar2(200):='http://zonasegura.seace.gob.pe/images/crear01_azul.jpg';
  gpk_volver_gris    varchar2(200):='http://zonasegura.seace.gob.pe/images/volver_gris.jpg';
  gpk_volver_azul    varchar2(200):='http://zonasegura.seace.gob.pe/images/volver_azul.jpg';
  gpk_ver_azul       varchar2(200):='http://zonasegura.seace.gob.pe/images/ver_azul.jpg';
  gpk_ver_gris       varchar2(200):='http://zonasegura.seace.gob.pe/images/ver_gris.jpg';*/
  gpk_eliminar       varchar2(200):='img/eliminar.gif';
  gpk_aceptar        varchar2(200):='img/aceptar.gif';
  gpk_barra_avance   varchar2(200):='img/Advancing_roll_bar_4.gif';
  ----------------------------------------------------------------
  gn_doc_rescont_porlet_id     varchar2(50):='UPLOAD_RESUMEN_CONTRATO'; ---'479';
  gn_doc_liqcont_porlet_id     varchar2(50):='UPLOAD_DOC_LIQUIDACION';  ---'483';
  gn_reenvio_transf_porlet_id  varchar2(50):='TRANSFERENCIA_MEF';  --- '483';
  ----------------------------------------------------------------
  gn_pagesize_contratos           number:= 20;
  gpk_coddoc_intervencion         number:= 800;
  gpk_coddoc_liquidacion          number:= 700;
  gpk_coddoc_resumen_contrato     number:= 600;
  gpk_coddoc_contrato_resolucion  number := 610; 
  gpk_coddoc_contrato_nulidad     number := 620;  
  gpk_IdCodpresuTmpProrroga       number;
  gpk_directorio_intervencion     varchar2(50):= 'mon\docs\contratos';
  gpk_directorio_liquidacion      varchar2(50):= 'mon\docs\contratos';
  gpk_directorio_resumen_cont     varchar2(50):= 'mon\docs\contratos';
  gpk_directorio_resolucion       varchar2(50):= 'mon\docs\contratos';
  gpk_directorio_nulidad          varchar2(50):= 'mon\docs\contratos';  
  ----------------------------------------------------------------

  /******************* PROCEDIMIENTOS ********************************/

  PROCEDURE uspLisGarantiasDoView
     ( ag_n_convoca         varchar2 DEFAULT Null,
       ag_cod_contrato      varchar2 DEFAULT Null,
       ag_ncor_orden_pedido varchar2,
       ag_cm_opc            varchar2,
       ag_cm_oper_compra    varchar2,
       ag_anhoentidad       varchar2,
       ag_proc_tipo         varchar2,
       ag_proc_desc         varchar2,
       ag_proc_sigla        varchar2,
       ag_currenpage        varchar2,
       session__userid      varchar2 ,
       session__AG_N_CONVOCA    varchar2 ,
       session__AG_COD_CONTRATO varchar2 );






  PROCEDURE uspManProItemDoInsert
     ( ag_id_usuario           varchar2,
       ag_n_convoca            varchar2,
       ag_cod_contrato         varchar2,
       ag_cod_contrato_ren     varchar2,
       ag_n_contrato           varchar2,
       ag_cod_moneda           varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_codconsucode         varchar2,
       ag_anhoentidad          varchar2,
       ag_cod_operacion        varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_cant_items           varchar2,
       ag_fila_inicio          varchar2,
       ag_fila_fin             varchar2,
       ag_caditem_nreg         varchar2,
       ag_caditem_item         varchar2,
       ag_caditem_unid         varchar2,
       ag_caditem_cant         varchar2,
       ag_caditem_monto        varchar2,
       ag_currenpage           varchar2,
       ag_Item_Ini             varchar2,
       ag_Item_Fin             varchar2,
       ag_next_url             varchar2,
       ag_ini_editar           varchar2  default null,
       session__userid          varchar2 default null,
       session__AG_N_CONVOCA    varchar2 default null,
       session__AG_COD_CONTRATO varchar2 default null);
  PROCEDURE uspNewIntervencionEconomica(
            session__userid                varchar2 default null,
            session__N_CONVOCA          varchar2 default null,
            session__COD_CONTRATO       varchar2 default null,
            session__EUE_CODIGO            varchar2 default null,
            session__maxMBUploadFileSize   varchar2 default null,
            docname__mime                  varchar2 default null,
            session__FileSingedHTTP        varchar2 default null,
            session__FileSinged            varchar2 default null,
            WriteFileDirectoryDynamic      varchar2 default null,
            extension                      varchar2 default null,
            session__IIS_REMOTE_ADDR       varchar2 default null,
            session__anhoentidad           varchar2 default null,
            session__PUBLICADO             varchar2 
);
  PROCEDURE uspDoInsertIntervEco(
            session__userid                         varchar2 default null,
            session__N_CONVOCA                   varchar2 default null,
            session__COD_CONTRATO                varchar2 default null,
            session__seacedocument                  varchar2,
            session__seacedocumentosdwn             varchar2,
            WriteFileDirectoryDynamic               varchar2,
            session__FileSingedHTTP                 varchar2,
            session__maxMBUploadFileSize            varchar2,
            docname_mimetype                        varchar2,
            iisenv__remote_host                     varchar,
            extension                               varchar2,
            ag_f_intervencion                       varchar2 default null,
            ag_cod_tipo_doc                         varchar2 default null,
            ag_resolInertv                          varchar2 default null,
            ag_f_resolInertv                        varchar2 default null,
            ag_causa_intervencion                   varchar2 default null,
            ag_apePatInertv                         varchar2 default null,
            ag_apeMatInertv                         varchar2 default null,
            ag_nomInertv                            varchar2 default null,
            ag_cargInertv                           varchar2 default null,
            ag_observInertv                         varchar2 default null,
            docname                                 varchar2 default null,
            session__anhoentidad                    varchar2 default null
);
  PROCEDURE uspValRNPProrrogaDoView
     ( ag_n_convoca            varchar2,
       ag_ind_consorcio        varchar2,
       ag_ruc_contratista      varchar2,
       ag_cod_contrato         varchar2,
       ag_cod_contrato_ren     varchar2,
       ag_n_contrato           varchar2,
       ag_codmoneda_contrato   varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_codconsucode         varchar2,
       ag_anhoentidad          varchar2,
       ag_cod_operacion        varchar2,
       ag_reg_cal_modif        varchar2,
       ag_codconsucode_paga    varchar2,
       ag_anhoentidad_paga     varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_cm_opc               varchar2,
       ag_cm_oper_compra       varchar2,
       ag_id_usuario           varchar2,
       ag_back_page            varchar2,
       session__userid         varchar2);

  PROCEDURE uspUplFileResConDoView(
    session__userid              varchar2,
    session__seacedocument       varchar2,
    session__seacedocumentosdwn  varchar2,
    WriteFileDirectoryDynamic    varchar2,
    ppnconvoca                   varchar2,
    docname                      varchar2,
    docname_mimetype             varchar2,
    pfiletoupload__size          varchar2,
    doc_obs                      varchar2,
    pcodentidad                  varchar2,
    session__IIS_REMOTE_ADDR     varchar2,
    ag_cod_contrato              varchar2,
    pfiletoupload                VARCHAR2,
    iisenv__remote_host          VARCHAR2,
    fec_aprob                    VARCHAR2);

 PROCEDURE uspUplFileResConDoEdit (
    ag_n_convoca                   varchar2 default null,
    ag_cod_tipo_doc                varchar2 default null,
    docname                        varchar2 default null,
    session__maxMBUploadFileSize   varchar2 default null,
    docname__mime                  varchar2 default null,
    session__FileSingedHTTP        varchar2 default null,
    session__FileSinged            varchar2 default null,
    WriteFileDirectoryDynamic      varchar2 default null,
    extension                      varchar2 default null,
    session__IIS_REMOTE_ADDR       varchar2 default null,
    session__userid                varchar2,
    ag_cod_contrato                varchar2);


  PROCEDURE uspTransferMefDoView (
    ag_n_convoca          varchar2,
    ag_cod_contrato       varchar2,
    ag_anhoentidad        varchar2,
    ag_eue_codigo         varchar2,
    ag_ind_show_error     varchar2,
    session__userid       varchar2);


 PROCEDURE uspSearchContratoOpCodPresu
  (  anho_entidad              VARCHAR2,
     session__eue_codigo       VARCHAR2,
     edicion                   VARCHAR2 DEFAULT NULL,
     codigo                    VARCHAR2 DEFAULT NULL,
     descripcion               VARCHAR2 DEFAULT NULL,
     session__n_convoca        VARCHAR2 DEFAULT NULL,
     ag_n_propuesta            VARCHAR2 DEFAULT NULL,
     ag_monto_codPre           VARCHAR2 DEFAULT NULL,
     ag_proc_item              VARCHAR2 DEFAULT NULL,
     ag_tipo_operacion         VARCHAR2 DEFAULT NULL,
     session__userid           varchar2
  );


  PROCEDURE uspResolucionDoCancel(
    ag_id_usuario           varchar2,
    ag_n_convoca            varchar2,
    ag_cod_contrato         varchar2,
    ag_anhoentidad          varchar2,
    ag_proc_tipo            varchar2,
    ag_proc_desc            varchar2,
    ag_proc_sigla           varchar2,
    ag_currenpage           varchar2,
    session__userid         varchar2);
  PROCEDURE uspReenvioTransferIniDoView (
    ag_id_operacion       varchar2,
    ag_n_convoca          varchar2,
    ag_cod_contrato       varchar2,
    ag_anhoentidad        varchar2,
    ag_eue_codigo         varchar2,
    session__userid       varchar2);
  PROCEDURE uspReenvioTransferFinDoView (
    ag_id_operacion       varchar2,
    ag_cod_estado_transf  varchar2,
    ag_n_convoca          varchar2,
    ag_cod_contrato       varchar2,
    ag_anhoentidad        varchar2,
    ag_eue_codigo         varchar2,
    session__userid       varchar2);

  PROCEDURE uspProItemDoInsert
     ( ag_id_usuario           varchar2,
       ag_n_convoca            varchar2,
       ag_cod_contrato         varchar2,
       ag_cod_contrato_ren     varchar2,
       ag_n_contrato           varchar2,
       ag_cod_moneda           varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_codconsucode         varchar2,
       ag_anhoentidad          varchar2,
       ag_cod_operacion        varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_cant_items           varchar2,
       ag_fila_inicio          varchar2,
       ag_fila_fin             varchar2,
       ag_caditem_nreg         varchar2,
       ag_caditem_item         varchar2,
       ag_caditem_unid         varchar2,
       ag_caditem_cant         varchar2,
       ag_caditem_monto        varchar2,
       ag_currenpage           varchar2,
       ag_Item_Ini             varchar2,
       ag_Item_Fin             varchar2,
       ag_next_url             varchar2,
       session__userid         varchar2);

  PROCEDURE uspNewProItemDoInsert
     ( ag_id_usuario           varchar2,
       ag_n_convoca            varchar2,
       ag_cod_contrato         varchar2,
       ag_n_contrato           varchar2,
       ag_cod_moneda           varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_codconsucode         varchar2,
       ag_anhoentidad          varchar2,
       ag_cod_operacion        varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_cant_items           varchar2,
       ag_fila_inicio          varchar2,
       ag_fila_fin             varchar2,
       ag_caditem_nreg         varchar2,
       ag_caditem_item         varchar2,
       ag_caditem_unid         varchar2,
       ag_caditem_cant         varchar2,
       ag_caditem_monto        varchar2,
       ag_currenpage           varchar2,
       ag_Item_Ini             varchar2,
       ag_Item_Fin             varchar2,
       ag_next_url             varchar2,
       ag_ini_editar           varchar2  default null,
       session__userid          varchar2 default null,
       session__AG_N_CONVOCA    varchar2 default null,
       session__AG_COD_CONTRATO varchar2 default null);

  PROCEDURE uspNewProItemDoDelete
    ( session__userid             varchar2 default null,
      session__ag_n_convoca       varchar2 default null,
      session__AG_COD_CONTRATO    varchar2 default null,
      proc_item                   varchar2,
      ag_cod_operacion            varchar2 );

  PROCEDURE uspManResolucionDoView(
    ag_n_convoca         varchar2 DEFAULT Null,
    ag_cod_resolucion    varchar2,
    ag_id_usuario        varchar2,
    ag_anhoentidad       varchar2,
    ag_proc_tipo         varchar2,
    ag_proc_desc         varchar2,
    ag_proc_sigla        varchar2,
    ag_currenpage        varchar2,
    session__userid      varchar2,
    session__FileSingedHTTP  varchar2 default null);
  PROCEDURE uspManProItemDoEdit
     ( ag_id_usuario            varchar2,
       ag_n_convoca             varchar2,
       ag_cod_contrato          varchar2,
       ag_cod_contrato_ren      varchar2,
       ag_n_contrato            varchar2,
       ag_cod_moneda            varchar2,
       ag_f_contrato            varchar2,
       ag_m_contratado          varchar2,
       ag_des_causa_renov       varchar2,
       ag_des_contrato          varchar2,
       ag_plazo                 varchar2,
       ag_f_culminacion         varchar2,
       ag_codconsucode          varchar2,
       ag_anhoentidad           varchar2,
       ag_cod_operacion         varchar2,
       ag_ncor_orden_pedido     varchar2,
       ag_cant_items            varchar2,
       ag_next_url              varchar2,
       ag_tipo_op               varchar2,
       ag_currenpage            varchar2,
       session__ag_cod_contrato varchar2,
       session__userid          varchar2);
  PROCEDURE uspManProItemDoDelete
     ( ag_cod_contrato_ren VARCHAR2,
       ag_proc_item        VARCHAR2,
       session__userid     VARCHAR2,
       session__n_convoca  VARCHAR2,
       ag_cod_contrato     VARCHAR2,
       ag_n_contrato       VARCHAR2);

  PROCEDURE uspLisProcesosDoView (
    v_proc_tipo                 varchar2 DEFAULT NULL,
    ag_descripcion              varchar2 DEFAULT NULL,
    ag_currentpage              varchar2 DEFAULT 1,
    session__eue_codigo         varchar2,
    session__anhoentidad        varchar2,
    panho                       varchar2,
    v_proc_sigla                    varchar2
);


  PROCEDURE uspConOpeTituloDoView(
    ag_cod_contrato             varchar2 DEFAULT Null,
    ag_f_liquidacion            varchar2 DEFAULT Null);



  PROCEDURE uspProrrogaCodPresDoDelete
     (  session__AG_N_CONVOCA    varchar2 default null,
        session__AG_COD_CONTRATO varchar2 default null,
        ag_proc_item             varchar2 default null,
        ag_cod_operacion         varchar2 default null,
        ag_n_propuesta           varchar2 default null,
        ag_cod_presu             varchar2 default null,
        ag_des_contrato          varchar2,
        ag_des_causa_renov       varchar2,
        ag_f_contrato            varchar2,
        ag_f_culminacion         varchar2,
        ag_n_contrato            varchar2,
        ag_plazo                 varchar2,
        ag_cod_moneda            varchar2
     );

PROCEDURE uspDoInsertIntervEco2(
            session__userid                         varchar2 default null,
            session__N_CONVOCA                   varchar2 default null,
            session__COD_CONTRATO                varchar2 default null,
            session__seacedocument                  varchar2,
            session__seacedocumentosdwn             varchar2,
            WriteFileDirectoryDynamic               varchar2,
            SizeFile                    varchar2 default null,
             pfiletoupload_file1              VARCHAR2 default null,
            pfiletoupload1                   VARCHAR2 default null,
            iisenv__remote_host                varchar,
            extension                               varchar2,
            ag_f_intervencion                       varchar2 default null,
            ag_cod_tipo_doc                         varchar2 default null,
            ag_resolInertv                          varchar2 default null,
            ag_f_resolInertv                        varchar2 default null,
            ag_causa_intervencion                   varchar2 default null,
            ag_apePatInertv                         varchar2 default null,
            ag_apeMatInertv                         varchar2 default null,
            ag_nomInertv                            varchar2 default null,
            ag_cargInertv                           varchar2 default null,
            ag_observInertv                         varchar2 default null,
            session__anhoentidad                    varchar2 default null
);
PROCEDURE uspNewIntervencionEconomica2(
      session__userid                varchar2 default null,
      session__N_CONVOCA          varchar2 default null,
      session__COD_CONTRATO       varchar2 default null,
      session__EUE_CODIGO            varchar2 default null,
      session__maxMBUploadFileSize   varchar2 default null,
      docname__mime                  varchar2 default null,
      session__FileSingedHTTP        varchar2 default null,
      session__FileSinged            varchar2 default null,
      WriteFileDirectoryDynamic      varchar2 default null,
      extension                      varchar2 default null,
      session__IIS_REMOTE_ADDR       varchar2 default null,
      session__anhoentidad           varchar2 default null,
      session__PUBLICADO             varchar2      
);

  function f_get_tipo_proc_ent (pv_select varchar2,  gv_entidad VARCHAR2 , gv_evento varchar2,anho varchar2) 
    return varchar;
END; -- Package spec

/


CREATE OR REPLACE PACKAGE BODY "PKU_GESTOR_CONT_CONTRATOS"
IS



/*******************************************************************************
/ Procedimiento : uspSearchCodPresupuestal
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Castañeda                          Version Inicial
/******************************************************************************/
PROCEDURE uspSearchContratoOpCodPresu(  anho_entidad              VARCHAR2,
                                        session__eue_codigo       VARCHAR2,
                                        edicion                   VARCHAR2 DEFAULT NULL,
                                        codigo                    VARCHAR2 DEFAULT NULL,
                                        descripcion               VARCHAR2 DEFAULT NULL,
                                        session__n_convoca        VARCHAR2 DEFAULT NULL,
                                        ag_n_propuesta            VARCHAR2 DEFAULT NULL,
                                        ag_monto_codPre           VARCHAR2 DEFAULT NULL,
                                        ag_proc_item              VARCHAR2 DEFAULT NULL,
                                        ag_tipo_operacion         VARCHAR2 DEFAULT NULL,
                                        session__userid           varchar2
                                     )
IS

 anhoentidad     varchar2(20);
 entidad         varchar2(100);
 editar          varchar2(1);
 codigo_pre      varchar2(50);
 descrip_pre     varchar2(100);
 convoca         varchar2(50);
 propuesta       varchar2(50);
 monto           varchar2(50);
 proc_item       varchar2(50);
 tipo_operacion  varchar2(1);

 CURSOR cCodPresupuesto (convocatoria varchar2,entidad varchar2,item varchar2)
 IS
   SELECT distinct cod_presupuestal, descripcion 
      FROM 
        REG_PROCESOS.CONTRATO_COD_PRESUPUESTAL
      WHERE 
            n_convoca   = convocatoria and
            n_propuesta = propuesta;

BEGIN

  if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
  end if;

  anhoentidad    := trim(anho_entidad); 
  entidad        := session__eue_codigo; 
  editar         := edicion;
  codigo_pre     := codigo;
  descrip_pre    := descripcion;
  convoca        := session__n_convoca;
  propuesta      := ag_n_propuesta; 
  monto          := ag_monto_codPre; 
  proc_item      := ag_proc_item;
  tipo_operacion := ag_tipo_operacion; 

  /*usp_print('anhoentidad: '||anhoentidad||'<br>');
  usp_print('entidad    : '||entidad||'<br>');
  usp_print('editar     : '||editar||'<br>');
  usp_print('codigo_pre : '||codigo_pre||'<br>');
  usp_print('descrip_pre: '||descrip_pre||'<br>');
  usp_print('convoca: '||convoca||'<br>');
  usp_print('propuesta: '||propuesta||'<br>');
  return;*/

  usp_print('
  <input type=hidden name=ag_tipo_operacion='||tipo_operacion||'>
  <input type=hidden name=ag_proc_item value='||proc_item||'>
  <input type=hidden name=ag_n_propuesta value='||propuesta||'>
  <input type=hidden name=anho_entidad value='||anhoentidad||'>
  <input type=hidden name=ag_proc_item value='||proc_item||'>
  <input type=hidden name=edicion value="">
  <input type=hidden name=codigo value="">
  <input type=hidden name=descripcion value="">
  ');

  IF edicion IS NULL THEN
      usp_print('
      <table border="0" class=tableform cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
        <tr>
          <td align=left>
            <h3>Busqueda de Codigos Presupuestales</h3>
          </td>
        </tr>
      </table>
      <br>
      <table border="0" class=tableform cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
        <tr>
          <td class=th1>&nbsp;</td>
          <td class=th1>Codigo</td>
          <td class=th1>descripcion</td>
        </tr>
        <tr>');
        FOR xd IN cCodPresupuesto(anhoentidad,entidad,proc_item)LOOP
        usp_print('
        <tr>
          <td><img src=images/Eliminar.gif onclick="IngresarCod('''||xd.cod_presupuestal||''','''||xd.descripcion||''');"></td>
          <td>'||xd.cod_presupuestal||'<input type=hidden name=ag_codPre_codpresupuestal value="'||xd.cod_presupuestal||'"></td>
          <td>'||xd.descripcion||'<input type=hidden name=ag_codPre_descripcion value="'||xd.descripcion||'"></td> 
        </tr> 
        '); 
        END LOOP;
       usp_print('   
        </tr>
      </table>
      ');

  ELSE 

      /*usp_print('anhoentidad: '||anhoentidad||'<br>');
      usp_print('entidad: '||entidad||'<br>');
      usp_print('editar: '||editar||'<br>');
      usp_print('codigo_pre: '||codigo_pre||'<br>');
      usp_print('descrip_pre: '||descrip_pre||'<br>');
      return;*/

      SELECT proy_descripcion descripcion into descrip_pre
      FROM REG_PROCESOS.mef_proyectos 
      WHERE proy_codigo = to_number(codigo_pre)
        and proy_estado = 'A';


      IF edicion = '1' THEN
          usp_print('
          <table border="0" class=tableform cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
            <tr>
              <td align=left>
                <h3>Busqueda de Codigos Presupuestales</h3>
              </td>
            </tr>
          </table>
          <br>
          <table border="0" class=tableform cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
            <tr>
             <td class=c1>Codigo Presupuestal</td>
             <td class=c2><b>'||codigo_pre||'</b></td>
             <td class=c3>Numero de Registro del Codigo Presupuestal</td>
            <tr>
            <tr>
             <td class=c1>Descripcion</td>
             <td class=c2><b>'||descrip_pre||'</b></td>
             <td class=c3>Descripcion del Codigo Presupuestal</td>
            <tr>
            <tr>
             <td class=c1>Monto Asignado</td>
             <td class=c2><input type=text name=ag_monto_codPre value=""></td>
             <td class=c3>Ingrese el Monto del Proyecto Asignado al Item</td>
            <tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
             <td align=center colspan=3>
                <input type="button" name="enviar" value="Enviar" onclick="Agregar('''||codigo_pre||''');">
              </td>
            </tr>
          </table>
           ');

       ELSE  

          SELECT proy_descripcion descripcion into descrip_pre
          FROM REG_PROCESOS.mef_proyectos 
          WHERE proy_codigo = codigo_pre
            and proy_estado = 'A';

          /*usp_print('anhoentidad: '||anhoentidad||'<br>');
          usp_print('entidad    : '||entidad||'<br>');
          usp_print('editar     : '||editar||'<br>');
          usp_print('codigo_pre : '||codigo_pre||'<br>');
          usp_print('descrip_pre: '||descrip_pre||'<br>');
          usp_print('convoca    : '||convoca||'<br>');
          usp_print('propuesta  : '||propuesta||'<br>');
          usp_print('monto      : '||monto||'<br>');
          usp_print('proc_item  : '||proc_item||'<br>');
          usp_print('Hola..........!!!!');
          return;*/

          INSERT INTO reg_procesos.tmp_contrato_op_cod_presu
          ( n_convoca      , anho_entidad  ,  cod_presupuestal, 
            descripcion    , monto_asignado,  proc_item,
            tipo_operacion , n_propuesta )
          VALUES
          ( convoca        , anhoentidad   ,  codigo_pre,
            descrip_pre    , monto         ,  proc_item,
            tipo_operacion , propuesta );
          COMMIT;

       usp_print('
       <script language=javascript>
           var wo = window.opener
           wo.RecargaContrato()
           window.close();
       </script>
       ');       
         --select * from reg_procesos.tmp_contrato_cod_presupuestal;
       END IF;   

  END IF;    

  usp_print('
  <script language=javascript>
    function IngresarCod(codigo,descripcion)
     { 
       var descrip = descripcion;
       var cod = codigo;
       thisform.codigo.value=cod;
       thisform.descripcion.value=descrip;
       thisform.edicion.value  = "1";
       thisform.scriptdo.value = "SearchCodPresupuestal";
       thisform.submit();
     }

    function Agregar(codigo)
     {
       thisform.codigo.value=codigo;
       thisform.edicion.value  = "2";
       thisform.scriptdo.value = "SearchCodPresupuestal";
       thisform.submit();
     }
  </script>
  '); 
       /*var wo = window.opener
       wo.RtnCatNU(codNU,value)
       window.close();*/

END;

/*******************************************************************************
/ Procedimiento : uspNewIntervencionEconomica
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Castañeda                          Version Inicial
/******************************************************************************/
PROCEDURE uspDoInsertIntervEco(
            session__userid                         varchar2 default null,
            session__N_CONVOCA                   varchar2 default null,
            session__COD_CONTRATO                varchar2 default null,
            session__seacedocument                  varchar2,
            session__seacedocumentosdwn             varchar2,
            WriteFileDirectoryDynamic               varchar2,
            session__FileSingedHTTP                 varchar2,
            session__maxMBUploadFileSize            varchar2,
            docname_mimetype                        varchar2,
            iisenv__remote_host                varchar,
            extension                               varchar2,
            ag_f_intervencion                       varchar2 default null,
            ag_cod_tipo_doc                         varchar2 default null,
            ag_resolInertv                          varchar2 default null,
            ag_f_resolInertv                        varchar2 default null,
            ag_causa_intervencion                   varchar2 default null,
            ag_apePatInertv                         varchar2 default null,
            ag_apeMatInertv                         varchar2 default null,
            ag_nomInertv                            varchar2 default null,
            ag_cargInertv                           varchar2 default null,
            ag_observInertv                         varchar2 default null,
            docname                                 varchar2 default null,
            session__anhoentidad                    varchar2 default null
)
IS
  ln_n_cod_contrato       number;
  ln_n_convoca            number;
  lv_codtipofile          varchar2(50);
  lv_cod_doc_intervencion varchar2(50);
  lv_NombreAprobador      varchar2(100);
  lv_ruta                 varchar2(200);
  ln_cod_tipo_doc         number;
  lvtipodocumento         varchar2(5);
  nError                  number;

BEGIN

  lv_cod_doc_intervencion := ag_resolInertv;
  ln_n_cod_contrato       := session__COD_CONTRATO;
  lvtipodocumento         := upper(substr(docname,length(docname)-2,length(docname)));
  lv_ruta                 := WriteFileDirectoryDynamic||'/'||docname;
  ln_cod_tipo_doc         := gpk_coddoc_intervencion;
  ln_n_convoca            := session__N_CONVOCA;

  select cod_tipo_file into lv_codtipofile from Reg_procesos.tipo_archivo where  ext_tipo_file = lvtipodocumento;

  begin
  insert into REG_PROCESOS.convocatoria_doc (
            n_convoca        , cod_tipo_doc , doc_url          , 
            cod_tipo_file    , doc_nombre   , user_upload      , 
            ip_from_upload   , nro_doc      , ape_pat_aprobador,
            ape_mat_aprobador, nom_aprobador, cargo_aprobador  , 
            fec_aprob        , doc_obs      , tamano_bytes, n_cod_contrato )
        values (
            ln_n_convoca  , ln_cod_tipo_doc, lv_ruta,
            lv_codtipofile, docname        , session__userid, 
            iisenv__remote_host, docname,ag_apePatInertv, 
            ag_apeMatInertv, ag_nomInertv, ag_cargInertv,
            sysdate, ag_observInertv, session__maxMBUploadFileSize,ln_n_cod_contrato );


  exception
   when others then
     nError := sqlcode;
     usp_print('ERROR:'||sqlerrm(nError));
   end;

  commit;

  update REG_PROCESOS.contrato set           
             fec_intervencion           =      ag_f_intervencion,
             FEC_RESOLUCION             =      ag_f_resolInertv,
             cod_documento_intervencion =      lv_cod_doc_intervencion,          
             cod_tipo_intervencion      =      ag_causa_intervencion,
             ape_pat_interventor        =      ag_apePatInertv,
             ape_mat_interventor        =      ag_apeMatInertv, 
             nom_interventor            =      ag_nomInertv,    
             cargo_interventor          =      ag_cargInertv          
       where n_cod_contrato             =      ln_n_cod_contrato;     


   /*usp_print('
   session__AG_N_CONVOCA        : '||session__AG_N_CONVOCA||'<BR>
   session__AG_COD_CONTRATO     : '||session__AG_COD_CONTRATO||'<BR>
   ag_f_intervencion            : '||ag_f_intervencion||'<br>
   ag_causa_intervencion        : '||ag_causa_intervencion||'<br>
   ag_apePatInertv              : '||ag_apePatInertv||'<br>
   ag_apeMatInertv              : '||ag_apePatInertv||'<br>
   ag_nomInertv                 : '||ag_nomInertv||'<br>
   ag_cargInertv                : '||ag_cargInertv||'<br> 
   doc_url                      : '||lv_ruta||'<br>
   doc_nombre                   : '||docname||'<br>
   session__maxMBUploadFileSize : '||session__maxMBUploadFileSize||'<br>
   session__IIS_REMOTE_ADDR     : '||session__IIS_REMOTE_ADDR||'<br>
   lvtipodocumento              : '||lvtipodocumento||'<br>
   lv_codtipofile               : '||lv_codtipofile||'<br>
           ');
  return;*/

   usp_print('
   <script language=javascript>
     retorna();
     function retorna()
     {
       thisform.scriptdo.value = "NewIntervencionEconomica"
       thisform.submit();
     }
   </script>
   ');

END;


PROCEDURE uspDoInsertIntervEco2(
            session__userid                         varchar2 default null,
            session__N_CONVOCA                   varchar2 default null,
            session__COD_CONTRATO                varchar2 default null,
            session__seacedocument                  varchar2,
            session__seacedocumentosdwn             varchar2,
            WriteFileDirectoryDynamic               varchar2,
            SizeFile                    varchar2 default null,
             pfiletoupload_file1              VARCHAR2 default null,
            pfiletoupload1                   VARCHAR2 default null,
            iisenv__remote_host                varchar,
            extension                               varchar2,
            ag_f_intervencion                       varchar2 default null,
            ag_cod_tipo_doc                         varchar2 default null,
            ag_resolInertv                          varchar2 default null,
            ag_f_resolInertv                        varchar2 default null,
            ag_causa_intervencion                   varchar2 default null,
            ag_apePatInertv                         varchar2 default null,
            ag_apeMatInertv                         varchar2 default null,
            ag_nomInertv                            varchar2 default null,
            ag_cargInertv                           varchar2 default null,
            ag_observInertv                         varchar2 default null,
            session__anhoentidad                    varchar2 default null
)
IS
  ln_n_cod_contrato       number;
  ln_n_convoca            number;
  lv_codtipofile          varchar2(50);
  lv_cod_doc_intervencion varchar2(50);
  lv_NombreAprobador      varchar2(100);
  lv_ruta                 varchar2(200);
  ln_cod_tipo_doc         number;
  lvtipodocumento         varchar2(5); 
  nError                  number;

BEGIN

  lv_cod_doc_intervencion := ag_resolInertv;
  ln_n_cod_contrato       := session__COD_CONTRATO;
  lvtipodocumento         := upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
  ln_cod_tipo_doc         := gpk_coddoc_intervencion;
  ln_n_convoca            := session__N_CONVOCA;

  select cod_tipo_file into lv_codtipofile from Reg_procesos.tipo_archivo where  ext_tipo_file = lvtipodocumento;

  begin
  insert into REG_PROCESOS.convocatoria_doc (
            n_convoca        , cod_tipo_doc , doc_url          , 
            cod_tipo_file    , doc_nombre   , user_upload      , 
            ip_from_upload   , nro_doc      , ape_pat_aprobador,
            ape_mat_aprobador, nom_aprobador, cargo_aprobador  , 
            fec_aprob        , doc_obs      , tamano_bytes, n_cod_contrato )
        values (
            ln_n_convoca  , ln_cod_tipo_doc, WriteFileDirectoryDynamic||'/'||pfiletoupload_file1,
            lv_codtipofile, pfiletoupload_file1        , session__userid, 
            iisenv__remote_host, lv_cod_doc_intervencion,ag_apePatInertv, 
            ag_apeMatInertv, ag_nomInertv, ag_cargInertv,
            sysdate, ag_observInertv, SizeFile,ln_n_cod_contrato );


  exception
   when others then
     nError := sqlcode;
     usp_print('ERROR:'||sqlerrm(nError));
   end;

  commit;

  update REG_PROCESOS.contrato set           
             fec_intervencion           =      ag_f_intervencion,
             FEC_RESOLUCION             =      ag_f_resolInertv,
             cod_documento_intervencion =      lv_cod_doc_intervencion,          
             cod_tipo_intervencion      =      ag_causa_intervencion,
             ape_pat_interventor        =      ag_apePatInertv,
             ape_mat_interventor        =      ag_apeMatInertv, 
             nom_interventor            =      ag_nomInertv,    
             cargo_interventor          =      ag_cargInertv          
       where n_cod_contrato             =      ln_n_cod_contrato;     


   /*usp_print('
   session__AG_N_CONVOCA        : '||session__AG_N_CONVOCA||'<BR>
   session__AG_COD_CONTRATO     : '||session__AG_COD_CONTRATO||'<BR>
   ag_f_intervencion            : '||ag_f_intervencion||'<br>
   ag_causa_intervencion        : '||ag_causa_intervencion||'<br>
   ag_apePatInertv              : '||ag_apePatInertv||'<br>
   ag_apeMatInertv              : '||ag_apePatInertv||'<br>
   ag_nomInertv                 : '||ag_nomInertv||'<br>
   ag_cargInertv                : '||ag_cargInertv||'<br> 
   doc_url                      : '||lv_ruta||'<br>
   doc_nombre                   : '||docname||'<br>
   session__maxMBUploadFileSize : '||session__maxMBUploadFileSize||'<br>
   session__IIS_REMOTE_ADDR     : '||session__IIS_REMOTE_ADDR||'<br>
   lvtipodocumento              : '||lvtipodocumento||'<br>
   lv_codtipofile               : '||lv_codtipofile||'<br>
           ');
  return;*/

   usp_print('
   <script language=javascript>
     retorna();
     function retorna()
     {
       thisform.scriptdo.value = "NewIntervencionEconomica"
       thisform.submit();
     }
   </script>
   ');

END;


/*******************************************************************************
/ Procedimiento : uspNewIntervencionEconomica
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Castañeda                          Version Inicial
/ Gerardo Millones      18/02/09 11:59    
/******************************************************************************/

PROCEDURE uspNewIntervencionEconomica(
      session__userid                varchar2 default null,
      session__N_CONVOCA          varchar2 default null,
      session__COD_CONTRATO       varchar2 default null,
      session__EUE_CODIGO            varchar2 default null,
      session__maxMBUploadFileSize   varchar2 default null,
      docname__mime                  varchar2 default null,
      session__FileSingedHTTP        varchar2 default null,
      session__FileSinged            varchar2 default null,
      WriteFileDirectoryDynamic      varchar2 default null,
      extension                      varchar2 default null,
      session__IIS_REMOTE_ADDR       varchar2 default null,
      session__anhoentidad           varchar2 default null,
      session__PUBLICADO             varchar2      
)
IS

 CURSOR cCausaIntervencion
 IS
 SELECT cod_tipo_intervencion, des_tipo_intervencion 
   FROM reg_procesos.t_tipo_intervencion;

 lv_directorio            varchar2(50);
 lv_ruta                  varchar2(50);
 lv_anhoentidad           varchar2(4);
 lv_eue_codigo            varchar2(50); 
 ln_n_convoca             varchar2(50);
 ln_n_cod_contrato        varchar2(50);
 ln_icon_tipo_file        varchar2(100); 
 ln_fec_upload            varchar2(100); 
 ln_doc_url               varchar2(100);

 v_file                  reg_procesos.convocatoria_doc%rowtype;
 filaContrato            reg_procesos.contrato%rowtype;
 LN_CODOBJETO            NUMBER;

BEGIN



   if session__COD_CONTRATO IS NOT NULL then
        ln_n_convoca := session__N_CONVOCA;
        ln_n_cod_contrato := session__COD_CONTRATO;
   else
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...',
                '')
        );
        return;
   end if;

   if( session__PUBLICADO <> 1 ) then
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Publique el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...',
                '')
     );
       return;    
    end if;


   lv_anhoentidad := session__anhoentidad;
   lv_eue_codigo := session__EUE_CODIGO;    
   lv_directorio := gpk_directorio_intervencion;
   lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||ln_n_convoca; 

   usp_print('
     <input name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=hidden>
     <input name=WriteFileDirectory value="FileSinged" type=hidden>
   ');

   pku_procesos_comun.dojscript;


   LN_CODOBJETO:= PKU_SS_UTILES.f_getcodobjeto(ln_n_convoca);

   select * into filaContrato
     from REG_PROCESOS.contrato 
    where n_cod_contrato = ln_n_cod_contrato; 


    ------- Se valida si le corresponde una liquidacion -----
    IF LN_CODOBJETO <> 3 THEN
        usp_print(
            pku_procesos_comun.f_putMensaje(
                '<font color="red">Una Intervencion Econ&oacute;mica se registra únicamente cuando el objeto es una ejecuci&oacute;n de Obra</font>',
                '')
        );
        RETURN;
    End If;


   begin

   select *  into v_file from (
        select * from reg_procesos.convocatoria_doc
         where n_cod_contrato = ln_n_cod_contrato
           and COD_TIPO_DOC = 800 
         order by fec_upload desc  
       )  where rownum = 1; 

   select replace('bootstrap/'||archivo.icon_tipo_file, 'jpg', 'png') icon_tipo_file
   --archivo.icon_tipo_file 
   into ln_icon_tipo_file
     from REG_PROCESOS.tipo_archivo archivo 
    where archivo.cod_tipo_file = v_file.cod_tipo_file;

   exception
        when no_data_found then
        v_file := null;
   end;


  usp_print('
   <script language=javascript>

    function enviar()
     {
         var extension = thisform.docname.value.substring(thisform.docname.value.length-4);
         extension = extension.replace(".","");
         if (!ValidarBlanco(thisform.ag_f_intervencion,"Fecha de la Intervención")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_resolInertv,"Numero de la Resolución de Intervención")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_f_resolInertv,"Fecha de Resolución de Intervención")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_causa_intervencion,"Seleccione el Tipo de Intervención")){
              return false;
         }
         if (!ValidarBlanco(thisform.docname,"Seleccione un documento")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_apePatInertv,"Apellido Paterno del Responsable")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_apeMatInertv,"Apellido Materno del Responsable")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_nomInertv,"Nombre del Responsable")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_cargInertv,"Cargo del Responsable")){
              return false;
         }
         if ( extension == "exe" || extension == "jsp"   || extension == "java" ||
              extension == "asp" || extension == "cgi"   || extension == "com"  ||
              extension == "js"  || extension == "class" || extension == "jar"  ||
              extension == "vbs" || extension == "aspx"  || extension == "dll"  ||
              extension == "mp3" || extension == "xml"   || extension == "xls"  ||
              extension == "sql" || extension == "txt"   || extension == "zip"  ||
              extension == "rar" || extension == "docx"  
            )
         {
            alert("Lo sentimos, el tipo de archivo que intenta grabar no esta permitido, Solo se admite los *.doc");
            return false;
         }
        else
         {
            thisform.extension.value = extension;
            thisform.scriptdo.value = "DoInsertIntervEco";
            thisform.submit();

         }
     }
   </script>

      <input type="hidden" value="" name="extension">
  ');

    usp_print('
        <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');

    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato(session__COD_CONTRATO, 'Ingreso de Intervención Económica' )
    );

    usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Grabar" OnClick=";enviar()">
            </td>
         </tr>
    </table>
    <br>
    <br>
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>
            <td><h3>Datos Generales</h3></td>
        </tr>
        <tr>
            <td class=c1>Número del Contrato Original</td>
            <td class=c2><b>'||session__COD_CONTRATO||'</b></td>
            <td class=c3>Numero del Contrato</td>
        </tr>
        <tr>
            <td class=c1>(*)Fecha de Intervención</td>
            <td class=c2>');
            if filacontrato.fec_intervencion is not null then
            usp_print('
              <input  class=CalSelect type=text size=50 name="ag_f_intervencion" onclick="calendario(this);" value="'|| filacontrato.fec_intervencion ||'">');
            else
            usp_print('
              <input  class=CalSelect type=text size=50 name="ag_f_intervencion" onclick="calendario(this);" value="">');
            end if;
            usp_print('  
            </td>
            <td class=c3>Ingrese la Fecha de Intervención.</td>
        </tr>
         <tr>   
            <td class=c1>(*)Resolucion de la Intervención</td>
            <td class=c2>');
            if filacontrato.fec_intervencion is not null then
            usp_print('
            <input name=ag_resolInertv value="'||trim(filacontrato.cod_documento_intervencion)||'" size=54 maxlength=18>
            ');
            else
            usp_print('
              <input name=ag_resolInertv value="" size=54 maxlength=18>');
            end if;
            usp_print('  
            </td>
            <td class=c3>Ingrese el número de la resolucion de intervención.</td>
         </tr>
         <tr>
            <td class=c1>(*)Fecha de la Resolución</td>
            <td class=c2>');
            if filacontrato.fec_resolucion is not null then 
            usp_print('
            <input  class=CalSelect type=text size=50 name="ag_f_resolInertv" onclick="calendario(this);" value="'||filacontrato.fec_resolucion||'">
            ');
            else
            usp_print('
              <input  class=CalSelect type=text size=50 name="ag_f_resolInertv" onclick="calendario(this);" value="">');
            end if;

            usp_print('</td>
            <td class=c3>Ingrese la Fecha de la Resolución de Intervención.</td>
        </tr>
        <tr>
            <td class=c1>(*)Causal de la Intervención</td>
            <td class=c2>
               <SELECT onchange="" name="ag_causa_intervencion" style="width:100%">
                <option value="">Seleccione</option> ');
            FOR xc IN cCausaIntervencion LOOP
              usp_print('
                <option value="'||xc.cod_tipo_intervencion||'"');
               if filacontrato.cod_tipo_intervencion = xc.cod_tipo_intervencion then
                usp_print('selected >'||xc.des_tipo_intervencion||'</option>');
               else
                usp_print('>'||xc.des_tipo_intervencion||'</option>');
               end if; 
            END LOOP;  

            usp_print('
               </SELECT>  
            </td>
            <td class=c3>Seleccione el tipo de Intervención.</td>
        </tr>
        <tr>
            <td class=c1>(*)Archivo de Resolución</td>
            <td class=c2>
              <input type=file name=docname value="" size=41>
              '||
                case when v_file.doc_url is not null then
                '<a target=_blank href="'||session__FileSingedHTTP||v_file.doc_url||'">
                    <img src="'||ln_icon_tipo_file||'" border="0" width="25" height="25"/>
                </a>' end ||
                case when v_file.fec_upload  is not null then
                ' Registrado el '||v_file.fec_upload end ||'
            </td>
            <td class=c3>Adjunte la Resolución de Intervención.</td>
        </tr>
        <tr>
            <td class=c1>Observaciones</td>
            <td class=c2>
              <input name=ag_observInertv value="" size=54 maxlength=150>
            </td>
            <td class=c3>Ingrese la Fecha de la Resolución de Intervención.</td>
        </tr>

    </table>
    <br>
    <br>
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>
            <td><h3>Datos del Interventor</h3></td>
        </tr>
        <tr>
            <td class=c1>(*)Apellido Paterno</td>
            <td class=c2>');
            if filaContrato.Ape_Pat_Interventor is null then
            usp_print('
              <input name=ag_apePatInertv value="" size=54 maxlength=18>');
            else
            usp_print('
              <input name=ag_apePatInertv value="'||filaContrato.Ape_Pat_Interventor||'" size=54 maxlength=18>');
            end if;    
            usp_print('
            </td>
            <td class=c3>Ingrese el Apellido Paterno del Interventor.</td>
         </tr>
         <tr>   
            <td class=c1>(*)Apellido Materno</td>
            <td class=c2>');
            if filacontrato.ape_mat_interventor is null then
            usp_print('
              <input name=ag_apeMatInertv value="" size=54 maxlength=18>');
            else
            usp_print('
              <input name=ag_apeMatInertv value="'||filacontrato.ape_mat_interventor||'" size=54 maxlength=18>');
            end if; 
            usp_print('               
            </td>
            <td class=c3>Ingrese el Apellido Materno del Interventor.</td>
         </tr>
         <tr>           
            <td class=c1>(*)Nombres</td>
            <td class=c2>');
            if filaContrato.Nom_Interventor is null then
            usp_print('
              <input name=ag_nomInertv value="" size=54 maxlength=18>');
            else
            usp_print('
              <input name=ag_nomInertv value="'||filaContrato.Nom_Interventor||'" size=54 maxlength=18>');
            end if; 
            usp_print(' 
            </td>
            <td class=c3>Ingrese los Nombres del Interventor.</td>
        </tr>
        <tr>        
            <td class=c1>(*)Cargo</td>
            <td class=c2>');
            if filacontrato.cargo_interventor is null then
            usp_print('
              <input name=ag_cargInertv value="" size=54 maxlength=18>');
            else
            usp_print('
              <input name=ag_cargInertv value="'||filacontrato.cargo_interventor||'" size=54 maxlength=18>');
            end if;
            usp_print('  
            </td>
            <td class=c3>Ingrese el Cargo del Interventor.</td>
        </tr>
    </table>    
    ');

END;


PROCEDURE uspNewIntervencionEconomica2(
      session__userid                varchar2 default null,
      session__N_CONVOCA          varchar2 default null,
      session__COD_CONTRATO       varchar2 default null,
      session__EUE_CODIGO            varchar2 default null,
      session__maxMBUploadFileSize   varchar2 default null,
      docname__mime                  varchar2 default null,
      session__FileSingedHTTP        varchar2 default null,
      session__FileSinged            varchar2 default null,
      WriteFileDirectoryDynamic      varchar2 default null,
      extension                      varchar2 default null,
      session__IIS_REMOTE_ADDR       varchar2 default null,
      session__anhoentidad           varchar2 default null,
      session__PUBLICADO             varchar2      
)
IS

 CURSOR cCausaIntervencion
 IS
 SELECT cod_tipo_intervencion, des_tipo_intervencion 
   FROM reg_procesos.t_tipo_intervencion;

 lv_directorio            varchar2(50);
 lv_ruta                  varchar2(50);
 lv_anhoentidad           varchar2(4);
 lv_eue_codigo            varchar2(50); 
 ln_n_convoca             varchar2(50);
 ln_n_cod_contrato        varchar2(50);
 ln_icon_tipo_file        varchar2(100); 
 ln_fec_upload            varchar2(100); 
 ln_doc_url               varchar2(100);

 v_file                  reg_procesos.convocatoria_doc%rowtype;
 filaContrato            reg_procesos.contrato%rowtype;
 LN_CODOBJETO            NUMBER;
     ln_modulo number;        -- (1/3) 12.09.2020 , permite verificar si las acciones sobre el contrato deben estas habilitados

BEGIN



   if session__COD_CONTRATO IS NOT NULL then
        ln_n_convoca := session__N_CONVOCA;
        ln_n_cod_contrato := session__COD_CONTRATO;
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


   lv_anhoentidad := session__anhoentidad;
   lv_eue_codigo := session__EUE_CODIGO;    
   lv_directorio := gpk_directorio_intervencion;
   lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||ln_n_convoca; 

   usp_print('
     <input name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=hidden>
     <input name=WriteFileDirectory value="FileSinged" type=hidden>
     <input type="hidden" name="SizeFile">
   ');

   pku_procesos_comun.dojscript;


   LN_CODOBJETO:= PKU_SS_UTILES.f_getcodobjeto(ln_n_convoca);

   select * into filaContrato
     from REG_PROCESOS.contrato 
    where n_cod_contrato = ln_n_cod_contrato; 


    ------- Se valida si le corresponde una liquidacion -----
    IF LN_CODOBJETO <> 3 THEN
        usp_print(
            pku_procesos_comun.f_putMensaje(
                '<font color="red">Una Intervencion Econ&oacute;mica se registra únicamente cuando el objeto es una ejecuci&oacute;n de Obra</font>',
                '')
        );
        RETURN;
    End If;


   begin

   select *  into v_file from (
        select * from reg_procesos.convocatoria_doc
         where n_cod_contrato = ln_n_cod_contrato
           and COD_TIPO_DOC = 800 
         order by fec_upload desc  
       )  where rownum = 1; 

   select replace('bootstrap/'||archivo.icon_tipo_file, 'jpg', 'png') icon_tipo_file
   --archivo.icon_tipo_file 
   into ln_icon_tipo_file
     from REG_PROCESOS.tipo_archivo archivo 
    where archivo.cod_tipo_file = v_file.cod_tipo_file;

   exception
        when no_data_found then
        v_file := null;
   end;


  usp_print('
   <script language=javascript>

    function enviar()
     {
       // alert("1");
         var extension = thisform.pfiletoupload1.value.substring(thisform.pfiletoupload1.value.length-4);
         extension = extension.replace(".","");
         if (!ValidarBlanco(thisform.ag_f_intervencion,"Fecha de la Intervención")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_resolInertv,"Numero de la Resolución de Intervención")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_f_resolInertv,"Fecha de Resolución de Intervención")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_causa_intervencion,"Seleccione el Tipo de Intervención")){
              return false;
         }
         if (!ValidarBlanco(thisform.pfiletoupload1,"Seleccione un documento")){
              return false;
         }

        if (!ValidarBlanco(thisform.ag_apePatInertv,"Apellido Paterno del Responsable")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_apeMatInertv,"Apellido Materno del Responsable")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_nomInertv,"Nombre del Responsable")){
              return false;
         }
         if (!ValidarBlanco(thisform.ag_cargInertv,"Cargo del Responsable")){
              return false;
         }
         if ( extension == "exe" || extension == "jsp"   || extension == "java" ||
              extension == "asp" || extension == "cgi"   || extension == "com"  ||
              extension == "js"  || extension == "class" || extension == "jar"  ||
              extension == "vbs" || extension == "aspx"  || extension == "dll"  ||
              extension == "mp3" || extension == "xml"   || extension == "xls"  ||
              extension == "sql" || extension == "txt"   || extension == "zip"  ||
              extension == "rar" || extension == "docx"  
            )
         {
            alert("Lo sentimos, el tipo de archivo que intenta grabar no esta permitido, Solo se admite los *.doc");
            return false;
         }
        else
         {
            thisform.extension.value = extension;
            extension = extension.replace(".", "");
            var namearchive="'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'."+extension;
            thisform.pfiletoupload_file1.value =namearchive;
            thisform.scriptdo.value = "DoInsertIntervEco";
            thisform.submit();

         }
     }
   </script>

      <input type="hidden" value="" name="extension">
  ');

    usp_print('
        <table border="0" width=100% align=center class=''table table-striped'' cellpadding=3 cellspacing=0>
        <tr>');

    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato(session__COD_CONTRATO, 'Ingreso de Intervención Económica' )
    );

    usp_print('
            <td align="right" valign=top width="50%">');
    -- (3/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
    if ln_modulo = 1 then             
       usp_print('           <input type="button" value="Grabar" OnClick=";enviar()">');
    end if; 
     usp_print('        </td>
         </tr>
    </table>
    <br>
    <br>
    <table border="0" width=100% align=center class=''table table-striped'' cellpadding=3 cellspacing=0>
        <tr>
            <td colspan=3><h3>Datos Generales</h3></td>
        </tr>
        <tr>
            <td class=c1>Número del Contrato Original</td>
            <td class=c2><b>'||session__COD_CONTRATO||'</b></td>
            <td class=c3>Numero del Contrato</td>
        </tr>

        <tr>
            <td class=c1>(*)Fecha de Intervenciónnn</td>
            <td class=c2>');
  --          if filacontrato.fec_intervencion is not null then
            usp_print('
            <div class="input-group datepicker" id="idDivTxtFechaIn">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
             <INPUT  type=text readonly style="width:70%" data-format="dd/MM/yyyy" class="form-control" id="ag_f_intervencion" name="ag_f_intervencion"  size="10"  value="'|| filacontrato.fec_intervencion ||'">
        </div>
             ');



            usp_print('  
            </td>
            <td class=c3>Ingrese la Fecha de Intervención.</td>
        </tr>
         <tr>   
            <td class=c1>(*)Resolucion de la Intervención</td>
            <td class=c2>');

            usp_print('
            <input name=ag_resolInertv value="'||trim(filacontrato.cod_documento_intervencion)||'" size=54 maxlength=18>
            ');
            usp_print('  
            </td>
            <td class=c3>Ingrese el número de la resolucion de intervención.</td>
         </tr>
         <tr>
            <td class=c1>(*)Fecha de la Resolución</td>
            <td class=c2>');
            usp_print('
             <div class="input-group datepicker" id="idDivTxtFechaRe">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
             <INPUT  type=text readonly style="width:70%" data-format="dd/MM/yyyy" class="form-control" id="ag_f_resolInertv" name="ag_f_resolInertv"  size="10"  value="'||filacontrato.fec_resolucion||'">
        </div>

        </td>
            <td class=c3>Ingrese la Fecha de la Resolución de Intervención.</td>
        </tr>
        <tr>
            <td class=c1>(*)Causal de la Intervención</td>
            <td class=c2>
               <SELECT onchange="" name="ag_causa_intervencion" style="width:100%">
                <option value="">Seleccione</option> ');
            FOR xc IN cCausaIntervencion LOOP
              usp_print('
                <option value="'||xc.cod_tipo_intervencion||'"');
               if filacontrato.cod_tipo_intervencion = xc.cod_tipo_intervencion then
                usp_print('selected >'||xc.des_tipo_intervencion||'</option>');
               else
                usp_print('>'||xc.des_tipo_intervencion||'</option>');
               end if; 
            END LOOP;  


            usp_print('
               </SELECT>  
            </td>
            <td class=c3>Seleccione el tipo de Intervención.</td>
        </tr>
        <tr>
            <td class=c1>(*)Archivo de Resolución</td>
            <td class=c2>
              <input type=file name=pfiletoupload1 value="" size=41>
              <input type="hidden" name="pfiletoupload_file1" value=""/>
              '||
                case when v_file.doc_url is not null then
                '<a target=_blank href="'||url_azure_app||v_file.doc_url||'">
                    <img src="'||ln_icon_tipo_file||'" border="0" width="25" height="25"/>
                </a>' end ||
                case when v_file.fec_upload  is not null then
                ' Registrado el '||v_file.fec_upload end ||'
            </td>
            <td class=c3>Adjunte la Resolución de Intervención.</td>
        </tr>
        <tr>
            <td class=c1>Observaciones</td>
            <td class=c2>
              <input name=ag_observInertv value="" size=54 maxlength=150>
            </td>
            <td class=c3>Ingrese la Fecha de la Resolución de Intervención.</td>
        </tr>

    </table>
    <br>
    <br>
    <table border="0" width=100% align=center class=''table table-striped'' cellpadding=3 cellspacing=0>
        <tr>
            <td colspan=3><h3>Datos del Interventor</h3></td>
        </tr>
        <tr>
            <td class=c1>(*)Apellido Paterno</td>
            <td class=c2>');
            usp_print('
              <input name=ag_apePatInertv value="'||filaContrato.Ape_Pat_Interventor||'" size=54 maxlength=18>');
            usp_print('
            </td>
            <td class=c3>Ingrese el Apellido Paterno del Interventor.</td>
         </tr>
         <tr>   
            <td class=c1>(*)Apellido Materno</td>
            <td class=c2>');
            usp_print('
              <input name=ag_apeMatInertv value="'||filacontrato.ape_mat_interventor||'" size=54 maxlength=18>');
            usp_print('               
            </td>
            <td class=c3>Ingrese el Apellido Materno del Interventor.</td>
         </tr>
         <tr>           
            <td class=c1>(*)Nombres</td>
            <td class=c2>');
            usp_print('
              <input name=ag_nomInertv value="'||filaContrato.Nom_Interventor||'" size=54 maxlength=18>');
           usp_print(' 
            </td>
            <td class=c3>Ingrese los Nombres del Interventor.</td>
        </tr>
        <tr>        
            <td class=c1>(*)Cargo</td>
            <td class=c2>');
            usp_print('
              <input name=ag_cargInertv value="'||filacontrato.cargo_interventor||'" size=54 maxlength=18>');
            usp_print('  
            </td>
            <td class=c3>Ingrese el Cargo del Interventor.</td>
        </tr>
    </table>    
    ');

END;

/* TIPO DE PROCESOS*/

function f_get_tipo_proc_ent (pv_select varchar2,  gv_entidad VARCHAR2 , gv_evento varchar2,anho varchar2) 
    return varchar
is
    lv_rtn varchar(32000):= '';
  cursor c_tipo_procesos is

  select tp.proc_tipo, tp.proc_tipo_sigla,
           decode(pv_select, tp.proc_tipo, 1 ,0) actual
        from (

        select distinct c.codconsucode, c.anhoentidad, tp.proc_tipo, tp.proc_tipo_sigla
          from reg_procesos.tipo_procesos tp, convocatorias c
          where tp.proc_tipo = c.proc_tipo
          union
          select lpad(to_char(etp.eue_codigo),6,'0') codconsucode, to_char(etp.eue_anho) anhoentidad, tp.proc_tipo, tp.proc_tipo_sigla
          from reg_procesos.tipo_procesos tp, reg_procesos.entidadue_anho_tipo_proceso etp
          where tp.proc_tipo = etp.tip_codigo
            and tp.Proc_Tipo NOT IN (22)
        ) tp
        where  tp.codconsucode   = lpad(gv_entidad,6,'0')
           and tp.anhoentidad    = anho;

/*    select tp.proc_tipo, tp.proc_tipo_sigla,
           decode(pv_select, tp.proc_tipo, 1 ,0) actual
        from reg_procesos.mvw_tipo_proceso_entidad tp
        where  tp.codconsucode   = lpad(gv_entidad,6,'0')
           and tp.anhoentidad    = anho;*/
begin

     lv_rtn:='<select name="v_proc_tipo" >';
     for item in  c_tipo_procesos loop
      lv_rtn:=lv_rtn||'<option  value="'||item.proc_tipo||'" '||(case when item.proc_tipo=pv_select then 'selected' else '' end)||'>'
      ||item.proc_tipo_sigla||'</option>';
     end loop;
     return lv_rtn||'</select>';


end;



procedure usp_get_siglas_proceso (
    v_entidad       varchar2,
    v_anhoentidad   varchar2,
    v_select        varchar2 )
is
    cursor c_siglas is
    select distinct s.codconsucode, s.anhoentidad, s.sigla_des, s.ind_proc_electr
    from t_entidades_siglas s
    where s.codconsucode = lpad(v_entidad,6,'0') and s.anhoentidad = v_anhoentidad
    order by s.sigla_des;
begin
    usp_print('
             <select  name="v_proc_sigla" id="v_proc_sigla">
                   <option value="">&nbsp;</option>
');
    for item in c_siglas loop
        usp_print('
                <option value="'||item.sigla_des||'" '||(case when item.sigla_des = v_select then 'selected' else '' end)||'>'||item.sigla_des||'</option>
        ');
    end loop;
    usp_print('
            </select>

   ');
end;


/******************* PROCEDIMIENTOS ********************************/
/*
    Muestra la Consola Principal de los Contratos y Permite Realizar
    la Busqueda de los Contratos según los criterios: tipo de proceso,
    descripcion del proceso, siglas del proceso.
*/
PROCEDURE uspLisProcesosDoView (
    v_proc_tipo                 varchar2 DEFAULT NULL,
    ag_descripcion              varchar2 DEFAULT NULL,
    ag_currentpage              varchar2 DEFAULT 1,
    session__eue_codigo         varchar2,
    session__anhoentidad        varchar2,
    panho                       varchar2,
    v_proc_sigla                    varchar2
)
IS
    ------- Convocatorias -------
  --   for cv in c_convoca( lv_eue_codigo, lv_anhoentidad, v_proc_tipo, lv_proc_sigla, ag_descripcion, lv_currentPage, lv_PageSize ) loop
    Cursor c_convoca(
        p_eue_codigo in varchar2, p_anhoentidad in varchar2, p_proc_tipo   in varchar2,
        p_proc_sigla in varchar2, p_proc_desc   in varchar2, p_CurrentPage number,
        p_session_pagesize number ) is


    select * from (
        select rownum num, a.* from (    
        Select distinct
                   a.n_convoca_origen n_convoca,
                   a.n_convoca n_convoca_ultimo,
                   a.n_proceso,
                   decode (a.num_convoca,
                        1, '1ra',
                        2, '2da',
                        3, '3ra',
                        4, '4ta',
                        5, '5ta',
                        6, '6ta',
                        7, '7ma',
                        '')
                      num_convoca,
                      decode(nvl(b.eue_codigo,to_number(a.codconsucode)),
                      to_number(a.codconsucode),0,1) ind_otra_entidad,        
                      a.cod_tipo_modalidad,
                      m.mon_desc,
                      tp.tip_desc, 
                      tp.tip_abrev||ts.sigla_abrev tip_abrev,
                      a.proc_tipo,
                      a.proc_num,
                      a.anhoentidad,
                      a.proc_sigla,
                      a.des_objeto,
                      a.n_feerrata,
                      a.observaciones,
                      a.ind_part_electronica,
                      --to_char(a.f_registro,'dd/mm/yyyy') f_registro,
                      to_char(a.f_publica,'dd/mm/yyyy')  f_publica,
                      a.codmoneda,
                      a.v_referencial,
                      a.ind_conv_ultimo_pub ind_estado,      
                      REG_PROCESOS.F_GET_NUM_GANADORES_BP(a.n_convoca_origen) buenapro,
                      REG_PROCESOS.F_GET_TIPO_PROC_DERIV(a.n_proceso) cant_deriv,

                      nvl(p.reg_codigo, 0) reg_codigo,
                      nvl(p.ley_codigo, 0) ley_codigo  
            from REG_PROCESOS.convocatorias a,
                 REG_PROCESOS.convocatoria_item_plan b,
                 REG_PROCESOS.t_tipo_subasta ts,
                 SEASE.moneda m, 
                 SEASE.tipo_proceso tp  ,
                 reg_procesos.procesos p                         
            where a.n_convoca = b.n_convoca(+)
              and (a.codconsucode = lpad(p_eue_codigo,6,'0') or (a.codconsucode != lpad(p_eue_codigo,6,'0') and b.eue_codigo = p_eue_codigo ))
              and a.anhoentidad =p_anhoentidad    
              /*and a.ind_proc_tipo_ultimo = decode(nvl(b.eue_codigo,to_number(a.codconsucode)),to_number(a.codconsucode),1,0)*/
              and a.proc_tipo    = p_proc_tipo
              and p.n_id_expede is null
              and exists(
                        select ice.cod_tipo_estado_item, tei.des_tipo_estado_item
                        from REG_PROCESOS.item_convoca_estado ice, REG_PROCESOS.tipo_estado_item tei
                        where ice.n_convoca =  a.n_convoca
                          and ice.cod_tipo_estado_item = 500                        
                          and ice.cod_tipo_estado_item = tei.cod_tipo_estado_item
                          and f_registro               = (select max(f_registro) from REG_PROCESOS.item_convoca_estado i
                                                           where i.n_convoca = ice.n_convoca
                                                           and i.proc_item = ice.proc_item)
                      )        
               and (p_proc_sigla is null or upper(a.proc_sigla) = p_proc_sigla )
               and (p_proc_desc is null or UPPER(a.des_objeto)||a.proc_num like '%'||UPPER(p_proc_desc)||'%' )                      
               and m.mon_codigo = a.codmoneda       
               and tp.tip_codigo = a.proc_tipo
               and ts.cod_tipo_subasta = a.cod_tipo_subasta
         and p.n_proceso = a.n_proceso
               order by a.anhoentidad, a.proc_num, a.proc_sigla

                ) a
     ) b
     where b.num between p_session_pagesize*(p_CurrentPage-1) + 1
     and p_session_pagesize*(p_CurrentPage);       



   /* select * from (
        select rownum num, a.* from (
            Select distinct 
                   a.n_convoca_origen n_convoca,
                   a.n_convoca n_convoca_ultimo,
                   a.n_proceso,
                   decode (a.num_convoca,
                        1, '1ra',
                        2, '2da',
                        3, '3ra',
                        4, '4ta',
                        5, '5ta',
                        6, '6ta',
                        7, '7ma',
                        '')
                   num_convoca,
                   decode(nvl(b.eue_codigo,
                   to_number(a.codconsucode)),
                   to_number(a.codconsucode),0,1) ind_otra_entidad,        
                   a.cod_tipo_modalidad,
                   m.mon_desc, 
                   tp.tip_desc, 
                   tp.tip_abrev||ts.sigla_abrev tip_abrev,
                   a.proc_tipo,
                   a.proc_num,
                   a.anhoentidad,
                   a.proc_sigla,
                   a.des_objeto,
                   a.n_feerrata,
                   a.observaciones,
                   a.ind_part_electronica,
                   to_char(a.f_publica,'dd/mm/yyyy')  f_publica,
                   a.codmoneda,
                   a.v_referencial,
                   a.ind_conv_ultimo_pub ind_estado,      
                   REG_PROCESOS.F_GET_NUM_GANADORES_BP(a.n_convoca_origen) buenapro,
                   REG_PROCESOS.F_GET_TIPO_PROC_DERIV(a.n_proceso) cant_deriv   
            from REG_PROCESOS.convocatorias a,
                 REG_PROCESOS.convocatoria_item_plan b,
                 REG_PROCESOS.t_tipo_subasta ts,
                 SEASE.moneda m, 
                 SEASE.tipo_proceso tp                         
            where a.n_convoca = b.n_convoca(+)
              and (a.codconsucode = lpad(p_eue_codigo,6,'0') 
                   --or (a.codconsucode != lpad(p_eue_codigo,6,'0') and b.eue_codigo = p_eue_codigo )
                   )
              and a.anhoentidad = p_anhoentidad      
              \*and a.ind_proc_tipo_ultimo = decode(nvl(b.eue_codigo,to_number(a.codconsucode)),to_number(a.codconsucode),1,0)*\
              and a.proc_tipo    = p_proc_tipo
              and exists(
                        select ice.cod_tipo_estado_item, tei.des_tipo_estado_item
                        from REG_PROCESOS.item_convoca_estado ice, REG_PROCESOS.tipo_estado_item tei
                        where ice.n_convoca =  a.n_convoca
                          and ice.cod_tipo_estado_item = 500                        
                          and ice.cod_tipo_estado_item = tei.cod_tipo_estado_item
                          and f_registro               = (select max(f_registro) from REG_PROCESOS.item_convoca_estado i
                                                           where i.n_convoca = ice.n_convoca
                                                           and i.proc_item = ice.proc_item)
                      )        
               and (p_proc_sigla is null or upper(a.proc_sigla) = upper(p_proc_sigla) )
               and (p_proc_desc is null or to_char(a.proc_num) = p_proc_desc or UPPER(a.des_objeto) like '%'||UPPER(p_proc_desc)||'%' ) 
               and m.mon_codigo = a.codmoneda       
               and tp.tip_codigo = a.proc_tipo
               and ts.cod_tipo_subasta = a.cod_tipo_subasta
               and a.ind_conv_ultimo_pub = 1

union

 select a.n_convoca_origen n_convoca,
        a.n_convoca n_convoca_ultimo,
        a.n_proceso,
        a.num_convoca,
        null ind_otra_entidad,
        a.cod_tipo_modalidad,
        a.mon_desc,
        a.tip_desc,a.proc_sigla tip_abrev,
        a.proc_tipo,
        a.proc_num,
        a.anhoentidad,
        a.proc_sigla,
        a.des_objeto,
        a.n_feerrata,
        a.observaciones,
        a.ind_part_electronica,
        a.f_publica,
        a.codmoneda,
        a.v_referencial,
        a.ind_conv_ultimo_pub ind_estado,
        REG_PROCESOS.F_GET_NUM_GANADORES_BP(a.n_convoca_origen) buenapro,
        REG_PROCESOS.F_GET_TIPO_PROC_DERIV(a.n_proceso) cant_deriv          

         from
         VW_PROCESOSCONVO_CORPORATIVAS a
         inner join reg_procesos.t_tipo_subasta b on a.cod_tipo_subasta=b.cod_tipo_subasta
         where a.entidad_part = lpad(p_eue_codigo,6,'0')
         and a.anhoentidad= p_anhoentidad
         and (p_proc_sigla is null or upper(a.proc_sigla) = upper(p_proc_sigla) )
         and (p_proc_desc is null or to_number(a.proc_num) = to_number(p_proc_desc) or UPPER(a.des_objeto) like '%'||UPPER(p_proc_desc)||'%' ) 
         and a.ind_conv_ultimo_pub = 1
         and A.IND_CONV_ULTIMO     = 1
         and a.proc_tipo           = p_proc_tipo
         and a.proc_tipo not in (10,11,23) 
         and exists(
                    select ice.cod_tipo_estado_item, tei.des_tipo_estado_item
                    from REG_PROCESOS.item_convoca_estado ice, REG_PROCESOS.tipo_estado_item tei
                    where ice.n_convoca =  a.n_convoca
                      and ice.cod_tipo_estado_item = 500                        
                      and ice.cod_tipo_estado_item = tei.cod_tipo_estado_item
                      and f_registro               = (select max(f_registro) from REG_PROCESOS.item_convoca_estado i
                                                       where i.n_convoca = ice.n_convoca
                                                       and i.proc_item = ice.proc_item)
                  )        

--               order by a.anhoentidad, a.proc_num, a.proc_sigla
        ) a
     ) b
     where b.num between p_session_pagesize*(p_CurrentPage-1) + 1
     and p_session_pagesize*(p_CurrentPage);
*/


    ------- Variables --------
    lv_eue_codigo       varchar2(6);
    lv_anhoentidad      varchar2(4);
    lv_CurrentPage      number;
    lv_PageSize         number;
    ln_Cant_Procesos    number;
    ln_cont             number:=0;
    ln_cant_doc         number;
/*    lv_proc_sigla       varchar2(60);
*/    lv_proc_desc        varchar2(250);
    e_ArgumentosMalos   exception;
    lv_numeropaginas    integer NOT NULL DEFAULT 0;
    lv_iterador         number  NOT NULL DEFAULT 0;
    ln_color            varchar(50);
BEGIN

--usp_print('session__eue_codigo:'||length(trim(session__eue_codigo)||'.'));
--return;
  if length(trim(session__eue_codigo)||'.') = 1 then

  usp_print('<center>Para visualizar la Consola de Contratos debe seleccionar una Entidad</center>');
  return;
  end if;
    ---------- Script -------------
    usp_print('
    <script language="javascript">

    function SinContrato()
    {
      alert("Antes de registrar en la ficha de Creacion de Contrato, deberá adjuntar el archivo del\n  contrato u orden de compra o servicio");

    }

    function EnviarResumen(convocatoria,tipodoc)
    { 
       var pag = window.open("ControllerServletOpen?portletid=mod_popup_contratos&scriptdo=doAddResumen&ag_n_convoca="+ convocatoria +"&ag_cod_tipo_doc="+ tipodoc,"Items","toolbar=no,Width=750,Height=220,scrollbars=yes,modal=yes,dependent,alwaysRaised");
       return pag;
    }


    function EnviarDatos(jscriptdo)
    {
        thisform.ag_currentPage.value = 1;
        thisform.scriptdo.value=jscriptdo;
        thisform.submit();
    }

    function VerContrato(entidad,codigo,convoca,tipo,descripcion,currentpage)
    {
        thisform.ag_n_convoca.value = convoca;
        thisform.ag_proc_tipo.value = tipo;
        thisform.ag_proc_desc.value = descripcion;
        thisform.ag_currentPage.value = currentpage;
        thisform.scriptdo.value="PKU_GESTOR_CONT_MAKE_CONTRATOS.usplistcontratosdoview";
        thisform.submit();
    }
    </script> ');

    usp_print ('<SESSION_EXPORT>
                    <AG_N_CONVOCA>'||NULL||'</AG_N_CONVOCA>
                    <N_CONVOCA>'||NULL||'</N_CONVOCA>
                    <AG_COD_CONTRATO>'||NULL||'</AG_COD_CONTRATO>
                    <COD_CONTRATO>'||NULL||'</COD_CONTRATO>
                </SESSION_EXPORT>');

    -------- Input Cabecera hidden -----------------
    lv_anhoentidad := nvl(panho,session__anhoentidad);
    lv_eue_codigo  := session__eue_codigo;

    usp_print('
    <input type="hidden" name="ag_n_convoca"   value="">
    <input type="hidden" name="ag_proc_tipo"   value="'||v_proc_tipo||'">
    <input type="hidden" name="ag_currentPage" value="'||ag_currentpage||'"> ');


    -- Para la paginación
    lv_CurrentPage := to_number(ag_currentpage);
    lv_PageSize := to_number(10);

    if ( lv_currentPage is null ) or ( lv_currentPage = '' ) then
        lv_currentPage := 1;
    end if;

    -------- Cabecera de la Consola -----------------
    usp_print('
    <table border="0" class="table table-striped" cellpadding="3" cellspacing="0" width="100%">
        <tr>
            <td class="page-header"><h3>Buscador de Procesos</h3></td>
            <td><b>Año:</b>
                '||reg_procesos.pku_ss_utiles.f_get_anhos( lv_anhoentidad, session__eue_codigo )||'</td>');
                usp_print('<td>'||'<b>Tipo:</b>
                '||f_get_tipo_proc_ent( v_proc_tipo, session__eue_codigo  , 'doView',  lv_anhoentidad   )||'</td>');
                usp_print('<td><b>Descripci&oacute;n:</b><input type="text" name="ag_descripcion" value="' || ag_descripcion ||'"></td><td><b>Sigla:</b>');
                usp_get_siglas_proceso(session__eue_codigo,lv_anhoentidad,v_proc_sigla);
                usp_print('</td><td><input type="button" value="Buscar" onclick="EnviarDatos(''doView'')">
            </td>
        </tr>
    </table>
    ');
    --------------- Cargar Datos de la Consulta -----------------------
    ------- Contar la cantidad de Registros -----
    Select Count(1)
    Into ln_Cant_Procesos
    From (

       Select distinct
                   a.n_convoca_origen n_convoca,
                   a.n_convoca n_convoca_ultimo,
                   a.n_proceso,
                   decode (a.num_convoca,
                        1, '1ra',
                        2, '2da',
                        3, '3ra',
                        4, '4ta',
                        5, '5ta',
                        6, '6ta',
                        7, '7ma',
                        '')
                      num_convoca,
                      decode(nvl(b.eue_codigo,to_number(a.codconsucode)),
                      to_number(a.codconsucode),0,1) ind_otra_entidad,        
                      a.cod_tipo_modalidad,
                      m.mon_desc, 
                      tp.tip_desc, 
                      tp.tip_abrev||ts.sigla_abrev tip_abrev,
                      a.proc_tipo,
                      a.proc_num,
                      a.anhoentidad,
                      a.proc_sigla,
                      a.des_objeto,
                      a.n_feerrata,
                      a.observaciones,
                      a.ind_part_electronica,
                      --to_char(a.f_registro,'dd/mm/yyyy') f_registro,
                      to_char(a.f_publica,'dd/mm/yyyy')  f_publica,
                      a.codmoneda,
                      a.v_referencial,
                      a.ind_conv_ultimo_pub ind_estado,      
                      REG_PROCESOS.F_GET_NUM_GANADORES_BP(a.n_convoca_origen) buenapro,
                      REG_PROCESOS.F_GET_TIPO_PROC_DERIV(a.n_proceso) cant_deriv,

                      nvl(p.reg_codigo, 0) reg_codigo,
                      nvl(p.ley_codigo, 0) ley_codigo  
            from REG_PROCESOS.convocatorias a,
                 REG_PROCESOS.convocatoria_item_plan b,
                 REG_PROCESOS.t_tipo_subasta ts,
                 SEASE.moneda m, 
                 SEASE.tipo_proceso tp  ,
                 reg_procesos.procesos p                         
            where a.n_convoca = b.n_convoca(+)
              and (a.codconsucode = lpad(lv_eue_codigo,6,'0') or (a.codconsucode != lpad(lv_eue_codigo,6,'0') and b.eue_codigo = lv_eue_codigo ))
              and a.anhoentidad =lv_anhoentidad    
              /*and a.ind_proc_tipo_ultimo = decode(nvl(b.eue_codigo,to_number(a.codconsucode)),to_number(a.codconsucode),1,0)*/
              and a.proc_tipo    = v_proc_tipo
              and p.n_id_expede is null
              and exists(
                        select ice.cod_tipo_estado_item, tei.des_tipo_estado_item
                        from REG_PROCESOS.item_convoca_estado ice, REG_PROCESOS.tipo_estado_item tei
                        where ice.n_convoca =  a.n_convoca
                          and ice.cod_tipo_estado_item = 500                        
                          and ice.cod_tipo_estado_item = tei.cod_tipo_estado_item
                          and f_registro               = (select max(f_registro) from REG_PROCESOS.item_convoca_estado i
                                                           where i.n_convoca = ice.n_convoca
                                                           and i.proc_item = ice.proc_item)
                      )        
               and (v_proc_sigla is null or upper(a.proc_sigla) = v_proc_sigla )
               and (ag_descripcion is null or UPPER(a.des_objeto)||a.proc_num like '%'||UPPER(ag_descripcion)||'%' )                      
               and m.mon_codigo = a.codmoneda       
               and tp.tip_codigo = a.proc_tipo
               and ts.cod_tipo_subasta = a.cod_tipo_subasta
         and p.n_proceso = a.n_proceso
               order by a.anhoentidad, a.proc_num, a.proc_sigla


    /*  Select distinct 
                   a.n_convoca_origen n_convoca,a.n_convoca n_convoca_ultimo,a.n_proceso,
                   decode (a.num_convoca,
                        1, '1ra',
                        2, '2da',
                        3, '3ra',
                        4, '4ta',
                        5, '5ta',
                        6, '6ta',
                        7, '7ma',
                        '')
                      num_convoca,
                      decode(nvl(b.eue_codigo,to_number(a.codconsucode)),to_number(a.codconsucode),0,1) ind_otra_entidad,        
                      a.cod_tipo_modalidad,m.mon_desc, tp.tip_desc, 
                      tp.tip_abrev||ts.sigla_abrev tip_abrev,a.proc_tipo,a.proc_num,a.anhoentidad,
                      a.proc_sigla,a.des_objeto,a.n_feerrata,a.observaciones,a.ind_part_electronica,
                      --to_char(a.f_registro,'dd/mm/yyyy') f_registro,
                      to_char(a.f_publica,'dd/mm/yyyy')  f_publica,a.codmoneda,a.v_referencial,
                      a.ind_conv_ultimo_pub ind_estado,      
                      REG_PROCESOS.F_GET_NUM_GANADORES_BP(a.n_convoca_origen) buenapro,
                      REG_PROCESOS.F_GET_TIPO_PROC_DERIV(a.n_proceso) cant_deriv    
            from REG_PROCESOS.convocatorias a,
                 REG_PROCESOS.convocatoria_item_plan b,
                 REG_PROCESOS.t_tipo_subasta ts,
                 SEASE.moneda m, 
                 SEASE.tipo_proceso tp                         
            where a.n_convoca = b.n_convoca(+)
              and (a.codconsucode = lpad(lv_eue_codigo,6,'0') 
                   --or (a.codconsucode != lpad(lv_eue_codigo,6,'0') and b.eue_codigo = lv_eue_codigo )
                   )
              and a.anhoentidad = lv_anhoentidad      
              \*and a.ind_proc_tipo_ultimo = decode(nvl(b.eue_codigo,to_number(a.codconsucode)),to_number(a.codconsucode),1,0)*\
              and a.proc_tipo    = lv_proc_tipo
              and exists(
                        select ice.cod_tipo_estado_item, tei.des_tipo_estado_item
                        from REG_PROCESOS.item_convoca_estado ice, REG_PROCESOS.tipo_estado_item tei
                        where ice.n_convoca =  a.n_convoca
                          and ice.cod_tipo_estado_item = 500                        
                          and ice.cod_tipo_estado_item = tei.cod_tipo_estado_item
                          and f_registro               = (select max(f_registro) from REG_PROCESOS.item_convoca_estado i
                                                           where i.n_convoca = ice.n_convoca
                                                           and i.proc_item = ice.proc_item)
                      )        
               and (lv_proc_sigla is null or upper(a.proc_sigla) = upper(lv_proc_sigla) )
               and (ag_descripcion is null or to_char(a.proc_num) = ag_descripcion or   UPPER(a.des_objeto) like '%'||UPPER(ag_descripcion)||'%' ) 
               and m.mon_codigo = a.codmoneda       
               and tp.tip_codigo = a.proc_tipo
               and ts.cod_tipo_subasta = a.cod_tipo_subasta


union

 select a.n_convoca_origen n_convoca,
        a.n_convoca n_convoca_ultimo,
        a.n_proceso,
        a.num_convoca,
        null ind_otra_entidad,
        a.cod_tipo_modalidad,
        a.mon_desc,
        a.tip_desc,a.proc_sigla tip_abrev,
        a.proc_tipo,
        a.proc_num,
        a.anhoentidad,
        a.proc_sigla,
        a.des_objeto,
        a.n_feerrata,
        a.observaciones,
        a.ind_part_electronica,
        a.f_publica,
        a.codmoneda,
        a.v_referencial,
        a.ind_conv_ultimo_pub ind_estado,
        REG_PROCESOS.F_GET_NUM_GANADORES_BP(a.n_convoca_origen) buenapro,
        REG_PROCESOS.F_GET_TIPO_PROC_DERIV(a.n_proceso) cant_deriv          

         from
         VW_PROCESOSCONVO_CORPORATIVAS a
         inner join reg_procesos.t_tipo_subasta b on a.cod_tipo_subasta=b.cod_tipo_subasta
         where a.entidad_part = lpad(lv_eue_codigo,6,'0')
         and a.anhoentidad= lv_anhoentidad
         and (lv_proc_sigla is null or upper(a.proc_sigla) = upper(lv_proc_sigla) )
         and (ag_descripcion is null or to_number(a.proc_num) = to_number(ag_descripcion) or UPPER(a.des_objeto) like '%'||UPPER(ag_descripcion)||'%' ) 
         and a.ind_conv_ultimo_pub = 1
         and A.IND_CONV_ULTIMO     = 1
         and a.proc_tipo           = lv_proc_tipo
         and a.proc_tipo not in (10,11,23) 
         and exists(
                    select ice.cod_tipo_estado_item, tei.des_tipo_estado_item
                    from REG_PROCESOS.item_convoca_estado ice, REG_PROCESOS.tipo_estado_item tei
                    where ice.n_convoca =  a.n_convoca
                      and ice.cod_tipo_estado_item = 500                        
                      and ice.cod_tipo_estado_item = tei.cod_tipo_estado_item
                      and f_registro               = (select max(f_registro) from REG_PROCESOS.item_convoca_estado i
                                                       where i.n_convoca = ice.n_convoca
                                                       and i.proc_item = ice.proc_item)

             )    */                                      
            );


    usp_print('<table border="1" class="table table-striped table-bordered table-hover data Table no-footer" cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
        <tr align="center" valign = "top">
            <th class="th1">N&uacute;mero<br/>de Convocatoria</th>
            <th class="th1">Proceso</th>
            <th class="th1">Valor Referencial</th>
       </tr>');

    If (ln_Cant_Procesos > 0) Then

        For cv in c_convoca( lv_eue_codigo, lv_anhoentidad, v_proc_tipo, v_proc_sigla, ag_descripcion, lv_currentPage, lv_PageSize ) loop
            ln_cont:= ln_cont + 1;
            If mod(ln_cont,2) = 0 then
                ln_color := 'bgcolor="#ECE9D8"'; 
            Else
                ln_color := ''; 
            End if;

            -- obtenemos la cantidad de cuadros resumen ya cargados en el proceso
            SELECT count(1) INTO ln_cant_doc
            from REG_PROCESOS.convocatoria_doc
            where cod_tipo_doc = 600 and n_convoca = cv.n_convoca;

        ------ 1era Fila ----
            usp_print('
        <tr '||ln_color||' valign="top">
            <td align="center" rowspan="2">');
            If ( cv.ind_part_electronica = 1 ) Then
                usp_print('<img src="'||gpk_ImagenElectron||'"/><br>');
            End If;
            if (cv.n_convoca != 0) then
                usp_print(cv.num_convoca);
            end if;

            usp_print('
            </td>
            <td align="left" valign="top" nowrap="" colspan="3"> ');
                usp_print('<b>'||makea('ag_n_convoca='||cv.n_convoca||'&ag_proc_tipo='||v_proc_tipo||'&ag_proc_desc=&ag_proc_sigla=&ag_currentPage='||ag_currentpage ||'&av_ind_resumen='||case when ln_cant_doc > 0 then '1' else '0' end ||'&scriptdo=doViewConsolaContratos',cv.tip_abrev||'-'||cv.proc_num||'-'||cv.anhoentidad||'-'||cv.proc_sigla)||'&#xa0;</b> ');

            if (cv.cant_deriv is not null) then
                usp_print('<img src="'||gpk_AdvancingR2||'" border="0" heigth="10" width="10"/>&#xa0; (<b>'||cv.cant_deriv||'</b>)&#xa0;');
            end if;

            if (cv.ind_otra_entidad = 1) then
                usp_print('<b>(PROCESO REALIZADO POR OTRA ENTIDAD)</b>&#xa0;');
            end if;
            if (cv.cod_tipo_modalidad = 1) then
                usp_print('(Corporativa Facultativa)&#xa0;');
            end if;
            if (cv.cod_tipo_modalidad = 2) then
                usp_print('(Corporativa Obligatoria)&#xa0;');
            end if;
            if (cv.cod_tipo_modalidad = 3) then
                usp_print('(Por Encargo)&#xa0;');
            end if;
            usp_print('
            </td>');


        usp_print('</tr>');
        ------ 2da Fila ----
        IF (cv.n_convoca != 0) THEN
                usp_print('
        <tr '||ln_color||' valign="top">
            <td>'||cv.des_objeto||'</td>
            <td align="right" nowrap="" valign = "top" >');
                if (cv.codmoneda=1) then usp_print('S/.'); end if;
                if (cv.codmoneda=2) then usp_print('US$'); end if;
                if (cv.codmoneda=3) then usp_print('EUR'); end if;
                usp_print('
                &#xa0;&#xa0;'||cv.v_referencial||'
            </td>
        </tr>');
            END IF;
        END LOOP;
    END IF;
    usp_print('</table>');

   ----------- Tabla de resultados --------------------
    usp_print('
    <table align="center" width="100%">
        <tr>
            <td align="left"><b>Total de registros encontrados : '||ln_Cant_Procesos||'</b> </td>
            <td align="right">');
    ------------ Paginacion ---------------
    lv_numeropaginas := ceil(ln_Cant_Procesos/lv_PageSize);
    lv_iterador:=1;
    usp_print('<b>P&aacute;gina:</b>');

    loop
        IF lv_iterador = lv_CurrentPage THEN
            usp_print('
                &nbsp<font color="#FFFFFF"><b><span style="background-color: #111111">&nbsp;'||lv_iterador||'&nbsp;</span></b></font>');
                if mod(lv_iterador,20)=0  then
                usp_print('<br>');
                end if;
        ELSE
            usp_print('&nbsp;'
                ||makea('ag_descripcion='||ag_descripcion||'&v_proc_tipo='||v_proc_tipo||'&ag_proc_desc='||lv_proc_desc||'&panho='||panho||'&ag_currentpage='||lv_iterador||'&scriptdo=doView',lv_iterador)
            );
            if mod(lv_iterador,20)=0 then
                usp_print('<br>');
            end if;
        END IF;
        lv_iterador := lv_iterador + 1;
    EXIT WHEN lv_numeropaginas < lv_iterador;
    end loop;
    -------- Campos de Cabecera -----------------
    usp_print('
            </td>
        </tr>
    </table>');

    exception
        when e_ArgumentosMalos then
            raise_application_error(-20000,'Se detecto una incorrecta asignacion de valores en los argumentos');
   End;


/*******************************************************************************
PROCEDIMIENTO QUE LISTA LAS GARANTIAS CORRESPONDIENTES A UN DETERMINADO CONTRATO
*******************************************************************************/
PROCEDURE uspLisGarantiasDoView(
    ag_n_convoca                varchar2 DEFAULT Null,
    ag_cod_contrato             varchar2 DEFAULT Null,
    ag_ncor_orden_pedido        varchar2,
    ag_cm_opc                   varchar2,
    ag_cm_oper_compra           varchar2,
    ag_anhoentidad              varchar2,
    ag_proc_tipo                varchar2,
    ag_proc_desc                varchar2,
    ag_proc_sigla               varchar2,
    ag_currenpage               varchar2,
    session__userid             varchar2,
    session__AG_N_CONVOCA       varchar2,
    session__AG_COD_CONTRATO    varchar2)
IS
    ------- Cursores -------
    ----- Items del Contrato -----
    Cursor c_items(p_n_cod_contrato in number) is
    Select trim(to_char(c.proc_item, '99999999')) proc_item
    from reg_procesos.item_contrato c
    where c.n_cod_contrato = p_n_cod_contrato
    order by proc_item;

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
        ind_fiel_cump, ind_adelanto, ind_monto_dif
    from
        REG_PROCESOS.contrato c,
        REG_PROCESOS.garantia g,
        REG_PROCESOS.t_tipo_garantia tg,
        REG_PROCESOS.monedas m
    where
        c.n_cod_contrato      = g.n_cod_contrato and
        g.cod_tipo_garantia   = tg.cod_tipo_garantia and
        g.cod_moneda          = m.codmoneda and
        g.n_cod_contrato      = p_n_cod_contrato
    order by
        to_char(g.cod_garantia, '99999999');

    ------- Variables ------
    e_ArgumentosMalos   exception;
    ln_n_convoca        number;
    ln_cod_contrato     number;
    lv_maxi             varchar2(10);
    ln_Cont_Fila        number;
    ln_color            varchar2(50);

Begin

    if( session__AG_COD_CONTRATO is not null ) then
        ln_n_convoca := session__AG_N_CONVOCA;
        ln_cod_contrato := session__AG_COD_CONTRATO;
    else
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...',
                '')
        );
       return;
    end if;

    if( session__userid is null ) then
        usp_print(
            pku_procesos_comun.f_putMensaje(
                'Su sesion ha expirado. Por favor, vuelva a loguearse ...',
                '')
        );
        return;
    end if;

     -------- Java Script -------
    REG_PROCESOS.PKU_SS_FUNCIONES_JS.fEfecto_Imagenes_JS;

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

    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato ( session__AG_COD_CONTRATO, 'Garant&iacute;as' )
    );
    usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Crear Garantia" OnClick="thisform.scriptdo.value=''doNewGarantias'';thisform.submit();"/>
            </td>
        </tr>
    </table>
    <br>
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <th class="th1">Garantia Nro</th>   
        <th class="th1">Tipo de Garantia</th>
        <th class="th1">Moneda</th>
        <th class="th1">Monto</th>
        <th class="th1">Fecha de Emisi&oacute;n</th>
        <th class="th1">Fecha de Vencimiento</th>
        <th class="th1">Tipo de Garantias</th>          
    ');

    ------ Listado de Garantias ---
    ln_Cont_Fila:=1;
    for cg in c_garantias(ln_cod_contrato) loop
        if mod(ln_Cont_Fila,2) = 0 then
            ln_color := 'bgcolor="#ECE9D8"';
        else
            ln_color := '';
        end if;
        usp_print('
        <tr '||ln_color||'>
            <td align="center">
                <b>'||makea('ag_n_convoca='||ln_n_convoca||'&ag_cod_garantia='||cg.cod_garantia||'&scriptdo=doViewGarantiaDetalle',cg.cod_garantia)||'<b>
            </td>
            <td align="center">'||cg.des_tipo_garantia||'</td>
            <td align="center">'||cg.descripcion||'</td>
            <td align="right">'||cg.monto_garantia||'</td>
            <td align="center">'||cg.fec_emision||'</td>
            <td align="center">'||cg.fec_vencimiento||'</td>
            <td align="left">');
        if cg.ind_fiel_cump = 1 then
            usp_print('Fiel Cumplimiento');
        end if;
        if ( ( cg.ind_fiel_cump = 1 and cg.ind_adelanto = 1 ) or ( cg.ind_fiel_cump = 1 and cg.ind_monto_dif = 1 ) ) then
            usp_print(', ');
        end if;
        if cg.ind_adelanto = 1 then
            usp_print('Adelanto');
        end if;
        if ( cg.ind_adelanto = 1 and cg.ind_monto_dif = 1 ) then
            usp_print(', ');
        end if;
        if cg.ind_monto_dif = 1 then
            usp_print('Monto Diferencial');
        end if;
        usp_print('
            </td>
        </tr>');
        ln_Cont_Fila:= ln_Cont_Fila + 1;
    end loop;
    usp_print('
    </table>');

exception
    when e_ArgumentosMalos then
        raise_application_error(-20000,'Se detecto una incorrecta asignacion de valores en los argumentos');
End;




PROCEDURE uspConOpeTituloDoView(
    ag_cod_contrato             varchar2 DEFAULT Null,
    ag_f_liquidacion            varchar2 DEFAULT Null
)
IS
    ln_cod_operacion_contrato   NUMBER;   
Begin

    usp_print('<script language="javascript">

         function goSubmit(jscriptdo)
         {
           thisform.scriptdo.value = jscriptdo;
           thisform.submit();
         };
      </script>');


    -------- Titulos ------------
    usp_print('
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(

            PKU_SS_UTILES.f_get_titulo_contrato ( ag_cod_contrato, 'Conformidad/Liquidación Consentida' )
    );
    usp_print('
            <td align="right" valign=top width="45%">
                <input type="button" value="Volver" onclick="goSubmit(''LisConformidadLiq'')">
                <input type="button" value="Grabar" onclick="grabar(this,''doInsertarLiquidacionAmpliacion'')">
            </td>
        </tr>

    </table>
    <br>');

    if ag_f_liquidacion is not null then

     select COD_OPERACION_CONTRATO into ln_cod_operacion_contrato from contrato where n_cod_contrato =ag_cod_contrato;

     IF ln_cod_operacion_contrato = 7 THEN
        usp_print(
            pku_procesos_comun.f_putMensaje(
                '<font color="red">Contrato con Conformidad</font>','')
        );
        return;
        usp_print('a');
      ELSIF   ln_cod_operacion_contrato = 8 THEN
        usp_print(
            pku_procesos_comun.f_putMensaje(
                '<font color="red">Contrato con liquidaci&oacute;n consentida</font>','')
        );
        return;
      END IF;
    end if;
End;


/********************************************************************/
PROCEDURE uspUplFileResConDoView(
    session__userid              varchar2,
    session__seacedocument       varchar2,
    session__seacedocumentosdwn  varchar2,
    WriteFileDirectoryDynamic    varchar2,
    ppnconvoca                   varchar2,
    docname                      varchar2,
    docname_mimetype             varchar2,
    pfiletoupload__size          varchar2,
    doc_obs                      varchar2,
    pcodentidad                  varchar2,
    session__IIS_REMOTE_ADDR     varchar2,
    ag_cod_contrato              varchar2,
    pfiletoupload                VARCHAR2,
    iisenv__remote_host          VARCHAR2,
    fec_aprob                    VARCHAR2)
IS
    lvtipodocumento    VARCHAR2(10);
    lv_codtipofile     VARCHAR2(10);
BEGIN

    lvtipodocumento:=upper(substr(pfiletoupload,length(pfiletoupload)-2,length(pfiletoupload)));

    begin
        select cod_tipo_file into lv_codtipofile
        from Reg_procesos.tipo_archivo
        where ext_tipo_file=lvtipodocumento;
    exception
        when no_data_found then
            lv_codtipofile:= Null;
    end;

    insert into reg_procesos.convocatoria_doc (
        N_CONVOCA,          
        COD_TIPO_DOC,       
        COD_TIPO_FILE,
        DOC_URL,            
        DOC_NOMBRE,         
        FEC_UPLOAD,
        USER_UPLOAD,        
        IP_FROM_UPLOAD,     
        TAMANO_BYTES,       
        DOC_OBS,
        N_COD_CONTRATO,
        FEC_APROB )
    values (
        reg_procesos.f_get_min_n_convoca(ppnconvoca),
        gpk_coddoc_resumen_contrato,
        lv_codtipofile,
        WriteFileDirectoryDynamic||pfiletoupload,
        pfiletoupload,
        sysdate, 
        session__userid,
        iisenv__remote_host, 
        pfiletoupload__size,
        doc_obs,
        ag_cod_contrato,
        fec_aprob);

    usp_print(
        '<br>'||
        pku_procesos_comun.f_putmensaje(
                'Documento del Contrato',
                'El documento fue cargado correctamente ... <br>Para continuar haga clic en el bot&oacute;n FINALIZAR.')
        );

    usp_print('
     <center>
        <br>
        <input type="button" value="Finalizar" onclick="window.close(); opener.location.reload();"
     </center>');
end;

--***************************************************************/

--**************************************************************

/*******************************************************************************
******* PROCEDIMIENTO QUE MUESTRA EL DETALLE DE LA RESOLUCION O NULIDAD ********
*******************************************************************************/
PROCEDURE uspManResolucionDoView(
    ag_n_convoca         varchar2 DEFAULT Null,
    ag_cod_resolucion    varchar2,
    ag_id_usuario        varchar2,
    ag_anhoentidad       varchar2,
    ag_proc_tipo         varchar2,
    ag_proc_desc         varchar2,
    ag_proc_sigla        varchar2,
    ag_currenpage        varchar2,
    session__userid      varchar2,
    session__FileSingedHTTP  varchar2 default null)
IS
    ------- Cursores ------
    ----- Items del Contrato -----
    Cursor c_items(p_n_cod_contrato in number) is
    Select trim(to_char(c.proc_item, '99999999')) proc_item
    from reg_procesos.item_contrato c
    where c.n_cod_contrato = p_n_cod_contrato
    order by proc_item;

    --------- Operaciones --------------
    Cursor c_oper(p_n_cod_contrato in number,p_cod_resolucion in number) is
    Select
        a.id_motivo, a.des_motivo, a.f_operacion,
        a.id_operacion id_operacion1, b.id_operacion id_operacion2
    from
        (   Select
                1 id_motivo, 'Contrato' des_motivo, c.n_cod_contrato id_op,
                to_char(c.f_contrato,'dd/mm/yyyy') f_operacion,
                nvl(c.id_operacion_src,c.id_operacion) id_operacion
            from reg_procesos.contrato c
            where c.n_cod_contrato = p_n_cod_contrato
            union
            Select
                2 id_motivo, 'Prorroga' des_motivo, c.n_cod_contrato id_op,
                to_char(c.f_contrato,'dd/mm/yyyy') f_operacion,
                nvl(c.id_operacion_src,c.id_operacion) id_operacion
            from reg_procesos.contrato c
            where c.n_cod_contrato_de_renovac = p_n_cod_contrato
            union
            Select
                3 id_motivo, 'Adicional' des_motivo, ar.cod_adicional id_op,
                to_char(ar.fec_doc_adicional,'dd/mm/yyyy') f_operacion,
                nvl(ar.id_operacion_src,ar.id_operacion) id_operacion
            from reg_procesos.adicional_reduccion ar
            where
                ar.n_cod_contrato = p_n_cod_contrato
                and ind_adicional_reduccion = 1
                and monto_adicional > 0
        ) a,
        (   select
                1 id_motivo, 'Contrato' des_motivo, c.n_cod_contrato id_op,
                to_char(c.f_contrato,'dd/mm/yyyy') f_operacion, co.id_operacion
            from reg_procesos.contrato_operacion co, reg_procesos.contrato c
            where
                c.n_cod_contrato = co.n_cod_contrato
                and co.n_cod_resolucion = p_cod_resolucion
                and co.cod_operacion_contrato = 1
            union
            select
                2 id_motivo, 'Prorroga' des_motivo, c.n_cod_contrato id_op,
                to_char(c.f_contrato,'dd/mm/yyyy') f_operacion, co.id_operacion
            from reg_procesos.contrato_operacion co, reg_procesos.contrato c
            where
                c.n_cod_contrato = co.n_cod_contrato_prorroga
                and co.n_cod_resolucion = p_cod_resolucion
                and co.cod_operacion_contrato = 2
            union
            select
                3 id_motivo, 'Adicional' des_motivo, ar.cod_adicional id_op,
                to_char(ar.fec_doc_adicional,'dd/mm/yyyy') f_operacion, co.id_operacion
            from reg_procesos.contrato_operacion co, reg_procesos.adicional_reduccion ar
            where
                ar.cod_adicional = co.cod_adicional
                and co.n_cod_resolucion = p_cod_resolucion
                and co.cod_operacion_contrato = 3
        ) b
    where a.id_motivo = b.id_motivo(+) and a.id_op = b.id_op(+)
    order by 1;


    ------- Calendario de cada tipo operacion -------
    Cursor c_cal(p_id_operacion1 in number,p_id_operacion2 in number) is
    Select
        a.num_pago, a.codmoneda, a.monto_pago monto_pago1,
        a.fec_pago fec_pago1, b.monto_pago monto_pago2, b.fec_pago fec_pago2
    from
        (   Select
                a.num_pago, a.codmoneda, a.monto_pago,
                to_char(a.fec_pago,'dd/mm/yyyy') fec_pago
            from reg_procesos.contrato_operacion_calendario a
            where a.id_operacion = p_id_operacion1
        ) a,
        (   Select
                a.num_pago, a.codmoneda, a.monto_pago,
                to_char(a.fec_pago,'dd/mm/yyyy') fec_pago
            from reg_procesos.contrato_operacion_calendario a
            where a.id_operacion = p_id_operacion2
        ) b
    where a.num_pago = b.num_pago(+)
    order by 1;

    ------------ Items del Contrato ----------------
    Cursor c_item_cont( p_n_cod_contrato in number, p_n_cod_resolucion in number ) is
    Select
        ic.descripcion, i.n_cod_contrato, i.n_convoca, i.proc_item,
        to_char(i.monto,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero) monto,
        i.f_registro, i.f_ult_mod, i.n_cod_resolucion, i.cantidad, i.unm_codigo
    from
        reg_procesos.item_contrato i,
        reg_procesos.item_convoca ic
    where
        i.n_convoca = ic.n_convoca
        and i.proc_item = ic.proc_item
        and i.n_cod_resolucion = p_n_cod_resolucion
        and i.n_cod_contrato = p_n_cod_contrato;

    --------------- Variables ------------
    e_ArgumentosMalos        exception;
    lv_eue_codigo            varchar2(6);
    lv_anhoentidad           varchar2(4);
    lv_procedure_main        varchar2(100);
    ln_n_convoca             number;
    lv_proc_sigla            varchar2(60);
    lv_proc_tipo_sigla       varchar2(10);
    lv_proc_num              varchar2(6);
    ln_proc_tipo             number;
    ln_n_proceso             number;
    ln_cod_contrato          number;
    ln_cod_resolucion        number;
    lv_des_tipo_resolucion   varchar2(250);
    lv_n_cod_resolucion      varchar2(10);
    lv_des_causa_resolucion  varchar2(250);
    lv_fec_resolucion        varchar2(20);
    ln_cod_tipo_resoucion    number;
    lv_n_contrato            REG_PROCESOS.contrato.n_contrato%type;
    lv_ruc_contratista       REG_PROCESOS.contrato.ruc_contratista%type;
    lv_nom_contratista       REG_PROCESOS.contrato.nom_contratista%type;
    lv_maxi                  varchar2(10);
    ln_cant_tipo             number;
    ln_ind_uso_siaf          number;
    ln_cont_pagos            number;
    ln_fila                  number;
    lv_total_pago_cont1      varchar2(20);
    lv_total_pago_cont2      varchar2(20);
    lv_total_pago_op1        varchar2(20);
    lv_total_pago_op2        varchar2(20);
    lv_id_usuario            varchar2(30);
    ln_icon_tipo_file        varchar2(100);
    row_documento_doc        reg_procesos.Convocatoria_Doc%rowtype;

Begin

    if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
    end if;

    lv_procedure_main  := pkname||'.uspManResolucionDoView';
    ln_cod_resolucion  := to_number(ag_cod_resolucion);
    ln_n_convoca       := to_number(ag_n_convoca);
    lv_id_usuario      := trim(ag_id_usuario);

    -------- Funciones Script -------
    REG_PROCESOS.PKU_SS_FUNCIONES_JS.fValidaCadenas_JS;
    ---------- Datos del documento de la Resolucion -----------  
    BEGIN 

      SELECT d.* into row_documento_doc         
        FROM REG_PROCESOS.CONTRATO_RESOLUCION  R
       INNER JOIN CONVOCATORIA_DOC D
          ON R.COD_DOC = D.COD_DOC
       WHERE R.N_COD_RESOLUCION = ln_cod_resolucion;

      select replace('bootstrap/'||archivo.icon_tipo_file, 'jpg', 'png') icon_tipo_file
      --archivo.icon_tipo_file 
      into ln_icon_tipo_file
        from REG_PROCESOS.tipo_archivo archivo 
       where archivo.cod_tipo_file = row_documento_doc.cod_tipo_file;

    EXCEPTION
        when no_data_found then
            row_documento_doc:= null;
    END;

    ---------- Datos de  la Resolucion -----------
    begin
        select
            n_cod_contrato, tr.des_tipo_resolucion,
            trim(to_char(n_cod_resolucion, '99999999')),
            tc.des_causa_resolucion,tr.cod_tipo_resoucion,
            to_char(fec_resolucion,'dd/mm/yyyy')
        into
            ln_cod_contrato, lv_des_tipo_resolucion,
            lv_n_cod_resolucion, lv_des_causa_resolucion,
            ln_cod_tipo_resoucion, lv_fec_resolucion
        from
            reg_procesos.contrato_resolucion c,
            reg_procesos.tipo_causa_resolucion tc,
            reg_procesos.tipo_resolucion_contrato tr
        where
            c.cod_causa_resoucion = tc.cod_causa_resoucion
            and c.cod_tipo_resolucion = tr.cod_tipo_resoucion
            and n_cod_resolucion = ln_cod_resolucion;
    exception
        when no_data_found then
            ln_cod_contrato:= null;
    end;

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
        into lv_n_contrato, lv_ruc_contratista, lv_nom_contratista
        from REG_PROCESOS.contrato c
        where c.n_cod_contrato = ln_cod_contrato;
    exception
        when no_data_found then
            lv_n_contrato:= null;
    end;

    select max(trim(to_char(c.proc_item, '99999999'))) into lv_maxi
    from reg_procesos.item_contrato c
    where  c.n_cod_contrato = ln_cod_contrato;


    -------- Titulos ------------
    usp_print('
    <input type="hidden" name="ag_n_convoca"        value="'||ln_n_convoca||'"/>
    <input type="hidden" name="ag_cod_contrato"     value="'||ln_cod_contrato||'"/>
    <input type="hidden" name="ag_cod_resolucion"   value="'||ln_cod_resolucion||'"/>
    <input type="hidden" name="ag_anhoentidad"      value="'||ag_anhoentidad||'"/>
    <input type="hidden" name="ag_proc_tipo"        value="'||ag_proc_tipo||'"/>
    <input type="hidden" name="ag_proc_desc"        value="'||ag_proc_desc||'"/>
    <input type="hidden" name="ag_proc_sigla"       value="'||ag_proc_sigla||'"/>
    <input type="hidden" name="ag_currenpage"       value="'||ag_currenpage||'"/>

    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
         --   pku_procesos_comun.f_get_titulo_contrato ( ln_cod_contrato, 'Nulidad / Resoluci&oacute;n' )
             PKU_SS_UTILES.f_get_titulo_contrato ( ln_cod_contrato, 'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios' ,'Nulidad / Resoluci&oacute;n del Contrato u Orden de Compra o Servicios ')
    );
    usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Volver" OnClick="thisform.scriptdo.value=''doViewNulidad'';thisform.submit();"/>
            </td>
        </tr>
    </table>
    <br>
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>');
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero del Contrato (u Orden de Compra o Servicio)',
                '<input type="text" name="n_contrato" readonly style="width:98%" value="'||lv_n_contrato||'"/>',
                '.'));

    --------------  Cantidad de Resoluciones ----------------
    Select count(cod_tipo_resolucion) into ln_cant_tipo
    from reg_procesos.contrato_resolucion
    where n_cod_contrato = ln_cod_contrato and cod_tipo_resolucion = 2;

    -------------- Obtener el indicador del SIAF ----------------
    begin
        select ep.ind_uso_siaf into ln_ind_uso_siaf
        from
            reg_procesos.entidadue_anho_tipo_proceso ep,
            reg_procesos.convocatorias c,
            reg_procesos.contrato cnt,
            reg_procesos.contrato_resolucion cr
        where
            ep.eue_codigo = c.codconsucode
            and ep.eue_anho   = c.anhoentidad
            and c.n_convoca   = cnt.n_convoca
            and cnt.n_cod_contrato   = cr.n_cod_contrato
            and cr.n_cod_resolucion  = ln_cod_resolucion
            and c.proc_tipo   = ep.tip_codigo;
    exception
        when no_data_found then
            ln_ind_uso_siaf:= null;
    end;

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Documento de Resoluci&oacute;n',
                   row_documento_doc.nro_doc ||' <br> ' ||
                   case when row_documento_doc.doc_url is not null then
                    '<a target=_blank href="'||session__FileSingedHTTP||row_documento_doc.doc_url||'">
                        <img src="'||ln_icon_tipo_file||'" border="0" width="25" height="25"/>
                    </a>' end ||
                   case when row_documento_doc.fec_upload  is not null then
                   ' Registrado el '||row_documento_doc.fec_upload end  ,'.'));

  usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Fecha del Documento de Resoluci&oacute;n',
                '<input type="text" name="fec_res" readonly style="width:98%" value="'||lv_fec_resolucion||'"/>',
                '.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Alcance de la Resoluci&oacute;n',
                '<input type="text" name="tipo_res" readonly style="width:98%" value="'||trim(lv_des_tipo_resolucion)||'"/>',
                '.'));


     usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Causal de la Resoluci&oacute;n',
                '<input type="text" name="causa_res" readonly style="width:98%" value="'||trim(lv_des_causa_resolucion)||'"/>',
                '.'));


    ---------- Calendario del Contrato ----------
    if (ln_ind_uso_siaf = 1) then
        ------- Total Pagos del Contrato----
        Select to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)
        into  lv_total_pago_cont1
        from reg_procesos.contrato_operacion_calendario a
        where a.id_operacion in (
                        Select nvl(c.id_operacion_src,c.id_operacion)
                        from reg_procesos.contrato c
                        where c.n_cod_contrato = ln_cod_contrato
                        union
                        Select nvl(c.id_operacion_src,c.id_operacion)
                        from reg_procesos.contrato c
                        where c.n_cod_contrato_de_renovac = ln_cod_contrato
                        union
                        Select nvl(ar.id_operacion_src,ar.id_operacion)
                        from reg_procesos.adicional_reduccion ar
                        where
                            ar.n_cod_contrato = ln_cod_contrato
                            and ind_adicional_reduccion=1
                            and monto_adicional > 0
        );

        ------- Total Pagos del Contrato----
        Select to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)
        into  lv_total_pago_cont2
        from reg_procesos.contrato_operacion_calendario a
        where a.id_operacion in (
                        select co.id_operacion
                        from
                            reg_procesos.contrato_operacion co,
                            reg_procesos.contrato c
                        where
                            c.n_cod_contrato = co.n_cod_contrato
                            and co.n_cod_resolucion = ln_cod_resolucion
                            and co.cod_operacion_contrato = 1
                        union
                        select co.id_operacion
                        from
                            reg_procesos.contrato_operacion co,
                            reg_procesos.contrato c
                        where
                            c.n_cod_contrato = co.n_cod_contrato_prorroga
                            and co.n_cod_resolucion = ln_cod_resolucion
                            and co.cod_operacion_contrato = 2
                        union
                        select co.id_operacion
                        from
                            reg_procesos.contrato_operacion co,
                            reg_procesos.ADICIONAL_REDUCCION ar
                        where
                            ar.COD_ADICIONAL = co.COD_ADICIONAL
                            and co.n_cod_resolucion = ln_cod_resolucion
                            and co.cod_operacion_contrato = 3
        );

        usp_print('
        <tr>
            <td class=c1>
                Calendario
            </td>
            <td colspan="2" class=c2>
                <table id="cal_idtable" border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
                    <th class="th1">Operación</th>
                    <th class="th1">Nro.</th>
                    <th class="th1">Fecha Prog.</th>
                    <th class="th1" align="center">Monto Prog.<br/>Total: '||lv_total_pago_cont1||'</th>
                    <th class="th1">Fecha Pago</th>
                    <th class="th1" align="center">Monto Pago<br/>Total: '||lv_total_pago_cont2||'</th>');
        ln_fila:= 1;
        ------ Operaciones del contrato -----
        for co in c_oper( ln_cod_contrato, ln_cod_resolucion ) loop
            ------- Total y Cantidad de Pagos del Contrato----
            Select
                to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero),
                count(a.num_pago)
            into  lv_total_pago_op1, ln_cont_pagos
            from reg_procesos.contrato_operacion_calendario a
            where a.id_operacion = co.id_operacion1;

            ------- Total y Cantidad de Pagos de la Resolucion ----
            Select to_char(nvl(sum(a.monto_pago),0),REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)
            into  lv_total_pago_op2
            from reg_procesos.contrato_operacion_calendario a
            where a.id_operacion = co.id_operacion2;

            usp_print('
                    <tr valign="top">
                        <td class="recuadro" rowspan="'||(ln_cont_pagos + 1)||'">
                            <table>
                                <tr>
                                    <td colspan="2" align="center">
                                        <b>'||co.des_motivo||'</b> ( '||co.f_operacion||' )
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">Programado : </td>
                                    <td align="right">'||lv_total_pago_op1||'</td>
                                </tr>
                                <tr>
                                    <td align="left">A Pagar : </td>
                                    <td align="right">'||lv_total_pago_op2||'</td>
                                </tr>
                            </table>
                        </td>
                    </tr>');
            -------- Calendario por Operacion ---------
            for cc in c_cal(co.id_operacion1,co.id_operacion2) loop
                ---------- mostrar datos del calendario -----
                usp_print('
                    <tr>
                        <td align="center">'||cc.num_pago||'</td>
                        <td align="center">'||cc.fec_pago1||'</td>
                        <td align="right">'||to_char(cc.monto_pago1,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)||'</td>
                        <td align="center">'||cc.fec_pago2||'</td>
                        <td align="right">'||to_char(cc.monto_pago2,REG_PROCESOS.PKU_SS_CONSTANTES.gv_formato_dinero)||'</td>
                    </tr>');
            end loop;
            ln_fila:= ln_fila + 1;
        end loop;
        usp_print('
                </table>
            </td>
        </tr>');
    end if;
    usp_print(
            PKU_PROCESOS_COMUN.f_get_subTitulo('Items del Contrato') );
    usp_print('
    </table>
    <table id="cal_idtable" border="0" width=100% align="center" class="tableform" cellpadding=3 cellspacing=0>
        <th class="th1">Resolver Items</th>
        <th class="th1">Item Nro.</th>
        <th class="th1">Descripci&oacute;n</th>
        <th class="th1">Monto</th>
        <th class="th1">Fecha de Registro</th>');
    ln_fila:= 1;
    -------- Items del Contrato --------

    FOR ci in c_item_cont( ln_cod_contrato, ln_cod_resolucion) loop
        usp_print('
        <tr id="tr_'||ln_fila||'">
            <td align="center" width= "9%">
                <input type="hidden" name="row" value="'||ln_fila||'"/>
                <input type="checkbox" name="proc_item" value="'||ci.proc_item||'" border="0"');
        if ci.n_cod_resolucion is not null then
            usp_print(' checked disabled ');
        end if;
        usp_print('/>
            </td>
            <td align="center" width= "8%">'||ci.proc_item||'</td>
            <td align="left" width= "61%">'||ci.descripcion||'</td>
            <td align="center" width= "7%">'||ci.monto||'</td>
            <td align="center" width= "15%">'||ci.f_registro||'</td>
        </tr>');
        ln_fila:= ln_fila + 1;
    end loop;

    usp_print('
    </table>');

End;

  /************************************************************************/
  /**********************************************************************/
PROCEDURE uspResolucionDoCancel(
    ag_id_usuario           varchar2,
    ag_n_convoca            varchar2,
    ag_cod_contrato         varchar2,
    ag_anhoentidad          varchar2,
    ag_proc_tipo            varchar2,
    ag_proc_desc            varchar2,
    ag_proc_sigla           varchar2,
    ag_currenpage           varchar2,
    session__userid         varchar2)
Is
Begin

    if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
    end if;

    --------- Borrar tabla temporal ----
    delete from reg_procesos.tmp_contrato_operacion_cal
    where id_usuario = ag_id_usuario;
    commit;

    ----------------------------------------------------
    usp_print('
    <input type="hidden"  name ="ag_id_usuario" value="'||ag_id_usuario||'"/>
    <input type="hidden"  name ="ag_n_convoca" value="'||ag_n_convoca||'"/>
    <input type="hidden"  name ="ag_cod_contrato" value="'||ag_cod_contrato||'"/>

    <script language="javascript">
        thisform.scriptdo.value="doViewNulidad";
        thisform.submit();
    </script>');
End;


  /**********************************************************************/
  PROCEDURE uspProrrogaCodPresDoDelete
     (  session__AG_N_CONVOCA    varchar2 default null,
        session__AG_COD_CONTRATO varchar2 default null,
        ag_proc_item             varchar2 default null,
        ag_cod_operacion         varchar2 default null,
        ag_n_propuesta           varchar2 default null,
        ag_cod_presu             varchar2 default null,
        ag_des_contrato          varchar2,
        ag_des_causa_renov       varchar2,
        ag_f_contrato            varchar2,
        ag_f_culminacion         varchar2,
        ag_n_contrato            varchar2,
        ag_plazo                 varchar2,
        ag_cod_moneda            varchar2
     )
  IS
  BEGIN

     delete from reg_procesos.tmp_contrato_op_cod_presu
     where n_convoca        = to_number(session__AG_N_CONVOCA) and
           n_cod_contrato   = to_number(session__AG_COD_CONTRATO) and
           proc_item        = to_number(ag_proc_item) and
           n_propuesta      = to_number(ag_n_propuesta) and
           cod_presupuestal = to_number(ag_cod_presu);

     commit;

     usp_print('
     <input type=hidden name=ag_eliminaCodPres           value=1>
     <input type=hidden name=ag_edicion                  value=1>
     <input type=hidden name=ag_cod_operacion            value="'||ag_cod_operacion||'">
     <input type=hidden name=ag_n_propuesta              value="'||ag_n_propuesta||'">
     <input type=hidden name=ag_des_contrato             value="'||ag_des_contrato||'">
     <input type=hidden name=ag_des_causa_renov          value="'||ag_des_causa_renov||'">
     <input type=hidden name=ag_f_contrato               value="'||ag_f_contrato||'">
     <input type=hidden name=ag_f_culminacion            value="'||ag_f_culminacion||'">
     <input type=hidden name=ag_n_contrato               value="'||ag_n_contrato||'">
     <input type=hidden name=ag_plazo                    value="'||ag_plazo||'">
     <input type=hidden name=ag_cod_moneda               value="'||ag_cod_moneda||'">
     <input type=hidden name=ag_Cod_Operacion            value="'||ag_cod_operacion||'">
     <script language=javascript>

     retorna();

     function retorna()
         {
           thisform.scriptdo.value="NewProrrogaDoEdit";
           thisform.submit();
         }  
     </script>
     ');  

  END;




  /**************************************************************/
 PROCEDURE uspManProItemDoDelete
     ( ag_cod_contrato_ren VARCHAR2,
       ag_proc_item        VARCHAR2,
       session__userid     VARCHAR2,
       session__n_convoca  VARCHAR2,
       ag_cod_contrato     VARCHAR2,
       ag_n_contrato       VARCHAR2) 
 IS

       lv_cod_contrato_ren   VARCHAR2(50);
       lv_ag_proc_item       VARCHAR2(50);
       usuario               VARCHAR2(50);  

 BEGIN

      if (session__userid is null) then
       usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
       return;
      end if;

      lv_cod_contrato_ren := ag_cod_contrato_ren;
      lv_ag_proc_item     := ag_proc_item;
      usuario             := session__userid;

      usp_print('
      <input type="hidden" name="ag_cod_contrato_ren" value="'||ag_cod_contrato_ren||'"/>
      <input type="hidden" name="ag_cod_contrato" value="'||ag_cod_contrato||'"/>
      <input type="hidden" name="ag_n_contrato" value="'||ag_n_contrato||'"/>
      <input type="hidden" name="ag_n_convoca" value="'||session__n_convoca||'"/>
      <input type="hidden" name="ag_ini_editar" value="2"/>
      ');
      /*--return;
      usp_print('lv_cod_contrato_ren: '||ag_cod_contrato_ren||'<br>');
      usp_print('ag_cod_contrato: '||ag_cod_contrato||'<br>');
      usp_print('lv_ag_proc_item: '||lv_ag_proc_item||'<br>');
      usp_print('usuario: '||usuario||'<br>');
      return;*/

      DELETE reg_procesos.tmp_contrato_prorroga_item
       WHERE id_usuario     = usuario AND
             n_cod_contrato = lv_cod_contrato_ren  AND
             proc_item      = lv_ag_proc_item;
      COMMIT;

      usp_print('
      <script language=javascript>
        thisform.scriptdo.value = "ManProrrogaDoEdit";
        thisform.submit();
      </script>
      ');          

 END;         

  /**************************************************************/ 
 PROCEDURE uspManProItemDoEdit
     ( ag_id_usuario            varchar2,
       ag_n_convoca             varchar2,
       ag_cod_contrato          varchar2,
       ag_cod_contrato_ren      varchar2,
       ag_n_contrato            varchar2,
       ag_cod_moneda            varchar2,
       ag_f_contrato            varchar2,
       ag_m_contratado          varchar2,
       ag_des_causa_renov       varchar2,
       ag_des_contrato          varchar2,
       ag_plazo                 varchar2,
       ag_f_culminacion         varchar2,
       ag_codconsucode          varchar2,
       ag_anhoentidad           varchar2,
       ag_cod_operacion         varchar2,
       ag_ncor_orden_pedido     varchar2,
       ag_cant_items            varchar2,
       ag_next_url              varchar2,
       ag_tipo_op               varchar2,
       ag_currenpage            varchar2,
       session__ag_cod_contrato varchar2,
       session__userid          varchar2) Is

   ------- Items del Contrato ----------
   Cursor c_items_cont(p_n_cod_contrato  in number,
                       p_CurrentPage     in number,
                       p_fila_ini        in number,
                       p_fila_fin        in number) is
    Select * from (
     Select rownum num, a.* from (
        Select ic.descripcion, i.n_cod_contrato, i.proc_item,
               nvl(tmp.monto,i.monto) monto,
               nvl(tmp.codigo_unidad,i.unm_codigo) unm_codigo,
               nvl(tmp.cantidad,i.cantidad) cantidad,
               i.f_registro,
               decode(tmp.proc_item,null,0,1) indica_seleccion
        from reg_procesos.item_convoca ic,
             reg_procesos.item_contrato i,
             (   Select a.codigo_unidad, a.cantidad, a.n_cod_contrato,
                        a.monto, a.fecha_registro, a.proc_item,
                        a.indica_seleccion
                 from reg_procesos.tmp_contrato_prorroga_item a
                 where a.id_usuario = ag_id_usuario
                   and a.n_cod_contrato = p_n_cod_contrato
              ) tmp
        where i.n_cod_contrato = p_n_cod_contrato
        and i.n_convoca = ic.n_convoca
        and i.proc_item = ic.proc_item
        and i.proc_item = tmp.proc_item(+)
        and i.n_cod_contrato = tmp.n_cod_contrato(+)
        order by i.proc_item
        ) a
     ) b
     where b.num >= p_fila_ini
       and b.num <= p_fila_fin;

   ------- Unidades de Medida -------
   Cursor c_medidas is
    Select unm_codigo, unm_desc
    from sease.unidad_medida;

   ----------- Variables ---------
   lv_procedure_main    varchar2(100);
   ln_cod_contrato      number;
   ln_cod_contrato_ren  number;
   ln_cod_operacion     number;
   ln_fila           number;
   lnContItems       number;
   ln_iterador       number;
   ln_numeropaginas  number;
   ln_CantItems      number;
   ln_CurrentPage    number;
   ln_Fila_Ini       number;
   ln_Fila_Fin       number;
   ln_Item_Ini       number;
   ln_Item_Fin       number;
   lv_next_url       varchar2(100);
   ln_tipo_op        number;
   ln_cont_fila      number;

   Begin

    if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
    end if;

    lv_procedure_main:= 'ManProItemDoEdit';
    ln_CantItems:= to_number(ag_cant_items);
    if (ag_cod_contrato is not null) then
        ln_cod_contrato:= to_number(ag_cod_contrato);
    end if;
    if (ag_cod_contrato_ren is not null) then
        ln_cod_contrato_ren:= to_number(ag_cod_contrato_ren);
    end if;
    if (ag_cod_operacion is not null) then
        ln_cod_operacion:= to_number(ag_cod_operacion);
    end if;
    lv_next_url:= 'ManProrrogaDoEdit';

    if (ag_currenpage is not null) then
        ln_CurrentPage:=  to_number(ag_currenpage);
    else
        ln_CurrentPage:= 1;
    end if;
    ln_numeropaginas:=ceil(ln_CantItems/gn_pagesize_contratos);
    ln_Fila_Ini:= (gn_pagesize_contratos*(ln_CurrentPage-1) + 1*sign(ln_CantItems));
    ln_Fila_Fin:= (ln_Fila_Ini + gn_pagesize_contratos - 1);
    if (ln_CantItems < ln_Fila_Fin) then
        ln_Fila_Fin:= ln_CantItems;
    end if;

    -------- Funciones Script -------
   PKU_SS_FUNCIONES_JS.fValidaCadenas_JS;

    ---------------- Captura Valores de la Pantalla Principal --------------
    usp_print('
        <input type="hidden"  name ="ag_id_usuario"
                     value="'||ag_id_usuario||'" />
        <input type="hidden"  name ="ag_n_convoca"
                     value="'||ag_n_convoca||'" />
        <input type="hidden"  name ="ag_cod_contrato"
                     value="'||ln_cod_contrato||'" />
        <input type="hidden"  name ="ag_cod_contrato_ren"
                     value="'||ln_cod_contrato_ren||'" />
        <input type="hidden"  name ="ag_n_contrato"
                     value="'||ag_n_contrato||'" />
        <input type="hidden"  name ="ag_cod_moneda"
                     value="'||ag_cod_moneda||'" />
        <input type="hidden"  name ="ag_f_contrato"
                     value="'||ag_f_contrato||'" />
        <input type="hidden"  name ="ag_m_contratado"
                     value="'||ag_m_contratado||'" />
        <input type="hidden"  name ="ag_des_causa_renov"
                     value="'||ag_des_causa_renov||'" />
        <input type="hidden"  name ="ag_des_contrato"
                     value="'||ag_des_contrato||'" />
        <input type="hidden"  name ="ag_plazo"
                     value="'||ag_plazo||'" />
        <input type="hidden"  name ="ag_f_culminacion"
                     value="'||ag_f_culminacion||'" />
        <input type="hidden"  name ="ag_codconsucode"
                     value="'||ag_codconsucode||'" />
        <input type="hidden"  name ="ag_anhoentidad"
                     value="'||ag_anhoentidad||'" />
        <input type="hidden"  name ="ag_cod_operacion"
                     value="'||ln_cod_operacion||'" />
        <input type="hidden"  name ="ag_ncor_orden_pedido"
                     value="'||ag_ncor_orden_pedido||'" />
        <input type="hidden"  name ="ag_currenpage"
                     value="'||ln_CurrentPage||'" />
       <input type="hidden" name ="ag_next_url"
                     value="'||ag_next_url||'"/>
       <input type="hidden" name="ag_caditem_nreg" value=""/>
       <input type="hidden" name="ag_caditem_item" value=""/>
       <input type="hidden" name="ag_caditem_unid" value=""/>
       <input type="hidden" name="ag_caditem_cant" value=""/>
       <input type="hidden" name="ag_caditem_monto" value=""/>
       <input type="hidden" name="ag_fila_inicio" />
       <input type="hidden" name="ag_fila_fin" />
       <input type="hidden" name="ag_cant_items"
                    value="'||ln_CantItems||'" />
       <input type="hidden" name="ag_tipo_op"
                    value="'||ag_tipo_op||'" />
       <input type="hidden" name ="ag_Item_Ini"
                     value="'||ln_Fila_Ini||'"/>
       <input type="hidden" name ="ag_Item_Fin"
                     value="'||ln_Fila_Fin||'"/>                                  

    ');

    ----------- Tabla de resultados --------------------
     usp_print('
    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');
    usp_print(
            PKU_SS_UTILES.f_get_titulo_contrato ( session__AG_COD_CONTRATO, 'Edición Prorrogas/Complementarios' )
    );
    usp_print('
            <td align="right" valign=top width="50%">
                <input type="button" value="Volver" OnClick="thisform.scriptdo.value=''ManProrrogaDoEdit'';thisform.submit();"/>
                <input type="button" value="Insertar" OnClick="volver(''ManProrrogaDoEdit'','||ln_Fila_Ini||','||ln_Fila_Fin||');"/>
            </td>
         </tr>
    </table>
    <br>');

       --------- Paginacion ------------
       if (ln_CantItems > 0) then
          begin
            ln_iterador:=1;
            usp_print('
            <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
            <tr>
            <td colspan=3 align=right>
            <b>Pagina :</b>');
            loop
                if (ln_iterador=ln_CurrentPage) then
                    usp_print('&nbsp<font color="#FFFFFF">
                                <b><span style="background-color: #111111">&nbsp;'||ln_iterador||'&nbsp;</span></b>
                              </font>');
                else
                    usp_print('&nbsp;<a href="#"
                        onclick="cambio_pagina(this,'||ln_Fila_Ini||','||ln_Fila_Fin||','||ln_iterador||')">
                                 '||ln_iterador||'</a>');           
                end if;
                ln_iterador := ln_iterador + 1;
                EXIT WHEN (ln_numeropaginas < ln_iterador);
            end loop;
            usp_print('
            </td>
            </tr>
            </table>');
          end;
    end if;

    usp_print('</td></tr></table>');


    ---------- Cabecera de los Items ---------------
     usp_print('
      <table align="center" BORDER="0" CELLPADDING="3" CELLSPACING="0" width="100%">
            <tr>
                <td>
                    <table border="1" width=100% align=center class=tableform cellpadding=3 cellspacing=0 style="border-collapse: collapse" bordercolor="#111111" width="100%">
                    <tr align="center">
                        <td class="th1"><b>Prorrogar Items</b></td>
                        <td class="th1"><b>Nº</b></td>
                        <td class="th1"><b>Descripción</b></td>
                        <td class="th1"><b>Item Proc</b></td>
                        <td class="th1"><b>Unidad de Medida</b></td>
                        <td class="th1"><b>Cantidad</b></td>
                        <td class="th1"><b>Monto</b></td>
                        <td class="th1"><b>Fecha de Registro</b></td>           
                    </tr>

         ');

     ----------------- Muestra los Items -----------------
     ln_cont_fila:=0;
     ln_fila:= ln_Fila_Ini;
     for cic in c_items_cont(ln_cod_contrato_ren,ln_CurrentPage,
                             ln_Fila_Ini,ln_Fila_Fin) loop
      if (ln_fila=ln_Fila_Ini) then --- Captura Item de Inicio
          ln_Item_Ini:= cic.proc_item;
      end if;
      ln_Item_Fin:= cic.proc_item;
      if (cic.indica_seleccion = 1) then --- Items seleccionados ---
         begin
           usp_print('
              <tr class="TabFilMan" id="tr_'||ln_fila||'" backgroundColor="#B6CBE6">
                <td align="center" width= "9%">
                <input type="hidden" name="row" value="'||ln_fila||'"/>
                    <input type="checkbox" name="proc_item" checked="true"
                           value="'||cic.proc_item||'" border="0"
                           onclick="activar('||ln_fila||',this)">
                    </input>
                </td>
                <td align="center" width= "6%">'||ln_fila||'</td>
                <td align="left"   width= "40%">'||cic.descripcion||'</td>
                <td align="center" width= "8%">'||cic.proc_item||'</td>
                <td>
                  <SELECT name="unm_codigo" > ');

                for cm in c_medidas loop
                  usp_print('<option value = "'||cm.unm_codigo||'"');
                  if (cm.unm_codigo = cic.unm_codigo) then
                      usp_print(' Selected ');
                  end if;
                  usp_print('>'||cm.unm_desc||'</option>');
                end loop;

                usp_print('
                      </SELECT>
                    </td>
                    <td width="4%">
                        <input align="right" name="cantidad"
                            value="'||cic.cantidad||'"  size = "8">
                        </input>
                    </td>
                    <td width="4%">
                        <input align="right" name="monto"
                               value="'||cic.monto||'"  size = "12">
                        </input>
                    </td>
                    <td align="center" width= "20%">'||cic.f_registro||'</td>
                    <input type="hidden" name="descripcion"
                                 value="'||cic.descripcion||'"/>

                   </tr>
               ');
          end;
       else --------- Items No Seleccionados ---------
          begin
           usp_print('
              <tr class="TabFilMan" id="tr_'||ln_fila||'">
                <td align="center" width= "9%">
                <input type="hidden" name="row" value="'||ln_fila||'"/>
                    <input type="checkbox" name="proc_item"
                           value="'||cic.proc_item||'" border="0"
                           onclick="activar('||ln_fila||',this)">
                    </input>
                </td>
                <td align="center" width= "6%">'||ln_fila||'</td>
                <td align="left"   width= "40%">'||cic.descripcion||'</td>
                <td align="center" width= "8%">'||cic.proc_item||'</td>
                <td>
                  <SELECT name="unm_codigo" disabled="true"> ');

                for cm in c_medidas loop
                  usp_print('<option value = "'||cm.unm_codigo||'"');
                  if (cm.unm_codigo = cic.unm_codigo) then
                      usp_print(' Selected ');
                  end if;
                  usp_print('>'||cm.unm_desc||'</option>');
                end loop;

                usp_print('
                      </SELECT>
                    </td>
                    <td width="4%">
                        <input align="right" name="cantidad" disabled
                            value="'||cic.cantidad||'"  size = "8">
                        </input>
                    </td>
                    <td width="4%">
                        <input align="right" name="monto" disabled
                               value="'||cic.monto||'"  size = "12">
                        </input>
                    </td>
                    <td align="center" width= "20%">'||cic.f_registro||'</td>
                    <input type="hidden" name="descripcion"
                                 value="'||cic.descripcion||'"/>

                   </tr>
               ');
           end;
       end if;
       ln_fila:= ln_fila + 1;
       ln_cont_fila:=ln_cont_fila + 1;
     end loop;
     lnContItems:= ln_fila - 1;
     usp_print('</table>
     </td>
     </tr>
     </table>
     <br> ');

     ------------- Botones Finales ---------------

     usp_print('
        <table align="center" BORDER="0"
            CELLPADDING="0" CELLSPACING="0" WIDTH="100%" class="TabFilMan">
            <tr align="center" valign = "top">
               <td colspan = 3 align="left"><b>Filas :&nbsp'
                 ||to_char(ln_Fila_Ini)
                 ||'&nbsp-&nbsp'
                 ||to_char(ln_Fila_Fin)
                 ||' de '||ln_CantItems||
              '</b></td>
               <td colspan = 6 align="right">
             </tr>
          </table>');


     ----------------- Java Script --------------
     usp_print('
       <script language="javascript">
         total_Filas= '||ln_cont_fila||';
         function activar(fila, obj){
             if (thisform.row.type){   // VALIDAR UNICA FILA
                if (obj.checked){
                     document.getElementById("tr_"+fila).style.backgroundColor="#B6CBE6";
                     thisform.cantidad.disabled    =   false;
                     thisform.monto.disabled       =   false;
                     thisform.unm_codigo.disabled  =   false;
                }else{
                    document.getElementById("tr_"+fila).style.backgroundColor="E8E9EB";
                    thisform.cantidad.disabled    =   true;
                    thisform.monto.disabled       =   true;
                    thisform.unm_codigo.disabled  =   true;
                }
             }else{
                var e_proc_item  = new Enumerator(thisform.item("proc_item"));
                var e_cantidad   = new Enumerator(thisform.item("cantidad"));
                var e_monto      = new Enumerator(thisform.item("monto"));
                var e_unm_codigo = new Enumerator(thisform.item("unm_codigo"));
                if (obj.checked){
                  for (; !e_proc_item.atEnd(); ){
                       document.getElementById("tr_"+fila).style.backgroundColor="#B6CBE6";
                       if(e_proc_item.item().value == obj.value){
                          e_cantidad.item().disabled    =   false;
                          e_monto.item().disabled       =   false;
                          e_unm_codigo.item().disabled  =   false;
                       }
                       e_proc_item.moveNext();
                       e_cantidad.moveNext();
                       e_monto.moveNext();
                       e_unm_codigo.moveNext();
                   }
                }else{
                   for (; !e_proc_item.atEnd(); ){
                           document.getElementById("tr_"+fila).style.backgroundColor="E8E9EB";
                           if(e_proc_item.item().value == obj.value){
                              e_cantidad.item().disabled    =   true;
                              e_monto.item().disabled       =   true;
                              e_unm_codigo.item().disabled  =   true;
                           }
                           e_proc_item.moveNext();
                           e_cantidad.moveNext();
                           e_monto.moveNext();
                           e_unm_codigo.moveNext();
                   }
                }
             }
         }

        function VerificarContenido(obj,flag){
            var itemNoCheck = 0;
            var itemCheck = 0;
            var lvCadNumReg = "";
            var lvCadItem = "";
            var lvCadCant = "";
            var lvCadUnid = "";
            var lvCadMonto = "";
            if(total_Filas > 0)
            {
                if (!thisform.row.type)
                {
                    var e_row           = new Enumerator(thisform.item("row"));
                    var e_proc_item     = new Enumerator(thisform.item("proc_item"));
                    var e_descripcion   = new Enumerator(thisform.item("descripcion"));
                    var e_unm_codigo    = new Enumerator(thisform.item("unm_codigo"));
                    var e_cantidad      = new Enumerator(thisform.item("cantidad"));
                    var e_monto         = new Enumerator(thisform.item("monto"));
                     for (; !e_row.atEnd(); )
                     {
                        if(e_proc_item.item().checked)
                        {
                            itemCheck++;
                            if(ValidarDecimal(e_monto.item() ,"Monto"))
                            {
                                if(e_monto.item().value == ""){
                                     alert("Debe colocar un monto en la casilla activada: Item Nº "+e_proc_item.item().value);
                                     return false;
                                }
                               else
                               {
                                    if(ValidarDecimal(e_cantidad.item() ,"Cantidad")){
                                        if(e_cantidad.item().value == ""){
                                             alert("Debe colocar una cantidad en la casilla activada: Item Nº "+e_proc_item.item().value);
                                             return false;
                                        }
                                       else
                                       {
                                             lvCadItem = lvCadItem + e_proc_item.item().value + ";";
                                             lvCadCant = lvCadCant + e_cantidad.item().value + ";";
                                             lvCadUnid = lvCadUnid + e_unm_codigo.item().value + ";";
                                             lvCadMonto = lvCadMonto + e_monto.item().value + ";";
                                             lvCadNumReg = lvCadNumReg + e_row.item().value + ";";
                                        }
                                     }
                                    else
                                        return false;
                                }
                              }
                             else
                               return false;
                        }
                       else
                       {
                            itemNoCheck++;
                        }
                        e_row.moveNext();
                        e_proc_item.moveNext();
                        e_unm_codigo.moveNext();
                        e_descripcion.moveNext();
                        e_cantidad.moveNext();
                        e_monto.moveNext();
                      }

                  }
                  else
                  {
                       if (thisform.proc_item.checked)
                       {
                           lvCadNumReg = thisform.row.value;
                           lvCadItem = thisform.proc_item.value;
                           lvCadCant = thisform.cantidad.value;
                           lvCadUnid = thisform.unm_codigo.value;
                           lvCadMonto = thisform.monto.value;
                       }
                      else
                      {
                           alert("Debe seleccionar el Item");
                           return false;
                       }
                 }

                 if(flag=="1")
                 {
                    if(itemCheck == 0)
                    {
                       alert("Debe Seleccionar por lo menos un item..!");
                       return false;
                     }
                  }

                  thisform.ag_caditem_nreg.value=lvCadNumReg;
                  thisform.ag_caditem_item.value=lvCadItem;
                  thisform.ag_caditem_cant.value=lvCadCant;
                  thisform.ag_caditem_unid.value=lvCadUnid;
                  thisform.ag_caditem_monto.value=lvCadMonto;

           }
           return true;
         }

        function grabar_pagina(obj,FilaIni,FilaFin,objSrc){
            if(total_Filas==0){
               alert("No hay items disponibles...");
               return false;
            }
            if(VerificarContenido(obj,"1")){
                thisform.ag_fila_inicio.value=FilaIni;
                thisform.ag_fila_fin.value=FilaFin;
                thisform.ag_next_url.value="'||lv_procedure_main||'";
                thisform.scriptdo.value=objSrc;
                thisform.submit();
                return true;
            }
        }

        function cambio_pagina(obj,FilaIni,FilaFin,nextpage){
            if(VerificarContenido(obj,"0")){
                thisform.ag_currenpage.value=nextpage;
                thisform.ag_fila_inicio.value=FilaIni;
                thisform.ag_fila_fin.value=FilaFin;
                thisform.ag_next_url.value="'||lv_procedure_main||'";
                thisform.scriptdo.value="PKU_GESTOR_CONT_CONTRATOS.uspProItemDoInsert";
                thisform.submit();
                return true;
            }
        }

        function volver(obj,FilaIni,FilaFin){
            if(VerificarContenido(obj,"0")){
                thisform.ag_fila_inicio.value=FilaIni;
                thisform.ag_fila_fin.value=FilaFin;
                thisform.ag_next_url.value="ManProrrogaDoEdit";  
                thisform.scriptdo.value="ManProItemDoInsert";
                thisform.submit();
                return true;
            }
        }

       </script>
     ');

  End;
/****************************************************************************************************/
/* NEWX1 PROCEDURE uspnewadicionalitemdoedit */
/*
   PROCEDURE uspnewproCompitemdoedit (
      session__ag_n_convoca      VARCHAR2 DEFAULT NULL,
      session__userid            VARCHAR2 DEFAULT NULL,
      session__ag_cod_contrato   VARCHAR2 DEFAULT NULL,
      ag_ind_adred               VARCHAR2, \* Tipo de operacion*\    
      ag_cant_items              VARCHAR2,        
      ag_currenpage              VARCHAR2,
      ag_cod_adicional           VARCHAR2,
      ag_cod_entid_autoriza      VARCHAR2,
      ag_trama_calendario        VARCHAR2

   )
   IS

      ----------- Variables ---------
      ln_iterador         NUMBER;
      ln_numeropaginas    NUMBER;
      ln_cantitems        NUMBER;
      ln_currentpage      NUMBER;
      ln_fila_ini         NUMBER;
      ln_fila_fin         NUMBER;
      lv_trama_items      LONG;
      ln_ind_adred        number;

   BEGIN

      IF (ag_cant_items IS NULL) THEN

          SELECT COUNT(1) INTO ln_cantitems
           FROM reg_procesos.item_convoca ic,
                reg_procesos.item_contrato i
          WHERE i.n_cod_contrato = session__ag_cod_contrato
            AND i.n_convoca = ic.n_convoca
            AND i.proc_item = ic.proc_item;

      ELSE
         ln_cantitems := 1;
      END IF;

      IF (ag_currenpage IS NOT NULL) THEN
         ln_currentpage := TO_NUMBER (ag_currenpage);
      ELSE
         ln_currentpage := 1;
      END IF;

      ln_numeropaginas := CEIL (ln_cantitems / gn_pagesize_contratos);

      ln_fila_ini := (gn_pagesize_contratos * (ln_currentpage - 1) + 1 * SIGN (ln_cantitems) );
      ln_fila_fin := (ln_fila_ini + gn_pagesize_contratos - 1);

      IF (ln_cantitems < ln_fila_fin) THEN
         ln_fila_fin := ln_cantitems;
      END IF;

      ----------- Tabla de resultados --------------------
    usp_print('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>
               <td>'
          || PKU_SS_UTILES.f_get_titulo_contrato(session__ag_cod_contrato,'Seleccionar Items')
          || '</td>
               <td valign=top align=right>
                    <input type=button value="Volver" onclick="thisform.scriptdo.value=''DoNewAdicionalEdit'';thisform.submit();">
                    <input type=button value="Continuar" onclick="generaTrama()">
               </td>
             </tr>
         </table>
         <br>
         <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
             <tr>
               <td colspan = 6 align="right">'
         );

      --------- Paginacion ------------
      IF (ln_cantitems > 0) THEN
      BEGIN
          ln_iterador := 1;
          usp_print ('<b>Pagina :</b>');

          LOOP
             IF(ln_iterador = ln_currentpage) THEN
                usp_print
                   ('&nbsp<font color="#FFFFFF"><b><span style="background-color: #111111">&nbsp;'
                    || ln_iterador || '&nbsp;</span></b></font>');
             ELSE
                usp_print
                   ('&nbsp;<a href="#" onclick="cambio_pagina(this,'
                    || ln_fila_ini || ',' || ln_fila_fin || ',' || ln_iterador || ')">'
                    || ln_iterador || '</a>');

             END IF;
             ln_iterador := ln_iterador + 1;
             EXIT WHEN (ln_numeropaginas < ln_iterador);
          END LOOP;
        END;
      END IF;

      usp_print ('</td>
            </tr>
        </table>');

   ----------------- Muestra los Items -----------------

   usp_print('<xml id="xmlActual"><root></root></xml>');

   \* No se a quien se le ocurrio tener dos indicadores para saber si es un adicional o reduccion*\
   IF ag_ind_adred = 3 THEN 
       ln_ind_adred := 1;
   END IF;

   IF ag_ind_adred = 4 THEN 
      ln_ind_adred := 2;
   END IF;

   lv_trama_items := PKU_SS_UTILES.f_getXmlItemsAdionReducSel(session__ag_cod_contrato,ag_cod_entid_autoriza,ln_ind_adred);     
   usp_print(lv_trama_items);


      ---------- Cabecera de los Items ---------------
   usp_print('<!-- datapagesize="1" -->
     <table datasrc="#xmlItems" id="tablaItems" pagesize="10" border="1" cellpadding="0" cellspacing="0" width="100%" class="tableform">
     <thead> 
          <tr align="center">
          <td><b>Nº</b></td>
          <td><b>Item</b></td>
          <td><b>Descripción</b></td>
          <td><b>Unidad de Medida</b></td>
          <td><b>Cantidad</b></td>
          <td><b>Monto Item Original</b></td>
          <td><b>Monto Adicional Actual</b></td>          
          <td><b>Monto Adicional Maximo</b></td>          
          <td><b>Monto Adicional Item </b></td>
          <td><b>Adicionar Items</b></td>
          </tr>
      </thead>
          <tr class="TabFilMan">
          <td align="center"    width="8%"><span datafld="chk" dataformatas="html" ></span>
          <input type="hidden"  datafld="copiar" name="hcopiar" /> </td>
          <td align="center"    width= "5%"><span datafld="fila"></span></td>
          <td align="center"    width= "5%"><span datafld="procitem"></span></td>          
          <td align="left"      width= "33%"><span datafld="descripcion"></span></td>
          <td align="center"    width="9%"><span datafld="unidad"></span></td>
          <td align="center"    width="7%"><span datafld="cantidad"></span></td>  
          <td align="right"     width="11%"><span datafld="mon"></span></td>                    
          <td align="right"     width="11%"><span datafld="sum"></span></td>               
          <td align="right"     width="12%"><span datafld="top"></span></td>      
          <td width="4%"><input type="text" datafld="monto" name="txtMontoxml" size="15" style="text-align:right" onKeyPress="f_validaCampoNumerico()"></input></td>
          </tr>
       </table>');

    usp_print('<br><br>
    <input type="button" name="btnPrimero" value="|<" onclick="go(0)">
    <input type="button" name="btnAnterior" value="<" onclick="go(1)">
    <input type="button" name="btnSiguiente" value=">" onclick="go(2)">
    <input type="button" name="btnUltimo" value=">|" onclick="go(3)">
    ');

    usp_print('
       </td>
     </tr>
     <tr>
        <td>
          Filas :&nbsp'
          ||TO_CHAR (ln_fila_ini)||'&nbsp-&nbsp'|| TO_CHAR (ln_fila_fin)||' de '|| ln_cantitems||'</td>
     </tr>
     </table>');
    usp_print('<input type="hidden"  name="ag_ind_adred"       value="'|| ag_ind_adred|| '" />');
    usp_print('<input type="hidden"  name="ag_trama_items"     value="" />');    
    usp_print('<input type="hidden"  name="ag_cod_entid_autoriza"     value="'||ag_cod_entid_autoriza||'" />');    
    usp_print('<input type="hidden"  name="ag_trama_calendario"     value="'||ag_trama_calendario||'" />');    

    ----------------- Java Script --------------
    PKU_SS_FUNCIONES_JS.fXmlAdicionalReduccion; 
    PKU_SS_FUNCIONES_JS.fNumeros;

 END;      */
  /**********************************************************/

  PROCEDURE uspProItemDoInsert
     ( ag_id_usuario           varchar2,
       ag_n_convoca            varchar2,
       ag_cod_contrato         varchar2,
       ag_cod_contrato_ren     varchar2,
       ag_n_contrato           varchar2,
       ag_cod_moneda           varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_codconsucode         varchar2,
       ag_anhoentidad          varchar2,
       ag_cod_operacion        varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_cant_items           varchar2,
       ag_fila_inicio          varchar2,
       ag_fila_fin             varchar2,
       ag_caditem_nreg         varchar2,
       ag_caditem_item         varchar2,
       ag_caditem_unid         varchar2,
       ag_caditem_cant         varchar2,
       ag_caditem_monto        varchar2,
       ag_currenpage           varchar2,
       ag_Item_Ini             varchar2,
       ag_Item_Fin             varchar2,
       ag_next_url             varchar2,
       session__userid         varchar2) Is

      ---------- variables --------------

       ln_cod_contrato         number;
       ln_cod_contrato_ren     number;
       ln_cod_tipo_prorroga    number;
       ln_fila_inicio          number;
       ln_fila_fin             number;
       lv_caditem_nreg         varchar2(2000);
       lv_caditem_item         varchar2(2000);
       lv_caditem_unid         varchar2(2000);
       lv_caditem_cant         varchar2(2000);
       lv_caditem_monto        varchar2(2000);
       lini                    number;
       lfin                    number;
       lv_nreg                 varchar2(10);
       lv_item                 varchar2(10);
       lv_unid                 varchar2(10);
       lv_cant                 varchar2(10);
       lv_monto                varchar2(10);
       lv_sql                  varchar2(2000);
       ln_Item_Ini             number;
       ln_Item_Fin             number;

  Begin

     if (session__userid is null) then
      usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
      return;
     end if;  

     ln_fila_inicio:= to_number(ag_fila_inicio);
     ln_fila_fin:= to_number(ag_fila_fin);
     ln_cod_contrato:= to_number(ag_cod_contrato);
     ln_cod_contrato_ren:= to_number(ag_cod_contrato_ren);
     ln_cod_tipo_prorroga:= to_number(ag_cod_operacion);
     ln_Item_Ini:= to_number(ag_Item_Ini);
     ln_Item_Fin:= to_number(ag_Item_Fin);

     --------- Borrar Registros anteriores ------------
     Delete from reg_procesos.tmp_contrato_prorroga_item
     where id_usuario = ag_id_usuario
       and n_cod_contrato = ln_cod_contrato_ren
       and proc_item >= ln_Item_Ini
       and proc_item <= ln_Item_Fin;

     ---------- Grabar Items Seleccionados -------------
     if ((ag_caditem_nreg is not null) and
         (ag_caditem_item is not null) and
         (ag_caditem_unid is not null) and
         (ag_caditem_cant is not null) and
         (ag_caditem_monto is not null))then
        begin
             lv_caditem_item := trim(ag_caditem_item);
             lv_caditem_unid := trim(ag_caditem_unid);
             lv_caditem_cant := trim(ag_caditem_cant);
             lv_caditem_monto:= trim(ag_caditem_monto);
             lv_caditem_nreg := trim(ag_caditem_nreg);
             lini:= 1;
             WHILE (length(lv_caditem_item)>0) LOOP
               begin
                 ------ Obtiene Nro de Item ------
                 lfin:= instr(lv_caditem_item,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_item) + 1;
                 end if;
                 lv_item:= substr(lv_caditem_item,lini,(lfin - lini));
                 lv_caditem_item:=substr(lv_caditem_item,lfin + 1,length(lv_caditem_item));

                 ------ Obtiene Unidad ------
                 lfin:= instr(lv_caditem_unid,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_unid) + 1;
                 end if;
                 lv_unid:= substr(lv_caditem_unid,lini,(lfin - lini));
                 lv_caditem_unid:=substr(lv_caditem_unid,lfin + 1,length(lv_caditem_unid));

                 ------ Obtiene Cantidad ------
                 lfin:= instr(lv_caditem_cant,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_cant) + 1;
                 end if;
                 lv_cant:= substr(lv_caditem_cant,lini,(lfin - lini));
                 lv_caditem_cant:=substr(lv_caditem_cant,lfin + 1,length(lv_caditem_cant));

                 ------ Obtiene Monto ------
                 lfin:= instr(lv_caditem_monto,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_monto) + 1;
                 end if;
                 lv_monto:= substr(lv_caditem_monto,lini,(lfin - lini));
                 lv_caditem_monto:=substr(lv_caditem_monto,lfin + 1,length(lv_caditem_monto));

                 ---------- Insertar Registro --------
                 insert into reg_procesos.tmp_contrato_prorroga_item(
                   id_usuario,n_cod_contrato,
                   proc_item, codigo_unidad, cantidad,
                   monto, fecha_registro,
                   indica_seleccion,estado
                 ) values (
                   ag_id_usuario,ln_cod_contrato_ren,
                   to_number(lv_item),to_number(lv_unid),to_number(lv_cant),
                   to_number(lv_monto),sysdate,
                   1,1);

               end;
             END LOOP;
         end;
     end if;

    commit;
    ----------------------------------------------------
    usp_print('
        <input type="hidden"  name ="ag_id_usuario"
                     value="'||ag_id_usuario||'" />
        <input type="hidden"  name ="ag_n_convoca"
                     value="'||ag_n_convoca||'" />
        <input type="hidden"  name ="ag_cod_contrato"
                     value="'||ln_cod_contrato||'" />
        <input type="hidden"  name ="ag_cod_contrato_ren"
                     value="'||ln_cod_contrato_ren||'" />
        <input type="hidden"  name ="ag_n_contrato"
                     value="'||ag_n_contrato||'" />
        <input type="hidden"  name ="ag_cod_moneda"
                     value="'||ag_cod_moneda||'" />
        <input type="hidden"  name ="ag_f_contrato"
                     value="'||ag_f_contrato||'" />
        <input type="hidden"  name ="ag_m_contratado"
                     value="'||ag_m_contratado||'" />
        <input type="hidden"  name ="ag_des_causa_renov"
                     value="'||ag_des_causa_renov||'" />
        <input type="hidden"  name ="ag_des_contrato"
                     value="'||ag_des_contrato||'" />
        <input type="hidden"  name ="ag_plazo"
                     value="'||ag_plazo||'" />
        <input type="hidden"  name ="ag_f_culminacion"
                     value="'||ag_f_culminacion||'" />
        <input type="hidden"  name ="ag_codconsucode"
                     value="'||ag_codconsucode||'" />
        <input type="hidden"  name ="ag_anhoentidad"
                     value="'||ag_anhoentidad||'" />
        <input type="hidden"  name ="ag_cod_operacion"
                     value="'||ag_cod_operacion||'" />
        <input type="hidden"  name ="ag_ncor_orden_pedido"
                     value="'||ag_ncor_orden_pedido||'" />
        <input type="hidden"  name ="ag_currenpage"
                     value="'||ag_currenpage||'" />
        <input type="hidden"  name ="ag_next_url"
                     value="'||ag_next_url||'" />
        <input type="hidden"  name ="ag_cant_items"
                     value="'||ag_cant_items||'" />

       <script language="javascript">
          thisform.scriptdo.value='''||ag_next_url||''';
          thisform.submit();
       </script>
    ');

  End;

  PROCEDURE uspNewProItemDoDelete
    ( session__userid             varchar2 default null,
      session__ag_n_convoca       varchar2 default null,
      session__AG_COD_CONTRATO    varchar2 default null,
      proc_item                   varchar2,
      ag_cod_operacion            varchar2 ) Is

      lv_usuario        varchar2(50);
      lv_n_convoca      varchar2(50);
      lv_n_cod_contrato varchar2(50);
      lv_proc_item      varchar2(50);

  begin

     if (session__userid is null) then
        usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
        return;
     end if;

     lv_usuario := session__userid;
     lv_n_convoca := session__ag_n_convoca;
     lv_n_cod_contrato := session__AG_COD_CONTRATO;
     lv_proc_item := proc_item;


     /*usp_print('lv_usuario: '||lv_usuario||'<br>');
     usp_print('lv_n_convoca: '||lv_n_convoca||'<br>');
     usp_print('lv_n_cod_contrato: '||lv_n_cod_contrato||'<br>');
     usp_print('lv_proc_item: '||lv_proc_item||'<br>');
     return;*/

     if lv_n_cod_contrato is not null then
       delete from reg_procesos.tmp_contrato_prorroga_item
       where n_cod_contrato   = lv_n_cod_contrato and
               id_usuario     = lv_usuario and
               proc_item      = lv_proc_item;
       commit;
     --else
         /*usp_print('lv_usuario: '||lv_usuario||'<br>');
         usp_print('lv_n_convoca: '||lv_n_convoca||'<br>');
         usp_print('lv_n_cod_contrato: '||lv_n_cod_contrato||'<br>');
         usp_print('lv_proc_item: '||lv_proc_item||'<br>');
         return;*/
     end if;

     usp_print('
     <input type="hidden" name="ag_id_usuario" value="'||session__userid||'">
     <input type="hidden" name="ag_cod_operacion" value="'||ag_cod_operacion||'">
     ');

     usp_print('
     <script language="javascript" >
       thisform.scriptdo.value="NewProrrogaDoEdit";
       thisform.submit();
     </script>
       ');

  end;

  /***************************************************/
  PROCEDURE uspManProItemDoInsert
     ( ag_id_usuario           varchar2,
       ag_n_convoca            varchar2,
       ag_cod_contrato         varchar2,
       ag_cod_contrato_ren     varchar2,
       ag_n_contrato           varchar2,
       ag_cod_moneda           varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_codconsucode         varchar2,
       ag_anhoentidad          varchar2,
       ag_cod_operacion        varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_cant_items           varchar2,
       ag_fila_inicio          varchar2,
       ag_fila_fin             varchar2,
       ag_caditem_nreg         varchar2,
       ag_caditem_item         varchar2,
       ag_caditem_unid         varchar2,
       ag_caditem_cant         varchar2,
       ag_caditem_monto        varchar2,
       ag_currenpage           varchar2,
       ag_Item_Ini             varchar2,
       ag_Item_Fin             varchar2,
       ag_next_url             varchar2,
       ag_ini_editar           varchar2  default null,
       session__userid          varchar2 default null,
       session__AG_N_CONVOCA    varchar2 default null,
       session__AG_COD_CONTRATO varchar2 default null) Is

    ---------- variables --------------
    ln_cod_contrato         number;
    ln_cod_tipo_prorroga    number;
    ln_fila_inicio          number;
    ln_fila_fin             number;
    lv_caditem_nreg         varchar2(2000);
    lv_caditem_item         varchar2(2000);
    lv_caditem_unid         varchar2(2000);
    lv_caditem_cant         varchar2(2000);
    lv_caditem_monto        varchar2(2000);
    lini                    number;
    lfin                    number;
    lv_nreg                 varchar2(10);
    lv_item                 varchar2(10);
    lv_unid                 varchar2(10);
    lv_cant                 varchar2(10);
    lv_monto                varchar2(10);
    lv_sql                  varchar2(2000);
    ln_Item_Ini             number;
    ln_Item_Fin             number;
    ln_cod_contrato_ren     varchar2(50);

  Begin

     /*usp_print('ag_caditem_nreg: '||ag_caditem_nreg||'<br>');
     usp_print('ag_caditem_item: '||ag_caditem_item||'<br>');
     usp_print('ag_caditem_unid: '||ag_caditem_unid||'<br>');
     usp_print('ag_caditem_cant: '||ag_caditem_cant||'<br>');
     usp_print('ag_caditem_monto: '||ag_caditem_monto||'<br>');
     usp_print('ag_cod_contrato_ren: '||ag_cod_contrato_ren||'<br>');
     usp_print('ag_Item_Ini: '||ag_Item_Ini||'<br>');
     usp_print('ag_Item_Fin: '||ag_Item_Fin||'<br>');
     return;*/

     if (session__userid is null) then
        usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
        return;
     end if;

     ln_fila_inicio:= to_number(ag_fila_inicio);
     ln_fila_fin:= to_number(ag_fila_fin);
     ln_cod_contrato:= to_number(ag_cod_contrato);
     ln_cod_tipo_prorroga:= to_number(ag_cod_operacion);
     ln_Item_Ini:= to_number(ag_Item_Ini);
     ln_Item_Fin:= to_number(ag_Item_Fin);
     ln_cod_contrato_ren:= to_number(ag_cod_contrato_ren);

     --------- Borrar Registros anteriores ------------
     Delete from reg_procesos.tmp_contrato_prorroga_item
     where id_usuario = ag_id_usuario
       and n_cod_contrato = ln_cod_contrato_ren
       and proc_item >= ln_Item_Ini
       and proc_item <= ln_Item_Fin;

    /* Delete from reg_procesos.tmp_contrato_op_cod_presu
     where n_convoca = REG_PROCESOS.f_get_max_n_convoca(session__AG_N_CONVOCA) and
           n_cod_contrato = ln_cod_contrato;  */ 

     commit;
     ---------- Grabar Items Seleccionados -------------
     if ((ag_caditem_nreg is not null) and
         (ag_caditem_item is not null) and
         (ag_caditem_unid is not null) and
         (ag_caditem_cant is not null) and
         (ag_caditem_monto is not null))then
        begin
             lv_caditem_item := trim(ag_caditem_item);
             lv_caditem_unid := trim(ag_caditem_unid);
             lv_caditem_cant := trim(ag_caditem_cant);
             lv_caditem_monto:= trim(ag_caditem_monto);
             lv_caditem_nreg := trim(ag_caditem_nreg);
             lini:= 1;
             WHILE (length(lv_caditem_item)>0) LOOP
               begin
                 ------ Obtiene Nro de Item ------
                 lfin:= instr(lv_caditem_item,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_item) + 1;
                 end if;
                 lv_item:= substr(lv_caditem_item,lini,(lfin - lini));
                 lv_caditem_item:=substr(lv_caditem_item,lfin + 1,length(lv_caditem_item));

                 ------ Obtiene Unidad ------
                 lfin:= instr(lv_caditem_unid,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_unid) + 1;
                 end if;
                 lv_unid:= substr(lv_caditem_unid,lini,(lfin - lini));
                 lv_caditem_unid:=substr(lv_caditem_unid,lfin + 1,length(lv_caditem_unid));

                 ------ Obtiene Cantidad ------
                 lfin:= instr(lv_caditem_cant,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_cant) + 1;
                 end if;
                 lv_cant:= substr(lv_caditem_cant,lini,(lfin - lini));
                 lv_caditem_cant:=substr(lv_caditem_cant,lfin + 1,length(lv_caditem_cant));

                 ------ Obtiene Monto ------
                 lfin:= instr(lv_caditem_monto,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_monto) + 1;
                 end if;
                 lv_monto:= substr(lv_caditem_monto,lini,(lfin - lini));
                 lv_caditem_monto:=substr(lv_caditem_monto,lfin + 1,length(lv_caditem_monto));

                 ---------- Insertar Registro --------
                 insert into reg_procesos.tmp_contrato_prorroga_item(
                   id_usuario,n_cod_contrato,
                   proc_item, codigo_unidad, cantidad,
                   monto, fecha_registro,
                   indica_seleccion,estado
                 ) values (
                   session__userid,ln_cod_contrato_ren,
                   to_number(lv_item),to_number(lv_unid),to_number(lv_cant),
                   to_number(lv_monto),sysdate,
                   1,1);

                  /*insert into reg_procesos.tmp_contrato_op_cod_presu(
                   n_convoca,proc_item,n_cod_contrato,userid,monto_asignado
                  ) values (
                   REG_PROCESOS.f_get_max_n_convoca(session__AG_N_CONVOCA),
                   to_number(lv_item),ln_cod_contrato_ren,session__userid,NULL);  */  

                 commit;
               end;
             END LOOP;
         end;
     end if;



    ----------------------------------------------------
    usp_print('
        <input type="hidden"  name ="ag_id_usuario"
                     value="'||ag_id_usuario||'" />
        <input type="hidden"  name ="ag_n_convoca"
                     value="'||ag_n_convoca||'" />
        <input type="hidden"  name ="ag_cod_contrato"
                     value="'||ln_cod_contrato||'" />
        <input type="hidden"  name ="ag_cod_contrato_ren"
                     value="'||ag_cod_contrato_ren||'" />             
        <input type="hidden"  name ="ag_n_contrato"
                     value="'||ag_n_contrato||'" />
        <input type="hidden"  name ="ag_cod_moneda"
                     value="'||ag_cod_moneda||'" />
        <input type="hidden"  name ="ag_f_contrato"
                     value="'||ag_f_contrato||'" />
        <input type="hidden"  name ="ag_m_contratado"
                     value="'||ag_m_contratado||'" />
        <input type="hidden"  name ="ag_des_causa_renov"
                     value="'||ag_des_causa_renov||'" />
        <input type="hidden"  name ="ag_des_contrato"
                     value="'||ag_des_contrato||'" />
        <input type="hidden"  name ="ag_plazo"
                     value="'||ag_plazo||'" />
        <input type="hidden"  name ="ag_f_culminacion"
                     value="'||ag_f_culminacion||'" />
        <input type="hidden"  name ="ag_codconsucode"
                     value="'||ag_codconsucode||'" />
        <input type="hidden"  name ="ag_anhoentidad"
                     value="'||ag_anhoentidad||'" />
        <input type="hidden"  name ="ag_cod_operacion"
                     value="'||ag_cod_operacion||'" />
        <input type="hidden"  name ="ag_ncor_orden_pedido"
                     value="'||ag_ncor_orden_pedido||'" />
        <input type="hidden"  name ="ag_currenpage"
                     value="'||ag_currenpage||'" />
        <input type="hidden"  name ="ag_next_url"
                     value="'||ag_next_url||'" />
        <input type="hidden"  name ="ag_cant_items"
                     value="'||ag_cant_items||'" />
        <input type="hidden"  name ="ag_ini_editar"
                     value="2" />                     

       <script language="javascript">
          thisform.scriptdo.value='''||ag_next_url||''';
          thisform.submit();
       </script>
    ');

  End;


  PROCEDURE uspNewProItemDoInsert
     ( ag_id_usuario           varchar2,
       ag_n_convoca            varchar2,
       ag_cod_contrato         varchar2,
       ag_n_contrato           varchar2,
       ag_cod_moneda           varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_codconsucode         varchar2,
       ag_anhoentidad          varchar2,
       ag_cod_operacion        varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_cant_items           varchar2,
       ag_fila_inicio          varchar2,
       ag_fila_fin             varchar2,
       ag_caditem_nreg         varchar2,
       ag_caditem_item         varchar2,
       ag_caditem_unid         varchar2,
       ag_caditem_cant         varchar2,
       ag_caditem_monto        varchar2,
       ag_currenpage           varchar2,
       ag_Item_Ini             varchar2,
       ag_Item_Fin             varchar2,
       ag_next_url             varchar2,
       ag_ini_editar           varchar2  default null,
       session__userid          varchar2 default null,
       session__AG_N_CONVOCA    varchar2 default null,
       session__AG_COD_CONTRATO varchar2 default null) Is

    ---------- variables --------------
    ln_cod_contrato         number;
    ln_cod_tipo_prorroga    number;
    ln_fila_inicio          number;
    ln_fila_fin             number;
    lv_caditem_nreg         varchar2(2000);
    lv_caditem_item         varchar2(2000);
    lv_caditem_unid         varchar2(2000);
    lv_caditem_cant         varchar2(2000);
    lv_caditem_monto        varchar2(2000);
    lini                    number;
    lfin                    number;
    lv_nreg                 varchar2(10);
    lv_item                 varchar2(10);
    lv_unid                 varchar2(10);
    lv_cant                 varchar2(10);
    lv_monto                varchar2(10);
    lv_sql                  varchar2(2000);
    ln_Item_Ini             number;
    ln_Item_Fin             number;

  Begin

     if (session__userid is null) then
        usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
        return;
     end if;

     ln_fila_inicio:= to_number(ag_fila_inicio);
     ln_fila_fin:= to_number(ag_fila_fin);
     ln_cod_contrato:= to_number(ag_cod_contrato);
     ln_cod_tipo_prorroga:= to_number(ag_cod_operacion);
     ln_Item_Ini:= to_number(ag_Item_Ini);
     ln_Item_Fin:= to_number(ag_Item_Fin);

     --------- Borrar Registros anteriores ------------
     Delete from reg_procesos.tmp_contrato_prorroga_item
     where id_usuario = ag_id_usuario
       and n_cod_contrato = ln_cod_contrato
       and proc_item >= ln_Item_Ini
       and proc_item <= ln_Item_Fin;

     ---------- Grabar Items Seleccionados -------------
     if ((ag_caditem_nreg is not null) and
         (ag_caditem_item is not null) and
         (ag_caditem_unid is not null) and
         (ag_caditem_cant is not null) and
         (ag_caditem_monto is not null))then
        begin
             lv_caditem_item := trim(ag_caditem_item);
             lv_caditem_unid := trim(ag_caditem_unid);
             lv_caditem_cant := trim(ag_caditem_cant);
             lv_caditem_monto:= trim(ag_caditem_monto);
             lv_caditem_nreg := trim(ag_caditem_nreg);
             lini:= 1;
             WHILE (length(lv_caditem_item)>0) LOOP
               begin
                 ------ Obtiene Nro de Item ------
                 lfin:= instr(lv_caditem_item,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_item) + 1;
                 end if;
                 lv_item:= substr(lv_caditem_item,lini,(lfin - lini));
                 lv_caditem_item:=substr(lv_caditem_item,lfin + 1,length(lv_caditem_item));

                 ------ Obtiene Unidad ------
                 lfin:= instr(lv_caditem_unid,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_unid) + 1;
                 end if;
                 lv_unid:= substr(lv_caditem_unid,lini,(lfin - lini));
                 lv_caditem_unid:=substr(lv_caditem_unid,lfin + 1,length(lv_caditem_unid));

                 ------ Obtiene Cantidad ------
                 lfin:= instr(lv_caditem_cant,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_cant) + 1;
                 end if;
                 lv_cant:= substr(lv_caditem_cant,lini,(lfin - lini));
                 lv_caditem_cant:=substr(lv_caditem_cant,lfin + 1,length(lv_caditem_cant));

                 ------ Obtiene Monto ------
                 lfin:= instr(lv_caditem_monto,';');
                 if (lfin = 0) then
                     lfin:= length(lv_caditem_monto) + 1;
                 end if;
                 lv_monto:= substr(lv_caditem_monto,lini,(lfin - lini));
                 lv_caditem_monto:=substr(lv_caditem_monto,lfin + 1,length(lv_caditem_monto));

                 ---------- Insertar Registro --------
                 insert into reg_procesos.tmp_contrato_prorroga_item(
                   id_usuario,n_cod_contrato,
                   proc_item, codigo_unidad, cantidad,
                   monto, fecha_registro,
                   indica_seleccion,estado
                 ) values (
                   ag_id_usuario,ln_cod_contrato,
                   to_number(lv_item),to_number(lv_unid),to_number(lv_cant),
                   to_number(lv_monto),sysdate,1,1);

               end;
             END LOOP;
         end;
     end if;


    commit;
    ----------------------------------------------------
    usp_print('
        <input type="hidden"  name ="ag_id_usuario"
                     value="'||ag_id_usuario||'" />
        <input type="hidden"  name ="ag_n_convoca"
                     value="'||ag_n_convoca||'" />
        <input type="hidden"  name ="ag_cod_contrato"
                     value="'||ln_cod_contrato||'" />
        <input type="hidden"  name ="ag_n_contrato"
                     value="'||ag_n_contrato||'" />
        <input type="hidden"  name ="ag_cod_moneda"
                     value="'||ag_cod_moneda||'" />
        <input type="hidden"  name ="ag_f_contrato"
                     value="'||ag_f_contrato||'" />
        <input type="hidden"  name ="ag_m_contratado"
                     value="'||ag_m_contratado||'" />
        <input type="hidden"  name ="ag_des_causa_renov"
                     value="'||ag_des_causa_renov||'" />
        <input type="hidden"  name ="ag_des_contrato"
                     value="'||ag_des_contrato||'" />
        <input type="hidden"  name ="ag_plazo"
                     value="'||ag_plazo||'" />
        <input type="hidden"  name ="ag_f_culminacion"
                     value="'||ag_f_culminacion||'" />
        <input type="hidden"  name ="ag_codconsucode"
                     value="'||ag_codconsucode||'" />
        <input type="hidden"  name ="ag_anhoentidad"
                     value="'||ag_anhoentidad||'" />
        <input type="hidden"  name ="ag_cod_operacion"
                     value="'||ag_cod_operacion||'" />
        <input type="hidden"  name ="ag_ncor_orden_pedido"
                     value="'||ag_ncor_orden_pedido||'" />
        <input type="hidden"  name ="ag_currenpage"
                     value="'||ag_currenpage||'" />
        <input type="hidden"  name ="ag_next_url"
                     value="'||ag_next_url||'" />
        <input type="hidden"  name ="ag_cant_items"
                     value="'||ag_cant_items||'" />
        <input type="hidden"  name ="ag_ini_editar"
                     value="1" />                     

       <script language="javascript">
          thisform.scriptdo.value='''||ag_next_url||''';
          thisform.submit();
       </script>
    ');

  End;

  /***************************************************************/

PROCEDURE uspUplFileResConDoEdit (
    ag_n_convoca                   varchar2 default null,
    ag_cod_tipo_doc                varchar2 default null,
    docname                        varchar2 default null,
    session__maxMBUploadFileSize   varchar2 default null,
    docname__mime                  varchar2 default null,
    session__FileSingedHTTP        varchar2 default null,
    session__FileSinged            varchar2 default null,
    WriteFileDirectoryDynamic      varchar2 default null,
    extension                      varchar2 default null,
    session__IIS_REMOTE_ADDR       varchar2 default null,
    session__userid                varchar2,
    ag_cod_contrato                varchar2)
IS
    -------- Variables ---------
    ln_n_convoca      number;
    ln_convoca_origen number;
    lv_anhoentidad    varchar2(50);
    lv_eue_codigo     varchar2(50);
    lv_cod_tipo_doc   varchar2(50);
    lv_proc_sigla_m   varchar2(50);
    lv_tip_abrev      varchar2(15);
    lv_proc_num       varchar2(15);
    lv_des_tipo_doc   varchar2(250);
    lvdirectorio      varchar2(50);
    lv_ruta_file      varchar2(250);

BEGIN


    usp_print('
    <script LANGUAGE="Javascript">
    function Guarda_envio()
    {


        var extension = thisform.pfiletoupload.value.substring(thisform.pfiletoupload.value.length-4);
        extension = extension.replace(".","");
        if (!ValidarBlanco(thisform.fec_aprob,"Fecha del Documento"))
            return false;
        if (!ValidarBlanco(thisform.pfiletoupload,"Seleccione un documento"))
            return false;
        if ( extension == "exe" || extension == "jsp"   || extension == "java" ||
                extension == "asp" || extension == "cgi"   || extension == "com"  ||
                extension == "js"  || extension == "class" || extension == "jar"  ||
                extension == "vbs" || extension == "aspx"  || extension == "dll"  ||
                extension == "mp3" || extension == "xml"   || extension =="xls"   ||
                extension == "sql" || extension == "txt" 
                        )
        {
            alert("Lo sentimos, el tipo de archivo que intenta subir no esta permitido. Ingrese un *.doc o *.pdf.");
            return false;
        }
        else
        {
            thisform.scriptdo.value = "UploadFileConResumen";
            thisform.submit();
        }
    }
    </script>'); 

    pku_procesos_comun.dojscript;

    ln_n_convoca :=  to_number(ag_n_convoca);
    lv_cod_tipo_doc := trim(ag_cod_tipo_doc);

    --------- Obtener datos de la convocatoria -------
    begin
        Select
            REG_PROCESOS.F_RENAME_SIGLA(convocatorias.proc_sigla),
            tipo_proceso.tip_abrev, convocatorias.anhoentidad,
            convocatorias.codconsucode,convocatorias.proc_num,
            convocatorias.n_convoca_origen
        into
            lv_proc_sigla_m, lv_tip_abrev,lv_anhoentidad,
            lv_eue_codigo,lv_proc_num,ln_convoca_origen
        from
            REG_PROCESOS.convocatorias
            left outer join sease.tipo_proceso
                on tipo_proceso.tip_codigo = proc_tipo
        where n_convoca = ln_n_convoca;
    exception
        when no_data_found then
            lv_proc_sigla_m:= null;
    end;

    lvdirectorio:= gpk_directorio_resumen_cont;
    lv_ruta_file:= lvdirectorio||'\'||lv_anhoentidad||'\'||lv_eue_codigo||'\'||ln_convoca_origen;

    -------- Funciones Script -------
    REG_PROCESOS.PKU_SS_FUNCIONES_JS.fValidaCadenas_JS;

    ----------- Descripcion del documento ---------
    begin
        Select a.des_tipo_doc into lv_des_tipo_doc
        from reg_procesos.tipo_documento a
        where a.cod_tipo_doc = gpk_coddoc_resumen_contrato;
    exception
        when no_data_found then
            lv_des_tipo_doc:= null;
    end;

    usp_print('
    <input type="hidden" name="ag_cod_contrato"    value="'||ag_cod_contrato||'"/>
    <input type="hidden" name="ppnconvoca"         value="'||ln_n_convoca||'"/>
    <input type="hidden" name="pcodentidad"        value="'||lv_eue_codigo||'"/>
    <input type="hidden" name="WriteFileDirectory" value="FileSinged" />
    <input type="hidden" name="extension" />
    <input type="hidden" name="WriteFileDirectoryDynamic" value="'||lv_ruta_file||'" />

    <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>
            <td colspan="2">
                <h3>Registro de Contrato/Orden de Compra o Servicio</h3>
            </td>
            <td align="right">
                <input type="button" value="Enviar" onclick="Guarda_envio();">
            </td>
        </tr>
        <tr>
            <td class="c1" colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td class="c1">Convocatoria</td>
            <td class="c2">'||lv_tip_abrev||'-'||lv_proc_num||'-'||lv_anhoentidad||'-'||lv_proc_sigla_m||'</td>
            <td class="c3">.</td>
        </tr>
        <tr>
            <td class="c1">(*)Fecha del Documento</td>
            <td class="c2">
                <input readonly name="fec_aprob" style="width:87%" class=CalSelect onclick="calendario(this)">
            </td>
            <td class="c3">Seleccione la fecha de aprobación del documento.</td>
        </tr>
        <tr>
            <td class="c1">(*)Archivo</td>
            <td class="c2"><input type="file" name="pfiletoupload" style="width:100%"</td>
            <td class="c3">Seleccione el archivo que contiene el Contrato/Orden de Compra o Servicio, solo se permiten archivos *.doc o *.pdf</td>
        </tr>
        <tr>
            <td class="c1">Observaci&oacute;n</td>
            <td class="c2"><input name="doc_obs" style="width:98%"/></td>
            <td class="c3">Ingrese sus observaciones</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td colspan="3" align="center">
                <a href="http://'||reg_procesos.f_get_conexiones(8)||'/mon/docs/procesos/ConfiguracionArchivo.zip" target="_blank" >
                    <b>[Manual de configuración para adjuntar archivos]</b>
                </a>
            </td>
        </tr>
    </table>');


END;

/***************** Muestra las Transferencias al MEF ************/
PROCEDURE uspTransferMefDoView (
    ag_n_convoca          varchar2,
    ag_cod_contrato       varchar2,
    ag_anhoentidad        varchar2,
    ag_eue_codigo         varchar2,
    ag_ind_show_error     varchar2,
    session__userid       varchar2)
Is
    Cursor c_cab(pn_cod_contrato in number) is
    SELECT
        a.id_operacion id_transaccion, 
        a.ind_modificacion cod_operacion,
        decode(a.ind_modificacion,1,'nuevo',2,'modif.') des_operacion,
        a.cod_operacion_contrato id_motivo,
        to_char(a.fec_operacion,
        'dd/mm/yyyy hh:mi:ss') fec_operacion,
        decode(a.cod_operacion_contrato,
                  1,a.n_cod_contrato,
                  2,a.n_cod_contrato_prorroga,
                  3,a.cod_adicional,
                  4,a.cod_adicional,
                  5,a.cod_adicional
                  ) id_operacion,
        a.cod_estado_transferencia,
        tt.des_estado_transferencia des_estado_transferencia,
        tt.obs_estado_transferencia,
        REG_PROCESOS.F_REPLACE_TILDES(a.valida_mef) valida_mef,
        to_char(a.fec_transferencia,
        'dd/mm/yyyy hh:mi:ss') fec_transferencia,
      --  REG_PROCESOS.F_GET_XML_CONTRATO_ATRIBUTO(a.id_operacion,'f_contrato') f_contrato,
       to_char(c.f_contrato,'dd/mm/yyyy hh24:mi:ss') f_contrato,
        a.xml_data, 
        a.usu_creacion, 
        a.ip_creacion,
        LOWER(toc.des_operacion_contrato) des_operacion_contrato,
        a.usuario_transfer
    FROM
        reg_procesos.contrato_operacion a,
        reg_procesos.contrato c,
        reg_procesos.t_tipo_estado_transf tt,
        reg_procesos.tipo_operacion_contrato toc
    WHERE
        a.n_cod_contrato = c.n_cod_contrato
        and a.cod_operacion_contrato = toc.cod_operacion_contrato
        and c.n_cod_contrato = pn_cod_contrato
        and tt.cod_estado_transferencia = a.cod_estado_transferencia
    order by a.id_operacion;

    Cursor c_error(pid_transaccion in number, pind_show_error in number) is
    SELECT '( ' ||to_char(a.fec_transferencia,'dd/mm/yyyy hh24:mi:ss')||' ) '||a.des_error des_error
    FROM reg_procesos.contrato_operacion_error a
    WHERE a.id_operacion = pid_transaccion;

    --------------- Variables ----------------
    ln_n_convoca                number;
    ln_cod_contrato             number;
    lv_eue_desc                 varchar2(250);
    lv_anhoentidad              varchar2(4);
    lv_eue_codigo               varchar2(6);
    lv_procedure_main           varchar2(250);
    ln_ind_show_error           number;
    ln_Cont_Error               number;
    lv_id_proceso               varchar2(100);
    lv_id_contrato              varchar2(100);
    ld_fec_reqMEF               date;
ln_modulo number;        -- (1/3) 12.09.2020 , permite verificar si las acciones sobre el contrato deben estas habilitados

Begin

    lv_procedure_main           := pkname||'.uspTransferMefDoView';
    ln_n_convoca                := to_number(ag_n_convoca);
    ln_cod_contrato             := to_number(ag_cod_contrato);
    ln_ind_show_error           := to_number(ag_ind_show_error);
    lv_anhoentidad              := trim(ag_anhoentidad);
    lv_eue_codigo               := trim(ag_eue_codigo);
    ld_fec_reqMEF               := to_date('20112015','ddmmyyyy');-- Jcerda req MEF 19/10/2015  

-- (2/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
 select F_CON_CONTRATO_MOD('DESACTIVAR', 'ACCIONES',sysdate, ln_cod_contrato  ) into ln_modulo from dual;

    REG_PROCESOS.PKU_SS_FUNCIONES_JS.fEfecto_Imagenes_JS;
    REG_PROCESOS.PKU_SS_FUNCIONES_JS.fValidaCadenas_JS;

    begin
        Select eue_desc into lv_eue_desc
        from  sease.entidadue_anho
        where eue_codigo = lv_eue_codigo and eue_anho = lv_anhoentidad;
    exception
       when no_data_found then lv_eue_desc:= null;
    end;

    begin

      SELECT tp.proc_tipo_sigla||'-'||cnv.proc_num||'-'||cnv.anhoentidad||'-'||cnv.proc_sigla id_proceso, 
             c.codconsucode||'-'||(case when PROC.N_ID_EXPEDE is not null and trunc(C.f_registro) >= ld_fec_reqMEF then lpad(PROC.N_ID_EXPEDE,8,'0') else lpad(c.n_convoca,8,'0') end)||'-'||lpad(c.n_cod_contrato,8,'0') id_contrato-- Jcerda req MEF 19/10/2015  
--             c.codconsucode||'-'||lpad(c.n_convoca,8,'0')||'-'||lpad(c.n_cod_contrato,8,'0') id_contrato
        INTO lv_id_proceso, lv_id_contrato
        FROM reg_procesos.contrato c,
             reg_procesos.convocatorias cnv,
             reg_procesos.tipo_procesos tp,
             reg_procesos.procesos proc
       where c.n_convoca      = cnv.n_convoca
         and cnv.proc_tipo    = tp.proc_tipo
         and proc.n_proceso      = cnv.n_proceso
         and c.n_cod_contrato = ln_cod_contrato;

    exception

       when no_data_found then lv_id_proceso:= null; lv_id_contrato:= null;

    end;

    usp_print('
    <table border="0" style="border-collapse: collapse" bordercolor="#111111" cellpadding="3" cellspacing="0" width="100%">
        <tr style="background-color: #BDBDBD;color:#111111">
            <td><h3>Entidad: '||lv_eue_desc||'</h3></td>
        </tr>
        <tr>
            <td>
                <h3>Operaciones Transferidas al MEF</h3>
                <h4>
                    Contrato: '||lv_id_contrato||'<br>
                    Proceso: '||lv_id_proceso||'
                </h4>
            </td>
        </tr>
    </table>
    <br/> ');

    usp_print('
    <table border="1" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" width="100%">
        <th class="th1" style="background-color: #BDBDBD;color:#111111">ID_TRANS</th>
        <th class="th1" style="background-color: #BDBDBD;color:#111111">ID_MOTIVO</th>
        <th class="th1" style="background-color: #BDBDBD;color:#111111">COD_OPERACION</th>
        <th class="th1" style="background-color: #BDBDBD;color:#111111">FEC_TRANSACCION</th>
        <th class="th1" style="background-color: #BDBDBD;color:#111111">FEC_CONTRATO</th>
        <th class="th1" style="background-color: #BDBDBD;color:#111111">ESTADO DE TRANSFERENCIA</th>
        <th class="th1" style="background-color: #BDBDBD;color:#111111">VALIDACION REALIZADA POR EL MEF</th>
        <th class="th1" style="background-color: #BDBDBD;color:#111111">FECHA DE TRANSFERENCIA</th>
        <th class="th1" style="background-color: #BDBDBD;color:#111111">USUARIO</th>');

    for cc in c_cab(ln_cod_contrato) loop 
        if ( ln_ind_show_error = 1) then
            SELECT count(a.fec_transferencia) INTO ln_Cont_Error
            FROM reg_procesos.contrato_operacion_error a
            WHERE a.id_operacion = cc.id_transaccion;
        end if;
        usp_print('
        <tr align="center" valign="top">
            <td rowspan="'||(ln_Cont_Error + 1)||'">
                '||cc.id_transaccion||'
            </td>
            <td nowrap="">'||cc.id_motivo||'-'||cc.des_operacion_contrato||'</td>
            <td nowrap="">'||cc.cod_operacion||'-'||cc.des_operacion||'</td>
            <td >'||cc.fec_operacion||'</td>
            <td >'||cc.f_contrato||'</td>
            <td >');

        if ( cc.cod_estado_transferencia = 3 or cc.cod_estado_transferencia = 10 ) then
            usp_print(cc.cod_estado_transferencia||'-'||cc.des_estado_transferencia);
        else
            usp_print('<font color="red"><b>'||cc.cod_estado_transferencia||'-'||cc.des_estado_transferencia||'</b></font>');
        end if;

        if ( cc.cod_estado_transferencia = 0 ) then        
              usp_print('
                  <td valign="center" align="center">');       
        else
              if ( cc.cod_estado_transferencia = '10' and cc.fec_transferencia is not null) then            
                  usp_print('
                    <td valign="center" align="center">'||cc.valida_mef);        
              else
               usp_print('
                  <td valign="center" align="center">'||cc.valida_mef);
              end if; 
      end if;

        usp_print('
            </td>
            <td valign="center" align="center">'||cc.fec_transferencia);
-- (3/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
if ln_modulo = 1 then        
       if ( cc.cod_estado_transferencia != 10 /*and cc.cod_estado_transferencia != 5*/  and cc.cod_estado_transferencia != 3 ) then
            usp_print('
                <input type="button" name="g" value="Enviar" OnClick="ReenviarTransf('''||cc.id_transaccion||''', ''doTransferMEFIni'')"/>
            ');
        end if;
end if;        
        usp_print('
            </td>
            <td>'||cc.usuario_transfer||'</td>
        </tr>
            ');

        if ( ln_ind_show_error = 1 ) then
            for ce in c_error(cc.id_transaccion,ln_ind_show_error) loop
              usp_print('
        <tr bgcolor="#ff9999">
            <td colspan="8" class="recuadro">'||ce.des_error||'</td>
        </tr>
              ');
            end loop;
        end if;
    end loop;

    usp_print('
    </table>');

    ----------- Java Script ---------
    usp_print('
      <script LANGUAGE="JavaScript"">
        // Temporary variables to hold mouse x-y pos.s
        var tempX = 0
        var tempY = 0

        var gn_id_oper      = 0;

        // Main function to retrieve mouse x-y pos.s

        function getMouseXY(e)
          {
          if (IE)
            { // grab the x-y pos.s if browser is IE
            tempX = event.clientX + document.body.scrollLeft
            tempY = event.clientY + document.body.scrollTop
            }
          else
            {  // grab the x-y pos.s if browser is NS
            tempX = e.pageX
            tempY = e.pageY
            }
          // catch possible negative values in NS4
          if (tempX < 0){tempX = 0}
          if (tempY < 0){tempY = 0}
          // show the position values in the form named Show
          // in the text fields named MouseX and MouseY
          // document.Show.MouseX.value = tempX
          // document.Show.MouseY.value = tempY
          return true
          }

          function f_show_xml(num)
            {
        //    alert("gn_id_oper : "+gn_id_oper+"\nnum    :"+num);
            if (gn_id_oper != 0)
              {
              if (gn_id_oper != num)
                {
                f_ocultar(gn_id_oper);
                f_mostrar(num);
                gn_id_oper = num;
                }
              else
                {
                f_ocultar(gn_id_oper);
                gn_id_oper = 0;
                }
              }
            else
              {
              f_mostrar(num);
              gn_id_oper = num;
              }
            }

          function f_mostrar(num)
            {
            eval("dv"+num).style.top     = tempY+10;
            eval("dv"+num).style.display = "";
            eval("b_show"+num).value     = "Ocultar XML";
            }
          function f_ocultar(num)
            {
            eval("dv"+num).style.display = "none";
            eval("b_show"+num).value     = "Ver XML";
            }

        // Detect if the browser is IE or not.
        // If it is not IE, we assume that the browser is NS.
        var IE = document.all?true:false

        // If NS -- that is, !IE -- then set up for mouse capture
        if (!IE) document.captureEvents(Event.MOUSEMOVE)

        // Set-up to use getMouseXY function onMouseMove
        document.onmousemove = getMouseXY;

        function ReenviarTransf(nro,objScrdo)
        {
           var Rpta;
           if ( Rpta = window.confirm("¿ Desea enviar manualmente la transferencia Nro. "+nro+" ?"))
           {
              //window.open("portlet5open.asp?_portletid_=mod_ConsolaContratos&scriptdo="+objScrdo+"&ag_id_operacion="+nro+"&ag_n_convoca='||ln_n_convoca||'&ag_cod_contrato='||ln_cod_contrato||'","Contraseña","toolbar=no,Width=300,Height=100,scrollbars=yes,modal=yes,dependent,alwaysRaised");
               window.open("ControllerServletOpen?portletid=mod_ConsolaContratos&scriptdo="+objScrdo+"&ag_id_operacion="+nro+"&ag_n_convoca='||ln_n_convoca||'&ag_cod_contrato='||ln_cod_contrato||'","Contraseña","toolbar=no,Width=300,Height=100,scrollbars=yes,modal=yes,dependent,alwaysRaised");
              return true;
           }
           else return false;
        }
       </script>
      ');

   End;

/**************** ReEnvio del Contrato al MEF **********************/
PROCEDURE uspReenvioTransferIniDoView (
    ag_id_operacion       varchar2,
    ag_n_convoca          varchar2,
    ag_cod_contrato       varchar2,
    ag_anhoentidad        varchar2,
    ag_eue_codigo         varchar2,
    session__userid       varchar2)
Is
    -------- Variables --------
    ln_estado_transf  number;
    ln_id_operacion   number;
Begin

    if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
    end if;

    ln_id_operacion:= to_number(ag_id_operacion);
    ---------- Cabecera ------------
    usp_print('
    <center>');
    -------- Mensaje de Espera ----------
    usp_print('
        <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
            <tr>
                <td align="center">
                    <br/>
                    <IMG src="'||gpk_barra_avance||'" width="270">
                    <h5>
                        <font size="2">
                            Enviando la transferencia nro '||ln_id_operacion||'
                            <br/>
                            <br/>
                            espere por favor....
                        </font>
                    </h5>
                </td>
            </tr>
        </table>
        <input type="hidden" name="ag_n_convoca" value="'||ag_n_convoca||'" />
        <input type="hidden" name="ag_cod_contrato" value="'||ag_cod_contrato||'" />
        <input type="hidden" name="ag_anhoentidad" value="'||ag_anhoentidad||'" />
        <input type="hidden" name="ag_eue_codigo" value="'||ag_eue_codigo||'" />
        <input type="hidden" name="ag_id_operacion" value="'||ln_id_operacion||'" />
        <input type="hidden" name="ag_cod_estado_transf" />
    </center>');

    -------- Ejecuta la Transferencia ---------
    reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion(ln_id_operacion);

    -------- Obtiene el estado de la transferencia -------
    select a.cod_estado_transferencia Into ln_estado_transf
    FROM reg_procesos.contrato_operacion a
    where a.id_operacion = ln_id_operacion;

    if ( ln_estado_transf is not null ) then
        usp_print('
    <script language="javascript">
        thisform.ag_cod_estado_transf.value='||ln_estado_transf||';
        thisform.scriptdo.value="doTransferMEFFin";
        thisform.submit();
    </script>');
    end if;
End;

/*******************************************************/
PROCEDURE uspReenvioTransferFinDoView (
    ag_id_operacion       varchar2,
    ag_cod_estado_transf  varchar2,
    ag_n_convoca          varchar2,
    ag_cod_contrato       varchar2,
    ag_anhoentidad        varchar2,
    ag_eue_codigo         varchar2,
    session__userid       varchar2)
Is
    -------- Variables --------
    ln_estado_transf     number;
    ln_id_operacion      number;
    ln_cod_estado_transf number;
    valida_mef varchar2(500);
Begin


    if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
    end if;

    ln_id_operacion:= to_number(ag_id_operacion);
    ln_cod_estado_transf:= to_number(ag_cod_estado_transf);

    ---------- Cabecera ------------
    usp_print('
    <center>
        <br>
        <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
            <tr>
                <td align="center">');

    if  (ln_cod_estado_transf = 3) then
          usp_print('
                        <h5><font color="red"> La entidad no se encuentra habilitada para registrar contratos <font></h4>');
    end if; 

    usp_print('
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br>');

    select F_REPLACE_TILDES(valida_mef) into valida_mef from reg_procesos.contrato_operacion 
    where id_operacion=ln_id_operacion;

    if (ln_cod_estado_transf = 10 and substr(valida_mef,1,1)='1') then
        usp_print('
                        <h5>Se Transfiri&oacute; correctamente.</h4>');
    else
        if(valida_mef ='Servicio del MEF no disponible') then  
                    usp_print(' 
                        <h5><font color="red">¡¡¡ Servicio del MEF no disponible !!!</font></h4>');               
        else
                     if(valida_mef ='Servicio del OSCE no disponible') then
                     usp_print(' 
                        <h5><font color="red">¡¡¡ Servicio del OSCE no disponible !!!</font></h4>');                      
                     else                    
                     usp_print(' 
                        <h5><font color="red">¡¡¡ No se pudo transferir !!!</font></h4>');     
                     end if;
        end if;   

    usp_print('
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br>');
    /*
    if (ln_cod_estado_transf = 10) then
        usp_print('
                    <input type="button" name="h" value="Cerrar" OnClick="f_return()"/>');
    else
        usp_print('
                    <input type="button" name="h" value="Cerrar" OnClick="window.close();"/>');
    end if;
    */
    usp_print('<input type="button" name="h" value="Cerrar" onclick="window.close();thisform.scriptdo.value=''doViewTransferencias'';thisform.submit();f_return();">');  
    end if;

        usp_print('
                </td>
            </tr>
        </table>
        <input type="hidden" name="ag_n_convoca"    value="'||ag_n_convoca||'"/>
        <input type="hidden" name="ag_cod_contrato" value="'||ag_cod_contrato||'"/>
        <input type="hidden" name="ag_anhoentidad"  value="'||ag_anhoentidad||'"/>
        <input type="hidden" name="ag_eue_codigo"   value="'||ag_eue_codigo||'"/>
        <input type="hidden" name="ag_id_operacion" value="'||ln_id_operacion||'"/>
    </center>');

    --------- Java Script ---------
    usp_print('
    <script language="javascript">
    function f_return()
    {
        if (top.opener)
        {
            top.opener.location.reload();
        }
        else
        {
            if (opener)
                opener.location.reload();
        }
        window.close();
    }
    </script>');
End;

   /*******************************************************/
  PROCEDURE uspValRNPProrrogaDoView
     ( ag_n_convoca            varchar2,
       ag_ind_consorcio        varchar2,
       ag_ruc_contratista      varchar2,
       ag_cod_contrato         varchar2,
       ag_cod_contrato_ren     varchar2,
       ag_n_contrato           varchar2,
       ag_codmoneda_contrato   varchar2,
       ag_f_contrato           varchar2,
       ag_m_contratado         varchar2,
       ag_des_causa_renov      varchar2,
       ag_des_contrato         varchar2,
       ag_plazo                varchar2,
       ag_f_culminacion        varchar2,
       ag_codconsucode         varchar2,
       ag_anhoentidad          varchar2,
       ag_cod_operacion        varchar2,
       ag_reg_cal_modif        varchar2,
       ag_codconsucode_paga    varchar2,
       ag_anhoentidad_paga     varchar2,
       ag_ncor_orden_pedido    varchar2,
       ag_cm_opc               varchar2,
       ag_cm_oper_compra       varchar2,
       ag_id_usuario           varchar2,
       ag_back_page            varchar2,
       session__userid         varchar2) Is

      ls_result_valrnp  varchar2(2000);

    Begin

    if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
    end if;

    ----------------------------------------------------
    usp_print('
        <input type="hidden"  name ="ag_n_contrato"
                     value="'||ag_n_contrato||'" />
        <input type="hidden"  name ="ag_codmoneda_contrato"
                     value="'||ag_codmoneda_contrato||'" />
        <input type="hidden"  name ="ag_des_causa_renov"
                     value="'||ag_des_causa_renov||'" />
        <input type="hidden"  name ="ag_plazo"
                     value="'||ag_plazo||'" />
        <input type="hidden"  name ="ag_f_culminacion"
                     value="'||ag_f_culminacion||'" />
        <input type="hidden"  name ="ag_f_contrato"
                     value="'||ag_f_contrato||'" />
        <input type="hidden"  name ="ag_cod_contrato_ren"
                     value="'||ag_cod_contrato_ren||'" />
        <input type="hidden"  name ="ag_id_usuario"
                     value="'||ag_id_usuario||'" />
        <input type="hidden"  name ="ag_n_convoca"
                     value="'||ag_n_convoca||'" />
        <input type="hidden"  name ="ag_cod_contrato"
                     value="'||ag_cod_contrato||'" />
        <input type="hidden"  name ="ag_m_contratado"
                     value="'||ag_m_contratado||'" />
        <input type="hidden"  name ="ag_ncor_orden_pedido"
                     value="'||ag_ncor_orden_pedido||'" />
        <input type="hidden"  name ="ag_cod_contrato_ren"
                     value="'||ag_cod_contrato_ren||'" />
        <input type="hidden"  name ="ag_des_contrato"
                     value="'||ag_des_contrato||'" />
        <input type="hidden"  name ="ag_codconsucode"
                     value="'||ag_codconsucode||'" />
        <input type="hidden"  name ="ag_anhoentidad"
                     value="'||ag_anhoentidad||'" />
        <input type="hidden"  name ="ag_cod_operacion"
                     value="'||ag_cod_operacion||'" />
        <input type="hidden"  name ="ag_reg_cal_modif"
                     value="'||ag_reg_cal_modif||'" />
        <input type="hidden"  name ="ag_codconsucode_paga"
                     value="'||ag_codconsucode_paga||'" />
        <input type="hidden"  name ="ag_anhoentidad_paga"
                     value="'||ag_anhoentidad_paga||'" />
        <input type="hidden"  name ="ag_cm_opc"
                     value="'||ag_cm_opc||'" />
        <input type="hidden"  name ="ag_cm_oper_compra"
                     value="'||ag_cm_oper_compra||'" />
       ');

        --------------------------------------------------
        if (ag_n_convoca is not null ) then
              ls_result_valrnp:= reg_procesos.F_VALIDA_CONT_RNP(
                                 ag_n_convoca, ag_ind_consorcio,
                                 ag_ruc_contratista,
                                 null, to_date(ag_f_contrato, 'dd/mm/yyyy'));

              if (ls_result_valrnp is not null) then
                  if (substr(ls_result_valrnp,1,1) != 1) then -- RUC No esta Vigente ---
                      begin
                           usp_print('
                             <center>
                                    <br>
                                    <h3> El RUC Del Contratista('||ag_ruc_contratista||') No está Vigente para la Fecha del Complementario..!</h3>
                                    <h3>'||substr(ls_result_valrnp,3,length(ls_result_valrnp))||'</h3>
                             </center>
                             <center>
                             ');

                           usp_print(REG_PROCESOS.PKU_XPORTAL_UTILS.UFUTIL_MKBTM(ag_back_page,'Regresar &gt;&gt;',''));
                           usp_print( '</center> ');

                           return;
                      end; 
                   end if;
               end if;

               --------- RUC Vigencia o No necesita validacion ---
               usp_print('
                   <script language="javascript">
                      thisform.scriptdo.value='''||ag_back_page||''';
                      thisform.submit();
                   </script>
                ');

        end if;

    End;


END;
/
