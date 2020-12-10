CREATE OR REPLACE PACKAGE                "PKU_GESTOR_CONT_UTILES_2" 
  IS
  type ref_cursor is ref cursor;

   function f_cClasesGarantia return ref_cursor;  
   function f_cClaseGarRazon( ag_clase number ) return ref_cursor;

   FUNCTION f_get_tipo_validos( ag_n_convoca NUMBER)    RETURN NUMBER ;

/*******************************************************************************
/ Procedimiento : f_list_contratos
/ Proposito :    Contratos , complementarios o prorrogas relacionados a un contrato original
/ Entradas : AV_COD_CONTRATO_ORIGINAL
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     15/07/2011 11:59  Version Inicial
/******************************************************************************/

function f_list_contratos(AV_COD_CONTRATO_ORIGINAL varchar2 ) return ref_cursor;
function f_get_anhos_v3(pv_select varchar, gv_entidad VARCHAR2) return varchar;

--------------------------------------------------------------------------------
--  Obtiene el objeto de la convocatoria
--------------------------------------------------------------------------------
   FUNCTION f_getcodobjeto (ag_n_convoca IN NUMBER)
      RETURN NUMBER;  

 /*******************************************************************************
/ Procedimiento : f_ctipo_causa
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                         Version Inicial
/******************************************************************************/ 
  function f_ctipo_causa(flag_operacion number) return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_ctipo_mecanismo
/ Proposito :   Lista los tipos de contrato
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_ctipo_mecanismo return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_ctipo_resultado_liq
/ Proposito :   Lista los tipos de contrato
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     27-05-2009 18:10  Version Inicial
/******************************************************************************/

function f_ctipo_resultado_liq return ref_cursor;


/*******************************************************************************
/ Procedimiento : f_get_referencia_proceso
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Michell Salas                         Version Inicial
/******************************************************************************/

   function f_get_anho_actual      return  varchar2;

/*******************************************************************************
/ Procedimiento : f_get_list_item_cont
/ Proposito :     Funcion que retorna listado de item por contrato
/ Entradas :      n_contrato
/ Salidas:        listado de item para ese contrato
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Darwin Rodriguez                       Version Inicial
/******************************************************************************/
function f_get_list_item_cont(ag_cod_contrato NUMBER) return varchar2;   

/*******************************************************************************
/ Procedimiento : f_get_referencia_proceso
/ Proposito :     Funcion que retorna la referencia  del proceso
/ Entradas :      n_convoca
/ Salidas:        referencia del proceso
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Michell Salas                              Version Inicial
/******************************************************************************/

  function f_get_referencia_proceso(pn_convoca number default null) return varchar2;

 /*******************************************************************************
/ Procedimiento : f_get_indUserAdmin
/ Proposito :
/ Entradas :    ag_user -> usuario
/ Salidas:      1 : ADM_PROC_SEL_MONITOREO
                0 : no es ADM_PROC_SEL_MONITOREO
                null : error
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     26-10-2007 11:59  Version Inicial
/******************************************************************************/
  function f_get_indUserAdmin(ag_user varchar2 default null) return number;

 /*******************************************************************************
/ Procedimiento : f_get_NumProceso
/ Proposito :
/ Entradas :    ag_n_convoca -> numero de convocatoria
/ Salidas:      Numero del Proceso completo, para mostrar al usuario
                null : error
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Michel Salas     30-10-2007 20:32  Version Inicial
/******************************************************************************/
  function f_get_NumProceso(ag_n_convoca number) return varchar2;

/*******************************************************************************
/ Procedimiento : f_ctipo_contrato
/ Proposito :     Lista los tipos de contratos
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

  function f_ctipo_contrato return ref_cursor;

/*******************************************************************************
/ Procedimiento : f_SumaMontoItemCont
/ Proposito :   Suma del monto de los contratos de una convocatoria para un tipo de item
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Darwin Rodriguez     09-10-2014 02:00  Version Inicial
/******************************************************************************/

function f_SumaMontoItemCont(ag_n_convoca number, ag_proc_item number) return number;  
/*******************************************************************************
/ Procedimiento : f_postor_paq_obra
/ Proposito :   validar si el postor tiene paquetes de item del tipo obras
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Darwin Rodriguez     01-10-2014 02:20  Version Inicial
/******************************************************************************/

procedure f_postor_paq_obra(ag_n_propuesta VARCHAR2, ag_n_convoca number);
/*******************************************************************************
/ Procedimiento : f_cmodalidad_finance
/ Proposito :   modalidades de financiamiento
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

  function f_cmodalidad_finance return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_csistema_finance
/ Proposito :    Lista los tipos de sistemas de adquisiciones
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

  function f_csistema_finance return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_ctipo_modalidad_alcance
/ Proposito :
/ Entradas :     lista las modalidades de alcance
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     26-10-2007 11:59  Version Inicial
/******************************************************************************/

  function f_ctipo_mod_alcance return ref_cursor;

/*******************************************************************************
/ Procedimiento : f_op_contrato
/ Proposito :  monedas
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     23-10-2007 11:59  Version Inicial
/******************************************************************************/
  function f_cmonedas return ref_cursor;

/*******************************************************************************
/ Procedimiento : f_op_moneda
/ Proposito :  monedas por item para  Consola SEACEv3
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Darwin Rodriguez    11-11-2013 17:08  Version Inicial
/******************************************************************************/
  function f_get_monedas_item (ag_nconvoca varchar2) return ref_cursor;

/*******************************************************************************
/ Procedimiento : f_op_contrato
/ Proposito :  monedas
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     23-10-2007 11:59  Version Inicial
/******************************************************************************/
  function f_cUnidadMedida return ref_cursor;

/*******************************************************************************
/ Procedimiento : f_tipo_sancion
/ Proposito :    Tipos de sanciones
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     05-11-2007 11:59  Version Inicial
/******************************************************************************/


  function f_tipo_sancion(ag_ind_seace number) return ref_cursor;

/*******************************************************************************
/ Procedimiento : f_cTipodeCambio
/ Proposito :    Tipos de cambio
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     07-11-2007 11:59  Version Inicial
/******************************************************************************/
  function f_cTipodeCambio return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_ctipo_postor
/ Proposito :    Tipos de postor
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     07-11-2007 11:59  Version Inicial
/******************************************************************************/
 function f_ctipo_postor return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_cPais
/ Proposito :    Paises
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     07-11-2007 11:59  Version Inicial
/******************************************************************************/
  function f_cPais return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_cPais
/ Proposito :    Paises
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     07-11-2007 11:59  Version Inicial
/******************************************************************************/

  function f_get_indSiaf(ag_n_convoca varchar2 default null) return number;
/*******************************************************************************
/ Procedimiento : p_entidad_ejecutora
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     07-11-2007 11:59  Version Inicial
/******************************************************************************/

  procedure p_entidad_pagadora(ag_codconsucode varchar2, ag_anhoentidad varchar2, av_flag number,
ag_ncont out varchar2,ag_codconsucode_paga out varchar2, ag_anhoentidad_paga out varchar2,
ag_descripcion out varchar2);
/*******************************************************************************
/ Procedimiento : f_nom_sancion
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     07-11-2007 11:59  Version Inicial
/******************************************************************************/

  function f_nom_sancion(ag_cod_sancion number) return varchar2;

/*******************************************************************************
/ Procedimiento : P_Mail_ConvocatoriaDoc
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Casta?eda     28-05-2008 11:59  Version Inicial
/******************************************************************************/
procedure P_Mail_ConvocatoriaDoc;

/*******************************************************************************
/ Procedimiento : f_retorna_combo
/ Proposito : Generar el html de un contro html  : <SELECT>... </SELECT>
/ Entradas :   
              pc_cursor       ref_cursor, 
              ag_name         varchar2, 
              ag_codigo       varchar2, 
              ag_libre        varchar2 default null,
              ag_atributos    varchar2 default null
/ Salidas:    Codigo html de un contro html  : <SELECT>... </SELECT>
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     20-03-2009 18:02  Version Inicial
/******************************************************************************/  

FUNCTION f_retorna_combo(
  pc_cursor       ref_cursor, 
  ag_name         varchar2, 
  ag_codigo       varchar2, 
  ag_libre        varchar2 default null,
  ag_atributos    varchar2 default null) RETURN varchar2;

/*******************************************************************************
/ Procedimiento : f_tipo_operacion_contrato
/ Proposito :    Tipos de operaciones contratos
/ Entradas :ag_cadena (ejemplo: '1,2')
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     30-03-2009 11:59  Version Inicial
/******************************************************************************/

function f_tipo_operacion_contrato(ag_cadena varchar2  default null) return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_tipo_instrumento
/ Proposito :    Tipos de operaciones contratos
/ Entradas :ag_cadena (ejemplo: '1,2')
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     30-03-2009 11:59  Version Inicial
/******************************************************************************/

function f_tipo_instrumento(ag_cadena varchar2 default null) return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_entidad_autoriza_adicional
/ Proposito :    Entidades que autoriza un Adicional, en caso de obras se agrega la contratloria..
/ Entradas :   codobjeto,codconsucode, anhoentidad
/ Salidas:  cursor
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     30-03-2009 11:59  Version Inicial
/******************************************************************************/

function f_entidad_autoriza_adicional(ag_codobjeto number,ag_codconsucode varchar2,ag_anhoentidad varchar2,t_tipo_consultoria number, ln_ley number) return ref_cursor;

/*******************************************************************************
/ Procedimiento : f_get_last_upload_contrato
/ Proposito     : Obtiene el ultimo archivo del contrato
/ Entradas      : ag_contrato,ag_nconvoca
/ Salidas       :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-04-2009 09:35  Version Inicial
/******************************************************************************/
PROCEDURE P_last_upload_contrato(
          ag_contrato        IN VARCHAR2, 
          ag_nconvoca        IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2 );



/*******************************************************************************
/ Procedimiento : p_insUploadContrato
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------  ----------------  ---------------------
/ Gerardo Millones P.  22-04-2009 17:40  Version Inicial
/******************************************************************************/
PROCEDURE p_insUploadContrato(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2
);    
/*******************************************************************************
/ Procedimiento : p_insUploadAdicional
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------  ----------------  ---------------------
/ jgarciaf P.  05-11-2018 17:40  Version Inicial
/******************************************************************************/
PROCEDURE p_insUploadAdicional(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2,
lv_id_adi                   NUMBER
);


/*  INICIO  ALEXANDER*/

   PROCEDURE p_insUploadprorroga(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2,
lv_id_prorroga                    NUMBER
);

/* FIN ALEXANDER*/

/*******************************************************************************
/ Procedimiento : f_get_last_upload_Adicional
/ Proposito     : Obtiene el ultimo archivo del Adicional del contrato
/ Entradas      : ag_cod_contrato,ag_n_convoca
/ Salidas       :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ JGARCIAF     11-11-2018 09:35  Version Inicial
/******************************************************************************/
PROCEDURE P_last_upload_adicional(
          ag_cod_contrato   IN VARCHAR2,
          ag_n_convoca      IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2,
           ag_cod_adicional         NUMBER

);



PROCEDURE p_insUploadComplementario(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2,
lv_id_redu                  NUMBER
);



PROCEDURE P_last_upload_complementario(
          ag_cod_contrato   IN VARCHAR2,
          ag_n_convoca      IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2,
          ag_cod_adicional  IN NUMBER
          );


PROCEDURE P_last_upload_prorroga(
          ag_cod_contrato   IN VARCHAR2,
          ag_n_convoca      IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2,
          ag_cod_adicional  IN NUMBER
          );


PROCEDURE usp_XmlItemsManContrato(
         session_COD_CONTRATO        VARCHAR2,
         ag_n_convoca             NUMBER,
         ln_n_propuesta            VARCHAR2
);

PROCEDURE   usp_XmlItemsNewContrato(
         ag_n_propuesta           VARCHAR2, 
         ag_n_convoca              NUMBER,       
         ag_cod_consucode          VARCHAR2 );



/*******************************************************************************
/ Procedimiento : p_insUploadReduccion
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------  ----------------  ---------------------
/ jgarciaf P.  12-11-2018 17:40  Version Inicial
/******************************************************************************/
PROCEDURE p_insUploadReduccion(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2,
lv_id_redu                  NUMBER
);    

/*******************************************************************************
/ Procedimiento : f_get_last_upload_Reduccion
/ Proposito     : Obtiene el ultimo archivo del Adicional del contrato
/ Entradas      : ag_cod_contrato,ag_n_convoca
/ Salidas       :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ JGARCIAF     12-11-2018 09:35  Version Inicial
/******************************************************************************/
PROCEDURE P_last_upload_reduccion(
          ag_cod_contrato   IN VARCHAR2,
          ag_n_convoca      IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2,
          ag_cod_adicional  IN NUMBER
);
/*******************************************************************************
/ Procedimiento : f_getXmlItemsNewContrato
/ Proposito :    
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     04-05-2009 11:59  Version Inicial
/******************************************************************************/

function f_getXmlItemsNewContrato(
         ag_n_propuesta           VARCHAR2, 
         ag_n_convoca             NUMBER,       
         ag_cod_consucode         VARCHAR2,
         ag_cod_presup             out varchar2 ) return VARCHAR2;


function f_cMiembros_postor(ag_n_propuesta varchar2) return ref_cursor;
/*******************************************************************************
/ Procedimiento : f_get_CodNU
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Casta?eda     15-01-2009 03:05  Version Inicial
/******************************************************************************/
  PROCEDURE f_get_CodNU (
     ag_n_convoca            VARCHAR2,
     ag_COD_NU_SEG     OUT   VARCHAR2,
     ag_DES_NU_SEG     OUT   VARCHAR2
   );

/*******************************************************************************
/ Procedimiento : f_getXmlItemsManContrato
/ Proposito :    
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     04-05-2009 11:59  Version Inicial
/******************************************************************************/

function f_getXmlItemsManContrato(
         ag_n_contrato            NUMBER, 
         ag_n_convoca             NUMBER,
         ag_cod_presup        OUT VARCHAR2) RETURN VARCHAR2;   

--------------------------------------------------------------------------------
--- CONTRATOS
--------------------------------------------------------------------------------
 -- Obtiene el indicador de publicacion del contrato

 FUNCTION f_get_indPubContrato (ag_cod_contrato IN NUMBER) RETURN NUMBER;         

------------------------------------------------------------------------------------------------------------------------
----- RESOLUCIONES   
------------------------------------------------------------------------------------------------------------------------

 -- Valida si ya se registro una resolucion de tipo total
 FUNCTION f_valida_resolucionTotal(ag_n_cod_contrato number) RETURN BOOLEAN;

 FUNCTION f_ctipo_resolucion(tipo_operacion number) return ref_cursor;

------------------------------------------------------------------------------------------------------------------------
----- ADELANTOS   
------------------------------------------------------------------------------------------------------------------------

 FUNCTION f_get_topeadelanto(ag_cod_tipo_adelanto NUMBER, ag_codobjeto number) RETURN NUMBER;

 FUNCTION f_get_MontoAdelanto(AG_N_COD_CONTRATO NUMBER,ag_cod_tipo_adelanto NUMBER, ag_n_adelanto number default null, ag_adelanto_actual number default null) RETURN NUMBER;



------------------------------------------------------------------------------------------------------------------------
----- PRORROGAS ------ COMPLEMENTARIOS   
------------------------------------------------------------------------------------------------------------------------
 FUNCTION f_getXmlItemsComPro_sel(
         ag_n_contrato            NUMBER,
         ag_ind_com_pro           NUMBER
       ) return VARCHAR2;

 FUNCTION f_getXmlItemsComPro(
         ag_n_contrato            NUMBER,
         ag_cod_Adicional         NUMBER ) 
         return VARCHAR2;

 FUNCTION f_valida_operaciones(
         ag_codobjeto             NUMBER, 
         ag_tipocontrato          NUMBER 
       ) return boolean;                        

 FUNCTION f_coperacionesAdenda(
         ag_codobjeto             NUMBER,
         ag_n_convoca             NUMBER
       ) return ref_cursor;

 FUNCTION f_getnumdiasoperaciones (
         ag_cod_contrato          NUMBER, 
         ag_cod_operacion         NUMBER)
         return NUMBER;

 FUNCTION f_getnumoperaciones (
         ag_cod_contrato IN NUMBER, 
         ag_cod_operacion NUMBER)
         return NUMBER;

 FUNCTION f_devuelve_num_proc(
         proctipo NUMBER,
         gv_entidad varchar2,
         anhoe VARCHAR2) RETURN varchar2;

 FUNCTION f_get_complementario (
         ag_cod_contrato IN NUMBER) RETURN NUMBER;
------------------------------------------------------------------------------------------------------------------------
------ TOTALES -------    
------------------------------------------------------------------------------------------------------------------------

  FUNCTION f_get_sum_monto_adicional(ag_ncodcontrato number) RETURN NUMBER;

  FUNCTION f_get_sum_monto_reajustes(ag_ncodcontrato number) RETURN NUMBER;

  FUNCTION f_get_sum_monto_gastos(ag_ncodcontrato number)    RETURN NUMBER;

  FUNCTION f_get_sum_monto_penalidades(ag_ncodcontrato number) RETURN NUMBER;

  FUNCTION f_get_numContratos (ag_cod_contrato IN NUMBER, ag_nconvoca IN NUMBER) RETURN NUMBER;

------------------------------------------------------------------------------------------------------------------------
------ CONTRATOS -------    
------------------------------------------------------------------------------------------------------------------------

FUNCTION f_getXmlCalContrato(
         ag_cod_contrato            NUMBER ) RETURN VARCHAR2;
------------------------------------------------------------------------------------------------------------------------
------ VARIOS -------    
------------------------------------------------------------------------------------------------------------------------

FUNCTION f_get_exo_causas_con(ag_n_convoca number) 
         RETURN NUMBER;

FUNCTION f_get_anhos(pv_select varchar, gv_entidad VARCHAR2) 
         return varchar;         

FUNCTION f_get_fecha_fin_amp(ag_cod_contrato varchar2) 
     RETURN  date;

FUNCTION F_VALIDA_FERIADO (AG_FECHA IN DATE)
      RETURN NUMBER;

FUNCTION f_get_fechafin_vig(ag_cod_contrato IN NUMBER,ag_cod_operacion number) RETURN DATE;


------------------------------------------------------------------------------------------------------------------------
------ REAJUSTES -------    
------------------------------------------------------------------------------------------------------------------------

procedure f_getXmlItemsReajuste_sel(
         ag_n_contrato            NUMBER,
         ag_tipo_reajuste         VARCHAR2
       ) ;

FUNCTION f_getXmlItemsReajuste(
         ag_cod_Contrato          NUMBER,
         ag_cod_Reajuste          NUMBER ) RETURN VARCHAR2;

------------------------------------------------------------------------------------------------------------------------
------ CODIGO PRESUPUESTAL  -------    
------------------------------------------------------------------------------------------------------------------------         
FUNCTION f_getXmlItemsCodPresu_sel(

       anho_entidad        varchar2, 
       ag_n_convoca        varchar2, 
       ag_codconsucode     varchar2 ) RETURN VARCHAR2;        

FUNCTION f_getXmlItemsCodPresu(
       anho_entidad        varchar2, 
       ag_codconsucode     varchar2,
       ag_cod_contrato     varchar2 ) return VARCHAR2;        

FUNCTION f_valida_codpresup(
       ag_cod_consucode    varchar2, 
       ag_anhoentidad      varchar2, 
       ag_nconvoca         varchar2) RETURN NUMBER;

FUNCTION f_ccod_presupuesto_conv(
       p_entidad           number, 
       p_anhoentidad       number, 
       p_convoca           number) return ref_cursor;

FUNCTION f_cod_presupuesto_cont(
       p_anhoentidad       number, 
       ag_cod_contrato     number,
       p_convoca           number) return ref_cursor;

----------------------------------------
-- Utiles
----------------------------------------
procedure usp_print_linea_gris;

function f_get_codmoneda_conv( ag_nconvoca number) return number;                        

function f_get_codmoneda_cont( ag_ncod_contrato number) return number;

function f_get_titulo_contrato ( vc_cod_contrato number, vc_titulo varchar, opTitulo varchar2 default null ) return varchar;

function f_get_cad_items( v_cod_contrato number) return varchar2;

function f_get_monto_CC (tipo number, propuesta number,convocatoria  number, item number, organ varchar2) return number; -- 001 ddrodriguez req 85 - 2016
------------------------------------------------------------------------------------------------------------------------
----- ADICIONALES Y REDUCCIONES   
------------------------------------------------------------------------------------------------------------------------
 FUNCTION f_getXmlItemsAdionReduc(
         ag_n_contrato            NUMBER,
         ag_cod_Adicional         NUMBER ) return VARCHAR2;


 FUNCTION f_getXmlCalAdionReduc(
         ag_id_operacion            NUMBER ) RETURN VARCHAR2;

 FUNCTION f_getXmlItemsAdionReducSel(
         ag_n_contrato            NUMBER,
         ag_entidad_sel           VARCHAR2,
         ag_ind_adc_red           NUMBER,
         ln_cod_obj               NUMBER, 
         t_tipo_consultoria       NUMBER) return VARCHAR2;  

 FUNCTION f_getXmlItemsAdionReducSel2(
         ag_n_contrato            NUMBER,
         ag_entidad_sel           VARCHAR2,
         ag_ind_adc_red           NUMBER,
         ln_cod_obj               NUMBER, 
         t_tipo_consultoria       NUMBER,
         n_entidad_autoriza     NUMBER) return VARCHAR2;     

    PROCEDURE   usp_XmlItemsNewContrato_v3(
         ag_n_propuesta            VARCHAR2,
         ag_n_convoca              number,
         ag_cod_consucode          varchar2,
         tipo_moneda               NUMBER );

PROCEDURE usp_XmlItemsManContrato_v3(
         session_COD_CONTRATO        VARCHAR2,
         ag_n_convoca             NUMBER,
         ln_n_propuesta            VARCHAR2
);


PROCEDURE   usp_XmlItemsNewContrato2(
         ag_n_propuesta            VARCHAR2,
         ag_n_convoca              NUMBER,
         ag_cod_consucode          VARCHAR2 );

FUNCTION f_get_tipo_validos_v3( ag_n_convoca NUMBER)
   RETURN NUMBER;


END;

/


CREATE OR REPLACE PACKAGE BODY                "PKU_GESTOR_CONT_UTILES_2" 
IS

--aramirez
/*******************************************************************************
/ Procedimiento : f_retorna_combo
/ Proposito : Generar el html de un contro html  : <SELECT>... </SELECT>
/ Entradas :
              pc_cursor       ref_cursor,
              ag_name         varchar2,
              ag_codigo       varchar2,
              ag_libre        varchar2 default null,
              ag_atributos    varchar2 default null
/ Salidas:    Codigo html de un contro html  : <SELECT>... </SELECT>
/ Indice      Nombre            Fecha y hora      Codigo de atencion         Modificacion
/ -----  -------------------- ----------------  ---------------------   ---------------------
/  000       Gerardo Millones     20-03-2009 18:02                             Version Inicial
/  001       ddrodriguez            19/07/2016        Memorando 85-2016        Validacion para compras corporativas, monto y cantidad asignada a cada entidad participante
/******************************************************************************/
FUNCTION f_retorna_combo(
  pc_cursor       ref_cursor,
  ag_name         varchar2,
  ag_codigo       varchar2,  /* if  condition */
  ag_libre        varchar2 default null /* texto cuando no esta seleccionado */,
  ag_atributos    varchar2 default null) RETURN varchar2

IS
    lv_combo               varchar2(2000);
    lc_cursor              ref_cursor;
    ls_descripcion         varchar2(250);
    ln_codigo              varchar2(25);

BEGIN

    lc_cursor   := pc_cursor;

    lv_combo := '<select id="combo" name="'||ag_name||'" '||ag_atributos||' >';

    If ag_libre is not null then
         lv_combo := lv_combo || '<option value="">'||ag_libre||'</option>';

    End if;

    LOOP

        FETCH lc_cursor INTO ln_codigo, ls_descripcion;
        EXIT WHEN lc_cursor%NOTFOUND;

        lv_combo := lv_combo || '<option value="'|| ln_codigo ||'"' ;

        IF( ag_codigo  = ln_codigo) THEN
                  lv_combo := lv_combo || ' selected ';
        END IF;

        lv_combo := lv_combo || '>' || ls_descripcion || '</option>';

    END LOOP;

    lv_combo := lv_combo || '</select>';

    CLOSE lc_cursor;

    return lv_combo;

END;

function f_get_cad_items( v_cod_contrato number) return varchar2
is
         cursor cItems is
                select i.proc_item
                from reg_procesos.item_contrato i
                where i.n_cod_contrato = v_cod_contrato;

         lv_cad varchar2(1000);
begin
         lv_cad := '';

                for xrow in cItems loop
                    lv_cad := lv_cad || xrow.proc_item || ',';
                end loop;

                return    lv_cad;
end;

---------------------------------------------------
function f_get_titulo_contrato ( vc_cod_contrato number, vc_titulo varchar, opTitulo varchar2 default null ) return varchar
is
    -- Obtenemos los datos del proceso y contrato.
    CURSOR c_proceso( vc_cod_contrato NUMBER ) IS
    SELECT
        a.n_contrato,
        a.ruc_contratista,
        a.nom_contratista,
        mo.simbolo moneda_contrato, -- del contrato
        a.f_vigencia_ini,
        a.f_vigencia_fin,
        f_get_fecha_fin_amp(vc_cod_contrato) f_vigencia_fin_ap,
       /* nvl(ampliacionplazo.f_vigencia_fin,a.f_vigencia_fin) f_vigencia_fin_ap,*/
        to_char(m_contratado, '999,999,999,999.00') m_contratado, -- del contrato
        t.tip_abrev,
        b.proc_num,
        b.anhoentidad,
        b.proc_sigla,
        b.num_convoca, -- de la convocatoria
        o.descripcion objeto,
        b.des_objeto sintesis,
        m.simbolo moneda_convoca, -- de la convocatoria
        to_char(b.v_referencial, '999,999,999,999.00') v_referencial, -- de la convocatoria
        case when b.cod_tipo_subasta = 0 then '(PROCEDIMIENTO CLASICO)' else ts.sigla_abrev end modalidad, -- de la convocatoria
        case when b.ind_part_electronica = 1 then 'Proceso Electronico' else '' end eletronico -- de la convocatoria
   FROM REG_PROCESOS.contrato a
        join REG_PROCESOS.convocatorias b on a.n_convoca = b.n_convoca
        left outer join SEASE.tipo_proceso t on t.tip_codigo = b.proc_tipo
        left outer join REG_PROCESOS.t_tipo_subasta ts on b.cod_tipo_subasta = ts.cod_tipo_subasta
        left outer join REG_PROCESOS.objeto o on b.codobjeto = o.codobjeto
        left outer join REG_PROCESOS.monedas m on b.codmoneda = m.codmoneda
        left outer join REG_PROCESOS.monedas mo on a.mon_codigo = mo.codmoneda
      /*  left outer join
        (
          SELECT N_COD_CONTRATO,F_VIGENCIA_INI,f_vigencia_fin
          FROM (
             select N_COD_CONTRATO,F_VIGENCIA_INI,f_vigencia_fin
               from reg_procesos.contrato_ampliacion_plazo
              where n_Cod_contrato = vc_cod_contrato
              order by cod_ampliacion desc
            ) where rownum = 1
        ) ampliacionplazo
        on a.n_cod_contrato = ampliacionplazo.n_cod_contrato*/
    where a.n_cod_contrato = vc_cod_contrato;

    cursor items_contrato( vc_cod_contrato number ) is
    select trim(to_char(c.proc_item, '99999999')) proc_item
    from reg_procesos.item_contrato c
    where  c.n_cod_contrato = vc_cod_contrato
    order by proc_item;

    lv_rtn varchar(32000):= '';
    vc_cant number;


begin

/*usp_print('<br>vc_cod_contrato:'||vc_cod_contrato);
*/    vc_cant := 0;
    lv_rtn := '<td valign=top width="60%">';

    for i_proc in c_proceso( vc_cod_contrato ) loop

        lv_rtn := lv_rtn||'<h3>'||nvl(opTitulo,vc_titulo||' del Contrato ') || i_proc.n_contrato||'</h3>';
        lv_rtn := lv_rtn||'<h4>Proceso: '||i_proc.tip_abrev||'-'||i_proc.proc_num||'-'||i_proc.anhoentidad||'-'||i_proc.proc_sigla||' ('||i_proc.num_convoca||')';
        lv_rtn := lv_rtn||'<br>'||i_proc.modalidad;
        lv_rtn := lv_rtn||'<br>'||i_proc.eletronico;
        lv_rtn := lv_rtn||'</h4>';
        lv_rtn := lv_rtn||'<b>OBJETO: </b>'||i_proc.objeto||'<br>';
        lv_rtn := lv_rtn||'<b>SINTESIS: </b>'||i_proc.sintesis||'<br>';
--        lv_rtn := lv_rtn||'<b>VALOR REFERENCIAL:&nbsp;</b>'||i_proc.moneda_convoca||'&nbsp;'||i_proc.v_referencial||'<br>';
        lv_rtn := lv_rtn||'<b>MONTO CONTRATADO:&nbsp;</b>'||i_proc.moneda_contrato||'&nbsp;'||i_proc.m_contratado||'<br>';
        lv_rtn := lv_rtn||'<b>VIGENCIA ORIGINAL: </b>'||to_char(i_proc.f_vigencia_ini,'dd/mm/yyyy')||' - '||to_char(i_proc.f_vigencia_fin,'dd/mm/yyyy')||'<br>';
        lv_rtn := lv_rtn||'<b>VIGENCIA ACTUALIZADA: </b>'||to_char(i_proc.f_vigencia_ini,'dd/mm/yyyy')||' - '||to_char(i_proc.f_vigencia_fin_ap,'dd/mm/yyyy')||'<br>';
        lv_rtn := lv_rtn||'<b>PROVEEDOR:&nbsp;</b>'||i_proc.ruc_contratista||'&nbsp;-&nbsp;'||i_proc.nom_contratista||'<br>';
        lv_rtn := lv_rtn||'<b>ITEMS: </b>';

        for iproc_items in items_contrato ( vc_cod_contrato ) loop
            lv_rtn := lv_rtn||iproc_items.proc_item;
            if( to_number(pku_procesos_comun.f_maxitems(vc_cod_contrato)) != to_number(iproc_items.proc_item) ) then
                lv_rtn := lv_rtn||',';
            end if;
        end loop;

    end loop;

    lv_rtn := lv_rtn||'</td>';

    return lv_rtn;
end;






function f_get_anhos(pv_select varchar, gv_entidad VARCHAR2) return varchar
is
    lv_rtn varchar(32000):= null;
    cursor c_anhos is

  select distinct anhoentidad  from reg_procesos.convocatorias where codconsucode = lpad(trim(gv_entidad),6,'0')
  union
  select distinct eue_anho anhoentidad   from REG_PROCESOS.convocatoria_item_plan b where eue_codigo = gv_entidad and eue_anho >= 1995;


begin

 lv_rtn:='<select name="panho" >';
 for item in c_anhos loop
  lv_rtn:=lv_rtn||'<option  value="'||item.anhoentidad||'" '||(case when item.anhoentidad=pv_select then ' selected ' else '' end)||'>'||item.anhoentidad||'</option>';
 end loop;
 return lv_rtn||'</select>';
end;

function f_get_anhos_v3(pv_select varchar, gv_entidad VARCHAR2) return varchar
is
    lv_rtn varchar(32000):= null;  
    cursor c_anhos is

  --  SELECT distinct c_anocon anhoentidad
  --  FROM PRO.TBL_ACT_expediente@AIXSEACE e
  --  where e.n_id_organ = lpad(gv_entidad,6,'0')
  --  union
  --  select distinct eue_anho anhoentidad   from REG_PROCESOS.convocatoria_item_plan b where eue_codigo = lpad(gv_entidad,6,'0') and eue_anho >= 1995;

  -- Formato 1209_OP_SEACE2_CON 
  -- MAMP 28/04/2015 
  -- No se visualiza el proceso en la consola de contratos
  SELECT distinct E.c_aninom anhoentidad
  From Pro.Tbl_Act_Expediente@AIXSEACE E
  Inner Join Adm.Tbl_Adm_Integracion_Ent@AIXSEACE I On E.N_Id_Organ = I.N_Id_Organ
  where I.N_Id_Int_Entidad = lpad(gv_entidad,6,'0')
  union
  select distinct c.anhoentidad  from reg_procesos.convocatorias c where c.codconsucode = lpad(trim(gv_entidad),6,'0')
  union
  select distinct eue_anho anhoentidad   from REG_PROCESOS.convocatoria_item_plan b where eue_codigo = lpad(gv_entidad,6,'0') and eue_anho >= 1995;
  -- Fin
begin

 lv_rtn:='<select name="panho" >';
 for item in c_anhos loop
  lv_rtn:=lv_rtn||'<option  value="'||item.anhoentidad||'" '||(case when item.anhoentidad=pv_select then ' selected ' else '' end)||'>'||item.anhoentidad||'</option>';
 end loop;
 return lv_rtn||'</select>';
end;
/*******************************************************************************
/ Procedimiento : P_Mail_ConvocatoriaDoc
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Casta?eda     28-05-2008 11:59  Version Inicial
/******************************************************************************/
procedure P_Mail_ConvocatoriaDoc
is
  ls_ind_error  varchar2(100);
  ls_conv_id    varchar2(100);
  ls_conv_des   convocatorias.des_objeto%type;
  ls_eue_codigo sease.usuario.eue_codigo%type;

  cursor c_mail_entidad (a_eue_codigo sease.usuario.eue_codigo%type) is
    select usu_email from sease.usuario
        where eue_codigo = a_eue_codigo
          and usu_email is not null
          and apl_codigo = 1
          and usu_activo=1;

  cursor c_newConvocatoriaDoc is
     select n_convoca from convocatoria_doc
        where trunc(fec_upload) = trunc(to_date(sysdate,'dd/mm/yyyy'))
          and cod_tipo_doc = 325;


begin
    for i in c_newConvocatoriaDoc loop
       Select tipo_proceso.tip_abrev||'-'||convocatorias.proc_num||'-'||
              convocatorias.anhoentidad||'-'||convocatorias.proc_sigla, des_objeto, codconsucode
              into ls_conv_id, ls_conv_des, ls_eue_codigo
        from  REG_PROCESOS.convocatorias left outer join sease.tipo_proceso on
              tipo_proceso.tip_codigo = proc_tipo
        where n_convoca = i.n_convoca;
        for e in c_mail_entidad(ls_eue_codigo)loop
           begin
           SP_SEND_MAIL(e.usu_email, 'Notificacion de pronunciamiento registrado para el proceso '||ls_conv_id,
                       'Se ha registrado un pronunciamiento para el proceso '||ls_conv_id||' referente a :  '||
                       chr(13)||chr(13)||upper(ls_conv_des)||chr(13)||chr(13)||
                       '  revisela en la ficha de este proceso');
           exception
             when others then
                ls_ind_error :='' ;
           end;
        end loop;
    end loop;
end;
/*******************************************************************************
/ Procedimiento : p_insUploadContrato
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------  ----------------  ---------------------
/ Gerardo Millones P.  22-04-2009 17:40  Version Inicial
/******************************************************************************/
PROCEDURE p_insUploadContrato(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2
)
IS

   ln_cont         NUMBER;

BEGIN


   SELECT COUNT(1) INTO ln_cont FROM REG_PROCESOS.Convocatoria_Doc WHERE N_CONVOCA = ag_n_convoca AND N_COD_CONTRATO = ag_cod_contrato;

   IF ln_cont = 0  THEN

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
                  DOC_OBS,
                  FEC_APROB,
                  N_COD_CONTRATO,
                  COD_PRORO)

                  VALUES (
                  reg_procesos.f_get_min_n_convoca(ag_n_convoca),
                  REG_PROCESOS.pku_ss_constantes.gn_tipo_doc_contrato,
                  ag_cod_tipo_file,
                  ag_ruta_file ||ag_doc_nombre ,
                  ag_doc_nombre,
                  sysdate,
                  session__userid,
                  session__IIS_REMOTE_ADDR,
                  ag_tamano_bytes,
                  ag_doc_obs,
                  ag_fec_aprob,
                  ag_cod_contrato,
                  NULL);

     ELSE

                  UPDATE reg_procesos.convocatoria_doc
                     SET COD_TIPO_FILE  = ag_cod_tipo_file,
                         DOC_URL        = ag_ruta_file ||ag_doc_nombre ,
                         DOC_NOMBRE     = ag_doc_nombre,
                         FEC_UPLOAD     = sysdate,
                         USER_UPLOAD    = session__userid,
                         IP_FROM_UPLOAD = session__IIS_REMOTE_ADDR,
                         TAMANO_BYTES   = ag_tamano_bytes,
                         DOC_OBS        = ag_doc_obs,
                         FEC_APROB      = ag_fec_aprob
                   WHERE N_CONVOCA       = ag_n_convoca
                     AND N_COD_CONTRATO  = ag_cod_contrato;

     END IF;
END;

/*******************************************************************************
/ Procedimiento : p_insUploadAdicional
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------  ----------------  ---------------------
/ jgarciaf P.  05-11-2018 17:40  Version Inicial
/******************************************************************************/
PROCEDURE p_insUploadAdicional(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2,
lv_id_adi                    NUMBER
)
IS

   ln_cont         NUMBER;


BEGIN

         ln_cont := 0;
 --  SELECT COUNT(1) INTO ln_cont FROM REG_PROCESOS.Convocatoria_Doc WHERE N_CONVOCA = ag_n_convoca AND N_COD_CONTRATO = ag_cod_contrato;

   IF ln_cont = 0  THEN

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
                  DOC_OBS,
                  FEC_APROB,
                  N_COD_CONTRATO,
                  COD_ADICIONAL,
                  COD_PRORO
                  )

                  VALUES (
                  reg_procesos.f_get_min_n_convoca(ag_n_convoca),
                  '901',
                  ag_cod_tipo_file,
                  ag_ruta_file ||'/'||ag_doc_nombre ,
                  ag_doc_nombre,
                  sysdate,
                  session__userid,
                  session__IIS_REMOTE_ADDR,
                  ag_tamano_bytes,
                  ag_doc_obs,
                  ag_fec_aprob,
                  ag_cod_contrato,
                  lv_id_adi,
                  NULL);


     END IF;
END;


--inicio alex


     /*******************************************************************************
/ Procedimiento : p_insUploadprorroga
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------  ----------------  ---------------------
/ aramirez P.  05-11-2018 17:40  Version Inicial
/******************************************************************************/
PROCEDURE p_insUploadprorroga(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2,
lv_id_prorroga                    NUMBER
)
IS

   ln_cont         NUMBER;


BEGIN

         ln_cont := 0;
 --  SELECT COUNT(1) INTO ln_cont FROM REG_PROCESOS.Convocatoria_Doc WHERE N_CONVOCA = ag_n_convoca AND N_COD_CONTRATO = ag_cod_contrato;

   IF ln_cont = 0  THEN

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
                  DOC_OBS,
                  FEC_APROB,
                  N_COD_CONTRATO,
                  COD_ADICIONAL,
                  COD_PRORO)

                  VALUES (
                  reg_procesos.f_get_min_n_convoca(ag_n_convoca),
                  '902',
                  ag_cod_tipo_file,
                  ag_ruta_file ||ag_doc_nombre ,
                  ag_doc_nombre,
                  sysdate,
                  session__userid,
                  session__IIS_REMOTE_ADDR,
                  ag_tamano_bytes,
                  ag_doc_obs,
                  ag_fec_aprob,
                  ag_cod_contrato,
                  NULL,
                   lv_id_prorroga);


     END IF;
END;



--fin alex


/*******************************************************************************
/ Procedimiento : f_get_last_upload_Adicional
/ Proposito     : Obtiene el ultimo archivo del Adicional del contrato
/ Entradas      : ag_cod_contrato,ag_n_convoca
/ Salidas       :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ JGARCIAF     11-11-2018 09:35  Version Inicial
/******************************************************************************/
PROCEDURE P_last_upload_adicional(
          ag_cod_contrato   IN VARCHAR2,
          ag_n_convoca      IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2,
          ag_cod_adicional  IN NUMBER
          )
IS


BEGIN

SELECT COD_DOC,
       replace(DOC_URL, '\', '/') DOC_URL,
       TO_CHAR(FEC_UPLOAD,'DD/MM/YYYY hh24:mi:ss'),
       USER_UPLOAD,
       TO_CHAR(FEC_APROB,'DD/MM/YYYY'),
       EXT_TIPO_FILE,
       replace('bootstrap/'||ICON_TIPO_FILE, 'jpg', 'png') icon_tipo_file,
       --ICON_TIPO_FILE,
       DOC_OBS
    INTO AG_COD_DOC, AG_VDOC_URL,AG_FEC_UPLOAD, AG_USER_UPLOAD, AG_FEC_APROB, AG_EXT_TIPO_FILE, AG_ICON_TIPO_FILE,AG_DOC_OBS
 FROM (
  SELECT d.cod_doc, d.doc_url, d.fec_upload, d.user_upload, d.fec_aprob,T.EXT_TIPO_FILE, T.ICON_TIPO_FILE, D.DOC_OBS,D.COD_ADICIONAL
  FROM REG_PROCESOS.CONVOCATORIA_DOC  d
  INNER JOIN REG_PROCESOS.tipo_archivo T ON D.COD_TIPO_FILE = T.COD_TIPO_FILE
  --INNER JOIN REG_PROCESOS.ADICIONAL_REDUCCION AR ON D.COD_ADICIONAL=AR.COD_ADICIONAL
  WHERE d.cod_tipo_doc  = 901
    AND d.n_convoca     = ag_n_convoca
    AND D.COD_ADICIONAL = ag_cod_adicional
    --AND (d.n_cod_contrato= ag_cod_contrato OR d.n_cod_contrato IS NULL)
  ORDER BY d.FEC_UPLOAD DESC
  )
  WHERE ROWNUM = 1 ; 

 EXCEPTION

 WHEN others THEN


          AG_EXT_TIPO_FILE  := NULL;
          AG_ICON_TIPO_FILE := NULL;

END;


--inicio aramirez

       /*******************************************************************************
/ Procedimiento : f_get_last_upload_PRORROGA
/ Proposito     : Obtiene el ultimo archivo del Adicional del contrato
/ Entradas      : ag_cod_contrato,ag_n_convoca
/ Salidas       :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ ARAMIREZ     11-11-2018 09:35  Version Inicial
/******************************************************************************/
PROCEDURE P_last_upload_prorroga(
          ag_cod_contrato   IN VARCHAR2,
          ag_n_convoca      IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2,
          ag_cod_adicional  IN NUMBER
          )
IS


BEGIN

SELECT COD_DOC,
       replace(DOC_URL, '\', '/') DOC_URL,
       TO_CHAR(FEC_UPLOAD,'DD/MM/YYYY hh24:mi:ss'),
       USER_UPLOAD,
       TO_CHAR(FEC_APROB,'DD/MM/YYYY'),
       EXT_TIPO_FILE,
       replace('bootstrap/'||ICON_TIPO_FILE, 'jpg', 'png') icon_tipo_file,
       --ICON_TIPO_FILE,
       DOC_OBS
    INTO AG_COD_DOC, AG_VDOC_URL,AG_FEC_UPLOAD, AG_USER_UPLOAD, AG_FEC_APROB, AG_EXT_TIPO_FILE, AG_ICON_TIPO_FILE,AG_DOC_OBS
 FROM (
  SELECT d.cod_doc, d.doc_url, d.fec_upload, d.user_upload, d.fec_aprob,T.EXT_TIPO_FILE, T.ICON_TIPO_FILE, D.DOC_OBS,D.COD_PRORO
  FROM REG_PROCESOS.CONVOCATORIA_DOC  d
  INNER JOIN REG_PROCESOS.tipo_archivo T ON D.COD_TIPO_FILE = T.COD_TIPO_FILE
  --INNER JOIN REG_PROCESOS.ADICIONAL_REDUCCION AR ON D.COD_ADICIONAL=AR.COD_ADICIONAL
  WHERE d.cod_tipo_doc  = 902
    AND d.n_convoca     = ag_n_convoca
    AND D.COD_PRORO = ag_cod_adicional
    --AND (d.n_cod_contrato= ag_cod_contrato OR d.n_cod_contrato IS NULL)
  ORDER BY d.FEC_UPLOAD DESC
  )
  WHERE ROWNUM = 1 ; 

 EXCEPTION

 WHEN others THEN


          AG_EXT_TIPO_FILE  := NULL;
          AG_ICON_TIPO_FILE := NULL;

END;

--fin aramirez



--inicio aramirez

       /*******************************************************************************
/ Procedimiento : f_get_last_upload_complementario
/ Proposito     : Obtiene el ultimo archivo del Adicional del contrato
/ Entradas      : ag_cod_contrato,ag_n_convoca
/ Salidas       :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ ARAMIREZ     11-11-2018 09:35  Version Inicial
/******************************************************************************/
PROCEDURE P_last_upload_complementario(
          ag_cod_contrato   IN VARCHAR2,
          ag_n_convoca      IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2,
          ag_cod_adicional  IN NUMBER
          )
IS


BEGIN

SELECT COD_DOC,
       replace(DOC_URL, '\', '/') DOC_URL,
       TO_CHAR(FEC_UPLOAD,'DD/MM/YYYY hh24:mi:ss'),
       USER_UPLOAD,
       TO_CHAR(FEC_APROB,'DD/MM/YYYY'),
       EXT_TIPO_FILE,
       replace('bootstrap/'||ICON_TIPO_FILE, 'jpg', 'png') icon_tipo_file,
       --ICON_TIPO_FILE,
       DOC_OBS
    INTO AG_COD_DOC, AG_VDOC_URL,AG_FEC_UPLOAD, AG_USER_UPLOAD, AG_FEC_APROB, AG_EXT_TIPO_FILE, AG_ICON_TIPO_FILE,AG_DOC_OBS
 FROM (
  SELECT d.cod_doc, d.doc_url, d.fec_upload, d.user_upload, d.fec_aprob,T.EXT_TIPO_FILE, T.ICON_TIPO_FILE, D.DOC_OBS,D.COD_PRORO
  FROM REG_PROCESOS.CONVOCATORIA_DOC  d
  INNER JOIN REG_PROCESOS.tipo_archivo T ON D.COD_TIPO_FILE = T.COD_TIPO_FILE
  --INNER JOIN REG_PROCESOS.ADICIONAL_REDUCCION AR ON D.COD_ADICIONAL=AR.COD_ADICIONAL
  WHERE d.cod_tipo_doc  = 903
    AND d.n_convoca     = ag_n_convoca
    AND D.COD_PRORO = ag_cod_adicional
    --AND (d.n_cod_contrato= ag_cod_contrato OR d.n_cod_contrato IS NULL)
  ORDER BY d.FEC_UPLOAD DESC
  )
  WHERE ROWNUM = 1 ; 

 EXCEPTION

 WHEN others THEN


          AG_EXT_TIPO_FILE  := NULL;
          AG_ICON_TIPO_FILE := NULL;

END;

--fin aramirez










/*******************************************************************************
/ Procedimiento : p_insUploadReduccion
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------  ----------------  ---------------------
/ jgarciaf P.  12-11-2018 17:40  Version Inicial
/******************************************************************************/
PROCEDURE p_insUploadReduccion(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2,
lv_id_redu                  NUMBER
)
IS

   ln_cont         NUMBER;

BEGIN

        ln_cont := 0;

 --  SELECT COUNT(1) INTO ln_cont FROM REG_PROCESOS.Convocatoria_Doc WHERE N_CONVOCA = ag_n_convoca AND N_COD_CONTRATO = ag_cod_contrato;

   IF ln_cont = 0  THEN

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
                  DOC_OBS,
                  FEC_APROB,
                  N_COD_CONTRATO,
                  COD_ADICIONAL,
                  COD_PRORO)

                  VALUES (
                  reg_procesos.f_get_min_n_convoca(ag_n_convoca),
                  '900',
                  ag_cod_tipo_file,
                  ag_ruta_file||'/'||ag_doc_nombre ,
                  ag_doc_nombre,
                  sysdate,
                  session__userid,
                  session__IIS_REMOTE_ADDR,
                  ag_tamano_bytes,
                  ag_doc_obs,
                  ag_fec_aprob,
                  ag_cod_contrato,
                  lv_id_redu,
                  null);


     END IF;
END;



/*******************************************************************************
/ Procedimiento : p_insUploadComplementario
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------  ----------------  ---------------------
/ aramirez P.  12-11-2019 17:40  Version Inicial
/******************************************************************************/
PROCEDURE p_insUploadComplementario(
ag_n_convoca       reg_procesos.convocatoria_doc.n_convoca%type,
ag_fec_aprob       reg_procesos.convocatoria_doc.fec_aprob%type,
ag_doc_obs         reg_procesos.convocatoria_doc.doc_obs%type,
ag_cod_tipo_file   reg_procesos.convocatoria_doc.cod_tipo_file%type,
ag_doc_nombre      reg_procesos.convocatoria_doc.doc_nombre%type,
ag_tamano_bytes    reg_procesos.convocatoria_doc.tamano_bytes%type,
session__userid            VARCHAR2,
session__IIS_REMOTE_ADDR   VARCHAR2,
ag_ruta_file               varchar2,
ag_cod_contrato            varchar2,
lv_id_redu                  NUMBER
)
IS

   ln_cont         NUMBER;

BEGIN

        ln_cont := 0;

 --  SELECT COUNT(1) INTO ln_cont FROM REG_PROCESOS.Convocatoria_Doc WHERE N_CONVOCA = ag_n_convoca AND N_COD_CONTRATO = ag_cod_contrato;

   IF ln_cont = 0  THEN

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
                  DOC_OBS,
                  FEC_APROB,
                  N_COD_CONTRATO,
                  COD_ADICIONAL,
                  COD_PRORO)

                  VALUES (
                  reg_procesos.f_get_min_n_convoca(ag_n_convoca),
                  '903',
                  ag_cod_tipo_file,
                  ag_ruta_file ||ag_doc_nombre ,
                  ag_doc_nombre,
                  sysdate,
                  session__userid,
                  session__IIS_REMOTE_ADDR,
                  ag_tamano_bytes,
                  ag_doc_obs,
                  ag_fec_aprob,
                  ag_cod_contrato,
                  null,
                  lv_id_redu);


     END IF;
END;









/*******************************************************************************
/ Procedimiento : f_get_last_upload_reduccion
/ Proposito     : Obtiene el ultimo archivo del Adicional del contrato
/ Entradas      : ag_cod_contrato,ag_n_convoca
/ Salidas       :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ JGARCIAF     12-11-2018 09:35  Version Inicial
/******************************************************************************/
PROCEDURE P_last_upload_reduccion(
          ag_cod_contrato   IN VARCHAR2,
          ag_n_convoca      IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2,
          ag_cod_adicional  IN NUMBER)
IS


BEGIN

SELECT COD_DOC,
       replace(DOC_URL, '\', '/') DOC_URL,
       TO_CHAR(FEC_UPLOAD,'DD/MM/YYYY hh24:mi:ss'),
       USER_UPLOAD,
       TO_CHAR(FEC_APROB,'DD/MM/YYYY'),
       EXT_TIPO_FILE,
       replace('bootstrap/'||ICON_TIPO_FILE, 'jpg', 'png') icon_tipo_file,
       --ICON_TIPO_FILE,
       DOC_OBS
  INTO AG_COD_DOC, AG_VDOC_URL,AG_FEC_UPLOAD, AG_USER_UPLOAD, AG_FEC_APROB, AG_EXT_TIPO_FILE, AG_ICON_TIPO_FILE,AG_DOC_OBS
 FROM (
  SELECT d.cod_doc, d.doc_url, d.fec_upload, d.user_upload, d.fec_aprob,T.EXT_TIPO_FILE, T.ICON_TIPO_FILE, D.DOC_OBS,D.COD_ADICIONAL
  FROM REG_PROCESOS.CONVOCATORIA_DOC  d
  INNER JOIN REG_PROCESOS.tipo_archivo T ON D.COD_TIPO_FILE = T.COD_TIPO_FILE
  --INNER JOIN REG_PROCESOS.ADICIONAL_REDUCCION AR ON D.COD_ADICIONAL=AR.COD_ADICIONAL
  WHERE d.cod_tipo_doc  = 900
    AND d.n_convoca     = ag_n_convoca
     AND D.COD_ADICIONAL = ag_cod_adicional
   -- AND (d.n_cod_contrato= ag_cod_contrato OR d.n_cod_contrato IS NULL)
  ORDER BY d.FEC_UPLOAD DESC
  )
 WHERE ROWNUM = 1;

 EXCEPTION

 WHEN others THEN


          AG_EXT_TIPO_FILE  := NULL;
          AG_ICON_TIPO_FILE := NULL;

END;


/*******************************************************************************
/ Procedimiento : p_entidad_pagadora
/ Proposito :xo
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     05-11-2007 11:59  Version Inicial
/******************************************************************************/
procedure p_entidad_pagadora(
ag_codconsucode          varchar2,
ag_anhoentidad           varchar2,
av_flag                  number,
ag_ncont             out varchar2,
ag_codconsucode_paga out varchar2,
ag_anhoentidad_paga  out varchar2,
ag_descripcion out       varchar2)
is
    ln_cont number;
begin

    -- pantalla de modificar
    if av_flag = 1 then

        select s.codconsucode,        s.anhoentidad,       s.DESCRIPCION
          into ag_codconsucode_paga , ag_anhoentidad_paga, ag_descripcion
          from sease.entidades s
         where s.codconsucode   = lpad(ag_codconsucode,6,'0')
           and s.anhoentidad    = ag_anhoentidad;

     end if;

    -- pantalla de registro
    if av_flag = 2 then

        select count(1) into ln_cont
        from reg_procesos.contrato_tipo_entidad s
        where s.CODCONSUCODE_EJECU   = ag_codconsucode
        and s.ANHOENTIDAD_EJECU    = ag_anhoentidad;

        ag_ncont := ln_cont;

        if ln_cont > 0 then

            select s.codconsucode_paga  , s.anhoentidad_paga,  e.DESCRIPCION
              into ag_codconsucode_paga , ag_anhoentidad_paga, ag_descripcion
              from reg_procesos.contrato_tipo_entidad s
             inner join sease.entidades e
                on s.codconsucode_ejecu = e.codconsucode
               and s.anhoentidad_ejecu = e.anhoentidad
             where s.codconsucode_ejecu = ag_codconsucode
               and s.anhoentidad_ejecu = ag_anhoentidad;
        else

            select s.codconsucode,        s.anhoentidad,       s.DESCRIPCION
              into ag_codconsucode_paga , ag_anhoentidad_paga, ag_descripcion
              from sease.entidades s
             where s.codconsucode   = lpad(ag_codconsucode,6,'0')
               and s.anhoentidad    = ag_anhoentidad;

        end if;

    end if;

    exception

         WHEN NO_DATA_FOUND THEN
            usp_print('No se encontro datos de la Entidad Pagadora '||'al intentar'||(case av_flag when 1 then ' modificar ' when 2 then ' crear ' end)||' el contrato');
            USP_PRINT('<br>'||SQLERRM);
            usp_print('<br>codconsucode:'||ag_codconsucode);
            usp_print('<br>ag_anhoentidad:'||ag_anhoentidad);
            usp_print('<br>av_flag:'||av_flag);
               usp_print('<br>ln_cont:'||ln_cont);
            return;
         WHEN others THEN
            usp_print('Error al buscar datos de la Entidad Pagadora '||'al intentar'||(case av_flag when 1 then ' modificar '  when 2 then ' crear ' end)||' el contrato');
          --  USP_PRINT('<br>'||SQLERRM);
         --   usp_print('<br>codconsucode:'||ag_codconsucode);
         --   usp_print('<br>ag_anhoentidad:'||ag_anhoentidad);
         --   usp_print('<br>ln_cont:'||ln_cont);
            return;
end;





   FUNCTION f_get_tipo_validos( ag_n_convoca NUMBER)
   RETURN NUMBER IS
     ln_cont NUMBER;
   BEGIN
       /*  select count(1)  cont into ln_cont
        from convocatorias  cc
        where \*cc.anhoentidad = 2010
        and *\cc.ind_conv_ultimo_pub = 1
        and n_convoca  = ag_n_convoca
        and cc.proc_tipo not in (11,23,40);  */

        select count(1)  cont into ln_cont
        from convocatorias  cc
        inner join convocatoria_pub p on cc.n_convoca = p.n_convoca
        where p.n_convoca  = reg_procesos.f_get_min_n_convoca(ag_n_convoca)
        and cc.proc_tipo not in (11,23,40);

        return ln_cont;

   END;



FUNCTION f_get_tipo_validos_v3( ag_n_convoca NUMBER)
   RETURN NUMBER IS
     ln_cont NUMBER;
   BEGIN


        select count(1)  cont into ln_cont
        from convocatorias  cc
        where cc.n_convoca  = ag_n_convoca
        and cc.proc_tipo not in (11,23,40);

        return ln_cont;

   END;

--------------------------------------------------------------------------------
--  Obtiene la fecha final
--------------------------------------------------------------------------------
   FUNCTION f_get_fecha_fin_amp(ag_cod_contrato varchar2)
     RETURN  date IS

     ld_fecha         date;
     ln_convoca       NUMBER;


   BEGIN


   select    max(f_vigencia_fin ) INTO ld_fecha
from (
select n_cod_contrato,f_vigencia_ini,/*f_culminacion,*/ nvl(f_vigencia_fin,f_culminacion)f_vigencia_fin
from reg_procesos.contrato
where (n_cod_contrato = ag_cod_contrato or  (N_COD_CONTRATO_DE_RENOVAC = ag_cod_contrato and cod_operacion_contrato <>6)) -- De acuerdo a MEMO 1093-2014-SDP No se debe cambiar Fecha Actualizada para Complementario
/*order by f_vigencia_fin*/
union
select amp.n_cod_contrato, amp.f_vigencia_ini, amp.f_vigencia_fin
  from reg_procesos.contrato_ampliacion_plazo amp
   where amp.n_cod_contrato = ag_cod_contrato
/*   where amp.n_cod_contrato in  (select n_cod_contrato from reg_procesos.contrato where n_convoca = LN_CONVOCA)
*/    and amp.ind_activo = 1
    );

/*
   SELECT N_CONVOCA INTO LN_CONVOCA FROM REG_PROCESOS.CONTRATO WHERE N_COD_CONTRATO = ag_cod_contrato;

   select    max(f_vigencia_fin ) INTO ld_fecha
from (
select n_cod_contrato,f_vigencia_ini,\*f_culminacion,*\ nvl(f_vigencia_fin,f_culminacion)f_vigencia_fin
from reg_procesos.contrato where n_convoca = LN_CONVOCA\* order by f_vigencia_fin*\
union
select amp.n_cod_contrato, amp.f_vigencia_ini, amp.f_vigencia_fin
  from reg_procesos.contrato_ampliacion_plazo amp
   where amp.n_cod_contrato in  (select n_cod_contrato from reg_procesos.contrato where n_convoca = LN_CONVOCA)
    and amp.ind_activo = 1
    );*/

/*select nvl( ampliacion.f_vigencia_fin ,co.f_vigencia_fin) fin_Vigencia into ld_fecha
From reg_procesos.contrato co
left outer join (
select n_cod_contrato, f_vigencia_ini, f_vigencia_fin
from (
 select amp.n_cod_contrato, amp.f_vigencia_ini, amp.f_vigencia_fin
  from reg_procesos.contrato_ampliacion_plazo amp
   where amp.n_cod_contrato = ag_cod_contrato
    and amp.ind_activo = 1
   order by f_registro desc
 )  where rownum = 1
 )ampliacion on co.n_cod_contrato = ampliacion.n_cod_contrato
where co.n_cod_contrato = ag_cod_contrato ;*/



  /*  select c.f_vigencia_fin into ld_fechaContrato from reg_procesos.contrato c where c.n_cod_contrato = ag_cod_contrato;

    BEGIN
      SELECT f_vigencia_fin INTO ld_fechaAmpliac
      FROM ( select plazo.f_vigencia_fin
               from reg_procesos.contrato_ampliacion_plazo plazo
              where plazo.n_cod_contrato = ag_cod_contrato
              order by plazo.cod_ampliacion desc
              ) WHERE rownum = 1;

    EXCEPTION
              WHEN OTHERS THEN
                ld_fechaAmpliac := NULL;
    END;

    IF  ld_fechaAmpliac IS NULL THEN
        ld_fecha := ld_fechaContrato;
        ag_mensaje:= 'la fecha de fin de vigencia del contrato : '|| to_char(ld_fecha,'dd/mm/yyyy');
    ELSE
        ld_fecha := ld_fechaAmpliac;
        ag_mensaje:= 'la fecha de fin de vigencia de la Ultima Ampliacion de Plazo : '|| to_char(ld_fecha,'dd/mm/yyyy');
    END IF;
     */
    RETURN ld_fecha;

   END;

--------------------------------------------------------------------------------
--  Obtiene el anho actual
--------------------------------------------------------------------------------
   FUNCTION f_get_Anho_Actual
     RETURN  varchar2 IS
     v_anho  varchar2(4);
   Begin
     v_anho:= to_char(sysdate,'YYYY')-1;
     RETURN v_anho;
   end;

--------------------------------------------------------------------------------
--  Obtiene el listado de ítem asociados a un contrato
--------------------------------------------------------------------------------
    function f_get_list_item_cont(ag_cod_contrato NUMBER)  RETURN varchar2
    is
        lv_rtn varchar(50):= '';
        vc_cant number;



    cursor items_contrato ( vc_cod_contrato number ) is
        select trim(to_char(c.proc_item, '99999999')) proc_item
        from reg_procesos.item_contrato c
        where  c.n_cod_contrato = vc_cod_contrato
        order by proc_item;

    begin

    for item in items_contrato ( ag_cod_contrato ) loop
        lv_rtn := lv_rtn||item.proc_item;
        if( to_number(pku_procesos_comun.f_maxitems(ag_cod_contrato)) != to_number(item.proc_item) ) then
            lv_rtn := lv_rtn||',';
        end if;
    end loop;

    return lv_rtn;

    end;
--------------------------------------------------------------------------------
--  Obtiene el numero de operaciones hechas para un tipo especifico
--------------------------------------------------------------------------------
   FUNCTION f_getnumoperaciones (ag_cod_contrato IN NUMBER, ag_cod_operacion NUMBER)
        RETURN NUMBER
   IS
      LN_CONT   NUMBER;
   begin
      -- De acuerdo a Memorando 1093-2014/SDP se debe agregar Contrato Complementario x Item(s)
      IF ag_cod_operacion = 6 THEN

          select count(1) INTO LN_CONT from (
          select c1.n_convoca,c1.proc_item from reg_procesos.item_contrato c1 where n_cod_contrato in (ag_cod_contrato)
          minus
          select c2.n_convoca,c2.proc_item from reg_procesos.item_contrato c2 where c2.n_cod_contrato in (select cn.n_cod_contrato from reg_procesos.contrato cn where cn.n_cod_contrato_de_renovac=ag_cod_contrato));

          IF LN_CONT > 0 THEN
             RETURN 0;
          ELSE
             RETURN 1;
          END IF;

     ELSE

      select count(1) INTO LN_CONT
        from reg_procesos.contrato c
      inner join reg_procesos.contrato co
          on c.n_cod_contrato       = co.n_cod_contrato_de_renovac
       where c.n_cod_contrato       = ag_cod_contrato
         and co.cod_operacion_contrato = ag_cod_operacion;

      RETURN LN_CONT;
   END IF;
/*
      select count(1) INTO LN_CONT
        from reg_procesos.contrato c
      inner join reg_procesos.contrato co
          on c.n_cod_contrato       = co.n_cod_contrato_de_renovac
       where c.n_cod_contrato       = ag_cod_contrato
         and co.cod_operacion_contrato = ag_cod_operacion;

  RETURN LN_CONT;
*/
  END;

--------------------------------------------------------------------------------
-- Obtiene el indicador de publicacion del contrato
--------------------------------------------------------------------------------
   FUNCTION f_get_indPubContrato (ag_cod_contrato IN NUMBER)
      RETURN NUMBER
   IS
      ln_ind_contrato   NUMBER;

   BEGIN
      BEGIN
         SELECT c.ind_contrato_pub INTO ln_ind_contrato
           FROM reg_procesos.contrato c
          WHERE c.n_cod_contrato = ag_cod_contrato;

      EXCEPTION

         WHEN NO_DATA_FOUND THEN

            ln_ind_contrato := NULL;
      END;

      RETURN ln_ind_contrato;
   END;

-----------------------------------------------------------------------------------
--  Obtiene la fecha fin de vigencia, teniendo en cuenta las ampliaciones de plazo
-----------------------------------------------------------------------------------

  FUNCTION f_get_fechafin_vig(ag_cod_contrato IN NUMBER,ag_cod_operacion number)
      RETURN DATE
  IS
      LD_FECHA_CONTRATO    DATE;
      LD_FECHA_AP          DATE;
      LD_FECHA             DATE;
  BEGIN

      BEGIN
         SELECT (case ag_cod_operacion when 6 then  s.f_culminacion else  s.f_vigencia_fin  end)
           INTO LD_FECHA_CONTRATO
           FROM reg_procesos.contrato s
          WHERE s.n_cod_contrato = ag_cod_contrato ;
      EXCEPTION
          WHEN OTHERS THEN
              LD_FECHA_AP := NULL;
      END;

      BEGIN

          SELECT f_vigencia_fin INTO LD_FECHA_AP FROM (
            SELECT f_vigencia_fin
              FROM REG_PROCESOS.CONTRATO_AMPLIACION_PLAZO
             WHERE n_cod_contrato = ag_cod_contrato
            ORDER BY cod_ampliacion desc
          ) WHERE rownum = 1;

      EXCEPTION
          WHEN OTHERS THEN
              LD_FECHA_AP := NULL;
      END;

      LD_FECHA := NVL(LD_FECHA_AP,LD_FECHA_CONTRATO);

      RETURN LD_FECHA;

  END;



--------------------------------------------------------------------------------
--  Obtiene los archivos de contrato por contrato
--------------------------------------------------------------------------------
   FUNCTION f_get_numContratos (ag_cod_contrato IN NUMBER, ag_nconvoca IN NUMBER)
      RETURN NUMBER
   IS
      LN_CONT   NUMBER;
   begin

           SELECT count(1) INTO LN_CONT
             from REG_PROCESOS.convocatoria_doc
            where cod_tipo_doc   = 600
              and n_convoca      = ag_nconvoca
              and N_COD_CONTRATO = ag_cod_contrato;


  RETURN LN_CONT;
  END;




--------------------------------------------------------------------------------
--  Obtiene la diferenecia de dias de una prorroga o complementario
--------------------------------------------------------------------------------
   FUNCTION f_getnumdiasoperaciones (ag_cod_contrato IN NUMBER, ag_cod_operacion NUMBER)
      RETURN NUMBER
   IS
      LN_CONT   NUMBER;
   begin

      select sum(co.f_culminacion - co.f_contrato) INTO LN_CONT
        from reg_procesos.contrato c
  inner join reg_procesos.contrato co
          on c.n_cod_contrato = co.n_cod_contrato_de_renovac
       where c.n_cod_contrato = ag_cod_contrato
             and co.cod_operacion_contrato  = ag_cod_operacion;

  RETURN LN_CONT;
  END;


--------------------------------------------------------------------------------
--  OBTIENE EL CONTRATO COMPLEMENTARIO
--------------------------------------------------------------------------------
   FUNCTION f_get_complementario (ag_cod_contrato IN NUMBER)
      RETURN NUMBER
   IS
      ln_cod_contrato  NUMBER;
   BEGIN
      BEGIN
        SELECT c.n_cod_contrato into ln_cod_contrato
          FROM REG_PROCESOS.CONTRATO c
         WHERE c.n_cod_contrato_de_renovac = ag_cod_contrato
           AND c.cod_operacion_contrato = 6;

      EXCEPTION
         WHEN OTHERS THEN
            ln_cod_contrato := NULL;
      END;

      RETURN ln_cod_contrato;
   END;

--------------------------------------------------------------------------------
--  validar si la fecha es feriado o domingo
--------------------------------------------------------------------------------

   FUNCTION F_VALIDA_FERIADO (AG_FECHA IN DATE)
      RETURN NUMBER
   IS
      LN_VALIDA                    NUMBER;
      LS_NLS_TERRITORY_VALUE       VARCHAR2(40);
   BEGIN

     -- Guardamos el valor del NLS_TERRITORY

      SELECT PARM.VALUE INTO LS_NLS_TERRITORY_VALUE
        FROM NLS_SESSION_PARAMETERS PARM
       WHERE parameter = 'NLS_TERRITORY';

      EXECUTE IMMEDIATE 'alter session set NLS_TERRITORY = ''AMERICA''';

      SELECT TO_CHAR(AG_FECHA , 'd') INTO LN_VALIDA FROM dual;

      IF LN_VALIDA = 1 THEN
            RETURN 1;
      END IF;

      SELECT COUNT(1) INTO LN_VALIDA FROM SEASE.FERIADOS F WHERE F.FER_DCODIGO = AG_FECHA;

      IF LN_VALIDA > 0 THEN
            RETURN 1;
      END IF;

       EXECUTE IMMEDIATE 'alter session set NLS_TERRITORY = '''||LS_NLS_TERRITORY_VALUE||'''';

      RETURN 2;
   END;
--------------------------------------------------------------------------------
--  Obtiene el objeto de la convocatoria
--------------------------------------------------------------------------------
   FUNCTION f_getcodobjeto (ag_n_convoca IN NUMBER)
      RETURN NUMBER
   IS
      codobjeto   NUMBER;
   BEGIN
      BEGIN
         SELECT c.codobjeto INTO codobjeto
           FROM reg_procesos.convocatorias c
          WHERE c.n_convoca = reg_procesos.f_get_min_n_convoca(ag_n_convoca);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            codobjeto := NULL;
      END;

      RETURN codobjeto;
   END;

--------------------------------------------------------------------------------
-- Verifica si la operacion se puede hacer para un objeto y tipo de operacion
--------------------------------------------------------------------------------
  function f_valida_operaciones(ag_codobjeto number, ag_tipocontrato number ) return boolean
    is
        ln_cont number;

    begin
    select count(1) into ln_cont
      from reg_procesos.tipo_operacion_contrato_obj
     where cod_operacion_contrato =  ag_codobjeto
       and COD_OPERACION_CONTRATO =  ag_tipocontrato;

     if ln_cont > 0 then

        return true;

     else
        return false;

     end if;

    EXCEPTION

         WHEN NO_DATA_FOUND THEN return false;
         WHEN others THEN        return false;

    end;


--------------------------------------------------------------------------------
-- Indica si un Usuario es ADM_PROC_SEL_MONITOREO
--------------------------------------------------------------------------------
  function f_get_indSiaf(ag_n_convoca varchar2 default null) return number
    is
        ln_indSiaf number;

    begin

      select ep.ind_uso_siaf into ln_indSiaf
        from reg_procesos.entidadue_anho_tipo_proceso ep,
        reg_procesos.convocatorias c
        where ep.eue_codigo = c.codconsucode
          and ep.eue_anho   = c.anhoentidad
          and c.n_convoca   = ag_n_convoca
          and c.proc_tipo   = ep.tip_codigo;

        return ln_indSiaf;

    EXCEPTION

         WHEN NO_DATA_FOUND THEN return null;
         WHEN others THEN        return null;

    end;

--------------------------------------------------------------------------------
-- Indica si un Usuario es ADM_PROC_SEL_MONITOREO
--------------------------------------------------------------------------------
  function f_get_indUserAdmin(ag_user varchar2 default null) return number
    is
        ln_indAdmin number;

    begin

       select sease.F_IS_GRANT_TO_ROL(ag_user,'ADM_PROC_SEL_MONITOREO')
         into ln_indAdmin   from dual;

        return ln_indAdmin;

    EXCEPTION

         WHEN NO_DATA_FOUND THEN return null;
         WHEN others THEN        return null;

    end;

--------------------------------------------------------------------------------
-- Funcion que retorna la referencia  del proceso
--------------------------------------------------------------------------------
    function f_get_referencia_proceso(pn_convoca number default null) return varchar2
    is
        lv_referencia varchar2(500);

    begin

        select --d.des_tipo_subasta||' '
               tp.Proc_tipo_sigla||'-'
               ||p.proc_num ||'-'
               ||c.anhoentidad||'-'
               ||p.proc_sigla||'('
               ||c.num_convoca||')'
          into lv_referencia
          from reg_procesos.procesos p
    inner join reg_procesos.tipo_procesos tp on  p.proc_tipo = tp.proc_tipo
    inner join  reg_procesos.convocatorias c on  p.n_proceso = c.n_proceso
    inner join reg_procesos.t_tipo_subasta d on  c.cod_tipo_subasta=d.cod_tipo_subasta
         where tp.ind_activo =1                 and n_convoca = pn_convoca;

        return lv_referencia;


    EXCEPTION
         WHEN NO_DATA_FOUND THEN
            return null;

         WHEN others THEN
            return null;

    end;

--------------------------------------------------------------------------------
-- Funcion que retorna la suma de ADICIONALES
--------------------------------------------------------------------------------
 FUNCTION f_get_sum_monto_adicional(ag_ncodcontrato number) RETURN NUMBER
 IS
    lv_sum_monto number;

 BEGIN

   SELECT NVL(sum(a.monto_adicional),0) INTO lv_sum_monto
     FROM REG_PROCESOS.ADICIONAL_REDUCCION a
    WHERE n_cod_contrato = ag_ncodcontrato
      AND a.ind_adicional_reduccion = 1;

   RETURN lv_sum_monto;

 EXCEPTION

 WHEN OTHERS THEN
      RETURN 0;
 END;

--------------------------------------------------------------------------------
-- Funcion que retorna la suma de REAJUSTES
--------------------------------------------------------------------------------
 FUNCTION f_get_sum_monto_codPre(ag_nconvoca number) RETURN NUMBER
 IS
    lv_sum_monto number;

 BEGIN

     select sum(monto_asignado) into lv_sum_monto
       from reg_procesos.convocatoria_cod_presup where n_convoca  =  ag_nconvoca;

     RETURN lv_sum_monto;

 EXCEPTION

 WHEN OTHERS THEN
      RETURN null;
 END;

--------------------------------------------------------------------------------
-- Funcion que retorna la suma de REAJUSTES
--------------------------------------------------------------------------------
 FUNCTION f_get_sum_monto_reajustes(ag_ncodcontrato number) RETURN NUMBER
 IS
    lv_sum_monto number;

 BEGIN

     SELECT NVL(SUM(MONTO_REAJUSTE),0) INTO lv_sum_monto
  FROM CONTRATO_REAJUSTE
  WHERE N_COD_CONTRATO = ag_ncodcontrato;

     RETURN lv_sum_monto;

 EXCEPTION

 WHEN OTHERS THEN
      RETURN 0;
 END;

--------------------------------------------------------------------------------
-- Funcion que retorna la suma de GASTOS GENERALES
--------------------------------------------------------------------------------
 FUNCTION f_get_sum_monto_gastos(ag_ncodcontrato number) RETURN NUMBER
 IS
    lv_sum_monto number;

 BEGIN

     lv_sum_monto    := 0;

     RETURN lv_sum_monto;

 EXCEPTION

 WHEN OTHERS THEN
      RETURN 0;
 END;


--------------------------------------------------------------------------------
-- Funcion que retorna la suma de PENALIDADES
--------------------------------------------------------------------------------
 FUNCTION f_get_sum_monto_penalidades(ag_ncodcontrato number) RETURN NUMBER
 IS
    lv_sum_monto number;

 BEGIN

    select NVL(SUM(PENALIDAD_MONTO),0) INTO lv_sum_monto
    from sancion
    WHERE N_COD_CONTRATO = ag_ncodcontrato;

    RETURN lv_sum_monto;

 EXCEPTION

 WHEN OTHERS THEN
      RETURN 0;
 END;



--------------------------------------------------------------------------------
-- Funcion que retorna el numero completo del proceso
--------------------------------------------------------------------------------
 function f_get_NumProceso(ag_n_convoca number)return varchar2
 is
    lv_NumProceso varchar(100);
 begin
   select UF_STR_PROC_NUM(b.PROC_TIPO_SIGLA,a.cod_tipo_subasta,a.proc_num,a.anhoentidad,a.proc_sigla,a.num_convoca)
         into lv_NumProceso
         from reg_procesos.convocatorias a
   inner join reg_procesos.tipo_procesos b
           on a.proc_tipo=b.proc_tipo
        where a.n_convoca=reg_procesos.f_get_max_n_convoca(ag_n_convoca);

    return lv_NumProceso;

 end;

/*******************************************************************************
/ Procedimiento : f_cUnidadMedida
/ Proposito :  Unidades de medida
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     26-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_cUnidadMedida return ref_cursor
is
  lrs_res ref_cursor;

begin
 open lrs_res for

      SELECT unm_codigo, unm_desc FROM sease.unidad_medida;

      return lrs_res;

end;

/*******************************************************************************
/ Procedimiento : f_cmonedas
/ Proposito :  monedas
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     23-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_cmonedas return ref_cursor
is
  lrs_res ref_cursor;

begin
 open lrs_res for
     SELECT mon_codigo, mon_desc FROM sease.moneda;

     return lrs_res;

end;
/**Consola SEACEv3 ****/
function f_get_monedas_item( ag_nconvoca varchar2) return ref_cursor
is
  cur_moneda ref_cursor;
begin
  open cur_moneda for
  --select mon_codigo, mon_desc from sease.moneda where mon_codigo in (select distinct codmoneda from reg_procesos.item_convoca where n_convoca = ag_nconvoca);
  select mon_codigo, mon_desc from sease.moneda where mon_codigo in (
  select distinct ic.codmoneda from reg_procesos.item_convoca ic
  inner join reg_procesos.convocatoria_propuesta_item cpi on ic.n_convoca = cpi.n_convoca and ic.proc_item = cpi.proc_item
  where cpi.n_propuesta = ag_nconvoca);

  return cur_moneda;

end;

/*******************************************************************************
/ Procedimiento : f_ctipo_modalidad_alcance
/ Proposito :   lista las modalidades de alcance
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     26-10-2007 11:59  Version Inicial
/******************************************************************************/
function f_ctipo_mod_alcance return ref_cursor
is
  lrs_res ref_cursor;

begin

    open lrs_res for
        SELECT cod_modalidad_alcance, des_modalidad_alcance
          FROM reg_procesos.tipo_modalidad_alcance
          where intestado = 1
         order by 2;

    return lrs_res;

end;

/*******************************************************************************
/ Procedimiento : f_csistema_finance
/ Proposito :   Lista los tipos de sistemas de adquisiciones
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_csistema_finance return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

       SELECT cod_sist_adquisicion, des_sist_adquisicion
       FROM reg_procesos.tipo_sist_adquisicion
       order by 1;

    return lrs_res;

end;
/*******************************************************************************
/ Procedimiento : f_ctipo_resultado_liq
/ Proposito :   Lista los tipos de contrato
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     27-05-2009 18:10  Version Inicial
/******************************************************************************/

function f_ctipo_resultado_liq return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

    SELECT cod_tipo_resultado, des_tipo_resultado
    FROM reg_procesos.tipo_resultado_liquidacion WHERE IND_ACTIVO = 1
    ORDER BY 2;

    return lrs_res;

end;

/*******************************************************************************
/ Procedimiento : f_ctipo_mecanismo
/ Proposito :   Lista los tipos de contrato
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     27-05-2009 18:10  Version Inicial
/******************************************************************************/

function f_ctipo_mecanismo return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

    SELECT cod_mecanismo, des_mecanismo
    FROM reg_procesos.tipo_mecanismo
    where ind_activo = 1
    ORDER BY 2;

    return lrs_res;

end;

/*******************************************************************************
/ Procedimiento : f_cod_presupuesto_cont
/ Proposito :   Lista los codigo presupuestales de una convocatoria
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_cod_presupuesto_cont(
    p_anhoentidad      number,
    ag_cod_contrato    number,
    p_convoca          number) return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

SELECT distinct m.proy_codigo cod_presupuestal,
                ic.monto,
                ic.proc_item
     FROM REG_PROCESOS.mef_proyectos_entidades p
    inner join REG_PROCESOS.mef_proyectos m           on p.proy_codigo = m.proy_codigo
    inner join REG_PROCESOS.convocatoria_cod_presup s on s.cod_presupuestal = m.proy_codigo
    left outer join  ITEM_CONTRATO_PRESUP ic          on m.proy_codigo = ic.cod_presupuestal
        and ic.n_cod_contrato = ag_cod_contrato
    WHERE /*  p.codconsucode = LPAD(p_entidad, 6, '0')
          and */p.anhoentidad  = p_anhoentidad
          and m.proy_estado  = 'A'
          and s.n_convoca    = p_convoca

    union
     select 'Total' codPresupuestal,null monto_asignado, null proc_item from dual ;

    return lrs_res;

end;



/*******************************************************************************
/ Procedimiento : f_cod_presupuesto_conv
/ Proposito :   Lista los codigo presupuestales de una convocatoria
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_ccod_presupuesto_conv(p_entidad number, p_anhoentidad number, p_convoca number) return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

   SELECT distinct m.proy_codigo cod_presupuestal, s.monto_asignado
     FROM REG_PROCESOS.mef_proyectos_entidades p
    inner join REG_PROCESOS.mef_proyectos m on p.proy_codigo = m.proy_codigo
    inner join REG_PROCESOS.convocatoria_cod_presup s on s.cod_presupuestal = m.proy_codigo
    WHERE s.codconsucode   = LPAD(p_entidad, 6, '0')
          and s.anhoentidad  = p_anhoentidad
          and m.proy_estado  = 'A'
          and s.n_convoca    = p_convoca

    union
     select 'Total' codPresupuestal,null monto_asignado from dual ;

    return lrs_res;

end;


/*******************************************************************************
/ Procedimiento : f_ctipo_contrato
/ Proposito :   Lista los tipos de contrato
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_ctipo_contrato return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for
     select s.cod_tipo_contrato, s.des_tipo_contrato
       from reg_procesos.tipo_contrato s
      order by s.des_tipo_contrato;

    return lrs_res;

end;

/*******************************************************************************
/ Procedimiento : f_ctipo_contrato
/ Proposito :   Lista los tipos de contrato
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_SumaMontoItemCont(ag_n_convoca number, ag_proc_item number) return number
is
  montoSuma number;
  montovalida number;
  esObrasPaquete number;

begin

    select count(1) into esObrasPaquete from reg_procesos.convocatorias c 
    inner join item_convoca ic on ic.n_convoca=c.n_convoca and ic.cod_tipo_detalle_bien=5
    where c.n_convoca = ag_n_convoca and c.codobjeto =3 and ic.proc_item=ag_proc_item;

/*    select count(1) into montovalida from reg_procesos.item_convoca_detalle icd 
    where icd.n_convoca = ag_n_convoca and icd.proc_item=ag_proc_item and icd.nivel5 not in (
    select nvl(nivel5,0) from reg_procesos.item_contrato where n_convoca = ag_n_convoca and proc_item=ag_proc_item); 
*/
    select count(1) into montovalida from pro.tbl_act_item@AIXSEACE i
    where n_id_padre in (select n_id_item from reg_procesos.item_convoca where n_convoca in (ag_n_convoca) and proc_item=ag_proc_item)
    and i.n_id_item not in (select nvl(ic.n_id_item,0) from reg_procesos.item_contrato ic where ic.n_convoca = ag_n_convoca and ic.proc_item=ag_proc_item);

    if esObrasPaquete = 1 and montoValida = 0 then
       return -1; 
    end if;

    select nvl(sum(monto),0) into montoSuma from reg_procesos.item_contrato where n_convoca =ag_n_convoca and proc_item=ag_proc_item;

    return montoSuma;

end;

/*******************************************************************************
/ Procedimiento : f_postor_paq_obra
/ Proposito :   validar si el postor tiene paquetes de item del tipo obras
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Darwin Rodriguez     01-10-2014 02:20  Version Inicial
/******************************************************************************/

procedure f_postor_paq_obra(ag_n_propuesta VARCHAR2, ag_n_convoca number)
is
  cantidad number;
  mensaje varchar2(500);

begin

        select count(*) into cantidad from reg_procesos.item_convoca_detalle where n_convoca in (
        select n_convoca from reg_procesos.convocatorias where n_convoca = ag_n_convoca and codobjeto =3) and proc_item in (
        select proc_item from reg_procesos.items_bp where n_propuesta=ag_n_propuesta and n_buenapro in (select n_buenapro from reg_procesos.buena_pro where n_convoca = ag_n_convoca));

   if  cantidad > 0 then
     usp_print('<script language=javascript> 
                        alert("Este proveedor cuenta con Ítem Paquete adjudicado, de acuerdo al RLCE cada componente del Ítem Paquete debe tener un contrato independiente, para efectuar ello debe seleccionar el botón ¿Agregar Nuevo Ítem al contrato");
                </script>');
   end if;

end;
/*******************************************************************************
/ Procedimiento : f_cTipodeCambio
/ Proposito :    Tipo de cambio
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_cTipodeCambio return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

         Select val_tipo_cambio cambio, codmoneda
           from REG_PROCESOS.t_cat_tipo_cambio
          where ind_vigente = 1
          order by 1;

    return lrs_res;

end;
/*******************************************************************************
/ Procedimiento : f_pais
/ Proposito :    Paises
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/
function f_cPais return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

       select cod_pais, des_pais from reg_procesos.t_pais
                where cod_pais not in ( 604 )
                order by des_pais;

        return lrs_res;
end;


function f_cClasesGarantia return ref_cursor
is
         lrs_res ref_cursor;
begin

         open lrs_res for
         select cod_clase,str_clase from  REG_PROCESOS.GARANTIA_CLASE where ind_estado = 1
         order by 1 ;

         return lrs_res;

end;

function f_cClaseGarRazon( ag_clase number ) return ref_cursor
is
         lrs_res ref_cursor;
begin

    open lrs_res for
    select gr.cod_razon, gr.str_razon
    from reg_procesos.garantia_clase_razon gcr
    inner join reg_procesos.garantia_razon gr on gcr.cod_razon = gr.cod_razon
    where gcr.cod_clase = ag_clase
    and gcr.ind_estado = 1
    and gr.ind_estado = 1 order by 1;

    return lrs_res;

end;

function f_cMiembros_postor(ag_n_propuesta varchar2) return ref_cursor
is
  lrs_res ref_cursor;

begin


    open lrs_res for
    select ruc_miembro,nom_miembro from reg_procesos.consorcio_miembro where cod_consorcio =
    ( select cod_consorcio from reg_procesos.convocatoria_propuesta where n_propuesta = ag_n_propuesta );

    return lrs_res;

end;


/*******************************************************************************
/ Procedimiento : f_ctipo_postor
/ Proposito :    Tipo de postor
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/
function f_ctipo_postor return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

        SELECT a.cod_tipo_postor, a.des_tipo_postor FROM reg_procesos.tipo_postor a;

        return lrs_res;
end;
/*******************************************************************************
/ Procedimiento : f_ctipo_causa
/ Proposito :    Causal de resolucion
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_ctipo_causa(flag_operacion number) return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

    SELECT cod_causa_resoucion, des_causa_resolucion
      FROM reg_procesos.tipo_causa_resolucion
     WHERE operacion = flag_operacion
       AND intEstado = 1 ;

    RETURN lrs_res;

end;


/*******************************************************************************
/ Procedimiento : f_coperacionesAdenda
/ Proposito :
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/
function f_coperacionesAdenda(ag_codobjeto NUMBER, ag_n_convoca NUMBER) return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

    Select t.cod_operacion_contrato,
           t.des_operacion_contrato
      from reg_procesos.tipo_operacion_contrato t
     inner join tipo_operacion_contrato_obj obj
        on t.cod_operacion_contrato = obj.cod_operacion_contrato
     where t.in_adenda   = 1
       and obj.codobjeto = ag_codobjeto
       and not exists (
                     select 1 from convocatorias c
                      inner join reg_procesos.convocatoria_pub pub on c.n_convoca = pub.n_convoca
                      inner join reg_procesos.proceso_doc  d on c.n_proceso = d.n_proceso
                      where c.proc_tipo           = 10
                        and d.cod_causal_exo      in (3,4)
                        and c.ind_conv_ultimo_pub = 1
                        and c.n_convoca           = ag_n_convoca
                      );
    return lrs_res;

end;


/*******************************************************************************
/ Procedimiento : f_cmodalidad_finance
/ Proposito :    modalidades de financiamiento
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

function f_cmodalidad_finance return ref_cursor
is
  lrs_res ref_cursor;

begin
    open lrs_res for

       SELECT cod_modalidad_finan, des_modalidad_finan
       FROM   reg_procesos.tipo_modalidad_finan
       order by 1;

    return lrs_res;

end;
/*******************************************************************************
/ Procedimiento : f_nom_sancion
/ Proposito :    NOmbre de la sancion
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     05-11-2007 11:59  Version Inicial
/******************************************************************************/
function f_nom_sancion(ag_cod_sancion number) return varchar2
is
    lv_nom_sancion varchar2(120);

begin

    select s.DES_SANCION into lv_nom_sancion from reg_procesos.tipo_sancion s
    where s.cod_sancion = ag_cod_sancion;

    return lv_nom_sancion;

    exception

         WHEN NO_DATA_FOUND THEN
                usp_print('Error, no se encontro la descripcion de la sancion');
                return null;
         WHEN others THEN
                usp_print('Error, al intentar buscar la descripcion de la sancion');
                return null;

end;
/*******************************************************************************
/ Procedimiento : f_tipo_sancion
/ Proposito :    Tipos de sanciones
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     05-11-2007 11:59  Version Inicial
/******************************************************************************/

function f_tipo_sancion(ag_ind_seace number) return ref_cursor
is
    cTipoSancion ref_cursor;
begin

    open cTipoSancion for
    SELECT cod_sancion, des_sancion FROM reg_procesos.tipo_sancion
    where ind_seace = ag_ind_seace;

    return cTipoSancion;

end;


/*******************************************************************************
/ Procedimiento : f_get_last_upload_contrato
/ Proposito     : Obtiene el ultimo archivo del contrato
/ Entradas      : ag_contrato,ag_nconvoca
/ Salidas       :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-04-2009 09:35  Version Inicial
/******************************************************************************/
PROCEDURE P_last_upload_contrato(
          ag_contrato        IN VARCHAR2,
          ag_nconvoca        IN VARCHAR2,
          AG_COD_DOC       OUT NUMBER,
          AG_VDOC_URL       OUT VARCHAR2,
          AG_FEC_UPLOAD     OUT VARCHAR2,
          AG_USER_UPLOAD    OUT VARCHAR2,
          AG_FEC_APROB      OUT VARCHAR2,
          AG_EXT_TIPO_FILE  OUT VARCHAR2,
          AG_ICON_TIPO_FILE OUT VARCHAR2,
          AG_DOC_OBS        OUT VARCHAR2)
IS


BEGIN

SELECT COD_DOC,
       replace(DOC_URL, '\', '/') DOC_URL,
       TO_CHAR(FEC_UPLOAD,'DD/MM/YYYY hh24:mi:ss'),
       USER_UPLOAD,
       TO_CHAR(FEC_APROB,'DD/MM/YYYY'),
       EXT_TIPO_FILE,
       replace('bootstrap/'||ICON_TIPO_FILE, 'jpg', 'png') icon_tipo_file,
       --ICON_TIPO_FILE,
       DOC_OBS
  INTO AG_COD_DOC, AG_VDOC_URL,AG_FEC_UPLOAD, AG_USER_UPLOAD, AG_FEC_APROB, AG_EXT_TIPO_FILE, AG_ICON_TIPO_FILE,AG_DOC_OBS
 FROM (
  SELECT d.cod_doc, d.doc_url, d.fec_upload, d.user_upload, d.fec_aprob,T.EXT_TIPO_FILE, T.ICON_TIPO_FILE, D.DOC_OBS
  FROM REG_PROCESOS.CONVOCATORIA_DOC  d
  INNER JOIN REG_PROCESOS.tipo_archivo T ON D.COD_TIPO_FILE = T.COD_TIPO_FILE
  WHERE d.cod_tipo_doc  = 600
    AND d.n_convoca     = ag_nconvoca
    AND (d.n_cod_contrato= ag_contrato OR d.n_cod_contrato IS NULL)
  ORDER BY d.FEC_UPLOAD DESC
  )
  WHERE ROWNUM = 1;

 EXCEPTION

 WHEN others THEN


          AG_EXT_TIPO_FILE  := NULL;
          AG_ICON_TIPO_FILE := NULL;

END;

/*******************************************************************************/


FUNCTION f_get_exo_causas_con(ag_n_convoca number) RETURN NUMBER
IS
         ln_cont NUMBER;
BEGIN

            SELECT COUNT(1) INTO ln_cont
              FROM convocatorias c
        INNER JOIN reg_procesos.proceso_doc  d ON c.n_proceso = d.n_proceso
             WHERE c.proc_tipo = 10
               AND d.cod_causal_exo IN (3,4)
               AND c.n_convoca= ag_n_convoca;

        RETURN ln_cont;

END;


/*******************************************************************************
/ Procedimiento : f_tipo_operacion_contrato
/ Proposito :    Tipos de operaciones contratos
/ Entradas :ag_cadena (ejemplo: '1,2')
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     30-03-2009 11:59  Version Inicial
/******************************************************************************/

function f_tipo_operacion_contrato(ag_cadena varchar2 default null) return ref_cursor
is
    cTipoOperacion ref_cursor;
begin

    open cTipoOperacion for
    select cod_operacion_contrato,des_operacion_contrato
      from tipo_operacion_contrato
     where
      (
        ( ag_cadena is null )
         or
        ( ag_cadena is not null and  cod_operacion_contrato in  (select column_value from table(resumen.split(ag_cadena))))
      );

    return cTipoOperacion;

end;

/*******************************************************************************
/ Procedimiento : f_tipo_instrumento
/ Proposito :    Tipos de operaciones contratos
/ Entradas :ag_cadena (ejemplo: '1,2')
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     30-03-2009 11:59  Version Inicial
/******************************************************************************/

function f_tipo_instrumento(ag_cadena varchar2 default null) return ref_cursor
is
    cTipoOperacion ref_cursor;
begin


    open cTipoOperacion for
    select cod_tipo_instrumento, des_tipo_instrumento
      from reg_procesos.t_tipo_instrumento
     where
      (
        ( ag_cadena is null )
         or
        ( ag_cadena is not null and  cod_tipo_instrumento in  (select column_value from table(resumen.split(ag_cadena))))
      );

    return cTipoOperacion;

end;

/*******************************************************************************
/ Procedimiento : f_entidad_autoriza_adicional
/ Proposito :    Entidades que autoriza un Adicional, en caso de obras se agrega la contratoria..
/ Entradas :   codobjeto,codconsucode, anhoentidad
/ Salidas:  cursor
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     30-03-2009 11:59  Version Inicial
/******************************************************************************/

function f_entidad_autoriza_adicional(ag_codobjeto number,ag_codconsucode varchar2,ag_anhoentidad varchar2,t_tipo_consultoria number, ln_ley number) return ref_cursor
is
    cEntidadAutoriza       ref_cursor;
    lv_codconsucode_cgr    varchar2(6);
    lv_codconsucode        varchar2(60);

begin





    IF ag_codobjeto = 3  or (ag_codobjeto = 4 and t_tipo_consultoria = 2 and ln_ley = 1 )   /* OBRAS u Consultoria con supervisión de obra*/  THEN

      lv_codconsucode_cgr := '000008';
      lv_codconsucode := lpad(ag_codconsucode,6,'0') || ',' || lv_codconsucode_cgr;

    ELSE

        lv_codconsucode := lpad(ag_codconsucode,6,'0') ;

    END IF;


    open cEntidadAutoriza for
         SELECT DISTINCT (e.codconsucode), e.descripcion
                      FROM reg_procesos.entidades e
                      where codconsucode in
                      ( select column_value from table(resumen.split(lv_codconsucode)))
                      and e.anhoentidad = ag_anhoentidad;


    return cEntidadAutoriza;

end;
/*******************************************************************************
/ Procedimiento : f_get_CodNU
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Casta?eda     15-01-2009 03:05  Version Inicial
/******************************************************************************/
  PROCEDURE f_get_CodNU (
     ag_n_convoca            VARCHAR2,
     ag_COD_NU_SEG     OUT   VARCHAR2,
     ag_DES_NU_SEG     OUT   VARCHAR2
   )
   IS
     lv_cod_nu varchar(50);
   BEGIN

    Begin

      SELECT c.COD_NU_SEG INTO lv_cod_nu
        FROM reg_procesos.convocatorias c
       WHERE c.n_convoca = ag_n_convoca;

    exception
       when others then
            lv_cod_nu := null;
    end;

    Begin

      SELECT d.nombre_gru INTO ag_DES_NU_SEG
        from reg_procesos.t_cat_grupo d
       where d.grupo_bien = lv_cod_nu and
             d.tipo_fuente = 'U';
      ag_COD_NU_SEG := lv_cod_nu;

    exception
       when others then
            ag_COD_NU_SEG := null;
            ag_DES_NU_SEG := null;
    end;

   END;



------------------------------------------------------------------------------------------------------------------------
---- COD PRESUPUESTAL ---
------------------------------------------------------------------------------------------------------------------------
/* Valida si la entidad tiene un codigo presupuestal para una convocatoria  */
 FUNCTION f_valida_codpresup(ag_cod_consucode varchar2, ag_anhoentidad varchar2, ag_nconvoca varchar2) RETURN NUMBER
 IS
  ln_cont  NUMBER;
  BEGIN

       SELECT count(1) into ln_cont
      FROM REG_PROCESOS.mef_proyectos_entidades p
        join REG_PROCESOS.mef_proyectos m on p.proy_codigo = m.proy_codigo
        join REG_PROCESOS.convocatoria_cod_presup s on s.cod_presupuestal = m.proy_codigo
      WHERE p.codconsucode = LPAD(trim(ag_cod_consucode), 6, '0')
        and p.anhoentidad  = ag_anhoentidad
        and m.proy_estado  = 'A'
        and s.n_convoca    =  ag_nconvoca;

        return ln_cont;
  END;
------------------------------------------------------------------------------------------------------------------------
----- RESOLUCIONES
------------------------------------------------------------------------------------------------------------------------
/* Valida si ya se registro una resolucion de tipo total */
 FUNCTION f_valida_resolucionTotal(ag_n_cod_contrato number) RETURN BOOLEAN
 IS
    ln_cant_tipo number;
 BEGIN

    SELECT COUNT(cod_tipo_resolucion) INTO ln_cant_tipo
    FROM reg_procesos.contrato_resolucion
    WHERE n_cod_contrato = ag_n_cod_contrato and cod_tipo_resolucion = 2;

    IF ln_cant_tipo > 0 THEN
       RETURN TRUE;
       ELSE
       RETURN FALSE;
    END IF;

 END;

/*******************************************************************************
/ Procedimiento : f_ctipo_resolucion
/ Proposito :    Tipo de resolucion de contrato
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

FUNCTION f_ctipo_resolucion(tipo_operacion NUMBER) RETURN ref_cursor
IS
  lrs_res ref_cursor;

BEGIN

    OPEN lrs_res for

    Select cod_tipo_resoucion, des_tipo_resolucion
    from reg_procesos.tipo_resolucion_contrato
    where
    (
         (tipo_operacion is null)
          or
         (tipo_operacion is not null and cod_tipo_resoucion = tipo_operacion)
    );

    RETURN lrs_res;

END;

------------------------------------------------------------------------------------------------------------------------
----- ADELANTOS
------------------------------------------------------------------------------------------------------------------------

/*******************************************************************************
/ Procedimiento : f_get_topeadelanto
/ Proposito :     Tope del adelanto deacuero el objeto y tipo de adelanto
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

FUNCTION f_get_topeadelanto(ag_cod_tipo_adelanto NUMBER, ag_codobjeto number) RETURN number
IS
   LN_TOPE NUMBER;

BEGIN

  SELECT TOPE INTO LN_TOPE
    FROM ADELANTO_MAXIMO
   WHERE COD_TIPO_ADELANTO = ag_cod_tipo_adelanto
     AND CODOBJETO = ag_codobjeto
     AND ESTADO =  1;

     RETURN LN_TOPE;

END;

/*******************************************************************************
/ Procedimiento : f_get_MontoAdelanto
/ Proposito :     Adelanto actual del contrato
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-10-2007 11:59  Version Inicial
/******************************************************************************/

FUNCTION f_get_MontoAdelanto(AG_N_COD_CONTRATO NUMBER,ag_cod_tipo_adelanto NUMBER, ag_n_adelanto number default null, ag_adelanto_actual number default null) RETURN NUMBER
IS
   LN_MONTO_ADELANTO NUMBER;

BEGIN

  SELECT SUM( (case ag_n_adelanto when adelanto.n_adelanto then ag_adelanto_actual else MONTO_PAGO end )* CAMBIO.val_tipo_cambio) INTO LN_MONTO_ADELANTO
    FROM REG_PROCESOS.ADELANTO
   INNER JOIN REG_PROCESOS.T_CAT_TIPO_CAMBIO CAMBIO  ON ADELANTO.CODMONEDA = CAMBIO.CODMONEDA
   WHERE N_COD_CONTRATO     = AG_N_COD_CONTRATO
     AND COD_TIPO_ADELANTO  = ag_cod_tipo_adelanto
     AND CAMBIO.IND_VIGENTE = 1;

     RETURN nvl(LN_MONTO_ADELANTO,0);

END;


------------------------------------------------------------------------------------------------------------------------
----- XML   ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
------------------------------------------------------------------------------------------------------------------------



PROCEDURE usp_XmlItemsManContrato(
         /* ag_n_contrato            NUMBER, */
         session_COD_CONTRATO        VARCHAR2,
         ag_n_convoca             NUMBER,
         ln_n_propuesta            VARCHAR2
)
IS

  lv_trama_items                VARCHAR2(32767);
  ln_fila                       NUMBER;
  ln_codconsucode               NUMBER;
  ln_anhoentidad                NUMBER;

  ln_min_n_convoca              NUMBER;

  CURSOR citemscontrato (
     pn_nconvoca        NUMBER,
     p_n_cod_contrato   NUMBER,pn_nconvoca_MIN number
  )
  IS

   SELECT DISTINCT
       ict.monto  monto,
       ict.cantidad cantidad,
       ict.proc_item,
     --replace(icv.descripcion,'&','') descripcion,
       REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(icv.descripcion) descripcion,

       icv.dep_codigo,
       icv.pro_codigo, icv.dis_codigo, dep.dep_desc,
       pro.pro_desc, dis.dis_desc, unm.unm_desc,unm.unm_codigo,
       TO_CHAR(ice.f_registro,reg_procesos.pku_ss_constantes.gv_formato_fecha) f_bp_cons,
       ( '['|| icv.dep_codigo||icv.pro_codigo||icv.dis_codigo || '] ['|| icv.dep_codigo|| '] '|| dep.dep_desc || ' / ['|| icv.pro_codigo|| '] ' || pro.pro_desc || ' / ['|| icv.dis_codigo|| '] '|| dis.dis_desc  ) ubigeo,
       /*inicio-Para mostrar la descripcion de item paquete para obras*/
       (select distinct n5.descripcion from reg_procesos.t_cat_nivel5 n5
           inner join reg_procesos.item_contrato ict on n5.nivel5 = ict.nivel5
           inner join reg_procesos.item_convoca ic on ict.n_convoca = ic.n_convoca and ict.proc_item = ic.proc_item and ic.cod_tipo_detalle_bien=5
           where ict.n_convoca = (select n_convoca from reg_procesos.convocatorias where n_convoca=pn_nconvoca_min and codobjeto=3)
           and ict.n_cod_contrato = p_n_cod_contrato) item_paq_desc
        /*fin*/ 
      FROM reg_procesos.item_contrato ict,
           reg_procesos.item_convoca icv,
           sease.dep_ubigeo dep,
           sease.prov_ubigeo pro,
           sease.dist_ubigeo dis,
           sease.unidad_medida unm,

           (
            select icei.* from  reg_procesos.item_convoca_estado icei
           where  icei.n_convoca_src = pn_nconvoca_MIN -- reg_procesos.f_get_min_n_convoca(pn_nconvoca )
           and icei.cod_tipo_Estado_item = 500
           and icei.f_registro = (
                         select max(f_registro) from reg_procesos.item_convoca_estado ice2 where ice2.n_convoca_src  = icei.n_convoca_src and ice2.proc_item = icei.proc_item
                       )
           )ice
     WHERE ict.n_cod_contrato = p_n_cod_contrato
       AND ict.n_convoca = icv.n_convoca
       AND ict.proc_item = icv.proc_item
       AND lpad(trim(icv.dep_codigo),2,'0') = lpad(trim(dis.dep_codigo),2,'0')
       AND lpad(trim(icv.pro_codigo),2,'0') = lpad(trim(dis.pro_codigo),2,'0')
       AND lpad(trim(icv.dis_codigo),2,'0') = lpad(trim(dis.dis_codigo),2,'0')
       AND lpad(trim(dis.dep_codigo),2,'0') = lpad(trim(pro.dep_codigo),2,'0')
       AND lpad(trim(dis.pro_codigo),2,'0') = lpad(trim(pro.pro_codigo),2,'0')
       AND lpad(trim(pro.dep_codigo),2,'0') = lpad(trim(dep.dep_codigo),2,'0')
       AND unm.unm_codigo = ict.unm_codigo

       AND ice.proc_item = ict.proc_item
  ORDER BY ict.proc_item;

BEGIN

   ln_min_n_convoca  := REG_PROCESOS.f_get_min_n_convoca(ag_n_convoca);


   SELECT C.CODCONSUCODE, C.ANHOENTIDAD INTO ln_codconsucode,ln_anhoentidad FROM REG_PROCESOS.CONTRATO C WHERE C.N_COD_CONTRATO = session_COD_CONTRATO;

 usp_print('
    <script language="javascript">


     function PintarLista()
    {

        var stable = "";
        var tipo="readonly";
        var color = "";
        var total_col = 9;
        v_bgcolor = "#ECE9D8";
        v_style = "font-size : 0.9em;";
        v_style2 = "font-size : 0.7em;";
        if (thisform.ag_tipo_modalidad.value != 0 ){
        tipo = "";
        } 
        stable = stable + "<table border=0  align=center class=''table table-striped table-bordered table-hover dataTable no-footer'' cellpadding=3 cellspacing=0>";
        stable = stable + "<thead> <tr style=''background-color: #BDBDBD;color:#111111''>";
        stable = stable + "<td align=center>&nbsp;</td>";
        stable = stable + "<td align=center>Nro.</td>";
        stable = stable + "<td align=center>Item</td>";
        stable = stable + "<td align=center>Descripcion</td>";
        stable = stable + "<td align=center>Componente del<br> item paquete</td>";
        stable = stable + "<td align=center>Fecha de BP<br> Consentida</td>";
        stable = stable + "<td align=center>Lugar de la ejecucion<br> de la Prestacion</td>";
        stable = stable + "<td align=center>U.Medida</td>";
        stable = stable + "<td align=center>Cantidad</td>";
        stable = stable + "<td align=center>Monto Contratado</td>";
        stable = stable + "</tr>";
        stable = stable + "<tr>";
        stable = stable + "<td width=5%>";
        stable = stable + "<input name=ag_unidad_codigo type=hidden>";
        stable = stable + "<input name=ag_itempaq_desc type=hidden>";
        stable = stable + "<input name=ag_nivel5_cod type=hidden>";
        stable = stable + "<input name=ag_monto_adj type=hidden></td>";
        stable = stable + "<td align=center width=5%><input name=button1  value=''...'' type=button onclick=''VerItemContrato_up('||ag_n_convoca||','||session_COD_CONTRATO ||','||TO_NUMBER (ln_codconsucode)||','||ln_n_propuesta ||');''></td>";
        stable = stable + "<td align=center width=5%><input name=ag_proc_item readonly=true  size = 1 style=''font-size : 1.0em;''></input></td>";
       stable = stable + "<td align=left width=20%><input name=ag_descripcion readonly=true  size=50 style=''font-size : 1.0em;''></input></td>";
       stable = stable + "<td align=center width=10%><font size=1><div id=id_itemdiv size =50 ></div></font></td>";
       stable = stable + "<td align=center width=15%><input name=ag_f_bp_cons    readonly=true  size = 11 style=''font-size : 1.0em;''></input></td>";
       stable = stable + "<td align=center width=15%><input name=ag_ubigeo       readonly=true  size = 25 style=''font-size : 1.0em;''></input></td>";
        stable = stable + "<td align=center width=10%><input name=ag_unidad       readonly=true  size = 5  style=''font-size : 1.0em;''></td>";
        stable = stable + "<td align=center width=5%><input name=ag_cantidad  id=ag_cantidad   "+tipo+"  size = 5 onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)''  style=''font-size : 1.0em;''></td>";

        stable = stable + "<td align=center width=10%><input name=ag_monto  id=ag_monto     "+tipo+" onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this) ; this.value = redondear(this.value, 2)'' size = 10 style=''font-size : 1.0em;''></input></td>";


        ');


      usp_print('stable = stable + "</tr></thead> ";

        for (var i=0; i< v_lista.length; i++)
        {
            if (v_lista[i].nro_item != "" )
            {
                color = "";

                stable = stable + "<tr " + color + ">";
                stable = stable + "<td><img src=img/eliminar.gif onclick=''EliminarElemento("+i+")'') />";
                stable = stable + "<input name=ag_unidad_codigo type=hidden value="+v_lista[i].cod_unidad+">&nbsp;</input>";
                stable = stable + "<input name=ag_itempaq_desc type=hidden value="+v_lista[i].itempaq+">&nbsp;</input>";
                stable = stable + "<input name=ag_nivel5_cod type=hidden value="+v_lista[i].nivel5+">&nbsp;</input>";
                stable = stable + "<input name=ag_monto_adj type=hidden  value="+v_lista[i].monto+">&nbsp;</input></td>";
                stable = stable + "<td align=center><font size=1>"+(i+1)+"</font></td>";
                stable = stable + "<td align=center><font size=1>"+v_lista[i].nro_item+"</font></td>";
                stable = stable + "<td align=center><font size=1>"+v_lista[i].descripcion+"</font></td>";
                stable = stable + "<td align=center><font size=1>"+v_lista[i].itempaq+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].f_bp+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].des_ubi+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].des_unidad+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].cantidad+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].monto+"</font></td>";
                stable = stable + "</tr>";

            }
       }
       stable = stable + "</table>";
       EscribirHTML("divLista", stable);
    }


    </script>

    ');


   ln_fila        := 1;




 IF session_COD_CONTRATO is not null THEN


     usp_print('
        <script language="javascript">');

 FOR xrow IN citemscontrato (ag_n_convoca,session_COD_CONTRATO,ln_min_n_convoca) LOOP

       usp_print('
            v_lista[v_lista.length] = new InitLista();
            v_lista[v_lista.length-1].nro_item = "'||xrow.proc_item||'";
            v_lista[v_lista.length-1].descripcion = "'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'";
            v_lista[v_lista.length-1].itempaq = "'|| case when LENGTH(xrow.item_paq_desc)>0 then xrow.item_paq_desc else '-' end||'";
            v_lista[v_lista.length-1].f_bp = "'||xrow.f_bp_cons||'"
            v_lista[v_lista.length-1].des_ubi = "'||xrow.ubigeo||'";
            v_lista[v_lista.length-1].cod_unidad = "'||xrow.unm_codigo||'";
            v_lista[v_lista.length-1].des_unidad = "'||xrow.unm_desc||'";
            v_lista[v_lista.length-1].cantidad = "'||xrow.cantidad||'";
            v_lista[v_lista.length-1].monto = "'||replace(xrow.monto, ',', '.')||'";
            v_lista[v_lista.length-1].nivel5 = "";

            ');


 END LOOP;
 usp_print('
            PintarLista();
        </script>');

 END IF;




END;


PROCEDURE usp_XmlItemsManContrato_v3(
         session_COD_CONTRATO        VARCHAR2,
         ag_n_convoca             NUMBER,
         ln_n_propuesta            VARCHAR2
)
IS

  lv_trama_items                VARCHAR2(32767);
  ln_fila                       NUMBER;
  ln_codconsucode               NUMBER;
  ln_anhoentidad                NUMBER;

  ln_min_n_convoca              NUMBER;
  fecha_registro                 VARCHAR2(8);

  CURSOR citemscontrato (
     pn_nconvoca        NUMBER,
     p_n_cod_contrato   NUMBER,pn_nconvoca_MIN number
  )
  IS

   SELECT DISTINCT
       ict.monto  monto,
       ict.cantidad cantidad,
       ict.proc_item,
       --replace(icv.descripcion,'&','') descripcion,
       REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(icv.descripcion) descripcion,
       icv.dep_codigo,
       icv.pro_codigo, icv.dis_codigo, dep.dep_desc,
       pro.pro_desc, dis.dis_desc, unm.unm_desc,unm.unm_codigo,
       TO_CHAR(ice.f_registro,reg_procesos.pku_ss_constantes.gv_formato_fecha) f_bp_cons,
       ( '['|| icv.dep_codigo||icv.pro_codigo||icv.dis_codigo || '] ['|| icv.dep_codigo|| '] '|| dep.dep_desc || ' / ['|| icv.pro_codigo|| '] ' || pro.pro_desc || ' / ['|| icv.dis_codigo|| '] '|| dis.dis_desc  ) ubigeo,
       tsc.sc_descripcion,tmc.desmodcnt, ict.cod_sc, ict.cod_mc,
       /*inicio-Para mostrar la descripcion de item paquete para obras*/
       /*(/*select distinct n5.descripcion from reg_procesos.t_cat_nivel5 n5
           inner join reg_procesos.item_contrato ict on n5.nivel5 = ict.nivel5
           inner join reg_procesos.item_convoca ic on ict.n_convoca = ic.n_convoca and ict.proc_item = ic.proc_item and ic.cod_tipo_detalle_bien=5
           where ict.n_convoca = (select n_convoca from reg_procesos.convocatorias where n_convoca=pn_nconvoca_min and codobjeto=3)
           and ict.n_cod_contrato = p_n_cod_contrato*/
        /*select distinct nvl(i.c_dsitem,i.c_dcubso)
        from pro.tbl_act_item@aixseace i
		INNER JOIN PRO.TBL_ACT_EXPEDIENTE@AIXSEACE E ON i.N_ID_EXPEDE=E.N_ID_EXPEDE
        where i.n_id_item in (select n_id_item from reg_procesos.item_contrato where n_cod_contrato in (p_n_cod_contrato)) AND E.C_TIPOBJ=64 AND i.N_ID_PADRE IS NOT NULL) item_paq_desc*/
        ipaq.item_paq_desc,
        ipaq.cod_item,
        ipaq.nivel5
        /*fin*/   
      FROM reg_procesos.item_contrato ict left join t_tipo_sist_cont  tsc on ict.cod_sc = tsc.sc_codigo
       left join t_tipo_modcont tmc on ict.cod_mc = tmc.codmodcnt

       LEFT JOIN  
          (select distinct nvl(i.c_dsitem,i.c_dcubso) item_paq_desc ,i.n_id_item cod_item,trim(substr(i.c_ccubso,9, 8)) nivel5
          from pro.tbl_act_item@AIXSEACE i
          inner join pro.tbl_act_expediente@AIXSEACE e on i.n_id_expede=e.n_id_expede
          where i.n_id_item in (select n_id_item from reg_procesos.item_contrato where n_cod_contrato in (p_n_cod_contrato)) and e.c_tipobj=64 and i.n_id_padre is not null) ipaq
          ON IPAQ.cod_item=ict.n_id_item,

           reg_procesos.item_convoca icv,
           sease.dep_ubigeo dep,
           sease.prov_ubigeo pro,
           sease.dist_ubigeo dis,
           sease.unidad_medida unm,

           (
            select icei.* from  reg_procesos.item_convoca_estado icei
           where  icei.n_convoca_src = pn_nconvoca_MIN -- reg_procesos.f_get_min_n_convoca(pn_nconvoca )
           and icei.cod_tipo_Estado_item = 500
           and icei.f_registro = (
                         select max(f_registro) from reg_procesos.item_convoca_estado ice2 where ice2.n_convoca_src  = icei.n_convoca_src and ice2.proc_item = icei.proc_item
                       )
           )ice

     WHERE ict.n_cod_contrato = p_n_cod_contrato
       AND ict.n_convoca = icv.n_convoca
       AND ict.proc_item = icv.proc_item
       AND lpad(trim(icv.dep_codigo),2,'0') = lpad(trim(dis.dep_codigo),2,'0')
       AND lpad(trim(icv.pro_codigo),2,'0') = lpad(trim(dis.pro_codigo),2,'0')
       AND lpad(trim(icv.dis_codigo),2,'0') = lpad(trim(dis.dis_codigo),2,'0')
       AND lpad(trim(dis.dep_codigo),2,'0') = lpad(trim(pro.dep_codigo),2,'0')
       AND lpad(trim(dis.pro_codigo),2,'0') = lpad(trim(pro.pro_codigo),2,'0')
       AND lpad(trim(pro.dep_codigo),2,'0') = lpad(trim(dep.dep_codigo),2,'0')
       AND unm.unm_codigo = ict.unm_codigo

       AND ice.proc_item = ict.proc_item
  ORDER BY ict.proc_item;



BEGIN

  select to_char(F_REGISTRO,'yyyymmdd' ) into fecha_registro from reg_procesos.convocatorias where n_convoca  = ag_n_convoca;

   ln_min_n_convoca  := REG_PROCESOS.f_get_min_n_convoca(ag_n_convoca);

   SELECT C.CODCONSUCODE, C.ANHOENTIDAD INTO ln_codconsucode,ln_anhoentidad FROM REG_PROCESOS.CONTRATO C WHERE C.N_COD_CONTRATO = session_COD_CONTRATO;

   usp_print('
    <script language="javascript">


     function PintarLista3()
    {
        var stable = "";
        var tipo="readonly";
        var color = "";
        var total_col = 9;
        v_bgcolor = "#ECE9D8";
        v_style = "font-size : 0.9em;";
        v_style2 = "font-size : 0.7em;";
        var fecharegistro = "'||fecha_registro||'" ;

         if (thisform.ag_tipo_modalidad.value != 0 ){
        tipo = "";
        }

        stable = stable + "<table border=0  align=center class=''table table-striped table-bordered table-hover dataTable no-footer'' cellpadding=3 cellspacing=0>";
        stable = stable + "<thead> <tr style=''background-color: #BDBDBD;color:#111111''>";
        stable = stable + "<td align=center  width=5%>&nbsp;</td>";
        stable = stable + "<td align=center  width=5%>Nro.</td>";
        stable = stable + "<td align=center  width=5%>Item</td>";
        stable = stable + "<td align=center  width=20%>Descripcion</td>";
        stable = stable + "<td align=center  width=10%>Componente del<br> item paquete</td>";
        stable = stable + "<td align=center  width=10%>Fecha de BP<br> Consentida</td>";
        stable = stable + "<td align=center  width=10%>Lugar de la ejecucin<br> de la Prestacion</td>";
        stable = stable + "<td align=center  width=10%>U.Medida</td>";
        stable = stable + "<td align=center  width=5%>Cantidad</td>";
        stable = stable + "<td align=center  width=10%>Monto Contratado</td>";
         stable = stable + "<td align=center  width=5%>Sistema de<br> Contratacion</td>";
         stable = stable + "<td align=center  width=5%>Modalidad de Ejecucion<br> Contractual</td>";
        stable = stable + "</tr>";
        stable = stable + "<tr>";
        stable = stable + "<td  width=5%>";
         stable = stable + "<input name=ag_unidad_codigo type=hidden>";
        stable = stable + "<input name=ag_itempaq_desc type=hidden>";
        stable = stable + "<input name=ag_nivel5_cod type=hidden>";
        stable = stable + "<input name=ag_cod_item type=hidden>";
        stable = stable + "<input name=ag_sis_cont type=hidden>";
        stable = stable + "<input name=ag_mod_cont type=hidden>";
        stable = stable + "<input name=ag_monto_adj type=hidden></td>";
        stable = stable + "<td align=center  width=5%><input name=button1  value=''...'' type=button onclick=''VerItemContrato_up_v3('||ag_n_convoca||','||session_COD_CONTRATO ||','||TO_NUMBER (ln_codconsucode)||','||ln_n_propuesta ||');''></td>";       
       stable = stable + "<td align=center  width=5%><input name=ag_proc_item readonly=true  size = 1 style=''font-size : 1.0em;'' ></input></td>";
       stable = stable + "<td align=left width=20%><input name=ag_descripcion readonly=true  size=50 style=''font-size : 1.0em;'' ></input></td>";
       stable = stable + "<td align=center width=10%><font size=1><div id=id_itemdiv size =50 ></div></font></td>";
       stable = stable + "<td align=center width=10%><input name=ag_f_bp_cons    readonly=true  size = 11 style=''font-size : 1.0em;''></input></td>";
       stable = stable + "<td align=center width=10%><input name=ag_ubigeo       readonly=true  size = 25 style=''font-size : 1.0em;'' ></input></td>";
        stable = stable + "<td align=center width=10%><input name=ag_unidad       readonly=true  size = 5 style=''font-size : 1.0em;''  ></td>";
        stable = stable + "<td align=center width=5%><input name=ag_cantidad id=ag_cantidad onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this)''  "+tipo+"   size = 5 style=''font-size : 1.0em;'' ></td>";
        /*  Inicio 085-2018-SGFS  tchacon */
         if (fecharegistro>="20181006"){
        stable = stable + "<td align=center width=10%><input name=ag_monto  id=ag_monto   "+tipo+"   onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)''   size = 10 style=''font-size : 1.0em;''  disabled/></td>";
        }else{
         stable = stable + "<td align=center width=10%><input name=ag_monto  id=ag_monto   "+tipo+"   onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)''   size = 10 style=''font-size : 1.0em;''/></td>";
        }
        /*  Fin 085-2018-SGFS  tchacon */
       stable = stable + "<td align=left width=5%><input name=ag_sis_des        readonly=true  size =25   style=''font-size : 0.9em;''></input></td>";
      stable = stable + "<td align=left width=5%><input name=ag_mod_des        readonly=true  size=25   style=''font-size : 0.9em;''></input></td>";

        ');


 usp_print('stable = stable + "</tr></thead> ";

        for (var i=0; i< v_lista3.length; i++)
        {
            if (v_lista3[i].nro_item != "" )
            {
                color = "";

                stable = stable + "<tr " + color + ">";
                stable = stable + "<td width=5%><img src=img/eliminar.gif onclick=''EliminarElemento3("+i+")'') />";
                /*stable = stable + "<input name=ag_unidad_codigo type=hidden value="+v_lista3[i].cod_unidad+">&nbsp;</input>";
                stable = stable + "<input name=ag_itempaq_desc type=hidden value=+v_lista3[i].itempaq+>&nbsp;</input>";
                stable = stable + "<input name=ag_nivel5_cod type=hidden value="+v_lista3[i].nivel5+">&nbsp;</input>";
                stable = stable + "<input name=ag_cod_item type=hidden value="+v_lista3[i].cod_item+">&nbsp;</input>";
                */
                stable = stable + "<input name=ag_sis_cont type=hidden value="+v_lista3[i].sc+">&nbsp;</input>";
                stable = stable + "<input name=ag_mod_cont type=hidden value="+v_lista3[i].mc+">&nbsp;</input>";
                //stable = stable + "<input name=ag_itempaq_desc type=hidden value=+v_lista3[i].itempaq+>&nbsp;</input>";
                stable = stable + "<td align=center width=5%><font size=1>"+(i+1)+"</font></td>";
                stable = stable + "<td align=center width=5%><font size=1>"+v_lista3[i].nro_item+"</font></td>";
                stable = stable + "<td align=center width=20%><font size=1>"+v_lista3[i].descripcion+"</font></td>";
                stable = stable + "<td align=center width=10%><font size=1>"+v_lista3[i].itempaq+"</font></td>";
                stable = stable + "<td align=left width=10%><font size=1>"+v_lista3[i].f_bp+"</font></td>";
                stable = stable + "<td align=left width=10%><font size=1>"+v_lista3[i].des_ubi+"</font></td>";
                stable = stable + "<td align=left width=10%><font size=1>"+v_lista3[i].des_unidad+"</font></td>";
                stable = stable + "<td align=left width=5%><font size=1>"+v_lista3[i].cantidad+"</font></td>";
                stable = stable + "<td align=left width=10%><font size=1>"+v_lista3[i].monto+"</font></td>";
                stable = stable + "<td align=left width=5%><font size=1>"+v_lista3[i].sc_des+"</font></td>";
                stable = stable + "<td align=left width=5%><font size=1>"+v_lista3[i].mc_des+"</font></td>";
                stable = stable + "</tr>";

            }
       }
       stable = stable + "</table>";
       EscribirHTML("divLista", stable);
    }


    </script>

    ');


 IF session_COD_CONTRATO is not null THEN


usp_print('
        <script language="javascript">');
 FOR xrow IN citemscontrato (ag_n_convoca,session_COD_CONTRATO,ln_min_n_convoca) LOOP

       usp_print('
            v_lista3[v_lista3.length] = new InitLista3();
            v_lista3[v_lista3.length-1].nro_item = "'||xrow.proc_item||'";

        v_lista3[v_lista3.length-1].descripcion = "'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'";

            v_lista3[v_lista3.length-1].itempaq = "'|| case when LENGTH(xrow.item_paq_desc)>0 then xrow.item_paq_desc else '-' end||'";
            v_lista3[v_lista3.length-1].f_bp = "'||xrow.f_bp_cons||'"
            v_lista3[v_lista3.length-1].des_ubi = "'||xrow.ubigeo||'";
            v_lista3[v_lista3.length-1].cod_unidad = "'||xrow.unm_codigo||'";
            v_lista3[v_lista3.length-1].des_unidad = "'||xrow.unm_desc||'";
            v_lista3[v_lista3.length-1].cantidad = "'||xrow.cantidad||'";
            v_lista3[v_lista3.length-1].monto = "'||replace(xrow.monto, ',', '.')||'";
            v_lista3[v_lista3.length-1].nivel5 = "'||xrow.nivel5||'";
            v_lista3[v_lista3.length-1].cod_item = "'||xrow.cod_item||'";
            v_lista3[v_lista3.length-1].sc = "'||xrow.cod_sc||'";
            v_lista3[v_lista3.length-1].sc_des = "'||xrow.sc_descripcion||'";
            v_lista3[v_lista3.length-1].mc = "'||xrow.cod_mc||'";
            v_lista3[v_lista3.length-1].mc_des = "'||xrow.desmodcnt||'";




            ');

 END LOOP;

usp_print('
            PintarLista3();
        </script>');
 END IF;


END;


PROCEDURE   usp_XmlItemsNewContrato2(
         ag_n_propuesta            VARCHAR2,
         ag_n_convoca              NUMBER,
         ag_cod_consucode          VARCHAR2 )
is 
lv_trama_items          VARCHAR2(32767);
  lv_trama_codpresup      VARCHAR2(32200);
  ln_convoca_max          NUMBER;
  ln_fila                 NUMBER;
  ccodpresupuestal        ref_cursor;

  ls_cod_presup                 VARCHAR2(10);
  ln_monto_presup               NUMBER;
  ln_item_presup                NUMBER;

  ln_min_n_convoca              NUMBER;


 cursor cItemsContratobp(pn_nconvoca number, pn_nconvoca_max number, pg_codconsucode varchar2,pn_nconvoca_MIN number ) is
    SELECT c.anhoentidad,
           c.codconsucode,
           itc.n_convoca,
           itc.unm_codigo,
           m.unm_desc,
           itc.proc_item,
           --replace(replace(replace(itc.descripcion,chr(13),chr(32)),chr(10),chr(32)),'&','') descripcion,
           REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,

           i.cant_adjudicada cantidad,
           i.monto_adjudicado monto,
           suma.suma_cant,suma.suma_monto,

           case suma.suma_monto     when suma.suma_monto
             then
                case when ( bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha) )
                 then i.monto_adjudicado-suma.suma_monto else i.monto_adjudicado
                 end
             else i.monto_adjudicado end monto_max,

             case suma.suma_cant   when suma.suma_cant
             then
                case when ( bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha) )
                 then i.cant_adjudicada-suma.suma_cant else i.cant_adjudicada
                 end
             else i.cant_adjudicada  end cant_max,

             itc.dep_codigo,itc.pro_codigo, itc.dis_codigo, dep.dep_desc , pro.pro_desc,
              dis.dis_desc,
            '['||itc.dep_codigo||'] '||dep.dep_desc||' / ['||itc.pro_codigo||']'||pro.pro_desc||' / ['||itc.dis_codigo||']'||dis.dis_desc  ubigeo,
            /* to_char(cd.fec_upload,'dd/mm/yyyy') f_bp_cons,*/

             to_char(ice.f_registro,'dd/mm/yyyy') f_bp_cons,
             i.n_propuesta
       FROM reg_procesos.item_convoca itc,
            reg_procesos.buena_pro bp,
            reg_procesos.convocatorias c,
            sease.unidad_medida m,
            sease.dep_ubigeo dep,
            sease.prov_ubigeo pro,
            sease.dist_ubigeo dis,

         (

           select icei.* from  reg_procesos.item_convoca_estado icei
           where  icei.n_convoca_src = pn_nconvoca_MIN --  reg_procesos.f_get_min_n_convoca(pn_nconvoca )
           and icei.cod_tipo_Estado_item = 500
           and icei.f_registro = (
                         select max(f_registro) from reg_procesos.item_convoca_estado ice2 where ice2.n_convoca_src  = icei.n_convoca_src and ice2.proc_item = icei.proc_item
                       )
         ) ice,

            reg_procesos.items_bp i
            left outer join (
                  Select c.n_propuesta,ict.proc_item,ict.n_convoca,
                         sum(ict.cantidad) suma_cant,sum(ict.monto) suma_monto
                    from REG_PROCESOS.item_contrato ict
                         inner join REG_PROCESOS.item_convoca icv on ict.n_convoca = icv.n_convoca and ict.proc_item = icv.proc_item
                         inner join REG_PROCESOS.contrato c on  c.n_cod_contrato =ict.n_cod_contrato
                   where c.n_convoca = pn_nconvoca and ict.n_convoca = pn_nconvoca_max
                     and c.codconsucode != lpad(pg_codconsucode ,6,'0')
                   group by c.n_propuesta,ict.proc_item,ict.n_convoca
                       ) suma on
                       suma.proc_item =  i.proc_item and suma.n_propuesta = i.n_propuesta
     where itc.n_convoca                     = pn_nconvoca_max
       and i.n_propuesta                     = ag_n_propuesta
       and lpad(itc.dep_codigo,2,'0')        = lpad(dis.dep_codigo,2,'0')
       and lpad(itc.pro_codigo,2,'0')        = lpad(dis.pro_codigo,2,'0')
       and lpad(trim(itc.dis_codigo),2,'0')  = lpad(trim(dis.dis_codigo),2,'0')
       and lpad(trim(dis.dep_codigo),2,'0')  = lpad(trim(pro.dep_codigo),2,'0')
       and lpad(dis.pro_codigo,2,'0')        = lpad(pro.pro_codigo,2,'0')
       and lpad(pro.dep_codigo,2,'0')        = lpad(dep.dep_codigo,2,'0')
       and itc.unm_codigo                    = m.unm_codigo
       and c.n_convoca                       = itc.n_convoca
       and bp.n_convoca                      = pn_nconvoca_MIN -- pn_nconvoca
       and bp.n_buenapro                     = i.n_buenapro
       and itc.proc_item                     = i.proc_item
       and i.n_propuesta   in
       (
         Select distinct convocatoria_propuesta.n_propuesta
           from REG_PROCESOS.buena_pro, REG_PROCESOS.items_bp, REG_PROCESOS.convocatoria_propuesta
          where buena_pro.n_convoca  = pn_nconvoca_MIN -- pn_nconvoca
            and buena_pro.n_buenapro = items_bp.n_buenapro
            and items_bp.n_propuesta = convocatoria_propuesta.n_propuesta
            and items_bp.monto_adjudicado > 0
            and buena_pro.ind_ultimo = 1
       )
       and i.monto_adjudicado > 0
       and bp.ind_ultimo      = 1
       and ice.proc_item     = i.proc_item
       and ((c.codobjeto * itc.cod_tipo_detalle_bien) != 15) -- Validacion temporal para no visualizar Los paquetes de item para un objeto Obras S.v2
       and not exists (Select iccc.proc_item
                         from REG_PROCESOS.contrato c,  REG_PROCESOS.item_contrato iccc
                        where c.n_convoca        = pn_nconvoca
                          and c.n_cod_contrato   = iccc.n_cod_contrato
                          and iccc.n_convoca     = pn_nconvoca_max
                          and iccc.proc_item     = itc.proc_item
                          and c.n_propuesta      = i.n_propuesta
                          and c.codconsucode     = lpad(pg_codconsucode ,6,'0')
                        )
       order by itc.proc_item;



begin

 LN_CONVOCA_MAX    := REG_PROCESOS.F_GET_MAX_N_CONVOCA (ag_n_convoca);
   ln_min_n_convoca  := REG_PROCESOS.f_get_min_n_convoca(ag_n_convoca);
   ln_fila           := 1;


    /*******************************************/
    ---------- Codigo Presupuestal ---------------
   lv_trama_codpresup := '<xml id="xmlItemsCP">';
   lv_trama_codpresup := lv_trama_codpresup ||'<root>';
   ----------------------------------------------
   ---------- Codigo Presupuestal ---------------
  lv_trama_codpresup := lv_trama_codpresup ||'</root></xml>';


   usp_print('<xml id="xmlItems">');
   usp_print('<root>');


 IF ag_n_propuesta is not null THEN

  FOR xrow IN cItemsContratobp (ag_n_convoca,LN_CONVOCA_MAX,ag_cod_consucode,ln_min_n_convoca) LOOP
   if xrow.monto_max > 0 THEN
      usp_print('<i>');
      usp_print('<ctr><![CDATA[<img src=img/eliminar.gif onclick=borraNodoItem('|| xrow.proc_item || ') />]]></ctr>');
      usp_print('<nro>'||ln_fila||'</nro>');
      usp_print('<item>'||xrow.proc_item||'</item>');
      usp_print('<fbp>'||xrow.f_bp_cons||'</fbp>');
      usp_print('<ubi>'||xrow.ubigeo||'</ubi>');
      usp_print('<des>'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'</des>');
      usp_print('<desitem>-</desitem>');
      usp_print('<niv5></niv5>');
      usp_print('<mon>'||xrow.monto||'</mon>');
      usp_print('<unm>'||xrow.unm_desc||'</unm>');
      usp_print('<unc>'||xrow.unm_codigo||'</unc>');
      usp_print('<can>'||xrow.cantidad||'</can>');
      usp_print('</i>');

      ln_fila := ln_fila + 1;

     END IF;

  END LOOP;

 END IF;
  ---------- Items -----------------------------
  usp_print('</root></xml>');

  ----------------------------------------------

  usp_print(lv_trama_codpresup);


end;


PROCEDURE   usp_XmlItemsNewContrato(
         ag_n_propuesta            VARCHAR2,
         ag_n_convoca              NUMBER,
         ag_cod_consucode          VARCHAR2 )
is

  lv_trama_items          VARCHAR2(32200);
  lv_trama_codpresup      VARCHAR2(32200);
  ln_convoca_max          NUMBER;
  ln_fila                 NUMBER;
  ccodpresupuestal        ref_cursor;

  ls_cod_presup                 VARCHAR2(10);
  ln_monto_presup               NUMBER;
  ln_item_presup                NUMBER;

  ln_min_n_convoca              NUMBER;


 cursor cItemsContratobp(pn_nconvoca number, pn_nconvoca_max number, pg_codconsucode varchar2,pn_nconvoca_MIN number ) is
    SELECT c.anhoentidad,
           c.codconsucode,
           itc.n_convoca,
           itc.unm_codigo,
           m.unm_desc,
           itc.proc_item,
           --replace(replace(replace(itc.descripcion,chr(13),chr(32)),chr(10),chr(32)),'&','') descripcion,
           REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,     

           i.cant_adjudicada cantidad,
           i.monto_adjudicado monto,
           suma.suma_cant,suma.suma_monto,

           case suma.suma_monto     when suma.suma_monto
             then
                case when ( bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha) )
                 then i.monto_adjudicado-suma.suma_monto else i.monto_adjudicado
                 end
             else i.monto_adjudicado end monto_max,

             case suma.suma_cant   when suma.suma_cant
             then
                case when ( bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha) )
                 then i.cant_adjudicada-suma.suma_cant else i.cant_adjudicada
                 end
             else i.cant_adjudicada  end cant_max,

             itc.dep_codigo,itc.pro_codigo, itc.dis_codigo, dep.dep_desc , pro.pro_desc,
              dis.dis_desc,
            '['||itc.dep_codigo||'] '||dep.dep_desc||' / ['||itc.pro_codigo||']'||pro.pro_desc||' / ['||itc.dis_codigo||']'||dis.dis_desc  ubigeo,
            /* to_char(cd.fec_upload,'dd/mm/yyyy') f_bp_cons,*/

             to_char(ice.f_registro,'dd/mm/yyyy') f_bp_cons,
             i.n_propuesta
       FROM reg_procesos.item_convoca itc,
            reg_procesos.buena_pro bp,
            reg_procesos.convocatorias c,
            sease.unidad_medida m,
            sease.dep_ubigeo dep,
            sease.prov_ubigeo pro,
            sease.dist_ubigeo dis,

         (

           select icei.* from  reg_procesos.item_convoca_estado icei
           where  icei.n_convoca_src = pn_nconvoca_MIN --  reg_procesos.f_get_min_n_convoca(pn_nconvoca )
           and icei.cod_tipo_Estado_item = 500
           and icei.f_registro = (
                         select max(f_registro) from reg_procesos.item_convoca_estado ice2 where ice2.n_convoca_src  = icei.n_convoca_src and ice2.proc_item = icei.proc_item
                       )
         ) ice,

            reg_procesos.items_bp i
            left outer join (
                  Select c.n_propuesta,ict.proc_item,ict.n_convoca,
                         sum(ict.cantidad) suma_cant,sum(ict.monto) suma_monto
                    from REG_PROCESOS.item_contrato ict
                         inner join REG_PROCESOS.item_convoca icv on ict.n_convoca = icv.n_convoca and ict.proc_item = icv.proc_item
                         inner join REG_PROCESOS.contrato c on  c.n_cod_contrato =ict.n_cod_contrato
                   where c.n_convoca = pn_nconvoca and ict.n_convoca = pn_nconvoca_max
                     and c.codconsucode != lpad(pg_codconsucode ,6,'0')
                   group by c.n_propuesta,ict.proc_item,ict.n_convoca
                       ) suma on
                       suma.proc_item =  i.proc_item and suma.n_propuesta = i.n_propuesta
     where itc.n_convoca                     = pn_nconvoca_max
       and i.n_propuesta                     = ag_n_propuesta
       and lpad(itc.dep_codigo,2,'0')        = lpad(dis.dep_codigo,2,'0')
       and lpad(itc.pro_codigo,2,'0')        = lpad(dis.pro_codigo,2,'0')
       and lpad(trim(itc.dis_codigo),2,'0')  = lpad(trim(dis.dis_codigo),2,'0')
       and lpad(trim(dis.dep_codigo),2,'0')  = lpad(trim(pro.dep_codigo),2,'0')
       and lpad(dis.pro_codigo,2,'0')        = lpad(pro.pro_codigo,2,'0')
       and lpad(pro.dep_codigo,2,'0')        = lpad(dep.dep_codigo,2,'0')
       and itc.unm_codigo                    = m.unm_codigo
       and c.n_convoca                       = itc.n_convoca
       and bp.n_convoca                      = pn_nconvoca_MIN -- pn_nconvoca
       and bp.n_buenapro                     = i.n_buenapro
       and itc.proc_item                     = i.proc_item
       and i.n_propuesta   in
       (
         Select distinct convocatoria_propuesta.n_propuesta
           from REG_PROCESOS.buena_pro, REG_PROCESOS.items_bp, REG_PROCESOS.convocatoria_propuesta
          where buena_pro.n_convoca  = pn_nconvoca_MIN -- pn_nconvoca
            and buena_pro.n_buenapro = items_bp.n_buenapro
            and items_bp.n_propuesta = convocatoria_propuesta.n_propuesta
            and items_bp.monto_adjudicado > 0
            and buena_pro.ind_ultimo = 1
       )
       and i.monto_adjudicado > 0
       and bp.ind_ultimo      = 1
       and ice.proc_item     = i.proc_item
       and ((c.codobjeto * itc.cod_tipo_detalle_bien) != 15) -- Validacion temporal para no visualizar Los paquetes de item para un objeto Obras S.v2
       and not exists (Select iccc.proc_item
                         from REG_PROCESOS.contrato c,  REG_PROCESOS.item_contrato iccc
                        where c.n_convoca        = pn_nconvoca
                          and c.n_cod_contrato   = iccc.n_cod_contrato
                          and iccc.n_convoca     = pn_nconvoca_max
                          and iccc.proc_item     = itc.proc_item
                          and c.n_propuesta      = i.n_propuesta
                          and c.codconsucode     = lpad(pg_codconsucode ,6,'0')
                        )
       order by itc.proc_item;




begin

  usp_print('
    <script language="javascript">


     function PintarLista()
    {
        var stable = "";
        var tipo="readonly";
        var color = "";
        var total_col = 9;
        v_bgcolor = "#ECE9D8";
        v_style = "font-size : 0.9em;";
        v_style2 = "font-size : 0.7em;";

        if (thisform.ag_tipo_modalidad.value != 0 ){
        tipo = "";
        }
        stable = stable + "<table border=0  align=center class=''table table-striped table-bordered table-hover dataTable no-footer'' cellpadding=3 cellspacing=0>";
        stable = stable + "<thead> <tr style=''background-color: #BDBDBD;color:#111111''>";
        stable = stable + "<td align=center  width=5%>&nbsp;</td>";
        stable = stable + "<td align=center  width=5%>Nro.</td>";
        stable = stable + "<td align=center  width=5%>Item</td>";
        stable = stable + "<td align=center  width=20%>Descripcion</td>";
        stable = stable + "<td align=center  width=10%>Componente del<br> item paquete</td>";
        stable = stable + "<td align=center  width=15%>Fecha de BP<br> Consentida</td>";
        stable = stable + "<td align=center  width=15%>Lugar de la ejecucin<br> de la Prestacion</td>";
        stable = stable + "<td align=center  width=10%>U.Medida</td>";
        stable = stable + "<td align=center  width=5%>Cantidad</td>";
        stable = stable + "<td align=center  width=10%>Monto Contratado</td>";
        stable = stable + "</tr>";
        stable = stable + "<tr>";
        stable = stable + "<td width=5%>";
        stable = stable + "<input name=ag_unidad_codigo type=hidden>";
        stable = stable + "<input name=ag_itempaq_desc type=hidden>";
        stable = stable + "<input name=ag_nivel5_cod type=hidden>";
        stable = stable + "<input name=ag_monto_adj type=hidden></td>";
        stable = stable + "<td align=center width=5%><input name=button1  value=''...'' type=button onclick=''VerItemContrato('||ag_n_convoca||','||TO_NUMBER ( lpad(ag_cod_consucode,6,'0'))||');''></td>";
       stable = stable + "<td align=center width=5%><font size=1><input name=ag_proc_item  readonly=true  size = 1/></font></td>";
       stable = stable + "<td align=left width=20%><font size=1><input name=ag_descripcion readonly=true size=70/></font></td>";
       stable = stable + "<td align=center width=10%><font size=1><div id=id_itemdiv size =50 ></div></font></td>";
       stable = stable + "<td align=center width=15%><font size=1><input name=ag_f_bp_cons    readonly=true  size = 11 /></font></td>";
       stable = stable + "<td align=center width=15%><font size=1><input name=ag_ubigeo       readonly=true  size = 25 /></font></td>";
        stable = stable + "<td align=center width=10%><font size=1><input name=ag_unidad       readonly=true  size = 5  /></font></td>";
        stable = stable + "<td align=center width=5%><font size=1><input name=ag_cantidad id=ag_cantidad "+tipo+"  size = 5  onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this)'' /></font></td>";
         stable = stable + "<td align=center width=10%><font size=1><input name=ag_monto id=ag_monto "+tipo+" onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this)'' size = 10/></font></td>";


        ');


      usp_print(' stable = stable + "</tr></thead> ";

        for (var i=0; i< v_lista.length; i++)
        {
            if (v_lista[i].nro_item != "" )
            {
                color = "";

                stable = stable + "<tr>";
                stable = stable + "<td><img src=img/eliminar.gif onclick=''EliminarElemento("+i+")'') />";
                 stable = stable + "<input name=ag_unidad_codigo type=hidden value="+v_lista[i].cod_unidad+">&nbsp;</input>";
                stable = stable + "<input name=ag_itempaq_desc type=hidden value="+v_lista[i].itempaq+">&nbsp;</input>";
                stable = stable + "<input name=ag_nivel5_cod type=hidden value="+v_lista[i].nivel5+">&nbsp;</input>";
                stable = stable + "<input name=ag_monto_adj type=hidden  value="+v_lista[i].monto+">&nbsp;</input></td>";
                stable = stable + "<td align=center><font size=1>"+(i+1)+"</font></td>";
                stable = stable + "<td align=center><font size=1>"+v_lista[i].nro_item+"</font></td>";
                stable = stable + "<td align=center><font size=1>"+v_lista[i].descripcion+"</font></td>";
                stable = stable + "<td align=center><font size=1>"+v_lista[i].itempaq+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].f_bp+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].des_ubi+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].des_unidad+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].cantidad+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista[i].monto+"</font></td>";
                stable = stable + "</tr>";



            }
       }
       stable = stable + "</table>";
       EscribirHTML("divLista", stable);
    }


    </script>

    ');

   LN_CONVOCA_MAX    := REG_PROCESOS.F_GET_MAX_N_CONVOCA (ag_n_convoca);
   ln_min_n_convoca  := REG_PROCESOS.f_get_min_n_convoca(ag_n_convoca);
   ln_fila           := 1;


    /*******************************************/
    ---------- Codigo Presupuestal ---------------
   lv_trama_codpresup := '<xml id="xmlItemsCP">';
   lv_trama_codpresup := lv_trama_codpresup ||'<root>';
   ----------------------------------------------
   ---------- Codigo Presupuestal ---------------
  lv_trama_codpresup := lv_trama_codpresup ||'</root></xml>';




 IF ag_n_propuesta is not null THEN

     usp_print('
        <script language="javascript">');
        FOR xrow IN cItemsContratobp (ag_n_convoca,LN_CONVOCA_MAX,ag_cod_consucode,ln_min_n_convoca) LOOP
        if xrow.monto_max > 0 THEN
           usp_print('
            v_lista[v_lista.length] = new InitLista();
            v_lista[v_lista.length-1].nro_item = "'||xrow.proc_item||'";
            v_lista[v_lista.length-1].descripcion = "'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'";
            v_lista[v_lista.length-1].itempaq = "-";
            v_lista[v_lista.length-1].f_bp = "'||xrow.f_bp_cons||'"
            v_lista[v_lista.length-1].des_ubi = "'||xrow.ubigeo||'";
            v_lista[v_lista.length-1].cod_unidad = "'||xrow.unm_codigo||'";
            v_lista[v_lista.length-1].des_unidad = "'||xrow.unm_desc||'";
            v_lista[v_lista.length-1].cantidad = "'||xrow.cantidad||'";
            v_lista[v_lista.length-1].monto = "'||replace(xrow.monto, ',', '.')||'";
            v_lista[v_lista.length-1].nivel5 = "";

            ');
        end if;              
        end loop;

        usp_print('
            PintarLista();
        </script>');


 END IF;
  ---------- Items -----------------------------
    ----------------------------------------------

  usp_print(lv_trama_codpresup);

END;


-- 001 Inicio ddrodriguez req 85
function f_get_monto_cc (tipo number, propuesta number,convocatoria number, item number, organ varchar2) return number
is
  escompracorp number;
  cantadj number;
  montadj number;
  nro_item number;
  nro_ruc varchar2(20);
  id_consorcio number;
  nro_consorcio number;

begin

  select count(1) into esCompraCorp from pro.tbl_act_expediente@AIXSEACE 
  where n_id_expede in (select n_id_expede from pro.tbl_act_item@AIXSEACE 
  where n_id_item = item) and c_tipcom = 51; --(51 = Compra corporativa facultativa)

  if escompracorp > 0 then

        select n_id_item into nro_item
        from pro.tbl_act_item@AIXSEACE e
        inner join adm.tbl_adm_integracion_ent@AIXSEACE i on e.n_id_organ = i.n_id_organ
        where I.N_Id_Int_Entidad = lpad(trim(organ),6,'0') and e.n_id_grupo = item;

        if tipo = 0 and nro_item is not null then
            return 1;
        end if;

        select cv.ruc_postor, cv.cod_consorcio, cv.ind_consorcio into nro_ruc, nro_consorcio, id_consorcio from reg_procesos.convocatoria_propuesta cv where cv.n_propuesta = propuesta;

        if id_consorcio = 1 then
           select DISTINCT(rp.c_ruc) into nro_ruc from pro.tbl_sel_reg_par@AIXSEACE rp 
           inner join pro.tbl_sel_propuesta@AIXSEACE p on p.n_id_reg_par = rp.n_id_reg_par and p.c_indcon='S'
           where rp.c_ruc in (select ruc_miembro from reg_procesos.consorcio_miembro cm where cm.cod_consorcio = nro_consorcio) and rp.n_id_pub_con =convocatoria and rp.c_intcon='N';
        end if;

        select to_number(replace(di.c_canadj,'.',',')),to_number(replace(di.c_monadj,'.',',')) into cantadj, montadj from 
        pro.tbl_sel_reg_par@AIXSEACE rp 
        inner join pro.tbl_sel_propuesta@AIXSEACE p on rp.n_id_reg_par = p.n_id_reg_par
        inner join pro.det_sel_propuesta@AIXSEACE dp on dp.n_id_propuesta = p.n_id_propuesta
        left join pro.tbl_sel_otor_item@AIXSEACE o on dp.n_id_det_prop = o.n_id_det_prop
        inner join pro.det_sel_de_corp@AIXSEACE di on di.n_id_otor_item = o.n_id_otor_item or di.n_id_bpro is not null   
        where
        rp.c_ruc=trim(nro_ruc) and rp.n_id_pub_con=convocatoria and dp.n_id_item=item and (o.c_estado='V' or di.n_id_bpro is not null)
        and di.n_id_item =nro_item;

        if tipo = 1 then
           return montadj;
        else
           return cantadj;
        end if;

  else if tipo = 0 then
        return 1;
       end if;
  end if;

  return null;

  exception
         when NO_DATA_FOUND then
            return null;
end;
-- 001 Fin ddrodriguez req 85

PROCEDURE   usp_XmlItemsNewContrato_v3(
         ag_n_propuesta            VARCHAR2,
         ag_n_convoca              number,
         ag_cod_consucode          varchar2,
         tipo_moneda                NUMBER)
is

  lv_trama_items          VARCHAR2(32767);
  lv_trama_codpresup      VARCHAR2(32200);
  ln_convoca_max          NUMBER;
  ln_fila                 NUMBER;
  ccodpresupuestal        ref_cursor;

  ls_cod_presup                 VARCHAR2(10);
  ln_monto_presup               NUMBER;
  ln_item_presup                NUMBER;

  ln_min_n_convoca              NUMBER;

  fecha_registro                 VARCHAR2(8);


 cursor cItemsContratobp(pn_nconvoca number, pn_nconvoca_max number, pg_codconsucode varchar2,pn_nconvoca_MIN number ) is
    SELECT c.anhoentidad,
           c.codconsucode,
           itc.n_convoca,
           itc.unm_codigo,
           m.unm_desc,
           itc.proc_item,
           --replace(replace(replace(itc.descripcion,chr(13),chr(32)),chr(10),chr(32)),'&','') descripcion,
           REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,
           nvl(f_get_monto_cc(2, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, pg_codconsucode), i.cant_adjudicada) cantidad,--i.cant_adjudicada 001 ddrodriguez
           nvl(f_get_monto_cc(1, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, pg_codconsucode),i.monto_adjudicado) monto,--i.monto_adjudicado 001 ddrodriguez
           suma.suma_cant,suma.suma_monto,

           case suma.suma_monto     when suma.suma_monto
             then
                case when ( bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha) )
                 then i.monto_adjudicado-suma.suma_monto else i.monto_adjudicado
                 end
             else i.monto_adjudicado end monto_max,

             case suma.suma_cant   when suma.suma_cant
             then
                case when ( bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha) )
                 then i.cant_adjudicada-suma.suma_cant else i.cant_adjudicada
                 end
             else i.cant_adjudicada  end cant_max,

             itc.dep_codigo,itc.pro_codigo, itc.dis_codigo, dep.dep_desc , pro.pro_desc,
              dis.dis_desc,
            '['||itc.dep_codigo||'] '||dep.dep_desc||' / ['||itc.pro_codigo||']'||pro.pro_desc||' / ['||itc.dis_codigo||']'||dis.dis_desc  ubigeo,
             to_char(ice.f_registro,'dd/mm/yyyy') f_bp_cons,
             i.n_propuesta, tsc.sc_descripcion,tmc.desmodcnt, itc.cod_sist_adquisicion, itc.cod_modalidad_alcance
       FROM reg_procesos.item_convoca itc left join t_tipo_sist_cont  tsc on itc.cod_sist_adquisicion = tsc.sc_codigo
       left join t_tipo_modcont tmc on itc.cod_modalidad_alcance = tmc.codmodcnt,
            reg_procesos.buena_pro bp,
            reg_procesos.convocatorias c,
            sease.unidad_medida m,
            sease.dep_ubigeo dep,
            sease.prov_ubigeo pro,
            sease.dist_ubigeo dis,

         (

           select icei.* from  reg_procesos.item_convoca_estado icei
           where  icei.n_convoca_src = pn_nconvoca_MIN --  reg_procesos.f_get_min_n_convoca(pn_nconvoca )
           and icei.cod_tipo_Estado_item = 500
           and icei.f_registro = (
                         select max(f_registro) from reg_procesos.item_convoca_estado ice2 where ice2.n_convoca_src  = icei.n_convoca_src and ice2.proc_item = icei.proc_item
                       )
         ) ice,

            reg_procesos.items_bp i
            left outer join (
                  Select c.n_propuesta,ict.proc_item,ict.n_convoca,
                         sum(ict.cantidad) suma_cant,sum(ict.monto) suma_monto
                    from REG_PROCESOS.item_contrato ict
                         inner join REG_PROCESOS.item_convoca icv on ict.n_convoca = icv.n_convoca and ict.proc_item = icv.proc_item
                         inner join REG_PROCESOS.contrato c on  c.n_cod_contrato =ict.n_cod_contrato
                   where c.n_convoca = pn_nconvoca and ict.n_convoca = pn_nconvoca_max
                     and c.codconsucode != lpad(pg_codconsucode ,6,'0')
                   group by c.n_propuesta,ict.proc_item,ict.n_convoca
                       ) suma on
                       suma.proc_item =  i.proc_item and suma.n_propuesta = i.n_propuesta
     where itc.n_convoca                     = pn_nconvoca_max
       and i.n_propuesta                     = ag_n_propuesta
       and lpad(itc.dep_codigo,2,'0')        = lpad(dis.dep_codigo,2,'0')
       and lpad(itc.pro_codigo,2,'0')        = lpad(dis.pro_codigo,2,'0')
       and lpad(trim(itc.dis_codigo),2,'0')  = lpad(trim(dis.dis_codigo),2,'0')
       and lpad(trim(dis.dep_codigo),2,'0')  = lpad(trim(pro.dep_codigo),2,'0')
       and lpad(dis.pro_codigo,2,'0')        = lpad(pro.pro_codigo,2,'0')
       and lpad(pro.dep_codigo,2,'0')        = lpad(dep.dep_codigo,2,'0')
       and itc.unm_codigo                    = m.unm_codigo
       and c.n_convoca                       = itc.n_convoca
       and bp.n_convoca                      = pn_nconvoca_MIN -- pn_nconvoca
       and bp.n_buenapro                     = i.n_buenapro
       and itc.proc_item                     = i.proc_item
       and itc.codmoneda                     = nvl(tipo_moneda,itc.codmoneda)
       and i.n_propuesta   in
       (
         Select distinct convocatoria_propuesta.n_propuesta
           from REG_PROCESOS.buena_pro, REG_PROCESOS.items_bp, REG_PROCESOS.convocatoria_propuesta
          where buena_pro.n_convoca  = pn_nconvoca_MIN -- pn_nconvoca
            and buena_pro.n_buenapro = items_bp.n_buenapro
            and items_bp.n_propuesta = convocatoria_propuesta.n_propuesta
            and items_bp.monto_adjudicado > 0
            and buena_pro.ind_ultimo = 1
       )
       and i.monto_adjudicado > 0
       and bp.ind_ultimo      = 1
       and ice.proc_item     = i.proc_item
       and ((c.codobjeto * itc.cod_tipo_detalle_bien) != 15) -- Validacion temporal para no visualizar Los paquetes de item para un objeto Obras S.v3
       and not exists (Select iccc.proc_item
                         from REG_PROCESOS.contrato c,  REG_PROCESOS.item_contrato iccc
                        where c.n_convoca        = pn_nconvoca
                          and c.n_cod_contrato   = iccc.n_cod_contrato
                          and iccc.n_convoca     = pn_nconvoca_max
                          and iccc.proc_item     = itc.proc_item
                          and c.n_propuesta      = i.n_propuesta
                          and c.codconsucode     = lpad(pg_codconsucode ,6,'0')
                        )
       and f_get_monto_cc(0, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, pg_codconsucode) = 1 --001 ddrodriguez
       order by itc.proc_item;




begin

 select to_char(F_REGISTRO,'yyyymmdd' ) into fecha_registro from reg_procesos.convocatorias where n_convoca  = ag_n_convoca;


  Usp_Print('
    <script language="javascript">


     function PintarLista3()
    {
        var stable = "";
         var tipo="readonly";
        var color = "";
        var total_col = 9;
        v_bgcolor = "#ECE9D8";
        v_style = "font-size : 0.9em;";
        v_style2 = "font-size : 0.7em;";
		var fecharegistro = "'||fecha_registro||'" ;

         if (thisform.ag_tipo_modalidad.value != 0 ){
        tipo = "";
        }
        stable = stable + "<table border=0  align=center class=''table table-striped table-bordered table-hover dataTable no-footer'' cellpadding=3 cellspacing=0>";
        stable = stable + "<thead> <tr style=''background-color: #BDBDBD;color:#111111''>";
        stable = stable + "<td align=center width=5%>&nbsp;</td>";
        stable = stable + "<td align=center width=5%>Nro.</td>";
        stable = stable + "<td align=center width=5%>Item</td>";
        stable = stable + "<td align=center width=20%>Descripcion</td>";
        stable = stable + "<td align=center width=10%>Componente del<br> item paquete</td>";
        stable = stable + "<td align=center width=10%>Fecha de BP<br> Consentida</td>";
        stable = stable + "<td align=center width=10%>Lugar de la ejecucin<br> de la Prestacion</td>";
        stable = stable + "<td align=center width=10%>U.Medida</td>";
        stable = stable + "<td align=center width=5%>Cantidad</td>";
        stable = stable + "<td align=center width=10%>Monto Contratado</td>";
        stable = stable + "<td align=center width=5%>Sistema de<br> Contratacion</td>";
        stable = stable + "<td align=center width=5%>Modalidad de Ejecucion<br> Contratual</td>";
        stable = stable + "</tr>";
        stable = stable + "<tr>";
        stable = stable + "<td width=5%>";
        stable = stable + "<input name=ag_unidad_codigo type=hidden>";
        stable = stable + "<input name=ag_itempaq_desc type=hidden>";
        stable = stable + "<input name=ag_nivel5_cod type=hidden>";
        stable = stable + "<input name=ag_cod_item type=hidden>";
        stable = stable + "<input name=ag_sis_cont type=hidden>";
        stable = stable + "<input name=ag_mod_cont type=hidden>";
        stable = stable + "<input name=ag_monto_adj type=hidden></td>";
        stable = stable + "<td align=center width=5%><input name=button1  value=''...'' type=button onclick=''VerItemContrato_v3('||ag_n_convoca||','||TO_NUMBER ( lpad(ag_cod_consucode,6,'0'))||','||tipo_moneda||');''></td>";
       stable = stable + "<td align=center width=5%><input name=ag_proc_item readonly=true  size = 1 style=''font-size : 1.0em;''/></td>";
       stable = stable + "<td align=left width=20%><input name=ag_descripcion readonly=true  size=50 /></td>";
       stable = stable + "<td align=center width=10%><font size=1><div id=id_itemdiv size =50 ></div></font></td>";
       stable = stable + "<td align=center width=10%><input name=ag_f_bp_cons    readonly=true  size = 11 style=''font-size : 1.0em;''/></td>";
       stable = stable + "<td align=center width=10%><input name=ag_ubigeo       readonly=true  size = 25 style=''font-size : 1.0em;'' /></td>";
        stable = stable + "<td align=center width=10%><input name=ag_unidad       readonly=true  size = 5  style=''font-size : 1.0em;'' /></td>";
        stable = stable + "<td align=center width=5%><input name=ag_cantidad  id=ag_cantidad  onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)''  size = 5  style=''font-size : 1.0em;'' /></td>";
      /*  Inicio 085-2018-SGFS  tchacon */
         if (fecharegistro>="20181006"){
        stable = stable + "<td align=center width=10%><input name=ag_monto  id=ag_monto     onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)''   size = 10 style=''font-size : 1.0em;''  disabled/></td>";
        }else{
         stable = stable + "<td align=center width=10%><input name=ag_monto  id=ag_monto     onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)''   size = 10 style=''font-size : 1.0em;''/></td>";
        }
        /*  Fin 085-2018-SGFS  tchacon */
		stable = stable + "<td align=center width=5%><input name=ag_sis_des    readonly=true  size = 25 style=''font-size : 0.7em;''/></td>";
        stable = stable + "<td align=center width=5%><input name=ag_mod_des        readonly=true  size = 25 style=''font-size : 0.7em;''/></td>";

        ');


      usp_print('stable = stable + "</tr></thead> ";

        for (var i=0; i< v_lista3.length; i++)
        {
            if (v_lista3[i].nro_item != "" )
            {
                color = "";

                stable = stable + "<tr " + color + ">";
                stable = stable + "<td><img src=img/eliminar.gif onclick=''EliminarElemento3("+i+")'') />";
                /*stable = stable + "<input name=ag_unidad_codigo type=hidden value="+v_lista3[i].cod_unidad+">&nbsp;</input>";
                stable = stable + "<input name=ag_itempaq_desc type=hidden value=+v_lista3[i].itempaq+>&nbsp;</input>";
                stable = stable + "<input name=ag_nivel5_cod type=hidden value="+v_lista3[i].nivel5+">&nbsp;</input>";
                stable = stable + "<input name=ag_cod_item type=hidden value="+v_lista3[i].cod_item+">&nbsp;</input>";
                stable = stable + "<input name=ag_cod_item type=hidden value=+v_lista3[i].monto+>&nbsp;</input>";
                */
                stable = stable + "<input name=ag_sis_cont type=hidden value="+v_lista3[i].sc+">&nbsp;</input>";
                stable = stable + "<input name=ag_mod_cont type=hidden value="+v_lista3[i].mc+">&nbsp;</input></td>";
                stable = stable + "<td align=center><font size=1>"+(i+1)+"</font></td>";
                stable = stable + "<td align=center><font size=1>"+v_lista3[i].nro_item+"</font></td>";
                stable = stable + "<td align=center><font size=1>"+v_lista3[i].descripcion+"</font></td>";
                stable = stable + "<td align=center><font size=1>"+v_lista3[i].itempaq+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista3[i].f_bp+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista3[i].des_ubi+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista3[i].des_unidad+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista3[i].cantidad+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista3[i].monto+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista3[i].sc_des+"</font></td>";
                stable = stable + "<td align=left><font size=1>"+v_lista3[i].mc_des+"</font></td>";

                stable = stable + "</tr>";

            }
       }
       stable = stable + "</table>";
       EscribirHTML("divLista", stable);
    }


    </script>

    ');

    ln_fila           := 1;


    /*******************************************/
    ---------- Codigo Presupuestal ---------------
   lv_trama_codpresup := '<xml id="xmlItemsCP">';
   lv_trama_codpresup := lv_trama_codpresup ||'<root>';
   ----------------------------------------------
   ---------- Codigo Presupuestal ---------------
  lv_trama_codpresup := lv_trama_codpresup ||'</root></xml>';




 IF ag_n_propuesta is not null THEN

    usp_print('
        <script language="javascript">');
   FOR xrow IN cItemsContratobp (ag_n_convoca,ag_n_convoca,ag_cod_consucode,ag_n_convoca) LOOP
   if xrow.monto_max > 0 THEN

          usp_print('
            v_lista3[v_lista3.length] = new InitLista3();
            v_lista3[v_lista3.length-1].nro_item = "'||xrow.proc_item||'";
            v_lista3[v_lista3.length-1].descripcion = "'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'";
            v_lista3[v_lista3.length-1].itempaq = "-";
            v_lista3[v_lista3.length-1].f_bp = "'||xrow.f_bp_cons||'"
            v_lista3[v_lista3.length-1].des_ubi = "'||xrow.ubigeo||'";
            v_lista3[v_lista3.length-1].cod_unidad = "'||xrow.unm_codigo||'";
            v_lista3[v_lista3.length-1].des_unidad = "'||xrow.unm_desc||'";
            v_lista3[v_lista3.length-1].cantidad = "'||xrow.cantidad||'";
            v_lista3[v_lista3.length-1].monto = "'||xrow.monto||'";
            v_lista3[v_lista3.length-1].nivel5 = "";
            v_lista3[v_lista3.length-1].sc = "'||xrow.cod_sist_adquisicion||'";
            v_lista3[v_lista3.length-1].sc_des = "'||xrow.sc_descripcion||'";
            v_lista3[v_lista3.length-1].mc = "'||xrow.cod_modalidad_alcance||'";
            v_lista3[v_lista3.length-1].mc_des = "'||xrow.desmodcnt||'";


            ');

      ln_fila := ln_fila + 1;

     END IF;

  END LOOP;

  usp_print('
            PintarLista3();
        </script>');

 END IF;
  ---------- Items -----------------------------

   ----------------------------------------------


  usp_print(lv_trama_codpresup);

END;


/*******************************************************************************
/ Procedimiento : f_getXmlItemsNewContrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     04-05-2009 11:59  Version Inicial
/******************************************************************************/

function f_getXmlItemsNewContrato(
         ag_n_propuesta           VARCHAR2,
         ag_n_convoca              NUMBER,
         ag_cod_consucode          VARCHAR2,
         ag_cod_presup             out varchar2 ) return VARCHAR2
is

  lv_trama_items          VARCHAR2(32767);
  lv_trama_codpresup      VARCHAR2(32200);
  ln_convoca_max          NUMBER;
  ln_fila                 NUMBER;
  ccodpresupuestal        ref_cursor;

  ls_cod_presup                 VARCHAR2(10);
  ln_monto_presup               NUMBER;
  ln_item_presup                NUMBER;


  cursor cItemsContratobp(pn_nconvoca number, pn_nconvoca_max number, pg_codconsucode varchar2) is
    SELECT c.anhoentidad,c.codconsucode,itc.n_convoca, itc.unm_codigo, m.unm_desc, itc.proc_item,
           --replace(replace(itc.descripcion,chr(13),chr(32)),chr(10),chr(32)) descripcion,
           REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,
           i.cant_adjudicada cantidad,
           i.monto_adjudicado monto,
           suma.suma_cant,suma.suma_monto,

           case suma.suma_monto     when suma.suma_monto
             then
                case when ( bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha) )
                 then i.monto_adjudicado-suma.suma_monto else i.monto_adjudicado
                 end
             else i.monto_adjudicado end monto_max,

             case suma.suma_cant   when suma.suma_cant
             then
                case when ( bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha) )
                 then i.cant_adjudicada-suma.suma_cant else i.cant_adjudicada
                 end
             else i.cant_adjudicada  end cant_max,

             itc.dep_codigo,itc.pro_codigo, itc.dis_codigo, dep.dep_desc , pro.pro_desc, dis.dis_desc,
             /*'['||itc.dep_codigo||itc.pro_codigo||itc.dis_codigo||']'||*/'['||itc.dep_codigo||'] '||dep.dep_desc||' / ['||itc.pro_codigo||']'||pro.pro_desc||' / ['||itc.dis_codigo||']'||dis.dis_desc  ubigeo,
             to_char(cd.fec_upload,'dd/mm/yyyy') f_bp_cons,
             i.n_propuesta
       FROM reg_procesos.item_convoca itc,
            reg_procesos.buena_pro bp,
            reg_procesos.convocatorias c,
            sease.unidad_medida m,
            sease.dep_ubigeo dep,
            sease.prov_ubigeo pro,
            sease.dist_ubigeo dis,
            reg_procesos.convocatoria_doc cd,
            reg_procesos.item_convoca_estado ice,
            reg_procesos.items_bp i
            left outer join (
                  Select c.n_propuesta,ict.proc_item,ict.n_convoca,
                         sum(ict.cantidad) suma_cant,sum(ict.monto) suma_monto
                    from REG_PROCESOS.item_contrato ict
                         inner join REG_PROCESOS.item_convoca icv on ict.n_convoca = icv.n_convoca and ict.proc_item = icv.proc_item
                         inner join REG_PROCESOS.contrato c on  c.n_cod_contrato =ict.n_cod_contrato
                   where c.n_convoca = pn_nconvoca and ict.n_convoca = pn_nconvoca_max
                     and c.codconsucode != lpad(pg_codconsucode ,6,'0')
                   group by c.n_propuesta,ict.proc_item,ict.n_convoca
                       ) suma on
                       suma.proc_item =  i.proc_item and suma.n_propuesta = i.n_propuesta
     where itc.n_convoca                     = pn_nconvoca_max
       and i.n_propuesta                     = ag_n_propuesta
       and lpad(itc.dep_codigo,2,'0')        = lpad(dis.dep_codigo,2,'0')
       and lpad(itc.pro_codigo,2,'0')        = lpad(dis.pro_codigo,2,'0')
       and lpad(trim(itc.dis_codigo),2,'0')  = lpad(trim(dis.dis_codigo),2,'0')
       and lpad(trim(dis.dep_codigo),2,'0')  = lpad(trim(pro.dep_codigo),2,'0')
       and lpad(dis.pro_codigo,2,'0')        = lpad(pro.pro_codigo,2,'0')
       and lpad(pro.dep_codigo,2,'0')        = lpad(dep.dep_codigo,2,'0')
       and itc.unm_codigo                    = m.unm_codigo
       and c.n_convoca                       = itc.n_convoca
       and bp.n_convoca                      = pn_nconvoca
       and bp.n_buenapro                     = i.n_buenapro
       and itc.proc_item                     = i.proc_item
       and i.n_propuesta   in
       (
        Select  distinct convocatoria_propuesta.n_propuesta
          from REG_PROCESOS.buena_pro, REG_PROCESOS.items_bp, REG_PROCESOS.convocatoria_propuesta
          where buena_pro.n_convoca  = pn_nconvoca
            and buena_pro.n_buenapro = items_bp.n_buenapro
            and items_bp.n_propuesta = convocatoria_propuesta.n_propuesta
            and items_bp.monto_adjudicado > 0
            and buena_pro.ind_ultimo = 1
       )
       and i.monto_adjudicado> 0
       and bp.ind_ultimo   = 1
       and cd.cod_tipo_doc   = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
       and cd.n_convoca      = bp.n_convoca
       and ice.cod_doc       = cd.cod_doc
       and ice.proc_item     = i.proc_item
       and not exists (Select iccc.proc_item
                         from REG_PROCESOS.contrato c,  REG_PROCESOS.item_contrato iccc
                        where c.n_convoca        = pn_nconvoca
                          and c.n_cod_contrato   = iccc.n_cod_contrato
                          and iccc.n_convoca     = pn_nconvoca_max
                          and iccc.proc_item     = itc.proc_item
                          and c.n_propuesta      = i.n_propuesta
                          and c.codconsucode     = lpad(pg_codconsucode ,6,'0')
                        )
       order by itc.proc_item;

begin


   LN_CONVOCA_MAX := REG_PROCESOS.F_GET_MAX_N_CONVOCA (ag_n_convoca);
   ln_fila        := 1;

   lv_trama_items := lv_trama_items ||'<xml id="xmlItems">';
   lv_trama_items := lv_trama_items ||'<root>';

   ---------- Codigo Presupuestal ---------------
   lv_trama_codpresup := '<xml id="xmlItemsCP">';
   lv_trama_codpresup := lv_trama_codpresup ||'<root>';
   ----------------------------------------------

 IF ag_n_propuesta is not null THEN

  FOR xrow IN cItemsContratobp (ag_n_convoca,LN_CONVOCA_MAX,ag_cod_consucode) LOOP

      lv_trama_items := lv_trama_items ||'<i>';
      lv_trama_items := lv_trama_items ||'<ctr><![CDATA[<img src=images/Eliminar.gif onclick=borraNodoItem('|| xrow.proc_item || ') />]]></ctr>';
      lv_trama_items := lv_trama_items ||'<nro>'||ln_fila||'</nro>';
      lv_trama_items := lv_trama_items ||'<item>'||xrow.proc_item||'</item>';
      lv_trama_items := lv_trama_items ||'<fbp>'||xrow.f_bp_cons||'</fbp>';
      lv_trama_items := lv_trama_items ||'<ubi>'||xrow.ubigeo||'</ubi>';
      lv_trama_items := lv_trama_items ||'<des>'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'</des>';


      lv_trama_items := lv_trama_items ||'<mon>'||xrow.monto||'</mon>';
      lv_trama_items := lv_trama_items ||'<unm>'||xrow.unm_desc||'</unm>';
      lv_trama_items := lv_trama_items ||'<unc>'||xrow.unm_codigo||'</unc>';
      lv_trama_items := lv_trama_items ||'<can>'||xrow.cantidad||'</can>';
/*
      ccodpresupuestal := f_ccod_presupuesto_conv(xrow.codconsucode,xrow.anhoentidad,xrow.n_convoca);
      LOOP
      FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup;
      EXIT WHEN ccodpresupuestal%NOTFOUND;
      lv_trama_items := lv_trama_items ||'<cp'||ls_cod_presup||'></cp'||ls_cod_presup||'>';
      lv_trama_items := lv_trama_items ||'<cv'||ls_cod_presup||'>0</cv'||ls_cod_presup||'>';
      If ls_cod_presup <> 'Total' Then
            lv_trama_items := lv_trama_items ||'<cp'||ls_cod_presup||'><![CDATA[<input type=text size=6 onBlur=calTotFila('''|| ls_cod_presup ||''','||xrow.proc_item||',this.value) />]]></cp'||ls_cod_presup||'>';
      End If;
      END LOOP;
      CLOSE ccodpresupuestal;

      lv_trama_items := lv_trama_items ||'</i>';
      */
     /* ---------- Codigo Presupuestal ------------------------------------------------------------
      lv_trama_codpresup := lv_trama_codpresup ||'<i>';
      lv_trama_codpresup := lv_trama_codpresup ||'<item>'||xrow.proc_item||'</item>';
      lv_trama_codpresup := lv_trama_codpresup ||'<nro>'||ln_fila||'</nro>';
      lv_trama_codpresup := lv_trama_codpresup ||'<mon>'||xrow.monto||'</mon>';

      ccodpresupuestal := f_ccod_presupuesto_conv(xrow.codconsucode,xrow.anhoentidad,xrow.n_convoca);
      LOOP
      FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup;
      EXIT WHEN ccodpresupuestal%NOTFOUND;
      lv_trama_codpresup := lv_trama_codpresup ||'<cv'||ls_cod_presup||'>0</cv'||ls_cod_presup||'>';

      If ls_cod_presup <> 'Total' Then
            lv_trama_codpresup := lv_trama_codpresup ||'<cp'||ls_cod_presup||'><![CDATA[<input type=text size=7 value=0 onKeyPress=f_validaCampoNumerico() maxlength=8 onBlur=calTotFila('''|| ls_cod_presup ||''','||xrow.proc_item||',this.value,this) />]]></cp'||ls_cod_presup||'>';
      Else
            lv_trama_codpresup := lv_trama_codpresup ||'<cp'||ls_cod_presup||'>0</cp'||ls_cod_presup||'>';
      End if;
      END LOOP;
      CLOSE ccodpresupuestal;

      lv_trama_codpresup := lv_trama_codpresup ||'</i>';*/
      -------------------------------------------------------------------------------------------

      ln_fila := ln_fila + 1;

  END LOOP;

 END IF;

 lv_trama_items := lv_trama_items ||'</root></xml>';

  ---------- Codigo Presupuestal ---------------
  lv_trama_codpresup := lv_trama_codpresup ||'</root></xml>';
  ag_cod_presup      := lv_trama_codpresup;
  ----------------------------------------------

 RETURN lv_trama_items;

END;

/*******************************************************************************
/ Procedimiento : f_getXmlItemsCodPresu
/ Proposito :
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     18-06-2009 11:59  Version Inicial
/******************************************************************************/
function f_getXmlItemsCodPresu(
       anho_entidad        varchar2,
       ag_codconsucode     varchar2,
       ag_cod_contrato     varchar2) return VARCHAR2
is

  lv_trama_items VARCHAR2(32200);
  ln_fila        NUMBER;


    ------- Items ----------
  CURSOR cCodPresupuesto (p_anhoentidad varchar2,p_entidad varchar2)
  IS

      select m.proy_descripcion descripcion,  lpad(m.proy_codigo,6,'0' ) proy_codigo, p.proc_item,
             p.monto
        from mef_proyectos  m
        inner join ITEM_CONTRATO_PRESUP  p
        on m.proy_codigo = p.cod_presupuestal
        and m.proy_anho = p_anhoentidad
        where p.n_cod_contrato = ag_cod_contrato;

   BEGIN

   ln_fila        := 1;
   lv_trama_items := lv_trama_items ||'<xml id="xmlPresupuesto">';
   lv_trama_items := lv_trama_items ||'<root>';

  FOR xrow IN cCodPresupuesto(anho_entidad,ag_codconsucode) LOOP
      lv_trama_items := lv_trama_items ||'<i>';
      lv_trama_items := lv_trama_items ||'<ctr><![CDATA[<img src=images/Eliminar.gif alt=Elimnar onclick=borraNodoItemPresupuesto('||xrow.proc_item||','||xrow.proy_codigo||') />]]></ctr>';
      lv_trama_items := lv_trama_items ||'<cod>'||xrow.proy_codigo||'</cod>';
      lv_trama_items := lv_trama_items ||'<nro>'||ln_fila||'</nro>';
      lv_trama_items := lv_trama_items ||'<des>'||xrow.descripcion||'</des>';
      lv_trama_items := lv_trama_items ||'<mon>'||TRIM(TO_CHAR (TO_NUMBER (xrow.monto),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</mon>';
      lv_trama_items := lv_trama_items ||'<item>'||xrow.proc_item||'</item>';
      lv_trama_items := lv_trama_items ||'</i>';

      ln_fila := ln_fila + 1;

   END LOOP;

 lv_trama_items := lv_trama_items ||'</root></xml>';

 RETURN lv_trama_items;

END;

/*******************************************************************************
/ Procedimiento : f_getXmlItemsManContrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     04-05-2009 11:59  Version Inicial
/******************************************************************************/

function f_getXmlItemsManContrato(
         ag_n_contrato            NUMBER,
         ag_n_convoca             NUMBER,
         ag_cod_presup        OUT VARCHAR2) RETURN VARCHAR2
IS

  lv_trama_items                VARCHAR2(32767);
  lv_trama_codpresup            VARCHAR2(32200);
  ln_fila                       NUMBER;
  ln_codconsucode               NUMBER;
  ln_anhoentidad                NUMBER;
  ccodpresupuestal              ref_cursor;

  ls_cod_presup                 VARCHAR2(10);
  ln_monto_presup               NUMBER;
  ln_item_presup                NUMBER;

  ln_total_codpresup            NUMBER;

  CURSOR citemscontrato (
     pn_nconvoca        NUMBER,
     p_n_cod_contrato   NUMBER
  )
  IS
     SELECT DISTINCT
       ict.monto  monto,
       ict.cantidad cantidad,
       ict.proc_item, REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(icv.descripcion) descripcion, icv.dep_codigo,
       icv.pro_codigo, icv.dis_codigo, dep.dep_desc,
       pro.pro_desc, dis.dis_desc, unm.unm_desc,unm.unm_codigo,
       TO_CHAR(cd.fec_upload,reg_procesos.pku_ss_constantes.gv_formato_fecha) f_bp_cons,
       ( '['|| icv.dep_codigo||icv.pro_codigo||icv.dis_codigo || '] ['|| icv.dep_codigo|| '] '|| dep.dep_desc || ' / ['|| icv.pro_codigo|| '] ' || pro.pro_desc || ' / ['|| icv.dis_codigo|| '] '|| dis.dis_desc  ) ubigeo
      FROM reg_procesos.item_contrato ict,
           reg_procesos.item_convoca icv,
           sease.dep_ubigeo dep,
           sease.prov_ubigeo pro,
           sease.dist_ubigeo dis,
           sease.unidad_medida unm,
           reg_procesos.convocatoria_doc cd,
           reg_procesos.item_convoca_estado ice
     WHERE ict.n_cod_contrato = p_n_cod_contrato
       AND ict.n_convoca = icv.n_convoca
       AND ict.proc_item = icv.proc_item
       AND lpad(trim(icv.dep_codigo),2,'0') = lpad(trim(dis.dep_codigo),2,'0')
       AND lpad(trim(icv.pro_codigo),2,'0') = lpad(trim(dis.pro_codigo),2,'0')
       AND lpad(trim(icv.dis_codigo),2,'0') = lpad(trim(dis.dis_codigo),2,'0')
       AND lpad(trim(dis.dep_codigo),2,'0') = lpad(trim(pro.dep_codigo),2,'0')
       AND lpad(trim(dis.pro_codigo),2,'0') = lpad(trim(pro.pro_codigo),2,'0')
       AND lpad(trim(pro.dep_codigo),2,'0') = lpad(trim(dep.dep_codigo),2,'0')
       AND unm.unm_codigo = ict.unm_codigo
       AND cd.cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
       AND cd.n_convoca = pn_nconvoca
       AND ice.cod_doc = cd.cod_doc
       AND ice.proc_item = ict.proc_item
  ORDER BY ict.proc_item;


BEGIN

   SELECT C.CODCONSUCODE, C.ANHOENTIDAD INTO ln_codconsucode,ln_anhoentidad FROM REG_PROCESOS.CONTRATO C WHERE C.N_COD_CONTRATO = ag_n_contrato;

   ccodpresupuestal := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cod_presupuesto_cont(ln_anhoentidad,ag_n_contrato,ag_n_convoca);

   ln_fila        := 1;

   lv_trama_items := lv_trama_items ||'<xml id="xmlItems">';
   lv_trama_items := lv_trama_items ||'<root>';

   ---------- Codigo Presupuestal ---------------
   lv_trama_codpresup := '<xml id="xmlItemsCP">';
   lv_trama_codpresup := lv_trama_codpresup ||'<root>';
   ----------------------------------------------

 IF ag_n_contrato is not null THEN

 FOR xrow IN citemscontrato (ag_n_convoca,ag_n_contrato) LOOP

      lv_trama_items := lv_trama_items ||'<i>';
      lv_trama_items := lv_trama_items ||'<ctr><![CDATA[<img src=images/Eliminar.gif alt=Elimnar onclick=borraNodoItem('|| xrow.proc_item || ') />]]></ctr>';
      lv_trama_items := lv_trama_items ||'<nro>'||ln_fila||'</nro>';
      lv_trama_items := lv_trama_items ||'<item>'||xrow.proc_item||'</item>';
      lv_trama_items := lv_trama_items ||'<fbp>'||xrow.f_bp_cons||'</fbp>';
      lv_trama_items := lv_trama_items ||'<ubi>'||xrow.ubigeo||'</ubi>';
      lv_trama_items := lv_trama_items ||'<des>'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'</des>';
      lv_trama_items := lv_trama_items ||'<mon>'||xrow.monto||'</mon>';
      lv_trama_items := lv_trama_items ||'<unm>'||xrow.unm_desc||'</unm>';
      lv_trama_items := lv_trama_items ||'<unc>'||xrow.unm_codigo||'</unc>';
      lv_trama_items := lv_trama_items ||'<can>'||xrow.cantidad||'</can>';
      lv_trama_items := lv_trama_items ||'<ctr2><![CDATA[<input type=button alt=codigoPresupuestal name=btncp value=Agregar  onclick=addcodigopresupuestal('||ag_n_convoca||','||ln_anhoentidad||','||ln_codconsucode||','|| xrow.proc_item || ',1) />]]></ctr2>';

      LOOP
      FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup,ln_item_presup;
      EXIT WHEN ccodpresupuestal%NOTFOUND;
      lv_trama_items := lv_trama_items ||'<cp'||ls_cod_presup||'></cp'||ls_cod_presup||'>';
      END LOOP;
      CLOSE ccodpresupuestal;


      lv_trama_items := lv_trama_items ||'</i>';

      ---------- Codigo Presupuestal ------------------------------------------------------------
      /*lv_trama_codpresup := lv_trama_codpresup ||'<i>';
      lv_trama_codpresup := lv_trama_codpresup ||'<item>'||xrow.proc_item||'</item>';
      lv_trama_codpresup := lv_trama_codpresup ||'<nro>'||ln_fila||'</nro>';
      lv_trama_codpresup := lv_trama_codpresup ||'<mon>'||xrow.monto||'</mon>';

      ln_total_codpresup := 0;

      ccodpresupuestal   := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cod_presupuesto_cont(ln_anhoentidad,ag_n_contrato,ag_n_convoca);
      LOOP
      FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup,ln_item_presup;
      EXIT WHEN ccodpresupuestal%NOTFOUND;

      lv_trama_codpresup := lv_trama_codpresup ||'<cv'||ls_cod_presup||'>'||nvl(ln_monto_presup,0)||'</cv'||ls_cod_presup||'>';
      ln_total_codpresup := ln_total_codpresup + nvl(ln_monto_presup,0);

      If ls_cod_presup <> 'Total' Then
            lv_trama_codpresup := lv_trama_codpresup ||'<cp'||ls_cod_presup||'><![CDATA[<input type=text size=7 value='''||nvl(ln_monto_presup,0)||''' onKeyPress=f_validaCampoNumerico() maxlength=8 onBlur=calTotFila('''|| ls_cod_presup ||''','||xrow.proc_item||',this.value,this) />]]></cp'||ls_cod_presup||'>';
      Else
            lv_trama_codpresup := lv_trama_codpresup ||'<cp'||ls_cod_presup||'>'||ln_total_codpresup||'</cp'||ls_cod_presup||'>';
      End if;
      END LOOP;
      CLOSE ccodpresupuestal;

      lv_trama_codpresup := lv_trama_codpresup ||'</i>';*/
      -------------------------------------------------------------------------------------------

      ln_fila := ln_fila + 1;

 END LOOP;

 END IF;

 lv_trama_items := lv_trama_items ||'</root></xml>';

 ---------- Codigo Presupuestal ---------------
 lv_trama_codpresup := lv_trama_codpresup ||'</root></xml>';
 ag_cod_presup      := lv_trama_codpresup;
 ----------------------------------------------

 RETURN lv_trama_items;

END;

/*******************************************************************************
/ Procedimiento : f_getXmlCalContrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     13-05-2009 11:59  Version Inicial
/******************************************************************************/
FUNCTION f_getXmlCalContrato(
         ag_cod_contrato            NUMBER ) RETURN VARCHAR2
IS
  lv_trama_calendario VARCHAR2(32200);
  ln_fila             NUMBER;

  CURSOR cCalendario(p_id_operacion NUMBER)
  IS
   SELECT   a.num_pago,
            a.fec_pago,
            a.codmoneda,
            a.monto_pago,
            m.descripcion,
            a.id_operacion
       FROM reg_procesos.CONTRATO_OPERACION_CALENDARIO  a,
            reg_procesos.monedas m,
            reg_procesos.contrato c
      WHERE c.n_cod_contrato = ag_cod_contrato
        AND a.ID_OPERACION   = C.ID_OPERACION
        AND a.codmoneda = m.codmoneda
   ORDER BY a.num_pago;

BEGIN

   ln_fila        := 1;
  -- lv_trama_calendario := lv_trama_calendario ||'<xml id="xmlCalendario">';
   lv_trama_calendario := lv_trama_calendario ||'<root>';


   IF ag_cod_contrato is not null THEN

   FOR xrow IN cCalendario (ag_cod_contrato) LOOP

      lv_trama_calendario := lv_trama_calendario ||'<calendario>';
      -- lv_trama_calendario := lv_trama_calendario ||'<control><![CDATA[<img src=images/Eliminar.gif alt=Elimnar onclick=borraNodoItem('|| xrow.num_pago || ') />]]></control>';
      lv_trama_calendario := lv_trama_calendario ||'<control></control>';
      lv_trama_calendario := lv_trama_calendario ||'<numpago>'||xrow.num_pago||'</numpago>';
      lv_trama_calendario := lv_trama_calendario ||'<fecha>'||to_Char(xrow.fec_pago,'dd/mm/yyyy')||'</fecha>';
      lv_trama_calendario := lv_trama_calendario ||'<monto>'||xrow.monto_pago||'</monto>';
      lv_trama_calendario := lv_trama_calendario ||'<moneda>'||xrow.codmoneda||'</moneda>';
      lv_trama_calendario := lv_trama_calendario ||'<id>'||xrow.num_pago||'</id>';
      lv_trama_calendario := lv_trama_calendario ||'</calendario>';

      ln_fila := ln_fila + 1;

   END LOOP;

 END IF;

 lv_trama_calendario := lv_trama_calendario ||'</root>';
 -- lv_trama_calendario := lv_trama_calendario ||'</xml>';

 RETURN lv_trama_calendario;



END;

/*******************************************************************************
/ Procedimiento : f_getXmlCalAdionReduc
/ Proposito :
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     13-05-2009 11:59  Version Inicial
/******************************************************************************/
FUNCTION f_getXmlCalAdionReduc(
         ag_id_operacion            NUMBER ) RETURN VARCHAR2
IS
  lv_trama_calendario VARCHAR2(32200);
  ln_fila             NUMBER;

  CURSOR cCalendario(p_id_operacion NUMBER)
  IS
  SELECT cal.id_operacion, cal.num_pago, cal.fec_pago, cal.codmoneda, cal.monto_pago
    FROM  contrato_operacion_calendario cal
   WHERE cal.id_operacion = p_id_operacion;

BEGIN

   ln_fila        := 1;
  -- lv_trama_calendario := lv_trama_calendario ||'<xml id="xmlCalendario">';
   lv_trama_calendario := lv_trama_calendario ||'<root>';

 IF ag_id_operacion is not null THEN

   FOR xrow IN cCalendario (ag_id_operacion) LOOP

      lv_trama_calendario := lv_trama_calendario ||'<calendario>';
      -- lv_trama_calendario := lv_trama_calendario ||'<control><![CDATA[<img src=images/Eliminar.gif alt=Elimnar onclick=borraNodoItem('|| xrow.num_pago || ') />]]></control>';
      lv_trama_calendario := lv_trama_calendario ||'<control></control>';
      lv_trama_calendario := lv_trama_calendario ||'<numpago>'||xrow.num_pago||'</numpago>';
      lv_trama_calendario := lv_trama_calendario ||'<fecha>'||to_Char(xrow.fec_pago,'dd/mm/yyyy')||'</fecha>';
      lv_trama_calendario := lv_trama_calendario ||'<monto>'||xrow.monto_pago||'</monto>';
      lv_trama_calendario := lv_trama_calendario ||'<moneda>'||xrow.codmoneda||'</moneda>';
      lv_trama_calendario := lv_trama_calendario ||'<id>'||xrow.num_pago||'</id>';
      lv_trama_calendario := lv_trama_calendario ||'</calendario>';

      ln_fila := ln_fila + 1;

   END LOOP;

 END IF;

 lv_trama_calendario := lv_trama_calendario ||'</root>';
 -- lv_trama_calendario := lv_trama_calendario ||'</xml>';

 RETURN lv_trama_calendario;

END;

/*******************************************************************************
/ Procedimiento : f_getXmlItemsAdionReduc
/ Proposito :    Para listar los Items registrados en la pantalla de registro
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     13-05-2009 11:59  Version Inicial
/******************************************************************************/
function f_getXmlItemsAdionReduc(
         ag_n_contrato            NUMBER,
         ag_cod_Adicional         NUMBER ) return VARCHAR2
is

  lv_trama_items VARCHAR2(32200);
  ln_fila        NUMBER;

  CURSOR cItems(p_n_cod_contrato NUMBER,p_cod_adicional NUMBER)
  IS
       SELECT itemc.proc_item,
              REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itemc.descripcion) descripcion,
              unm.unm_desc,
              unm.unm_codigo,
              itemc.cantidad,
              itema.monto_adicional
         FROM reg_procesos.adicional_reduccion_item  itema
   INNER JOIN item_contrato item on itema.n_cod_contrato = item.n_cod_contrato and itema.proc_item = item.proc_item
   INNER JOIN item_convoca itemc on item.n_convoca = itemc.n_convoca and item.proc_item = itemc.proc_item
   INNER JOIN sease.unidad_medida unm on itemc.unm_codigo = unm.unm_codigo
        WHERE itema.n_cod_contrato = p_n_cod_contrato
          AND itema.cod_adicional  = p_cod_adicional;

BEGIN

   ln_fila        := 1;
   lv_trama_items := lv_trama_items ||'<xml id="xmlItems">';
   lv_trama_items := lv_trama_items ||'<root>';

 IF ag_n_contrato is not null THEN

   FOR xrow IN cItems (ag_n_contrato,ag_cod_Adicional) LOOP

    lv_trama_items := lv_trama_items ||'<i>';
      lv_trama_items := lv_trama_items ||'<ctr><![CDATA[<img src=images/Eliminar.gif alt=Elimnar onclick=borraNodoItem('|| xrow.proc_item || ') />]]></ctr>';
      lv_trama_items := lv_trama_items ||'<nro>'||ln_fila||'</nro>';
      lv_trama_items := lv_trama_items ||'<item>'||xrow.proc_item||'</item>';
      lv_trama_items := lv_trama_items ||'<des>'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'</des>';
      lv_trama_items := lv_trama_items ||'<mon>'||xrow.monto_adicional||'</mon>';
      lv_trama_items := lv_trama_items ||'<unm>'||xrow.unm_desc||'</unm>';
      lv_trama_items := lv_trama_items ||'<unc>'||xrow.unm_codigo||'</unc>';
      lv_trama_items := lv_trama_items ||'<can>'||xrow.cantidad||'</can>';
      lv_trama_items := lv_trama_items ||'</i>';

      ln_fila := ln_fila + 1;

   END LOOP;

 END IF;

 lv_trama_items := lv_trama_items ||'</root></xml>';

 RETURN lv_trama_items;

END;

/*******************************************************************************
/ Procedimiento : f_getXmlItemsAdionReducSel
/ Proposito :     para mostrar los items del contrato cuando se hace una reduccion o adicional,
                  incluye la logica de topes maximos.
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     14-05-2009 11:59  Version Inicial
/******************************************************************************/
function f_getXmlItemsAdionReducSel(
         ag_n_contrato            NUMBER,
         ag_entidad_sel           VARCHAR2,
         ag_ind_adc_red           NUMBER ,
         ln_cod_obj               NUMBER,
         t_tipo_consultoria       NUMBER

       ) return VARCHAR2
is

  lv_trama_items VARCHAR2(32200);
  ln_fila        NUMBER;
ln_ley number;


    ------- Items del Contrato ----------
      CURSOR c_items_cont (
         p_n_cod_contrato   IN   NUMBER/*,
         p_fila_ini         IN   NUMBER DEFAULT NULL,
         p_fila_fin         IN   NUMBER DEFAULT NULL*/

      )
      IS
         SELECT *
           FROM (SELECT ROWNUM num, a.*
                   FROM (
                    SELECT  ic.descripcion,
                            i.n_cod_contrato,
                            i.proc_item,
                            i.monto monto,
                            aditems.SUMMONTO,
                            I.MONTO * (TOPES.TOPE/100)tope,
                            i.unm_codigo unm_codigo,
                            i.cantidad cantidad,
                            i.f_registro,
                            m.unm_desc,
                            c.codconsucode,
                            topes.codobjeto,
                            i.n_convoca n_convoca


                               FROM reg_procesos.item_convoca ic,
                                    reg_procesos.item_contrato i,
                                    sease.unidad_medida m,
                                    reg_procesos.convocatorias c,
                                    REG_PROCESOS.ADICIONAL_REDUCCION_TOPES TOPES,
                                    (SELECT PROC_ITEM,SUM(ITEM.MONTO_ADICIONAL) SUMMONTO
                                        FROM reg_procesos.adicional_reduccion_item item
                                        INNER JOIN REG_PROCESOS.ADICIONAL_REDUCCION ADC ON ITEM.COD_ADICIONAL = ADC.COD_ADICIONAL
                                       WHERE item.n_cod_contrato = p_n_cod_contrato
                                       AND ADC.IND_ADICIONAL_REDUCCION = ag_ind_adc_red
                                       GROUP BY PROC_ITEM
                                    ) aditems
                              WHERE i.n_cod_contrato = p_n_cod_contrato
                                AND i.n_convoca      = ic.n_convoca
                                AND i.proc_item      = ic.proc_item
                                AND i.unm_codigo     = m.unm_codigo
                                AND ic.n_convoca     = c.n_convoca
                                AND c.codobjeto      = topes.codobjeto
                                and topes.ind_adicional_reduccion = ag_ind_adc_red
                                AND i.proc_item      = aditems.PROC_ITEM (+)

                               /* INICIO - Se agrega validación en atención de incidencia (2040_OP_SEACE2_CON) */
                                AND (
                                       (ag_entidad_sel is  null )
                                       or
                                       (
                                         (ag_entidad_sel is not null )
                                          AND
                                         ( ag_entidad_sel   = (
                                                            case
                                                                 when ag_entidad_sel = '000008' and c.codobjeto='4' then '000008' /*De acuerdo a Ley Contrataciones art 41 - 41.3*/
                                                                 when topes.cgr = 2 and c.cod_tipo_modalidad = 0 then c.codconsucode
                                                                 when topes.cgr = 1 then '000008'
                                                                 else ag_entidad_sel
                                                            end)
                                         )
                                       )
                                     )   
                                /*FIN*/
                           ORDER BY i.proc_item
                         ) a) b;
/*          WHERE b.num >= p_fila_ini AND b.num <= p_fila_fin;*/

    BEGIN

   ln_fila        := 1;
   lv_trama_items := lv_trama_items ||'<xml id="xmlItems">';
   lv_trama_items := lv_trama_items ||'<root>';

 IF ag_n_contrato is not null THEN

 FOR xrow IN c_items_cont (ag_n_contrato/*,ln_fila_ini,ln_fila_fin*/) LOOP

      lv_trama_items := lv_trama_items ||'<item>';
      lv_trama_items := lv_trama_items ||'<chk><![CDATA[<input type=checkbox   name=proc_item  value='|| xrow.proc_item||' onclick=asignarItem(this) />]]></chk>';
      lv_trama_items := lv_trama_items ||'<procitem>'||xrow.proc_item||'</procitem>';
      lv_trama_items := lv_trama_items ||'<fila>'||ln_fila||'</fila>';
      lv_trama_items := lv_trama_items ||'<unidad>'||xrow.unm_desc||'</unidad>';
      lv_trama_items := lv_trama_items ||'<cantidad>'||xrow.cantidad||'</cantidad>';
      lv_trama_items := lv_trama_items ||'<descripcion><![CDATA['||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||']]></descripcion>';

      lv_trama_items := lv_trama_items ||'<mon>'||nvl(round(TO_NUMBER (xrow.monto),2),0)||'</mon>';
       -- Memo 368-2011/spla-raa


     ln_ley :=  f_get_primer_publicado(xrow.n_convoca)  ;




         if ln_cod_obj = 4 and t_tipo_consultoria = 2 and  ln_ley  = 1 then
                 if  ag_entidad_sel  =  '000008'  and ag_ind_adc_red  = 3     then
                           lv_trama_items := lv_trama_items ||'<top>'||nvl(round(TO_NUMBER (xrow.tope),2),0) ||'</top>';
                  else
                           lv_trama_items := lv_trama_items ||'<top>'||nvl(round(TO_NUMBER (xrow.monto),2) * 0.15  ,0) ||'</top>';
                  end if;

         else
               lv_trama_items := lv_trama_items ||'<top>'||nvl(round(TO_NUMBER (xrow.tope),2),0) ||'</top>';
         end if ;



      lv_trama_items := lv_trama_items ||'<sum>'||nvl(round(TO_NUMBER (xrow.SUMMONTO),2),0)||'</sum>';

--    lv_trama_items := lv_trama_items ||'<mon>'||trim(TO_CHAR (TO_NUMBER (xrow.monto),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</mon>';
--    lv_trama_items := lv_trama_items ||'<top>'||trim(TO_CHAR (TO_NUMBER (xrow.tope),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</top>';
--    lv_trama_items := lv_trama_items ||'<sum>'||trim(TO_CHAR (nvl(TO_NUMBER (xrow.SUMMONTO),0),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</sum>';

      lv_trama_items := lv_trama_items ||'<monto></monto>';
      lv_trama_items := lv_trama_items ||'<copiar>NO</copiar>';

     /* if xrow.codobjeto in (1,2,4) then*/
      lv_trama_items := lv_trama_items ||'<chl><![CDATA[<input type=checkbox   name=pley  value='|| xrow.proc_item||' onclick=asignarLey(this) />]]></chl>';
      lv_trama_items := lv_trama_items ||'<ley>0</ley>';
   /*   end if;*/

      lv_trama_items := lv_trama_items ||'</item>';

      ln_fila := ln_fila + 1;

   END LOOP;

 END IF;

 lv_trama_items := lv_trama_items ||'</root></xml>';

 RETURN lv_trama_items;

END;

/*******************************************************************************
/ Procedimiento : f_getXmlItemsAdionReducSel2
/ Proposito :     para mostrar los items del contrato cuando se hace una reduccion o adicional,
                  incluye la logica de topes maximos.
/ Entradas :
/ Salidas:
/ Sustento: Suceso #14129
            INC.2014.02.25.246_OP.No permite registrar adicional
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Isaac Mendoza     02-05-2014 17:23  Version inicial
/******************************************************************************/
function f_getXmlItemsAdionReducSel2(
         ag_n_contrato            NUMBER,
         ag_entidad_sel           VARCHAR2,
         ag_ind_adc_red           NUMBER ,
         ln_cod_obj               NUMBER,
         t_tipo_consultoria       NUMBER,
         n_entidad_autoriza     NUMBER

       ) return VARCHAR2
is

  lv_trama_items VARCHAR2(32200);
  ln_fila        NUMBER;
ln_ley number;


    ------- Items del Contrato ----------
      CURSOR c_items_cont (
         p_n_cod_contrato   IN   NUMBER
      )
      IS
         SELECT *
           FROM (SELECT ROWNUM num, a.*
                   FROM (
                    SELECT  ic.descripcion,
                            i.n_cod_contrato,
                            i.proc_item,
                            i.monto monto,
                            aditems.SUMMONTO,
                            I.MONTO * (TOPES.TOPE/100)tope,
                            i.unm_codigo unm_codigo,
                            i.cantidad cantidad,
                            i.f_registro,
                            m.unm_desc,
                            c.codconsucode,
                            topes.codobjeto,
                            i.n_convoca n_convoca


                               FROM reg_procesos.item_convoca ic,
                                    reg_procesos.item_contrato i,
                                    sease.unidad_medida m,
                                    reg_procesos.convocatorias c,
                                    REG_PROCESOS.ADICIONAL_REDUCCION_TOPES TOPES,
                                    (SELECT PROC_ITEM,SUM(ITEM.MONTO_ADICIONAL) SUMMONTO
                                        FROM reg_procesos.adicional_reduccion_item item
                                        INNER JOIN REG_PROCESOS.ADICIONAL_REDUCCION ADC ON ITEM.COD_ADICIONAL = ADC.COD_ADICIONAL
                                       WHERE item.n_cod_contrato = p_n_cod_contrato
                                       AND ADC.IND_ADICIONAL_REDUCCION = ag_ind_adc_red
                                       GROUP BY PROC_ITEM
                                    ) aditems
                              WHERE i.n_cod_contrato = p_n_cod_contrato
                                AND i.n_convoca      = ic.n_convoca
                                AND i.proc_item      = ic.proc_item
                                AND i.unm_codigo     = m.unm_codigo
                                AND ic.n_convoca     = c.n_convoca
                                AND c.codobjeto      = topes.codobjeto
                                and topes.ind_adicional_reduccion = ag_ind_adc_red
                                and topes.cgr = n_entidad_autoriza
                                AND i.proc_item      = aditems.PROC_ITEM (+)


                           ORDER BY i.proc_item
                         ) a) b;

    BEGIN

   ln_fila        := 1;
   lv_trama_items := lv_trama_items ||'<xml id="xmlItems">';
   lv_trama_items := lv_trama_items ||'<root>';

 IF ag_n_contrato is not null THEN

 FOR xrow IN c_items_cont (ag_n_contrato) LOOP

      lv_trama_items := lv_trama_items ||'<item>';
      lv_trama_items := lv_trama_items ||'<chk><![CDATA[<input type=checkbox   name=proc_item  value='|| xrow.proc_item||' onclick=asignarItem(this) />]]></chk>';
      lv_trama_items := lv_trama_items ||'<procitem>'||xrow.proc_item||'</procitem>';
      lv_trama_items := lv_trama_items ||'<fila>'||ln_fila||'</fila>';
      lv_trama_items := lv_trama_items ||'<unidad>'||xrow.unm_desc||'</unidad>';
      lv_trama_items := lv_trama_items ||'<cantidad>'||xrow.cantidad||'</cantidad>';
      lv_trama_items := lv_trama_items ||'<descripcion><![CDATA['||F_GEN_CARACTER_EXTRANOS(xrow.descripcion)||']]></descripcion>';

      lv_trama_items := lv_trama_items ||'<mon>'||nvl(round(TO_NUMBER (xrow.monto),2),0)||'</mon>';
       -- Memo 368-2011/spla-raa


     ln_ley :=  f_get_primer_publicado(xrow.n_convoca)  ;




         if ln_cod_obj = 4 and t_tipo_consultoria = 2 and  ln_ley  = 1 then
                 if  ag_entidad_sel  =  '000008'  and ag_ind_adc_red  = 3     then
                           lv_trama_items := lv_trama_items ||'<top>'||nvl(round(TO_NUMBER (xrow.tope),2),0) ||'</top>';
                  else
                           lv_trama_items := lv_trama_items ||'<top>'||nvl(round(TO_NUMBER (xrow.monto),2) * 0.15  ,0) ||'</top>';
                  end if;

         else
               lv_trama_items := lv_trama_items ||'<top>'||nvl(round(TO_NUMBER (xrow.tope),2),0) ||'</top>';
         end if ;



      lv_trama_items := lv_trama_items ||'<sum>'||nvl(round(TO_NUMBER (xrow.SUMMONTO),2),0)||'</sum>';

--    lv_trama_items := lv_trama_items ||'<mon>'||trim(TO_CHAR (TO_NUMBER (xrow.monto),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</mon>';
--    lv_trama_items := lv_trama_items ||'<top>'||trim(TO_CHAR (TO_NUMBER (xrow.tope),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</top>';
--    lv_trama_items := lv_trama_items ||'<sum>'||trim(TO_CHAR (nvl(TO_NUMBER (xrow.SUMMONTO),0),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</sum>';

      lv_trama_items := lv_trama_items ||'<monto></monto>';
      lv_trama_items := lv_trama_items ||'<copiar>NO</copiar>';


      lv_trama_items := lv_trama_items ||'<chl><![CDATA[<input type=checkbox   name=pley  value='|| xrow.proc_item||' onclick=asignarLey(this) />]]></chl>';
      lv_trama_items := lv_trama_items ||'<ley>0</ley>';


      lv_trama_items := lv_trama_items ||'</item>';

      ln_fila := ln_fila + 1;

   END LOOP;

 END IF;

 lv_trama_items := lv_trama_items ||'</root></xml>';

 RETURN lv_trama_items;

END;

/*******************************************************************************
/ Procedimiento : f_getXmlItemsReajuste
/ Proposito :    Para listar los Items registrados en la pantalla de registro de Reajustes
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-05-2009 18:44  Version Inicial
/******************************************************************************/
FUNCTION f_getXmlItemsReajuste(
         ag_cod_Contrato          NUMBER,
         ag_cod_Reajuste          NUMBER ) RETURN VARCHAR2
IS

  lv_trama_items VARCHAR2(32200);
  ln_fila        NUMBER;

  CURSOR cItems(p_cod_contrato NUMBER, p_cod_reajuste NUMBER)
  IS
  SELECT i.n_cod_contrato,
         ic.descripcion,
         i.proc_item,
         i.f_registro,
         r.monto_reajuste monto,
         m.unm_codigo,
         m.unm_desc,
         i.cantidad
    FROM reg_procesos.item_convoca ic,
         reg_procesos.item_contrato i,
         sease.unidad_medida m,
         reg_procesos.contrato_reajuste_item r
   WHERE i.n_cod_contrato = p_cod_contrato
     AND i.n_convoca = ic.n_convoca
     AND i.proc_item = ic.proc_item
     AND i.unm_codigo     = m.unm_codigo
     AND r.n_cod_contrato = i.n_cod_contrato
     AND r.proc_item      = i.proc_item
     AND r.cod_reajuste   = p_cod_reajuste
   order by i.proc_item;


BEGIN

   ln_fila        := 1;
   lv_trama_items := lv_trama_items ||'<xml id="xmlItems">';
   lv_trama_items := lv_trama_items ||'<root>';

 IF ag_cod_Contrato is not null THEN

   FOR xrow IN cItems (ag_cod_Contrato,ag_cod_Reajuste) LOOP
    lv_trama_items := lv_trama_items ||'<i>';
      lv_trama_items := lv_trama_items ||'<ctr><![CDATA[<img src=images/Eliminar.gif alt=Elimnar onclick=borraNodoItem('|| xrow.proc_item || ') />]]></ctr>';
      lv_trama_items := lv_trama_items ||'<nro>'||ln_fila||'</nro>';
      lv_trama_items := lv_trama_items ||'<item>'||xrow.proc_item||'</item>';
      lv_trama_items := lv_trama_items ||'<des>'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'</des>';
      lv_trama_items := lv_trama_items ||'<mon>'||xrow.monto||'</mon>';
      lv_trama_items := lv_trama_items ||'<unm>'||xrow.unm_desc||'</unm>';
      lv_trama_items := lv_trama_items ||'<unc>'||xrow.unm_codigo||'</unc>';
      lv_trama_items := lv_trama_items ||'<can>'||xrow.cantidad||'</can>';
      lv_trama_items := lv_trama_items ||'</i>';

      ln_fila := ln_fila + 1;

   END LOOP;

 END IF;

 lv_trama_items := lv_trama_items ||'</root></xml>';

 RETURN lv_trama_items;

END;


/*******************************************************************************
/ Procedimiento : f_getXmlItemsComPro
/ Proposito :    Para listar los Items registrados en la pantalla de registro
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     22-05-2009 18:44  Version Inicial
/******************************************************************************/
function f_getXmlItemsComPro(
         ag_n_contrato            NUMBER,
         ag_cod_Adicional         NUMBER ) return VARCHAR2
is

  lv_trama_items VARCHAR2(32200);
  ln_fila        NUMBER;

  CURSOR cItems(p_n_cod_contrato NUMBER,p_cod_adicional NUMBER)
  IS
    SELECT itemc.proc_item,
              --itemc.descripcion,
              REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itemc.descripcion) descripcion,
              unm.unm_desc,
              unm.unm_codigo,
              itemc.cantidad,
              item.monto
         FROM reg_procesos.contrato co
   INNER JOIN item_contrato item on co.n_cod_contrato = item.n_cod_contrato
   INNER JOIN item_convoca  itemc on item.n_convoca = itemc.n_convoca and item.proc_item = itemc.proc_item
   INNER JOIN sease.unidad_medida unm on itemc.unm_codigo = unm.unm_codigo
        WHERE cO.n_cod_contrato         = ag_n_contrato
          AND co.cod_operacion_contrato = ag_cod_Adicional;


BEGIN

   ln_fila        := 1;
   lv_trama_items := lv_trama_items ||'<xml id="xmlItems">';
   lv_trama_items := lv_trama_items ||'<root>';

 IF ag_n_contrato is not null THEN

   FOR xrow IN cItems (ag_n_contrato,ag_cod_Adicional) LOOP

    lv_trama_items := lv_trama_items ||'<i>';
      lv_trama_items := lv_trama_items ||'<ctr><![CDATA[<img src=images/Eliminar.gif alt=Elimnar onclick=borraNodoItem('|| xrow.proc_item || ') />]]></ctr>';
      lv_trama_items := lv_trama_items ||'<nro>'||ln_fila||'</nro>';
      lv_trama_items := lv_trama_items ||'<item>'||xrow.proc_item||'</item>';
      lv_trama_items := lv_trama_items ||'<des>'||F_GEN_CARACTER_EXTRANOS(xrow.descripcion)||'</des>';
      lv_trama_items := lv_trama_items ||'<mon>'||xrow.monto||'</mon>';
      lv_trama_items := lv_trama_items ||'<unm>'||xrow.unm_desc||'</unm>';
      lv_trama_items := lv_trama_items ||'<unc>'||xrow.unm_codigo||'</unc>';
      lv_trama_items := lv_trama_items ||'<can>'||xrow.cantidad||'</can>';
      lv_trama_items := lv_trama_items ||'</i>';

      ln_fila := ln_fila + 1;

   END LOOP;

 END IF;

 lv_trama_items := lv_trama_items ||'</root></xml>';

 RETURN lv_trama_items;

END;

/*******************************************************************************
/ Procedimiento : f_getXmlItemsComPro
/ Proposito :     para mostrar los items del contrato cuando se hace una Prorroga o Complementario,
                  incluye la logica de topes maximos.
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     14-05-2009 11:59  Version Inicial
/******************************************************************************/
function f_getXmlItemsComPro_sel(
         ag_n_contrato            NUMBER,
         ag_ind_com_pro           NUMBER
       ) return VARCHAR2
is

  lv_trama_items VARCHAR2(32200);
  ln_fila        number;
  ln_igual       number;

    ------- Items con Contrato Complementario----------
    CURSOR c_items_cont_comp (ag_n_contrato IN   NUMBER)
      IS
    SELECT DISTINCT item.proc_item FROM reg_procesos.contrato co
    INNER JOIN reg_procesos.contrato cc ON cc.n_cod_contrato = co.n_cod_contrato
    inner join item_contrato item on co.n_cod_contrato = item.n_cod_contrato
        WHERE cc.n_cod_contrato_de_renovac = ag_n_contrato
          AND cc.cod_operacion_contrato = 6; 

    ------- Items del Contrato ----------
      CURSOR c_items_cont (
         p_n_cod_contrato   IN   NUMBER/*,
         p_fila_ini         IN   NUMBER DEFAULT NULL,
         p_fila_fin         IN   NUMBER DEFAULT NULL*/

      )
      IS
         SELECT *
           FROM (SELECT ROWNUM num, a.*
                   FROM (
                    Select i.n_cod_contrato,
                          ic.descripcion,
                          i.proc_item,
                          i.f_registro,
                          tope.tope,
                          i.monto,
                          (i.monto * (tope.tope /100 )) topemax,
                          m.unm_codigo,
                          m.unm_desc,
                          i.cantidad,
                          suma.sumamonto
                          from reg_procesos.item_convoca ic,
                               reg_procesos.item_contrato i,
                               reg_procesos.CONTRATO_OPERACION_TOPES tope,
                               sease.unidad_medida m,
                               (
                                  select c.n_cod_contrato,i.proc_item,sum(i.monto) sumamonto
                                  from contrato c
                                  inner join reg_procesos.item_contrato i on c.n_cod_contrato = i.n_cod_contrato
                                  where c.cod_operacion_contrato  = 6
                                  and c.n_cod_contrato = p_n_cod_contrato
                                  group by c.n_cod_contrato,i.proc_item
                               ) suma
                          where i.n_cod_contrato = p_n_cod_contrato
                          and i.n_convoca = ic.n_convoca
                          and i.proc_item = ic.proc_item
                          and reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_getcodobjeto(ic.n_convoca) = tope.codobjeto (+)
                          and tope.cod_operacion_contrato = ag_ind_com_pro
                          and i.unm_codigo                = m.unm_codigo
                          and i.n_cod_contrato            = suma.n_cod_contrato (+)
                          and i.proc_item                 = suma.proc_item (+)
                          order by i.proc_item
                         ) a) b;
/*          WHERE b.num >= p_fila_ini AND b.num <= p_fila_fin;*/

   BEGIN


   ln_fila        := 1;
   lv_trama_items := lv_trama_items ||'<xml id="xmlItems">';
   lv_trama_items := lv_trama_items ||'<root>';

 IF ag_n_contrato is not null THEN

 FOR xrow IN c_items_cont (ag_n_contrato/*,ln_fila_ini,ln_fila_fin*/) LOOP

      lv_trama_items := lv_trama_items ||'<item>';
      lv_trama_items := lv_trama_items ||'<chk><![CDATA[<input type=checkbox   name=proc_item  value='|| xrow.proc_item||' onclick=asignarItem(this) />]]></chk>';
      lv_trama_items := lv_trama_items ||'<procitem>'||xrow.proc_item||'</procitem>';
      lv_trama_items := lv_trama_items ||'<fila>'||ln_fila||'</fila>';
      lv_trama_items := lv_trama_items ||'<unidad>'||xrow.unm_desc||'</unidad>';
      lv_trama_items := lv_trama_items ||'<cantidad>'||xrow.cantidad||'</cantidad>';
      lv_trama_items := lv_trama_items ||'<descripcion><![CDATA['||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||']]></descripcion>';

      lv_trama_items := lv_trama_items ||'<mon>'||TO_NUMBER (xrow.monto)||'</mon>';
      lv_trama_items := lv_trama_items ||'<top>'||TO_NUMBER (xrow.topemax)||'</top>';


--      lv_trama_items := lv_trama_items ||'<mon>'||TRIM(TO_CHAR (TO_NUMBER (xrow.monto),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</mon>';
--      lv_trama_items := lv_trama_items ||'<top>'||TRIM(TO_CHAR (TO_NUMBER (xrow.topemax),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</top>';
      lv_trama_items := lv_trama_items ||'<sum>'||nvl(xrow.sumamonto,0)||'</sum>';
      lv_trama_items := lv_trama_items ||'<monto></monto>';
      lv_trama_items := lv_trama_items ||'<copiar>NO</copiar>';
      IF ag_ind_com_pro = 6 THEN
      ln_igual       := 0;
          FOR cc IN c_items_cont_comp (ag_n_contrato) LOOP
              if cc.proc_item=xrow.proc_item then
                 lv_trama_items := lv_trama_items ||'<chkcc><![CDATA[<input type=checkbox name=chkObjs disabled=true />]]></chkcc>';
                 ln_igual       := 1;
                 exit;
              end if;
          END LOOP;

              if ln_igual = 0 then
                lv_trama_items := lv_trama_items ||'<chkcc><![CDATA[<input type=checkbox name=chkObjs />]]></chkcc>';
              end if;

       END IF;
      lv_trama_items := lv_trama_items ||'</item>';

      ln_fila := ln_fila + 1;

   END LOOP;

 END IF;

 lv_trama_items := lv_trama_items ||'</root></xml>';

 RETURN lv_trama_items;

END;

/*******************************************************************************
/ Procedimiento : f_getXmlItemsReajuste_sel
/ Proposito :     para mostrar los items del contrato cuando se hace un reajuste
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     14-05-2009 11:59  Version Inicial
/******************************************************************************/
procedure f_getXmlItemsReajuste_sel(
         ag_n_contrato            NUMBER,
         ag_tipo_reajuste         VARCHAR2
       ) 
is

  lv_trama_items VARCHAR2(32200);
  ln_fila        NUMBER;



    ------- Items del Contrato ----------
      CURSOR c_items_cont (
         p_n_cod_contrato   IN   NUMBER/*,
         p_fila_ini         IN   NUMBER DEFAULT NULL,
         p_fila_fin         IN   NUMBER DEFAULT NULL*/

      )
      IS
         SELECT *
           FROM (SELECT ROWNUM num, a.*
                   FROM (
                    Select i.n_cod_contrato,
                          ic.descripcion,
                          i.proc_item,
                          i.f_registro,
                          i.monto,
                          m.unm_codigo,
                          m.unm_desc,
                          i.cantidad,
                          (case ag_tipo_reajuste when '1' then 'INCREMENTO' WHEN '2' then 'DECREMENTO' end) tipo_reajuste
                          from reg_procesos.item_convoca ic,
                               reg_procesos.item_contrato i,
                               sease.unidad_medida m
                          where i.n_cod_contrato = p_n_cod_contrato
                          and i.n_convoca = ic.n_convoca
                          and i.proc_item = ic.proc_item
                          AND i.unm_codigo     = m.unm_codigo
                          order by i.proc_item
                         ) a) b;

   BEGIN

PKU_GESTOR_CONT_FUNCIONES_JS_2. fXmlGeneral;

 IF ag_n_contrato is not null THEN

 usp_print('
        <script language="javascript">');

 FOR xrow IN c_items_cont (ag_n_contrato) LOOP

           usp_print('
            v_reajuste[v_reajuste.length] = new InitReajuste();
             v_reajuste[v_reajuste.length-1].mostrar = "";
            v_reajuste[v_reajuste.length-1].nro_item = "'||xrow.proc_item||'";
            v_reajuste[v_reajuste.length-1].descripcion = "'||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'";
            v_reajuste[v_reajuste.length-1].unidad ="'||xrow.unm_desc||'";
             v_reajuste[v_reajuste.length-1].cantidad = "'||xrow.cantidad||'";
            v_reajuste[v_reajuste.length-1].mon = "'||TRIM(TO_CHAR (TO_NUMBER (xrow.monto),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'"
            v_reajuste[v_reajuste.length-1].tir = "'||nvl(xrow.tipo_reajuste,0)||'";
            v_reajuste[v_reajuste.length-1].monto = "";

            ');


   END LOOP;



        usp_print('
            PintarReajuste();
        </script>');

 END IF;

-- usp_print('</root></xml>');

 --RETURN lv_trama_items;

END;


/*******************************************************************************
/ Procedimiento : f_getXmlItemsCodPresu_sel
/ Proposito :     para mostrar los items del contrato cuando se hace una Prorroga o Complementario,
                  incluye la logica de topes maximos.
/ Entradas :
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     14-05-2009 11:59  Version Inicial
/******************************************************************************/
function f_getXmlItemsCodPresu_sel(
       anho_entidad        varchar2,
       ag_n_convoca        varchar2,
       ag_codconsucode        varchar2 ) return VARCHAR2
is

  lv_trama_items VARCHAR2(32200);
  ln_fila        NUMBER;


    ------- Items ----------
  CURSOR cCodPresupuesto (p_anhoentidad varchar2,p_entidad varchar2, p_convoca varchar2)
  IS
   SELECT distinct m.proy_codigo cod_presupuestal, m.proy_descripcion descripcion, s.monto_asignado
      FROM REG_PROCESOS.mef_proyectos_entidades p
        join REG_PROCESOS.mef_proyectos m on p.proy_codigo = m.proy_codigo
        join REG_PROCESOS.convocatoria_cod_presup s on s.cod_presupuestal = m.proy_codigo
      WHERE
          /*  p.codconsucode = LPAD(p_entidad, 6, '0')
        and */p.anhoentidad  = p_anhoentidad
        and m.proy_estado  = 'A'
     /*   and s.n_convoca    = p_convoca*/;

   BEGIN

   ln_fila        := 1;
   lv_trama_items := lv_trama_items ||'<xml id="xmlPresupuesto">';
   lv_trama_items := lv_trama_items ||'<root>';

  FOR xrow IN cCodPresupuesto(anho_entidad,ag_codconsucode,ag_n_convoca) LOOP
      lv_trama_items := lv_trama_items ||'<item>';
      lv_trama_items := lv_trama_items ||'<chk><![CDATA[<input type=checkbox   name=proc_item  value='|| xrow.cod_presupuestal||' onclick=asignarItem(this) />]]></chk>';
      lv_trama_items := lv_trama_items ||'<cod>'||xrow.cod_presupuestal||'</cod>';
      lv_trama_items := lv_trama_items ||'<fila>'||ln_fila||'</fila>';
      lv_trama_items := lv_trama_items ||'<descripcion><![CDATA['||REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||']]></descripcion>';
      lv_trama_items := lv_trama_items ||'<mon>'||TRIM(TO_CHAR (TO_NUMBER (xrow.monto_asignado),reg_procesos.pku_ss_constantes.gv_formato_dinero))||'</mon>';
      lv_trama_items := lv_trama_items ||'<monto></monto>';
      lv_trama_items := lv_trama_items ||'<copiar>NO</copiar>';
      lv_trama_items := lv_trama_items ||'</item>';

      ln_fila := ln_fila + 1;

   END LOOP;

 lv_trama_items := lv_trama_items ||'</root></xml>';

 RETURN lv_trama_items;

END;

/*******************************************************************************/

function f_get_codmoneda_cont( ag_ncod_contrato number) return number
is
  ln_codmoneda number;
begin

  select c.CODMONEDA_CONTRATO into ln_codmoneda from reg_procesos.contrato c where c.n_cod_contrato = ag_ncod_contrato;

  return ln_codmoneda;

  exception
         when NO_DATA_FOUND then
            return null;
end;

function f_get_codmoneda_conv( ag_nconvoca number) return number
is
  ln_codmoneda number;
begin

  select c.codmoneda into ln_codmoneda from reg_procesos.convocatorias c where c.n_convoca = ag_nconvoca;

  return ln_codmoneda;

  exception
         when NO_DATA_FOUND then
            return null;
end;

function f_devuelve_num_proc(
    proctipo number,
    gv_entidad varchar2,
    anhoe VARCHAR2 )
    return varchar2
is
    cursor c_num_procesos (ptipo number, pentidad varchar2, panho varchar2) is

     Select count(a.n_convoca_origen) num_procs

            from
                (
                select c.n_convoca, c.n_convoca_origen, c.n_proceso, c.num_convoca, c.codconsucode,
                       c.cod_tipo_modalidad, c.proc_num, c.proc_sigla, c.des_objeto, c.n_feerrata,
                       c.observaciones, c.ind_part_electronica, c.f_publica, c.codmoneda,
                       c.v_referencial, c.ind_conv_ultimo_pub, c.anhoentidad, c.cod_tipo_subasta,
                       c.proc_tipo, c.ind_proc_tipo_ultimo
                from REG_PROCESOS.convocatorias c
                where
                    c.anhoentidad = panho
                    and c.proc_tipo = ptipo
                    and c.ind_conv_ultimo_pub = 1
                ) a,
                REG_PROCESOS.convocatoria_item_plan b,
                REG_PROCESOS.t_tipo_subasta ts,
                SEASE.moneda m,
                SEASE.tipo_proceso tp
            where
                a.n_convoca = b.n_convoca(+)
                and a.codconsucode = lpad(pentidad,6,'0')
                and a.ind_proc_tipo_ultimo = decode(nvl(b.eue_codigo,to_number(a.codconsucode)),to_number(a.codconsucode),1,0)

                and exists(
                        select ice.cod_tipo_estado_item
                        from REG_PROCESOS.item_convoca_estado ice
                        where ice.n_convoca =  a.n_convoca
                          and ice.cod_tipo_estado_item = 500
                          and ice.f_registro = (
                                                  select max(f_registro)
                                                    from REG_PROCESOS.item_convoca_estado i
                                                   where i.n_convoca = ice.n_convoca
                                                     and i.proc_item = ice.proc_item)
                                                )

                 and m.mon_codigo = a.codmoneda
                and tp.tip_codigo = a.proc_tipo
                and ts.cod_tipo_subasta = a.cod_tipo_subasta;





    lv_num_proc varchar2(500);
begin
    for x in c_num_procesos(proctipo, gv_entidad, anhoe) loop
        lv_num_proc:= x.num_procs;
    end loop;

    if lv_num_proc is null then
        return '0';
    end if;

    return lv_num_proc;
end;

procedure usp_print_linea_gris
is
begin
          usp_print('<tr><td colspan=100><hr style="color: #C0C0C0;height:0.5px;" width="100%"></td></tr>');
end;




/*******************************************************************************
/ Procedimiento : f_list_contratos
/ Proposito :    Contratos , complementarios o prorrogas relacionados a un contrato original
/ Entradas : AV_COD_CONTRATO_ORIGINAL
/ Salidas:
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     15/07/2011 11:59  Version Inicial
/******************************************************************************/

function f_list_contratos(AV_COD_CONTRATO_ORIGINAL varchar2 ) return ref_cursor
is
    cContratos ref_cursor;
begin


      open cContratos for

      select x.n_cod_contrato, (case when x.N_COD_CONTRATO_DE_RENOVAC is null then 'CONTRATO ' end ) || x.n_contrato
      from reg_procesos.contrato x
      where x.n_cod_contrato = AV_COD_CONTRATO_ORIGINAL  or x.N_COD_CONTRATO_DE_RENOVAC = AV_COD_CONTRATO_ORIGINAL ;


      return cContratos;


end;



END;




-- End of DDL Script for Package REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2
/
