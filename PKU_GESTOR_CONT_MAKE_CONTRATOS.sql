set scan off;
CREATE OR REPLACE PACKAGE "PKU_GESTOR_CONT_MAKE_CONTRATOS"

  IS

-- Pendientes
-- la ruta de los docs gv_url_docs
-- ventana donde se muestra si se transfirio al MEF
-- revizar el estado del contrato

-- validancion de montos de la garantia en sanciones

-- test
    lv_url varchar2(200):='http://www.consucode.gob.pe/consultasenlinea/rnp/ConsultaVigenciaCont.asp?ruc=';
    gn_convoca      varchar2(20)  := 130093; --126692;
    gn_codcontrato  number        := 0;
    gn_codconsucode varchar2(20)  := 1952;
    gn_anhoentidad  varchar2(20)  := 2007;
    gn_propuesta    number        := 46622;

  gpk_directorio_intervencion     varchar2(50):= 'mon\docs\contratos';
  gpk_directorio_liquidacion      varchar2(50):= 'mon\docs\contratos';
  gpk_directorio_resumen_cont     varchar2(50):= 'mon\docs\contratos';
  gpk_directorio_resolucion       varchar2(50):= 'mon\docs\contratos';
  gpk_directorio_nulidad          varchar2(50):= 'mon\docs\contratos';  

    --consultoria nube migracion
  url_azure_app    varchar2(50):= 'https://zonasegura2.seace.gob.pe/documentos/';
  url_azure_app1    varchar2(50):= 'https://zonasegura2.seace.gob.pe/';

------------------------- Constantes--------------------------

  type ref_cursor is ref cursor;
  -- Inicio 1508_BD_SEACE3_CON
  --Gv_Pkname       Varchar2(100):= 'PKU_GESTOR_CONT_MAKE_CONTRATOS';
  Gv_Pkname       Varchar2(100):= 'PKU_SS_MAKE_CONTRATO2';
  -- Fin
  gv_opPkName     varchar2(100):= 'PKU_SS_CONTRATOS_TMP';
  gv_PkVentana    varchar2(100):= 'PKU_SS_VENTANAS';
  gv_PkName_co    varchar2(100):= 'PKU_GESTOR_CONT_CONTRATOS';
  gv_url_docs     varchar2(250):= null;
  gv_url_icono    varchar2(250):= null;
  gn_porlet_id    varchar2(250):= 'ContratosConsola';
--  gn_porlet_id    number       := 443;
  gv_pic_eliminar varchar2(200) := PKU_GESTOR_CONT_CONTRATOS.gpk_eliminar;
  gv_pic_vb       varchar2(200) := PKU_GESTOR_CONT_CONTRATOS.gpk_aceptar;


/*******************************************************************************
/ Procedimiento : uspRepResumenContratos
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Casta¿eda                          Version Inicial
/ JCarrillo            19/05/2015        Se agrega el nombre del paquete correcto para busqueda de items del Seace v3 1508_BD_SEACE3_CON
/******************************************************************************/

 procedure uspRepResumenContratos(ag_n_convoca varchar2 default null, ag_cod_contrato varchar2 default null);



procedure uspIrOperacionDoView(
    ag_operacion_va varchar2 default null,
    ag_tipo_op      varchar2 default null,
    ag_n_convoca     varchar2 default null,
    ag_cod_contrato  varchar2 default null,
        ag_proc_tipo      varchar2 DEFAULT Null,
    ag_proc_desc      varchar2 DEFAULT Null,
    ag_proc_sigla     varchar2 DEFAULT Null,
    ag_currenpage     varchar2 DEFAULT Null,
     ag_anhoentidad    varchar2 default null
     );

/*******************************************************************************
/ Procedimiento : uspIrOperacionDoView
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                          Version Inicial
/******************************************************************************/



/*
  procedure uspNewContratosItemsDoEdit(
    ag_fecSusc   varchar2 default null,
    ag_n_convoca  varchar2 default null
    );

/*******************************************************************************
/ Procedimiento : uspNewContratosItemsDoEdit
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                          Version Inicial
/******************************************************************************/
  procedure uspListTransferenciasDoView(ag_ncod_contrato varchar2);

  PROCEDURE usplistcontratosdoview_v3 (
    ag_n_convoca              VARCHAR2 DEFAULT NULL,
    an_codconsucode           VARCHAR2 DEFAULT NULL,
    ag_anhoentidad            VARCHAR2 DEFAULT NULL,
    session__userid           VARCHAR2 DEFAULT NULL,
    ag_proc_tipo              VARCHAR2 DEFAULT NULL,
    ag_proc_desc              VARCHAR2 DEFAULT NULL,
    ag_proc_sigla             VARCHAR2 DEFAULT NULL,
    ag_currenpage             VARCHAR2 DEFAULT NULL,
    session__eue_codigo       VARCHAR2 DEFAULT NULL,
    session__anhoentidad      VARCHAR2 DEFAULT NULL,
    session__filesingedhttp   VARCHAR2 DEFAULT NULL,
    convoca                   VARCHAR2 DEFAULT '',
    contrato                  VARCHAR2 DEFAULT '',
    control_sesion            NUMBER   DEFAULT 0,
    av_ind_resumen            VARCHAR  DEFAULT NULL,
    av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL,
    session__n_convoca        VARCHAR  DEFAULT NULL);

  procedure usp_calcula_costoFinal(ag_ncod_contrato number);

  PROCEDURE usp_change_ruc_contratista (
      ag_ruc_contratista              VARCHAR2,
      ag_ruc_destino_pago             NUMBER,
      ag_n_propuesta                  NUMBER,
      ag_ind_consorcio                NUMBER,
      ag_ruc_destino_pago_out   OUT   VARCHAR2,
      ag_ind_consorcio_out      OUT   NUMBER
   );
  PROCEDURE sp_javascript_valida_ruc;
  PROCEDURE sp_javascript_contratos_ficha;
  PROCEDURE sp_javascript_contratos_busca;
  PROCEDURE paginar_2 (
      ag_hreflink       VARCHAR2 DEFAULT '',                        --LINK URL
      ag_currenpage     NUMBER DEFAULT 0,            --NUMERO DE PAGINA ACTUAL
      ag_totalrecords   NUMBER DEFAULT 0,                 --TOTAL DE REGISTROS
      ag_pagesize       NUMBER DEFAULT 0                 --TAMA¿O DE LA PAGINA
   );
  FUNCTION f_get_validaingcontrato (
      ag_nconvoca       NUMBER,
      ag_proc_tipo      NUMBER,
      ag_codconsucode   NUMBER
   )
      RETURN NUMBER;
  FUNCTION f_get_ncontrato (
      ag_ncodcontrato     IN       VARCHAR2,
      ag_n_convoca        IN       VARCHAR2,
      ag_ncontrato        OUT      VARCHAR2,
      ag_nomcontratista   OUT      VARCHAR2,
      ag_ruccontratista   OUT      VARCHAR2
   )
      RETURN VARCHAR2;
  FUNCTION f_get_itemscontratos (ag_ncod_contrato NUMBER)
      RETURN ref_cursor;
  FUNCTION f_get_itemscontratopropuesta (
      ag_codconsucode   VARCHAR2,
      ag_n_convoca      NUMBER,
      ag_proc_item      NUMBER,
      ag_n_propuesta    NUMBER
   )
      RETURN ref_cursor;
  FUNCTION f_get_itemsadjudicados (ag_n_convoca NUMBER, ag_codconsucode NUMBER)
      RETURN ref_cursor;


  FUNCTION f_crucs_contrato (ag_n_convoca NUMBER)
      RETURN ref_cursor;
  FUNCTION f_get_cantitemsenejecucion (ag_ncod_contrato NUMBER)
      RETURN NUMBER;
  FUNCTION f_get_cantitemsresueltos (ag_ncod_contrato NUMBER)
      RETURN NUMBER;
  PROCEDURE f_get_ciiu (
      ag_n_convoca            VARCHAR2,
      ag_ciu_codigo     OUT   VARCHAR2,
      ag_ciu_especial   OUT   VARCHAR2,
      ag_ciu_desc       OUT   VARCHAR2
   );
  FUNCTION f_get_ciiudesc (ag_cod_ciiu VARCHAR2, ag_esp_ciiu VARCHAR2)
      RETURN VARCHAR2;
  FUNCTION f_get_contrato_renov_fcontra (
      ag_ncod_contrato   IN       NUMBER,
      ag_fcontrato       OUT      VARCHAR2,
      ag_fculminacion    OUT      VARCHAR2
   )
      RETURN NUMBER;
  FUNCTION f_get_contratomensajeerrortx (ag_idtx NUMBER, ag_showerror NUMBER)
      RETURN VARCHAR2;
  FUNCTION f_get_contratoresultadotx (ag_cod_contrato NUMBER)
      RETURN ref_cursor;
  FUNCTION f_get_contratos (
      ag_n_convoca      IN       NUMBER,
      ag_codconsucode   IN       NUMBER,
      session__userid   IN       VARCHAR2,
      ag_count          OUT      NUMBER
   )
      RETURN ref_cursor;

  FUNCTION f_get_datospostorbp (
      ag_n_convoca     IN       NUMBER,
      ag_n_propuesta   IN       NUMBER,
      ag_postorruc     OUT      VARCHAR2,
      ag_postornom     OUT      VARCHAR2
   )
      RETURN NUMBER;
  FUNCTION f_get_documentoscontrato (
      ag_cod_doc_liq      IN       VARCHAR2 DEFAULT NULL,
      ag_doc_url          OUT      VARCHAR2,
      ag_icon_tipo_file   OUT      VARCHAR2,
      ag_doc_nombre       OUT      VARCHAR2
   )
      RETURN NUMBER;
  FUNCTION f_get_estadocontrato (
      f_contrato_pro      IN   DATE,
      f_culminacion_pro   IN   DATE,
      f_liquidacion       IN   DATE,
      fec_intervencion    IN   DATE,
      cant_items          IN   VARCHAR2,
      cant_items2         IN   VARCHAR2
   )
      RETURN VARCHAR2;
  FUNCTION f_get_fechasprorroga (
      ag_ncodcontrato      IN       NUMBER,
      ag_fec_contrato      OUT      DATE,
      ag_fec_culminacion   OUT      DATE
   )
      RETURN NUMBER;
  PROCEDURE uspversanciondoview (
      ag_n_sancion            IN       NUMBER,
      ag_cod_contrato         OUT      NUMBER,
      ag_n_sancionout         OUT      NUMBER,
      ag_cod_sancion          OUT      NUMBER,
      ag_penalidadcodmoneda   OUT      NUMBER,
      ag_penalidad_monto      OUT      NUMBER,
      ag_penalidad_fecha      OUT      VARCHAR2,
      ag_penalidad_causal     OUT      VARCHAR2
   );

 PROCEDURE usplistsearchitems (
      ag_cod_contrato     NUMBER default null,
      ag_n_convoca        NUMBER default null,
      ag_n_propuesta      NUMBER default null,
      an_codconsucode     NUMBER default null,
      ag_descripcion      VARCHAR2 DEFAULT NULL,
      ag_currenpage       VARCHAR2 := '1',
      ag_currenpageco     VARCHAR2 DEFAULT NULL
      --session__pagesize   VARCHAR2 := '100',
      --portlet__title      VARCHAR2 := '',
   );

  PROCEDURE usplistcontratosdoview (
    ag_n_convoca              VARCHAR2 DEFAULT NULL,
    an_codconsucode           VARCHAR2 DEFAULT NULL,
    ag_anhoentidad            VARCHAR2 DEFAULT NULL,
    session__userid           VARCHAR2 DEFAULT NULL,
    ag_proc_tipo              VARCHAR2 DEFAULT NULL,
    ag_proc_desc              VARCHAR2 DEFAULT NULL,
    ag_proc_sigla             VARCHAR2 DEFAULT NULL,
    ag_currenpage             VARCHAR2 DEFAULT NULL,
    session__eue_codigo       VARCHAR2 DEFAULT NULL,
    session__anhoentidad      VARCHAR2 DEFAULT NULL,
    session__filesingedhttp   VARCHAR2 DEFAULT NULL,
    convoca                   VARCHAR2 DEFAULT '',
    contrato                  VARCHAR2 DEFAULT '',
    control_sesion            NUMBER   DEFAULT 0,
    av_ind_resumen            VARCHAR  DEFAULT NULL,
    session__n_convoca        VARCHAR  DEFAULT NULL,
    session__seacedocument    VARCHAR2  DEFAULT NULL);



  FUNCTION f_CalculaCostosFinal ( ag_n_convoca        VARCHAR2 DEFAULT NULL,
                                ag_cod_contrato     VARCHAR2 DEFAULT NULL,
                                an_monto_adjudicado NUMBER   DEFAULT 0
                                )RETURN NUMBER;
  PROCEDURE uspEliminaCodPresu(ag_n_convoca       VARCHAR2,
                             ag_n_propuesta     VARCHAR2,
                             ag_EliminacodPresu VARCHAR2);

 PROCEDURE usplistsearchitems_v3 (
     ag_cod_contrato     NUMBER default null,
      ag_n_convoca        NUMBER ,
      ag_n_propuesta      NUMBER default null,
      an_codconsucode     NUMBER default null,
      ag_descripcion      VARCHAR2 DEFAULT NULL,
      ag_currenpage       VARCHAR2 := '1',
      ag_currenpageco     varchar2 default null,
      ag_tipo_moneda      NUMBER default null

   );
  PROCEDURE uspSearchCodPresupuestal( anho_entidad              VARCHAR2,
                                    session__eue_codigo       VARCHAR2,
                                    edicion                   VARCHAR2 DEFAULT NULL,
                                    codigo                    VARCHAR2 DEFAULT NULL,
                                    descripcion               VARCHAR2 DEFAULT NULL,
                                    session__n_convoca        VARCHAR2 DEFAULT NULL,
                                    ag_n_propuesta            VARCHAR2 DEFAULT NULL,
                                    ag_monto_codPre           VARCHAR2 DEFAULT NULL,
                                    ag_proc_item              VARCHAR2 DEFAULT NULL,
                                    ag_tipo_operacion         VARCHAR2 DEFAULT NULL,
                                    ag_cod_contrato           VARCHAR2 DEFAULT NULL,
                                    session__userid           VARCHAR2 DEFAULT NULL,
                                    session__AG_COD_CONTRATO  VARCHAR2 DEFAULT NULL,
                                    contrata                  VARCHAR2 DEFAULT NULL  
                                    );
  PROCEDURE uspnewcontratosdoedit (
      session__userid            VARCHAR2 DEFAULT NULL,
      session__N_CONVOCA         VARCHAR2 DEFAULT NULL,
      session__EUE_CODIGO        VARCHAR2 DEFAULT NULL,
      session__anhoentidad       VARCHAR2 DEFAULT NULL,
      session__cod_moneda        VARCHAR2 DEFAULT NULL,
      ag_des_contrato            VARCHAR2 DEFAULT NULL,
      ag_cod_tipo_contrato       VARCHAR2 DEFAULT NULL,
      ag_n_contrato              VARCHAR2 DEFAULT NULL,
      ag_ciu_ccodigo             VARCHAR2 DEFAULT NULL,
      ag_ciu_cespecial           VARCHAR2 DEFAULT NULL,
      ag_ruc_contratista         VARCHAR2 DEFAULT NULL,
      ag_ind_consorcio           VARCHAR2 DEFAULT NULL,
      ag_f_contrato              VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_ini          VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_fin          VARCHAR2 DEFAULT NULL,
      ag_cod_sist_adquisicion    VARCHAR2 DEFAULT NULL,
      ag_cod_modalidad_alcance   VARCHAR2 DEFAULT NULL,
      ag_observaciones           VARCHAR2 DEFAULT NULL,
      ag_n_propuesta             VARCHAR2 DEFAULT NULL,
      ag_currenpage              VARCHAR2 DEFAULT NULL,
      ag_trama_calendario        VARCHAR2 DEFAULT NULL
   );

  PROCEDURE uspprocesar_pub_contrato (
   ag_cod_contrato                  NUMBER,
   session__AG_N_CONVOCA            VARCHAR2 DEFAULT NULL,
   ag_id_operacion                  VARCHAR2
  );

  PROCEDURE uspmancontratosdoedit (
      session__userid            VARCHAR2 DEFAULT NULL,
      session__N_CONVOCA      VARCHAR2 DEFAULT NULL,
      ag_cod_contrato            VARCHAR2 DEFAULT NULL,
      ag_proc_tipo               VARCHAR2 DEFAULT NULL,
      ag_proc_desc               VARCHAR2 DEFAULT NULL,
      ag_proc_sigla              VARCHAR2 DEFAULT NULL,
      ag_iproc_item              VARCHAR2 DEFAULT NULL,
      ag_iop_item                VARCHAR2 DEFAULT NULL,
      ag_unm_codigo              VARCHAR2 DEFAULT NULL,
      ag_calop_item              VARCHAR2 DEFAULT NULL,
      ag_calop_numpago           VARCHAR2 DEFAULT NULL,
      ag_des_contrato            VARCHAR2 DEFAULT NULL,
      ag_cod_tipo_contrato       VARCHAR2 DEFAULT NULL,
      ag_n_contrato              VARCHAR2 DEFAULT NULL,
      ag_f_contrato              VARCHAR2 DEFAULT NULL,
      ag_cod_sist_adquisicion    VARCHAR2 DEFAULT NULL,
      ag_cod_modalidad_alcance   VARCHAR2 DEFAULT NULL,
      ag_observaciones           VARCHAR2 DEFAULT NULL,
      ag_currenpage              VARCHAR2 DEFAULT NULL,
      v_calendario               VARCHAR2 DEFAULT NULL,
      session__FileSingedHTTP    VARCHAR2 DEFAULT NULL,
      session__anhoentidad       VARCHAR2,   
      session__eue_codigo        VARCHAR2,
      ag_trama_calendario        VARCHAR2 
   );

   PROCEDURE uspprocesarupdatecontrato (
      session__cod_contrato           VARCHAR2,
      session__n_convoca              VARCHAR2,
      session__userid                 VARCHAR2,
      ag_des_contrato                 VARCHAR2,
      ag_ciu_ccodigo                  VARCHAR2,
      ag_ciu_cespecial                VARCHAR2,
      ag_ruc_contratista              VARCHAR2,
      ag_f_contrato                   VARCHAR2,
      ag_codmoneda_contrato           VARCHAR2,
      ag_m_contratado                 VARCHAR2,
      ag_cod_sist_adquisicion         VARCHAR2,
      ag_cod_modalidad_finan          VARCHAR2,
      ag_cod_modalidad_alcance        VARCHAR2,
      ag_mon_codigo                   VARCHAR2,
      ag_costo_final                  VARCHAR2,
      ag_observaciones                VARCHAR2,
      ag_f_vigencia_ini               VARCHAR2,
      ag_f_vigencia_fin               VARCHAR2,
      ag_n_propuesta                  VARCHAR2,
      ag_nom_contratista              VARCHAR2,
      ag_ind_consorcio                VARCHAR2,
      ag_cod_tipo_contrato            VARCHAR2,
      ag_ruc_destino_pago             VARCHAR2,
      ag_nom_destino_pago             VARCHAR2,
      ag_tipo_postor                  VARCHAR2,
      ag_cod_pais_destino_pago        VARCHAR2,
      ag_proc_tipo                    VARCHAR2,
      an_codconsucode                 VARCHAR2,
      ag_calop_item                   VARCHAR2,
      ag_iop_item                     VARCHAR2,
      ag_n_contrato                   VARCHAR2,
      ag_iproc_item                   VARCHAR2 DEFAULT NULL,
      ag_calop_numpago                VARCHAR2 DEFAULT NULL,
      ag_proc_desc               IN   VARCHAR2 DEFAULT NULL,
      ag_proc_sigla                   VARCHAR2 DEFAULT NULL,
      ag_currenpage              IN   VARCHAR2 DEFAULT NULL,
      v_calendario                    VARCHAR2 DEFAULT NULL,     
      pfiletoupload                   VARCHAR2 DEFAULT NULL,
      pfiletoupload__size             VARCHAR2 DEFAULT NULL,
      pfiletoupload__mimetype         VARCHAR2 DEFAULT NULL,
      WriteFileDirectoryDynamic       VARCHAR2 ,
      iisenv__remote_host             VARCHAR2 ,      
      ag_fec_aprob                    VARCHAR2 DEFAULT NULL,
      doc_obs                         VARCHAR2 DEFAULT NULL,
      session__anhoentidad            VARCHAR2 ,            
      session__eue_codigo             VARCHAR2 ,
      ag_trama_items                  VARCHAR2 ,
      ag_trama_items_xml              VARCHAR2 ,
      ag_id_operacion                 VARCHAR2 ,
      ag_trama_calendario             varchar2 ,
      ag_trama_items_codpresup        VARCHAR2 
   );

 PROCEDURE uspprocesarinsertcontrato (
    session__AG_N_CONVOCA           VARCHAR2 DEFAULT NULL,
    session__USERID                 VARCHAR2 DEFAULT NULL,
    ag_des_contrato                 VARCHAR2,
    ag_ciu_ccodigo                  VARCHAR2,
    ag_ciu_cespecial                VARCHAR2,
    ag_ruc_contratista              VARCHAR2,
    ag_f_contrato                   VARCHAR2,
    ag_codmoneda_contrato           VARCHAR2,
    ag_m_contratado                 VARCHAR2,
    ag_cod_sist_adquisicion         VARCHAR2,
    ag_cod_modalidad_finan          VARCHAR2,
    ag_cod_modalidad_alcance        VARCHAR2,
    ag_costo_final                  VARCHAR2,
    ag_observaciones                VARCHAR2,
    ag_n_contrato                   VARCHAR2,
    ag_f_vigencia_ini               VARCHAR2,
    ag_f_vigencia_fin               VARCHAR2,
    ag_n_propuesta                  VARCHAR2,
    ag_nom_contratista              VARCHAR2,
    ag_ind_consorcio                VARCHAR2,
    ag_cod_tipo_contrato            VARCHAR2,
    ag_ruc_destino_pago             VARCHAR2,
    ag_tipo_postor                  VARCHAR2,
    an_codconsucode                 VARCHAR2,
    ag_anhoentidad                  VARCHAR2,
    WriteFileDirectoryDynamic       VARCHAR2,
    session__IIS_REMOTE_ADDR        VARCHAR2 ,
    session__maxMBUploadFileSize    VARCHAR2 ,
    ag_iproc_item                   VARCHAR2 DEFAULT NULL,
    doc_name                        VARCHAR2 DEFAULT NULL,
    ag_calop_numpago                VARCHAR2 DEFAULT NULL,
    ag_anho_enti_pagadora           VARCHAR2 DEFAULT NULL,
    ag_cod_enti_pagadora            VARCHAR2 DEFAULT NULL,
    agdesciiu                       VARCHAR2 DEFAULT NULL,
    doc_obs                         VARCHAR2 DEFAULT NULL,
    ag_proc_desc               IN   VARCHAR2 DEFAULT NULL,
    ag_proc_sigla              IN   VARCHAR2 DEFAULT NULL,
    ag_currenpage              IN   VARCHAR2 DEFAULT NULL,
    v_calendario                    VARCHAR2,
    ag_fec_aprob                    VARCHAR2,
    ag_trama_items                  VARCHAR2,
    ag_trama_items_xml              VARCHAR2,
    iisenv__remote_host             VARCHAR2,
    pfiletoupload                   VARCHAR2,
    pfiletoupload__size             VARCHAR2,
    ag_trama_calendario             varchar2,
    ag_trama_items_codpresup        varchar2
 );

  PROCEDURE uspverconvocatoriadoview (
      ag_n_convoca            IN       VARCHAR2,
      ag_codconsucode         OUT      VARCHAR2,
      ag_n_convocaout         OUT      NUMBER,
      ag_codmoneda            OUT      NUMBER,
      ag_anhoentidad          OUT      VARCHAR2,
      ag_proc_tipo            OUT      NUMBER,
      ag_proc_num             OUT      NUMBER,
      ag_proc_sigla           OUT      VARCHAR2,
      ag_proc_tipo_sigla      OUT      VARCHAR2,
      ag_cod_tipo_modalidad   OUT      NUMBER,
      ag_resultado            OUT      NUMBER,
      ag_objeto               OUT      NUMBER
   );
  PROCEDURE uspvercontratodoview (
      ag_cod_contrato            IN       varchar2,
      ag_cod_contrato_res        OUT      reg_procesos.contrato.n_cod_contrato%TYPE,
      ag_n_convoca               OUT      reg_procesos.contrato.n_convoca%TYPE,
      ag_item                    OUT      reg_procesos.contrato.n_item%TYPE,
      ag_des_contrato            OUT      reg_procesos.contrato.des_contrato%TYPE,
      ag_ciu_ccodigo             OUT      reg_procesos.contrato.ciu_ccodigo%TYPE,
      ag_ciu_cespecial           OUT      reg_procesos.contrato.ciu_cespecial%TYPE,
      ag_ruc_contratista         OUT      reg_procesos.contrato.ruc_contratista%TYPE,
      ag_ruc_destino_pago        OUT      reg_procesos.contrato.ruc_destino_pago%TYPE,
      ag_nom_destino_pago        OUT      reg_procesos.contrato.nom_destino_pago%TYPE,
      ag_f_contrato              OUT      VARCHAR2,
      ag_codmoneda_contrato      OUT      reg_procesos.contrato.codmoneda_contrato%TYPE,
      ag_m_contratado            OUT      VARCHAR2,
      ag_m_contrato              OUT      VARCHAR2,
      ag_cod_situacion           OUT      reg_procesos.contrato.cod_situacion%TYPE,
      ag_cod_causa_resoucion     OUT      reg_procesos.contrato.cod_causa_resoucion%TYPE,
      ag_f_liquidacion           OUT      VARCHAR2,
      ag_f_intervencion          OUT      VARCHAR2,
      ag_cod_sist_adquisicion    OUT      reg_procesos.contrato.cod_sist_adquisicion%TYPE,
      ag_cod_modalidad_finan     OUT      reg_procesos.contrato.cod_modalidad_finan%TYPE,
      ag_cod_modalidad_alcance   OUT      reg_procesos.contrato.cod_modalidad_alcance%TYPE,
      ag_plazo_real              OUT      reg_procesos.contrato.plazo_real%TYPE,
      ag_mon_codigo              OUT      reg_procesos.contrato.mon_codigo%TYPE,
      ag_mon_desc                OUT      VARCHAR2,
      ag_costo_final             OUT      VARCHAR2,
      ag_cod_sancion             OUT      reg_procesos.contrato.cod_sancion%TYPE,
      ag_penalidad               OUT      VARCHAR2,
      ag_cod_ejec_garantias      OUT      reg_procesos.contrato.cod_ejec_garantias%TYPE,
      ag_observaciones           OUT      reg_procesos.contrato.observaciones%TYPE,
      ag_n_contrato              OUT      reg_procesos.contrato.n_contrato%TYPE,
      ag_codconsucode            OUT      reg_procesos.contrato.codconsucode%TYPE,
      ag_f_vigencia_ini          OUT      VARCHAR2,
      ag_f_vigencia_fin          OUT      VARCHAR2,
      ag_convoca_pad             OUT      VARCHAR2,
      ag_cod_contrato_pad        OUT      VARCHAR2,
      ag_nom_contratista         OUT      reg_procesos.contrato.nom_contratista%TYPE,
      ag_ind_consorcio           OUT      reg_procesos.contrato.ind_consorcio%TYPE,
      ag_n_propuesta             OUT      reg_procesos.contrato.n_propuesta%TYPE,
      ag_cod_tipo_contrato       OUT      reg_procesos.contrato.cod_tipo_contrato%TYPE,
      ag_cod_tipo_postor         OUT      reg_procesos.contrato.cod_tipo_postor%TYPE,
      ag_cod_pais_destino_pago   OUT      reg_procesos.contrato.cod_pais_destino_pago%TYPE,
      ag_des_pais                OUT      reg_procesos.t_pais.des_pais%TYPE,
      ag_cod_tipo_modalidad      OUT      reg_procesos.convocatorias.cod_tipo_modalidad%TYPE,
      ag_id_opereacion           OUT      reg_procesos.contrato.id_operacion%TYPE,
      ag_codentidadpaga          OUT      reg_procesos.contrato.codconsucode_paga%TYPE,
      ag_anhoentidadpaga         OUT      reg_procesos.contrato.anhoentidad_paga%TYPE,
      ag_error                   OUT      NUMBER
   );

  /*PROCEDURE uspsancallactualizar (
    ag_cod_contrato             NUMBER default null,
    ag_tiposancion              NUMBER default null,
    ag_penalidad_fecha          VARCHAR2 default null,
    ag_penalidad_moneda         NUMBER default null,
    ag_penalidad_monto          NUMBER default null,
    ag_penalidad_causal         VARCHAR2 default null,
    ag_n_sancion                NUMBER default null,
    ag_sangar_monto             VARCHAR2 default null,
    ag_sangar_nums              VARCHAR2 default null,
    ag_n_convoca                NUMBER default null,
    session__AG_N_CONVOCA       VARCHAR2 default null,
    session__AG_COD_CONTRATO    VARCHAR2 default null);*/




PROCEDURE uspBuscarCodPresupuestal(
          anho_entidad                varchar2, 
          ag_n_convoca                varchar2, 
          ag_proc_item                varchar2, 
          ag_tipo_operacion           varchar2,
          ag_codconsucode             VARCHAR2 );

PROCEDURE usp_registra_codpresup(
          ag_trama_items_codpresup varchar2, 
          ag_ncodcontrato          number, 
          ag_nconvoca              number,
          ag_anhoentidad           number);

FUNCTION f_retorna_combo(
  pc_cursor       ref_cursor, 
  ag_name         varchar2, 
  ag_codigo       varchar2, 
  ag_libre        varchar2 default null,
  ag_atributos    varchar2 default null) RETURN varchar2;

  procedure usp_documento(
    session__filesingedhttp   VARCHAR2 DEFAULT NULL,
    vi_n_convoca number );

END;

/


CREATE OR REPLACE PACKAGE BODY PKU_GESTOR_CONT_MAKE_CONTRATOS
IS
/*******************************************************************************
/ Procedimiento : uspCalculaCostosFinal
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Indice      Nombre            Fecha y hora      Codigo de atencion         Modificacion
/ -----  -------------------- ----------------  ---------------------   ---------------------
/  000       Jorge Casta¿eda                                                   Version Inicial
/  001       ddrodriguez            19/07/2016        Memorando 85-2016        Validacion para compras corporativas, monto y cantidad asignada a cada entidad participante
/******************************************************************************/

FUNCTION f_CalculaCostosFinal ( ag_n_convoca        VARCHAR2 DEFAULT NULL,
                                ag_cod_contrato     VARCHAR2 DEFAULT NULL,
                                an_monto_adjudicado NUMBER   DEFAULT 0
                                )RETURN NUMBER
IS
    ln_monto_reajuste         NUMBER;
    ln_total_reajuste         NUMBER;
    ln_monto_sancion          NUMBER;
    ln_monto_adicional        NUMBER;
    ln_monto_complementario   NUMBER;
    ln_monto_prorroga         NUMBER;
    ln_monto_final            NUMBER;
    lnv_cod_contrato          VARCHAR2(50);
    lnv_n_convoca             VARCHAR2(50);
    ln_monto_adjudicado       NUMBER;

    CURSOR csanciones(lv_cod_contrato varchar2) IS
    SELECT a.penalidad_monto, b.des_sancion
    FROM reg_procesos.sancion a INNER JOIN reg_procesos.tipo_sancion b ON a.cod_sancion = b.cod_sancion
    WHERE a.n_cod_contrato = lv_cod_contrato;

    CURSOR cadicionales(lv_cod_contrato varchar2) IS
    SELECT monto_adicional
    FROM reg_procesos.adicional_reduccion
    WHERE n_cod_contrato = lv_cod_contrato;

    CURSOR ccomplementarios(lv_cod_contrato varchar2) IS
    SELECT m_contratado
    FROM reg_procesos.contrato
    WHERE n_cod_contrato_de_renovac = lv_cod_contrato
    AND cod_operacion_contrato = 6;

    CURSOR cprorrogas(lv_cod_contrato varchar2) IS
    SELECT m_contratado
    FROM reg_procesos.contrato
    WHERE n_cod_contrato_de_renovac = lv_cod_contrato
    AND cod_operacion_contrato = 2;

BEGIN

   lnv_cod_contrato        := ag_cod_contrato;
   lnv_n_convoca           := ag_n_convoca;
   ln_monto_final          := 0;
   ln_monto_adicional      := 0;
   ln_monto_sancion        := 0;
   ln_monto_complementario := 0;
   ln_monto_prorroga       := 0;
   ln_monto_adjudicado     := an_monto_adjudicado;

   FOR xrow IN cadicionales(lnv_cod_contrato) LOOP
     ln_monto_adicional := ln_monto_adicional + xrow.monto_adicional;
   END LOOP;

   FOR xrow IN csanciones(lnv_cod_contrato) LOOP
     ln_monto_sancion := ln_monto_sancion + xrow.penalidad_monto;
   END LOOP;

   FOR xrow IN ccomplementarios(lnv_cod_contrato) LOOP
     ln_monto_complementario := ln_monto_complementario + xrow.m_contratado;
   END LOOP;

   FOR xrow IN cprorrogas(lnv_cod_contrato) LOOP
     ln_monto_prorroga := ln_monto_prorroga + xrow.m_contratado;
   END LOOP;

   ln_monto_final := ln_monto_adicional + ln_monto_sancion + ln_monto_complementario + ln_monto_prorroga + ln_monto_adjudicado;

   RETURN ln_monto_final;

END;

/*******************************************************************************/
FUNCTION f_retorna_combo(
  pc_cursor       ref_cursor,
  ag_name         varchar2,
  ag_codigo       varchar2,
  ag_libre        varchar2 default null,
  ag_atributos    varchar2 default null) RETURN varchar2

IS
    lv_combo               varchar2(20000);
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

    return lv_combo;

END;

 PROCEDURE usplistsearchitems_v3 (
      ag_cod_contrato     NUMBER default null,
      ag_n_convoca        NUMBER ,
      ag_n_propuesta      NUMBER default null,
      an_codconsucode     NUMBER default null,
      ag_descripcion      VARCHAR2 DEFAULT NULL,
      ag_currenpage       VARCHAR2 := '1',
      ag_currenpageco     varchar2 default null,
      ag_tipo_moneda      NUMBER default null

   )
   IS
      -- Items del Contrato para una propuesta para un  item
      ln_contrato_prop      VARCHAR2 (120);
      ln_propuesta_prop     NUMBER;
      ln_procitem_prop      NUMBER;
      ln_nconvoca_prop      NUMBER;
      ln_mcontratado        FLOAT;
      ln_monto              FLOAT;
      -- Cursor
      citemscontratoprop    ref_cursor;
      -- datos presentacion de las filas
      lv_clase              VARCHAR2 (80);
      -- datos para los cursores
      ln_cod_contrato       NUMBER;
      ln_n_convoca          NUMBER;
      ln_n_propuesta        NUMBER;
      ln_codconsucode       NUMBER;
      lv_descripcion        varchar2 (500);
      ln_tipo_moneda        NUMBER;
      ln_max_nconvoca       NUMBER;
      -- Paginacion Items adjudicados
      lv_currentpage        NUMBER;
      lv_pagesize           NUMBER;
      lv_totalregistros     NUMBER;
      -- Paginacion Items adjudicados con Contrato
      lv_currentpageco      NUMBER;
      lv_totalregistrosco   NUMBER;
      -- Datos del proveedor
      lv_postorruc          reg_procesos.convocatoria_propuesta.ruc_postor%TYPE;
      lv_postornom          reg_procesos.convocatoria_propuesta.nom_postor%TYPE;
      lv_resultado1         NUMBER;

      -- Cursor Items Adjudicados - con  contratos
      CURSOR citemsadjudicadosco (
         p_n_convoca          NUMBER,
         p_n_propuesta        NUMBER,
         p_max_n_convoca      NUMBER,
         p_descripcion        VARCHAR2,
         p_currentpage        NUMBER,
         p_session_pagesize   NUMBER
      )
      IS
         SELECT DISTINCT itc.n_convoca, itc.unm_codigo, m.unm_desc,
                         itc.proc_item,
                         REPLACE (REPLACE (itc.descripcion, CHR (13),CHR(32)), CHR(10),CHR (32)  ) descripcion,
                         i.cant_adjudicada cantidad,
                         i.monto_adjudicado monto, itc.dep_codigo,
                         itc.pro_codigo, itc.dis_codigo, dep.dep_desc,
                         pro.pro_desc, dis.dis_desc,
                         to_char(ice.f_registro,'dd/mm/yyyy') f_bp_cons,
                         i.n_propuesta,tsc.sc_descripcion,tmc.desmodcnt, itc.cod_sist_adquisicion, itc.cod_modalidad_alcance,
                         case itc.cod_tipo_detalle_bien 
                              when 1 then 'Item' 
                              when 5 then 'Item paquete'
                              else '-'
                         end  item_paquete

                    FROM reg_procesos.item_convoca itc
                        left join t_tipo_sist_cont  tsc on itc.cod_sist_adquisicion = tsc.sc_codigo
                        left join t_tipo_modcont tmc on itc.cod_modalidad_alcance = tmc.codmodcnt,
                         reg_procesos.items_bp i,
                         reg_procesos.buena_pro bp,
                         reg_procesos.convocatorias c,
                         sease.unidad_medida m,
                         sease.dep_ubigeo dep,
                         sease.prov_ubigeo pro,
                         sease.dist_ubigeo dis,
                         (
                             select icei.* from  reg_procesos.item_convoca_estado icei
                             where  icei.n_convoca_src = reg_procesos.f_get_min_n_convoca(p_n_convoca )
                             and icei.cod_tipo_Estado_item = 500
                             and icei.f_registro = (
                                           select max(f_registro)
                                           from reg_procesos.item_convoca_estado ice2
                                           where ice2.n_convoca_src  = icei.n_convoca_src
                                           and ice2.proc_item = icei.proc_item
                                         )
                           ) ice

                   where itc.n_convoca = p_max_n_convoca
                     AND (   UPPER (itc.descripcion) LIKE UPPER ('%' || p_descripcion || '%')
                          OR UPPER (itc.proc_item) LIKE UPPER ('%' || p_descripcion || '%')
                          OR p_descripcion IS NULL)
                     AND itc.dep_codigo = dis.dep_codigo
                     AND itc.pro_codigo = dis.pro_codigo
                     AND itc.dis_codigo = dis.dis_codigo
                     AND dis.dep_codigo = pro.dep_codigo
                     AND dis.pro_codigo = pro.pro_codigo
                     AND pro.dep_codigo = dep.dep_codigo
                     AND itc.unm_codigo = m.unm_codigo
                     AND c.n_convoca = itc.n_convoca
                     AND bp.n_convoca = p_n_convoca
                     AND bp.n_buenapro = i.n_buenapro
                     AND itc.proc_item = i.proc_item
                     AND i.n_propuesta = p_n_propuesta
                     AND i.monto_adjudicado > 0
                     AND bp.ind_ultimo = 1
                     AND ice.proc_item = i.proc_item
                ORDER BY itc.proc_item;

      -- Cursor Items adjudicados
      CURSOR citemsadjudicados (
         p_cod_contrato       NUMBER,
         p_n_convoca          NUMBER,
         p_n_propuesta        NUMBER,
         p_codconsucode       NUMBER,
         p_max_n_convoca      NUMBER,
         p_descripcion        VARCHAR2,
         p_currentpage        NUMBER,
         p_session_pagesize   NUMBER,
         p_tipo_moneda        NUMBER
      )
      IS
         SELECT *
           FROM (SELECT ROWNUM num, a.*
                   FROM (SELECT DISTINCT itc.n_convoca, itc.unm_codigo,
                               m.unm_desc, itc.proc_item,
                               REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(descripcion) descripcion,
                               nvl(pku_gestor_cont_utiles_2.f_get_monto_cc(2, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, p_codconsucode), i.cant_adjudicada) cantidad,--i.cant_adjudicada cantidad, 001 ddrodriguez
                               nvl(pku_gestor_cont_utiles_2.f_get_monto_cc(1, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, p_codconsucode),i.monto_adjudicado) monto,--i.monto_adjudicado monto, 001 ddrodriguez
                               suma.suma_cant,
                               suma.suma_monto,
                               CASE suma.suma_monto
                                  WHEN suma.suma_monto
                                     THEN CASE
                                  -- WHEN (bp.f_registro >= TO_DATE(bp.f_bp,reg_procesos.pku_ss_constantes.gv_formato_fecha ))
                                  when (bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha ))
                                     --then  i.monto_adjudicado - suma.suma_monto 001 ddrodriguez (inactivar)
                                     then nvl(pku_gestor_cont_utiles_2.f_get_monto_cc(1, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, p_codconsucode),i.monto_adjudicado) - suma.suma_monto -- 001 ddrodriguez
                                  else nvl(pku_gestor_cont_utiles_2.f_get_monto_cc(1, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, p_codconsucode),i.monto_adjudicado) --i.monto_adjudicado 001 ddrodriguez                                 
                               end
                                  ELSE nvl(PKU_GESTOR_CONT_UTILES_2.f_get_monto_cc(1, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, p_codconsucode),i.monto_adjudicado) --i.monto_adjudicado 001 ddrodriguez
                               END monto_max,
                               CASE suma.suma_cant
                                  WHEN suma.suma_cant
                                     THEN CASE
                                 when (bp.f_registro >= to_date('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha ) )
                                     --then i.cant_adjudicada - suma.suma_cant 001 ddrodriguez (inactivar)
                                     then nvl(pku_gestor_cont_utiles_2.f_get_monto_cc(2, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, p_codconsucode), i.cant_adjudicada) - suma.suma_cant -- 001 ddrodriguez
                                  ELSE nvl(pku_gestor_cont_utiles_2.f_get_monto_cc(2, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, p_codconsucode), i.cant_adjudicada) --i.cant_adjudicada 001 ddrodriguez
                               end
                                  ELSE nvl(pku_gestor_cont_utiles_2.f_get_monto_cc(2, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, p_codconsucode), i.cant_adjudicada)--i.cant_adjudicada 001 ddrodriguez
                               END cant_max,
                               itc.dep_codigo, itc.pro_codigo,
                               itc.dis_codigo, dep.dep_desc,
                               pro.pro_desc, dis.dis_desc,
                               to_char(ice.f_registro,'dd/mm/yyyy') f_bp_cons,
                               NVL(c.cod_tipo_modalidad, 0) cod_tipo_modalidad,
                               tsc.sc_descripcion,tmc.desmodcnt, itc.cod_sist_adquisicion, itc.cod_modalidad_alcance,
                               case itc.cod_tipo_detalle_bien 
                                    when 1 then 'Item' 
                                    when 5 then 'Item paquete'
                                    else '-'
                               end  item_paquete,
                               itc.cod_tipo_detalle_bien tipoitem, -- Tipo de item(1) o paquete item(5)
                               c.codobjeto -- Para verificar el Objeto(3:obras)
                          FROM reg_procesos.item_convoca itc
                              left join t_tipo_sist_cont  tsc on itc.cod_sist_adquisicion = tsc.sc_codigo
                              left join t_tipo_modcont tmc on itc.cod_modalidad_alcance = tmc.codmodcnt,
                               reg_procesos.buena_pro bp,
                               reg_procesos.convocatorias c,
                               sease.unidad_medida m,
                               sease.dep_ubigeo dep,
                               sease.prov_ubigeo pro,
                               sease.dist_ubigeo dis,

                               (
                                 select icei.* from  reg_procesos.item_convoca_estado icei
                                 where  icei.n_convoca_src = reg_procesos.f_get_min_n_convoca(p_n_convoca )
                                 and icei.cod_tipo_Estado_item = 500
                                 and icei.f_registro = (
                                               select max(f_registro)
                                               from reg_procesos.item_convoca_estado ice2
                                               where ice2.n_convoca_src  = icei.n_convoca_src
                                               and ice2.proc_item = icei.proc_item
                                             )
                               ) ice,
                               reg_procesos.items_bp i

                               LEFT OUTER JOIN (
                                          SELECT   c.n_propuesta, ict.proc_item,
                                                   ict.n_convoca,
                                                   SUM(ict.cantidad )
                                                   suma_cant,
                                                   SUM(ict.monto)
                                                   suma_monto
                                                   FROM reg_procesos.item_contrato ict
                                                   INNER JOIN reg_procesos.item_convoca icv
                                                   ON ict.n_convoca = icv.n_convoca AND ict.proc_item = icv.proc_item
                                                   INNER JOIN reg_procesos.contrato c
                                                   ON c.n_cod_contrato =ict.n_cod_contrato
                                                   WHERE ict.n_convoca = p_max_n_convoca
                                                   AND c.n_convoca = p_n_convoca
                                                   --AND c.codconsucode != LPAD(p_codconsucode,6,'0') 001 ddrodriguez Reque 85-2016 (inactivar)
                                                   AND c.codconsucode = LPAD(p_codconsucode,6,'0') --001 ddrodriguez Reque 85-2016
                                                   AND c.n_propuesta = p_n_propuesta
                                                   AND (c.n_cod_contrato != nvl(p_cod_contrato,0))-- Si es contrato Borrador
                                                   GROUP BY c.n_propuesta, ict.proc_item, ict.n_convoca)
                                                   suma ON suma.proc_item = i.proc_item
                                                   AND suma.n_propuesta = i.n_propuesta
                         where itc.n_convoca = p_max_n_convoca
                           AND itc.codmoneda = nvl(p_tipo_moneda,itc.codmoneda)   -- agregado para version 3
                           AND (   UPPER (itc.descripcion) LIKE UPPER ('%'|| p_descripcion || '%' )
                            OR UPPER (itc.proc_item) LIKE  UPPER (   '%' || p_descripcion || '%' )
                            OR p_descripcion IS NULL )
                           AND itc.dep_codigo = dis.dep_codigo
                           AND itc.pro_codigo = dis.pro_codigo
                           AND itc.dis_codigo = dis.dis_codigo
                           AND dis.dep_codigo = pro.dep_codigo
                           AND dis.pro_codigo = pro.pro_codigo
                           AND pro.dep_codigo = dep.dep_codigo
                           AND itc.unm_codigo = m.unm_codigo
                           AND c.n_convoca = itc.n_convoca
                           AND bp.n_convoca = p_n_convoca
                           AND bp.n_buenapro = i.n_buenapro
                           AND itc.proc_item = i.proc_item
                           AND i.n_propuesta = p_n_propuesta
                           AND i.monto_adjudicado > 0
                           AND bp.ind_ultimo = 1
                           AND ice.proc_item = i.proc_item
                           AND i.proc_item IN (
                                  SELECT ic.proc_item
                                    FROM reg_procesos.contrato c
                                    JOIN reg_procesos.item_contrato ic ON c.n_cod_contrato = ic.n_cod_contrato
                                     AND c.n_cod_contrato = p_cod_contrato
                                     AND c.n_propuesta =p_n_propuesta
                                  UNION
                                  SELECT i.proc_item
                                    FROM reg_procesos.item_convoca itc,
                                         reg_procesos.convocatorias c,
                                         reg_procesos.buena_pro bp,
                                         reg_procesos.items_bp i,
                                         reg_procesos.convocatoria_doc cd,
                                         reg_procesos.item_convoca_estado ice
                                   WHERE itc.n_convoca = p_max_n_convoca
                                     AND c.n_convoca = itc.n_convoca
                                     AND bp.n_convoca = p_n_convoca
                                     AND bp.n_buenapro = i.n_buenapro
                                     AND itc.proc_item = i.proc_item
                                     AND i.n_propuesta = p_n_propuesta
                                     AND i.monto_adjudicado > 0
                                     AND bp.ind_ultimo = 1
                                     AND cd.cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                                     AND cd.n_convoca = bp.n_convoca
                                     AND ice.cod_doc = cd.cod_doc
                                     AND ice.proc_item = i.proc_item
                                     AND NOT EXISTS (
                                            SELECT iccc.proc_item
                                              FROM reg_procesos.contrato c,
                                                   reg_procesos.item_contrato iccc
                                             WHERE c.n_convoca =         p_n_convoca
                                               AND c.n_cod_contrato =    iccc.n_cod_contrato
                                               AND iccc.n_convoca =      p_max_n_convoca
                                               AND iccc.proc_item =      itc.proc_item
                                               AND c.n_propuesta =       p_n_propuesta
                                               AND c.codconsucode = lpad(p_codconsucode,6,'0' )
                                               /*permite validar que se muestre los item paquetes de obras mientras no complete sus contratos para todos los items*/
                                               and iccc.proc_item not in (
                                               select distinct(icd.proc_item) from reg_procesos.item_convoca_detalle icd
                                               where icd.n_convoca in (select n_convoca from reg_procesos.convocatorias where n_convoca = p_max_n_convoca and codobjeto =3) and icd.proc_item=itc.proc_item
                                               and (select sum(icd.cantidad) from reg_procesos.item_convoca_detalle icd where icd.n_convoca = p_max_n_convoca and icd.proc_item = itc.proc_item) != 
                                                   (select sum(ic.cantidad) from reg_procesos.item_contrato ic where ic.n_convoca = p_max_n_convoca and ic.proc_item = itc.proc_item)))
                                                    and PKU_GESTOR_CONT_UTILES_2.f_get_monto_cc(0, i.n_propuesta ,itc.n_id_pub_con, itc.n_id_item, p_codconsucode) = 1 --001 ddrodriguez
                                    )
                                ORDER BY itc.proc_item) a) b
          WHERE b.num >= p_session_pagesize * (p_currentpage - 1) + 1
            AND b.num <= p_session_pagesize * (p_currentpage);
   BEGIN

      -- Filtro de los cursores
      ln_cod_contrato  := ag_cod_contrato;
      ln_n_convoca     := ag_n_convoca;
      ln_n_propuesta   := ag_n_propuesta;
      ln_codconsucode  := an_codconsucode;
      lv_descripcion   := ag_descripcion;
      ln_tipo_moneda   := ag_tipo_moneda;
      ln_max_nconvoca  := reg_procesos.f_get_max_n_convoca (ag_n_convoca);

      -- Paginacion
      lv_pagesize := 100;
      -- Paginacion Items adjudicados
      lv_currentpage := NVL (TO_NUMBER (ag_currenpage), 1);
      -- Paginacion Items adjudicados con Contrato
      lv_currentpageco := NVL (TO_NUMBER (ag_currenpageco), 1);
      -- datos del proveedor
      lv_resultado1 := f_get_datospostorbp (ln_n_convoca,
                                            ln_n_propuesta,
                                            lv_postorruc,
                                            lv_postornom);

      sp_javascript_contratos_busca;

      usp_print('

     <script language=javascript>
      function BuscarDatos()
      {
          thisform.scriptdo.value = "'||gv_pkname||'.uspListSearchItems_v3";
          thisform.submit();
      }
     </script>');
      -- Hiddens
      usp_print('<input type="hidden" name="ag_cod_contrato"  value="'|| ln_cod_contrato || '"></input>');
      usp_print('<input type="hidden" name="ag_n_propuesta"   value="'|| ln_n_propuesta || '"></input>');
      usp_print('<input type="hidden" name="ag_n_convoca"     value="'|| ln_n_convoca || '"></input>');
      usp_print('<input type="hidden" name="an_codconsucode"  value="'|| ln_codconsucode|| '"></input>');
      usp_print('<input type="hidden" name="ag_tipo_moneda"   value="'|| ln_tipo_moneda|| '"></input>');
      usp_print('<input type="hidden" name="ag_currenpage"    value="'|| lv_currentpage|| '"></input>');
      usp_print('<input type="hidden" name="ag_currenpageCO"  value="'|| lv_currentpageco|| '"></input>');
      usp_print('<table width="100%" valign="top">');
      usp_print('<tr><td width="100%">');
      usp_print('<table border=0 width=100% cellpadding="2" cellspacing="2">');
        usp_print('<tr><td width="20%" align=left>Buscar Item:</td>
                 <td width="60%" align="left"> <input name="ag_descripcion" size="4" style="height:20"></td>
                 <td width="20%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Buscar" onclick="javascript:BuscarDatos();" style="height:20">
                 </td></tr>
                 </table></td></tr>');

      -- Numero de registros
      SELECT COUNT (1)
        INTO lv_totalregistros
        FROM (SELECT DISTINCT itc.n_convoca, itc.unm_codigo, m.unm_desc,
                              itc.proc_item,
                              REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,
                              i.cant_adjudicada cantidad,
                              i.monto_adjudicado monto, suma.suma_cant,
                              suma.suma_monto,
                              CASE suma.suma_monto
                                 WHEN suma.suma_monto
                                    THEN CASE
                                          WHEN (bp.f_registro >= TO_DATE('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha ))
                                          THEN i.monto_adjudicado - suma.suma_monto
                                    ELSE i.monto_adjudicado
                                    END
                                 ELSE i.monto_adjudicado
                              END monto_max,
                              CASE suma.suma_cant
                                 WHEN suma.suma_cant
                                    THEN CASE
                                 WHEN (bp.f_registro >=TO_DATE('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha))
                                    THEN i.cant_adjudicada - suma.suma_cant
                                 ELSE i.cant_adjudicada
                              END
                                 ELSE i.cant_adjudicada
                              END cant_max,
                              itc.dep_codigo, itc.pro_codigo, itc.dis_codigo,
                              dep.dep_desc, pro.pro_desc, dis.dis_desc,
                              TO_CHAR(cd.fec_upload,reg_procesos.pku_ss_constantes.gv_formato_fecha ) f_bp_cons,
                              NVL (c.cod_tipo_modalidad, 0) cod_tipo_modalidad
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
                              LEFT OUTER JOIN (
                                             SELECT c.n_propuesta,
                                                    ict.proc_item,
                                                    ict.n_convoca,
                                                    SUM(ict.cantidad) suma_cant,
                                                    SUM(ict.monto) suma_monto
                                               FROM reg_procesos.item_contrato ict
                                               INNER JOIN reg_procesos.item_convoca icv ON ict.n_convoca =  icv.n_convoca
                                               AND ict.proc_item = icv.proc_item
                                               INNER JOIN reg_procesos.contrato c ON c.n_cod_contrato = ict.n_cod_contrato
                                              WHERE ict.n_convoca = ln_max_nconvoca
                                                AND c.n_convoca = ln_n_convoca
                                                --AND c.codconsucode != LPAD(ln_codconsucode, 6,'0') 001 ddrodriguez Reque 85-2016 (Inactivar)
                                                AND c.codconsucode = LPAD(ln_codconsucode, 6,'0') --001 ddrodriguez Reque 85-2016
                                                AND c.n_propuesta = ln_n_propuesta
                                           GROUP BY c.n_propuesta, ict.proc_item,
                                                    ict.n_convoca
                                                  ) suma
                                                    ON suma.proc_item = i.proc_item
                                                    AND suma.n_propuesta = i.n_propuesta
                        where itc.n_convoca = ln_max_nconvoca
                          AND itc.codmoneda = nvl(ln_tipo_moneda,itc.codmoneda)   -- agregado para version 3
                          AND (   UPPER (itc.descripcion) LIKE '%' || UPPER (lv_descripcion) || '%'
                               OR UPPER (itc.proc_item) LIKE  '%' || UPPER (lv_descripcion) || '%'
                               OR lv_descripcion IS NULL)
                          AND itc.dep_codigo = dis.dep_codigo
                          AND itc.pro_codigo = dis.pro_codigo
                          AND itc.dis_codigo = dis.dis_codigo
                          AND dis.dep_codigo = pro.dep_codigo
                          AND dis.pro_codigo = pro.pro_codigo
                          AND pro.dep_codigo = dep.dep_codigo
                          AND itc.unm_codigo = m.unm_codigo
                          AND c.n_convoca = itc.n_convoca
                          AND bp.n_convoca = ln_n_convoca
                          AND bp.n_buenapro = i.n_buenapro
                          AND itc.proc_item = i.proc_item
                          AND i.n_propuesta = ln_n_propuesta
                          AND i.monto_adjudicado > 0
                          AND bp.ind_ultimo = 1
                          AND cd.cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                          AND cd.n_convoca = bp.n_convoca
                          AND ice.cod_doc = cd.cod_doc
                          AND ice.proc_item = i.proc_item
                          AND i.proc_item IN (
                                 SELECT ic.proc_item
                                   FROM reg_procesos.contrato c JOIN reg_procesos.item_contrato ic
                                   ON c.n_cod_contrato = ic.n_cod_contrato
                                   AND c.n_cod_contrato = ln_cod_contrato
                                   AND c.n_propuesta = ln_n_propuesta
                                 UNION
                                 SELECT i.proc_item
                                   FROM reg_procesos.item_convoca itc,
                                        reg_procesos.convocatorias c,
                                        reg_procesos.buena_pro bp,
                                        reg_procesos.items_bp i,
                                        (
                                           select icei.* from  reg_procesos.item_convoca_estado icei
                                           where  icei.n_convoca_src = reg_procesos.f_get_min_n_convoca(ln_n_convoca )
                                           and icei.cod_tipo_Estado_item = 500
                                           and icei.f_registro = (
                                                         select max(f_registro)
                                                         from reg_procesos.item_convoca_estado ice2
                                                         where ice2.n_convoca_src  = icei.n_convoca_src
                                                         and ice2.proc_item = icei.proc_item
                                                       )
                                         ) ice
                                        /*(
                                           select * from (
                                                  select *
                                                  from reg_procesos.convocatoria_doc
                                                  where n_convoca = ln_n_convoca and cod_tipo_doc   = 1600 order by 1 desc ) where rownum = 1

                                            )cd,

                                        reg_procesos.item_convoca_estado ice*/
                                  WHERE itc.n_convoca = ln_max_nconvoca
                                    AND c.n_convoca = itc.n_convoca
                                    AND bp.n_convoca = ln_n_convoca
                                    AND bp.n_buenapro = i.n_buenapro
                                    AND itc.proc_item = i.proc_item
                                    AND i.n_propuesta = ln_n_propuesta
                                    AND i.monto_adjudicado > 0
                                    AND bp.ind_ultimo = 1
                                  /*  AND cd.cod_tipo_doc =  reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                                    AND cd.n_convoca = bp.n_convoca
                                    AND ice.cod_doc = cd.cod_doc*/
                                    AND ice.proc_item = i.proc_item
                                    AND NOT EXISTS (
                                           SELECT iccc.proc_item
                                             FROM reg_procesos.contrato c,
                                                  reg_procesos.item_contrato iccc
                                            WHERE c.n_convoca = ln_n_convoca
                                              AND c.n_cod_contrato =  iccc.n_cod_contrato
                                              AND iccc.n_convoca = ln_max_nconvoca
                                              AND iccc.proc_item = itc.proc_item
                                              AND c.n_propuesta = ln_n_propuesta
                                              and c.ind_contrato_pub <> 1
                                              AND c.codconsucode = LPAD (ln_codconsucode, 6,'0')
                                              and iccc.proc_item not in (
                                               select distinct(icd.proc_item) from reg_procesos.item_convoca_detalle icd
                                               where icd.n_convoca in (select n_convoca from reg_procesos.convocatorias where n_convoca = ln_max_nconvoca and codobjeto =3) and icd.proc_item=itc.proc_item
                                               and (select sum(icd.cantidad) from reg_procesos.item_convoca_detalle icd where icd.n_convoca = ln_max_nconvoca and icd.proc_item = itc.proc_item) != 
                                                   (select sum(ic.cantidad) from reg_procesos.item_contrato ic where ic.n_convoca = ln_max_nconvoca and ic.proc_item = itc.proc_item)))));

------------------------------------------------------
      SELECT COUNT (1)
        INTO lv_totalregistrosco
        FROM (SELECT DISTINCT itc.n_convoca, itc.unm_codigo, m.unm_desc,
                              itc.proc_item,
                              REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,
                              i.cant_adjudicada cantidad,
                              i.monto_adjudicado monto, itc.dep_codigo,
                              itc.pro_codigo, itc.dis_codigo, dep.dep_desc,
                              pro.pro_desc, dis.dis_desc,
                              to_char(ice.f_registro,'dd/mm/yyyy') f_bp_cons,
                             /* TO_CHAR(cd.fec_upload,reg_procesos.pku_ss_constantes.gv_formato_fecha) f_bp_cons,*/
                              i.n_propuesta
                         FROM reg_procesos.item_convoca itc,
                              reg_procesos.items_bp i,
                              reg_procesos.buena_pro bp,
                              reg_procesos.convocatorias c,
                              sease.unidad_medida m,
                              sease.dep_ubigeo dep,
                              sease.prov_ubigeo pro,
                              sease.dist_ubigeo dis,
                             (
                                           select icei.* from  reg_procesos.item_convoca_estado icei
                                           where  icei.n_convoca_src = reg_procesos.f_get_min_n_convoca(ln_n_convoca )
                                           and icei.cod_tipo_Estado_item = 500
                                           and icei.f_registro = (
                                                         select max(f_registro)
                                                         from reg_procesos.item_convoca_estado ice2
                                                         where ice2.n_convoca_src  = icei.n_convoca_src
                                                         and ice2.proc_item = icei.proc_item
                                                       )
                             ) ice
                             /* (
                         select * from (
                                select *
                                from reg_procesos.convocatoria_doc
                                where n_convoca = ln_n_convoca and cod_tipo_doc   = 1600 order by 1 desc ) where rownum = 1

                          )cd,
                              reg_procesos.item_convoca_estado ice*/
                        WHERE itc.n_convoca = ln_max_nconvoca
                          AND (UPPER (itc.descripcion) LIKE UPPER ('%' || lv_descripcion || '%')
                               OR UPPER (itc.proc_item) LIKE UPPER ('%' || lv_descripcion || '%')
                               OR lv_descripcion IS NULL)
                          AND itc.dep_codigo = dis.dep_codigo
                          AND itc.pro_codigo = dis.pro_codigo
                          AND itc.dis_codigo = dis.dis_codigo
                          AND dis.dep_codigo = pro.dep_codigo
                          AND dis.pro_codigo = pro.pro_codigo
                          AND pro.dep_codigo = dep.dep_codigo
                          AND itc.unm_codigo = m.unm_codigo
                          AND c.n_convoca = itc.n_convoca
                          AND bp.n_convoca = ln_n_convoca
                          AND bp.n_buenapro = i.n_buenapro
                          AND itc.proc_item = i.proc_item
                          AND i.n_propuesta = ln_n_propuesta
                          AND i.monto_adjudicado > 0
                          AND bp.ind_ultimo = 1
                         /* AND cd.cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                          AND cd.n_convoca    = bp.n_convoca
                          AND cd.cod_doc      = ice.cod_doc*/
                          AND ice.proc_item = i.proc_item);

    ------------ Crear la tabla de resultados ------------
      usp_print ('<tr><td width="100%">');
      usp_print ('</table>');
      usp_print ('</td></tr>');

      -- MOSTRAMOS LOS ITEMS ADJUDICADOS - AUN SIN CONTRATO --
IF lv_totalregistros > 0 THEN
      usp_print('<tr class="TabResManCuerpoPar">
                    <td align="center"  colspan="8" class="recuadro"><br><b>'
                    || lv_postorruc || ' - ' || lv_postornom || '</b><br><br></td>
                 </tr>');

       usp_print ('<tr><td width="100%">');
       ------------ Crear la tabla de resultados ------------
       usp_print
         ('<table border="1" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" width="100%">
          <tr><td colspan = 2>Resultado:&nbsp'
             ||TO_CHAR(lv_pagesize * (lv_currentpage - 1) + 1 * SIGN (lv_totalregistros))
             || '&nbsp-&nbsp'
             || (CASE lv_currentpage
                    WHEN CEIL (lv_totalregistros / lv_pagesize)
                    THEN lv_totalregistros
                    ELSE lv_pagesize * lv_currentpage * SIGN (lv_totalregistros)
                 END)
             || ' de ' || lv_totalregistros || '</td><td colspan = 6 align="left">');

         ------------ Imprimir el indice de paginas ------------
         reg_procesos.pku_xportal_utils.paginar ('?scriptdo=' || gv_pkname || '.gv_PkName&',
                                    lv_currentpage,
                                    lv_totalregistros,
                                    lv_pagesize);

         ------------ Crear los campos de cabecera ------------
         usp_print('</td></tr>');
         usp_print('
      <TR class="TabCabMan" >
        <TD><center><b>Item</b></center></TD>
        <TD><center><b>Tipo de Item</b></center></TD>
        <TD><center><b>Descripcion</b></center></TD>
        <TD><center><b>Cantidad Adjudicada</b></center></TD>
        <TD><center><b>Monto Adjudicado</b></center></TD>
        <TD><center><b>U. Medida</b></center></TD>
        <TD><center><b>Cantidad Maxima</b></center></TD>
        <TD><center><b>Monto Maximo</b></center></TD>
        <TD><center><b>Lugar de ejecucion</b></center></TD>
        <TD><center><b>Sistema de Contratacion</b></center></TD>
        <TD><center><b>Modalidad Contractual</b></center></TD>
      </TR>');

         FOR xrow IN citemsadjudicados (ln_cod_contrato,
                                        ln_n_convoca,
                                        ln_n_propuesta,
                                        ln_codconsucode,
                                        ln_max_nconvoca,
                                        lv_descripcion,
                                        lv_currentpage,
                                        lv_pagesize,
                                        ln_tipo_moneda)
         LOOP
            usp_print ('<tr  class="TabResManCuerpoPar">');

            --if xrow.cant_max > 0 AND xrow.monto_max > 0 THEN
            if (xrow.cant_max > 0 or (xrow.tipoitem=5 and xrow.codobjeto=3)) and xrow.monto_max > 0 then -- Si es paquete-obras no validar la cantidad

               lv_clase := '';
               usp_print('<td align="right"  class="recuadro">'||
                         makea2('pitem='|| xrow.proc_item||'
                               ,pdesc='''|| xrow.descripcion||'''
                               ,pfbcons='''|| xrow.f_bp_cons||'''
                               ,pubigeo=''['|| xrow.dep_codigo|| xrow.pro_codigo||  xrow.dis_codigo|| ']['
                                            || xrow.dep_codigo|| '] '||xrow.dep_desc||' / ['|| xrow.pro_codigo|| '] '||
                                               xrow.pro_desc|| '/ ['|| xrow.dis_codigo|| '] '|| xrow.dis_desc|| '''
                                ,pmonto='||replace(xrow.monto_max, ',', '.')||'
                                ,pcantidad='||replace(xrow.cant_max, ',', '.')||'
                                ,sc_codigo='||nvl(xrow.cod_sist_adquisicion,9999)||'
                                ,sc_des='''||xrow.sc_descripcion||'''
                                ,mc_codigo='||nvl(xrow.cod_modalidad_alcance,9999)||'
                                ,mc_des='''||xrow.desmodcnt||'''
                                ,unm_desc='''||xrow.unm_desc||'''
                                ,unm_codigo='|| xrow.unm_codigo,'retornaItemsCO_v3',xrow.proc_item)||
                         '</td>');

              usp_print('<td align="center" class="recuadro">'|| xrow.item_paquete||'</td>');         

              usp_print('<td align="right"  class="recuadro"><font size=1>'||
                         makea2('pitem='|| xrow.proc_item||'
                                ,pdesc='''|| xrow.descripcion||'''
                                ,pfbcons='''|| xrow.f_bp_cons||'''
                                ,pubigeo=''['|| xrow.dep_codigo|| xrow.pro_codigo||xrow.dis_codigo|| ']['|| xrow.dep_codigo|| '] '||
                                               xrow.dep_desc|| ' / ['|| xrow.pro_codigo|| '] '||
                                               xrow.pro_desc|| '/ ['|| xrow.dis_codigo|| '] '||
                                               xrow.dis_desc|| '''
                                  ,pmonto='||replace(xrow.monto_max, ',', '.')||'
                                ,pcantidad='||replace(xrow.cant_max, ',', '.')||'
                                 ,sc_codigo='||nvl(xrow.cod_sist_adquisicion,9999)||'
                                ,sc_des='''||xrow.sc_descripcion||'''
                                ,mc_codigo='||nvl(xrow.cod_modalidad_alcance,9999)||'
                                ,mc_des='''||xrow.desmodcnt||'''
                                ,unm_desc='''||xrow.unm_desc||'''
                                ,unm_codigo='||xrow.unm_codigo,'retornaItemsCO_v3',xrow.descripcion)||
                         '</font></td>');

            -- IF xrow.cant_max = 0 AND xrow.monto_max = 0  THEN
            else
               lv_clase := '<font color="red">';
               usp_print('<td align="right"  class="recuadro">'|| xrow.proc_item || '</td>' );
               usp_print('<td align="center" class="recuadro">'|| xrow.item_paquete||'</td>'); --001 ddrodriguez memo 85-2016 (corregir)
               usp_print('<td align="center" class="recuadro">'|| xrow.descripcion|| '</td>');


            END IF;

            usp_print('<td align="center" class="recuadro">'|| TO_CHAR (xrow.cantidad,reg_procesos.pku_ss_constantes.gv_formato_dinero )|| '</td>');
            usp_print('<td align="center" class="recuadro">'|| TO_CHAR (xrow.monto,reg_procesos.pku_ss_constantes.gv_formato_dinero)|| '</td>');
            usp_print('<td align="center" class="recuadro">'|| xrow.unm_desc|| '</td>');
            usp_print('<td align="center" class="recuadro">'|| lv_clase || TO_CHAR (xrow.cant_max,reg_procesos.pku_ss_constantes.gv_formato_dinero )|| '</td>');
            usp_print('<td align="center" class="recuadro">'|| lv_clase || TO_CHAR (xrow.monto_max, reg_procesos.pku_ss_constantes.gv_formato_dinero) || '</td>');
            usp_print('<td align="center" class="recuadro">['
            || xrow.dep_codigo|| xrow.pro_codigo || xrow.dis_codigo|| ']['
            || xrow.dep_codigo|| '] '|| xrow.dep_desc
            || ' / ['|| xrow.pro_codigo || '] '|| xrow.pro_desc|| '/ ['|| xrow.dis_codigo
                       || '] '|| xrow.dis_desc || '</td>');

            usp_print('<td align="center" class="recuadro">'|| xrow.sc_descripcion|| '</td>');
            usp_print('<td align="center" class="recuadro">'|| xrow.desmodcnt|| '</td>');
            usp_print ('</tr>');
         END LOOP;

         usp_print ('</table>');
         usp_print ('</td></tr>');
END IF;




---------------------------------------------------------------
-- FIN DE MOSTRAMOS LOS ITEMS ADJUDICADOS - AUN SIN CONTRATO --
---------------------------------------------------------------
---------------------------------------------------------------
-- MUESTRA LOS ITEM CON CONTRATO --
---------------------------------------------------------------
   -- Desde aqui se muestra la lista de items adjudicados pero con saldos cero,
   -- muestra la lista de contratos para cada item

IF lv_totalregistros = 0 THEN
     -- Si hay items con contrato los mostramos
     IF lv_totalregistrosco > 0 THEN
        usp_print ('<tr><td width="100%">');
        usp_print
           ('<table border="1" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" width="100%">');

        usp_print('<tr class="">');
        usp_print
           ('<td align="center"  colspan="8" class="recuadro"><br/><b>'
            || lv_postorruc || ' - '  || lv_postornom || '  </b><br/><br/>
          <b>YA SE HAN REGISTRADO CONTRATOS PARA TODOS LOS ITEMS ADJUDICADOS</b><br/><br/>
          </td>');

        usp_print ('</tr>');
        ------------ Crear la tabla de resultados ------------
        usp_print
           ('
       <table class="CabPage" width="100%" border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111">
       <tr><td colspan = 2>Resultado:&nbsp'
            || TO_CHAR (  lv_pagesize * (lv_currentpageco - 1)+ 1 * SIGN (lv_totalregistrosco) )
            || '&nbsp-&nbsp'
            || (CASE lv_currentpageco
                   WHEN CEIL (lv_totalregistrosco / lv_pagesize)
                      THEN lv_totalregistrosco
                   ELSE   lv_pagesize * lv_currentpageco * SIGN (lv_totalregistrosco)
                END
               )
            || ' de ' || lv_totalregistrosco || '</td><td colspan = 6 align="left">');

        ------------ Imprimir el indice de paginas ------------
        reg_procesos.pku_xportal_utils.paginar ('?scriptdo='|| gv_pkname|| '.gv_PkName&',lv_currentpageco,lv_totalregistrosco,lv_pagesize);

        ------------ Crear los campos de cabecera ------------
        usp_print ('</td></tr>');
        usp_print
           ('<TR class="TabCabMan" >
           <TD><center><b>Item</b></center></TD>
           <TD><center><b>Tipo de Item</b></center></TD>
           <TD><center><b>Descripcion</b></center></TD>
           <TD><center><b>Cantidad Adjudicada</b></center></TD>
           <TD><center><b>Monto Adjudicado</b></center></TD>
           <TD><center><b>U. Medida</b></center></TD>
           <TD><center><b>Nro. Contrato</b></center></TD>
           <TD><center><b>Lugar de ejecucion</b></center></TD>
            <TD><center><b>Sistema de Contratacion</b></center></TD>
        <TD><center><b>Modalidad Contractual</b></center></TD>
           <TD><center><b>&nbsp;</b></center></TD>
           </TR>'
           );

        FOR xrow IN citemsadjudicadosco (ln_n_convoca,
                                         ln_n_propuesta,
                                         ln_max_nconvoca,
                                         lv_descripcion,
                                         lv_currentpageco,
                                         lv_pagesize
                                        )
        LOOP
           citemscontratoprop :=
              f_get_itemscontratopropuesta (ln_codconsucode,
                                            xrow.n_convoca,
                                            xrow.proc_item,
                                            xrow.n_propuesta
                                           );
           usp_print
              ('<TR class="TabResManCuerpoPar" >
              <TD class="recuadro" align="right" >'|| xrow.proc_item || '</TD>
              <TD class="recuadro" align="center" >'|| xrow.item_paquete||'</TD> 
              <TD class="recuadro" align="center" ><font size=1>'|| xrow.descripcion || '</font></TD>
              <TD class="recuadro" align="right">'|| TO_CHAR (xrow.cantidad,reg_procesos.pku_ss_constantes.gv_formato_dinero) || '</TD>
              <TD class="recuadro" align="right">'|| TO_CHAR (xrow.monto, reg_procesos.pku_ss_constantes.gv_formato_dinero)|| '</TD>
              <TD class="recuadro" align="center">'|| xrow.unm_desc || '</TD>

              <TD class="recuadro">');

           usp_print
              ('<table border="1" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" width="100%">' );

           LOOP
              FETCH citemscontratoprop
               INTO ln_contrato_prop, ln_propuesta_prop,
                    ln_procitem_prop, ln_nconvoca_prop, ln_mcontratado,
                    ln_monto;

              EXIT WHEN citemscontratoprop%NOTFOUND;
              usp_print
                 ('<tr class="TabResManCuerpoPar"><td lign="left">Nro:'|| ln_contrato_prop || '</td></tr>');
              usp_print
                 ('<tr class="TabResManCuerpoPar"><td lign="left">Monto x Item:'|| ln_monto|| '</td></tr>');
           END LOOP;

           usp_print('</table>');
           usp_print('</TD>
           <TD class="recuadro">['|| xrow.dep_codigo || xrow.pro_codigo || xrow.dis_codigo || ']
                                ['|| xrow.dep_codigo || '] ' || xrow.dep_desc || '/
                                ['|| xrow.pro_codigo || '] ' || xrow.pro_desc || '/
                                ['|| xrow.dis_codigo || '] ' || xrow.dis_desc || '</TD>

                                     <td align="center" class="recuadro">'|| xrow.sc_descripcion|| '</td>
           <td align="center" class="recuadro">'|| xrow.desmodcnt|| '</td>
                                ');

        usp_print('<TD><input type="button" value="Agregar" onclick="retornaItemsCO2_v3('|| xrow.proc_item ||','''||xrow.descripcion||''','''|| xrow.f_bp_cons||''',''['|| xrow.dep_codigo|| xrow.pro_codigo||xrow.dis_codigo|| ']['|| xrow.dep_codigo|| '] '|| xrow.dep_desc|| ' / ['|| xrow.pro_codigo|| '] '|| xrow.pro_desc|| '/ ['|| xrow.dis_codigo|| '] '|| xrow.dis_desc|| ''','||xrow.monto||','||xrow.cantidad||','''||xrow.unm_desc||''','||xrow.unm_codigo ||','||nvl(xrow.cod_sist_adquisicion,9999) ||', '''||xrow.sc_descripcion||''','||nvl(xrow.cod_modalidad_alcance,9999) ||', '''||xrow.desmodcnt||''')" /></TD>');

        USP_PRINT('</TR>' );
        END LOOP;

        usp_print ('</table>');
        usp_print ('</td></tr>');
     END IF;
    -- Fin -- Si hay items con contrato los mostramos
  END IF;

---------------------------------------------------------------
-- FIN - MUESTRA LOS ITEM CON CONTRATO --
---------------------------------------------------------------
      usp_print ('</table><br><br>');
   END;


/*******************************************************************************
/ Procedimiento : uspBuscarCodPresupuestal
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Casta¿eda                          Version Inicial
/******************************************************************************/
PROCEDURE uspBuscarCodPresupuestal(
          anho_entidad        varchar2,
          ag_n_convoca        varchar2,
          ag_proc_item        varchar2,
          ag_tipo_operacion   varchar2,
          ag_codconsucode     VARCHAR2 )
IS
 LV_TRAMA_PRESUPUESTO   LONG;

BEGIN

    /*Plantilla*/
    usp_print('<xml id="xmlActual"><root></root></xml>');

USP_PRINT(PKU_SS_UTILES.f_getXmlItemsCodPresu_sel(anho_entidad,ag_n_convoca,ag_codconsucode));

usp_print('
    <table border="0" class=tableform cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
        <tr>
            <td>
                <h3>Asignacion del Codigo Presupuestal</h3>
            </td>
        </tr>
    </table>
    <br/> ');

 USP_PRINT('
  <table border="0" datasrc="#xmlPresupuesto" class=tableform cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
        <thead> <tr>
          <td class=th1>&nbsp;</td>
          <td class=th1>Codigo</td>
          <td class=th1>descripcion</td>
          <td class=th1>Monto Presupuestado</td>
          <td class=th1>Monto Asignado</td>
        </tr> </thead>');
  usp_print('
  <tbody><tr class="TabFilMan">
          <td align="center"    width="8%"><span datafld="chk" dataformatas="html" ></span>
          <input type="hidden"  datafld="copiar" name="hcopiar" /> </td>
          <td align="center"    width= "5%"><span datafld="cod"></span></td>
          <td align="left"      width= "35%"><span datafld="descripcion"></span></td>
          <td align="center"    width= "5%"><span datafld="mon"></span></td>
          <td width="4%"><input type="text" datafld="monto" name="txtMontoxml" size="15" style="text-align:right" onKeyPress="f_validaCampoNumerico()"></input></td>
  </tr></tbody>
  ');
  usp_print('</table>');

  USP_PRINT('<br><br><table border="0" class=tableform cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">');
  usp_print('<tr><td colspan="5" align="right">');
  usp_print('<input type="button"  value="Aceptar"  name="btnAceptar"  onclick="generaTrama(1,'||ag_proc_item||')" />');
  usp_print('<input type="button"  value="Cancelar" name="btnCancelar" onclick="window.close();" />');
  usp_print('</td></tr>');
  usp_print('</table>');

    ----------------- Java Script --------------

    PKU_GESTOR_CONT_FUNCIONES_JS_2.fNumeros;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlPresupuesto;

END;

/*******************************************************************************
/ Procedimiento : uspSearchCodPresupuestal
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Casta¿eda                          Version Inicial
/******************************************************************************/
PROCEDURE uspSearchCodPresupuestal( anho_entidad              VARCHAR2,
                                    session__eue_codigo       VARCHAR2,
                                    edicion                   VARCHAR2 DEFAULT NULL,
                                    codigo                    VARCHAR2 DEFAULT NULL,
                                    descripcion               VARCHAR2 DEFAULT NULL,
                                    session__n_convoca        VARCHAR2 DEFAULT NULL,
                                    ag_n_propuesta            VARCHAR2 DEFAULT NULL,
                                    ag_monto_codPre           VARCHAR2 DEFAULT NULL,
                                    ag_proc_item              VARCHAR2 DEFAULT NULL,
                                    ag_tipo_operacion         VARCHAR2 DEFAULT NULL,
                                    ag_cod_contrato           VARCHAR2 DEFAULT NULL,
                                    session__userid           VARCHAR2 DEFAULT NULL,
                                    session__AG_COD_CONTRATO  VARCHAR2 DEFAULT NULL,
                                    contrata                  VARCHAR2 DEFAULT NULL
                                    )
IS

 anhoentidad  varchar2(20);
 entidad      varchar2(100);
 editar       varchar2(1);
 codigo_pre   varchar2(50);
 descrip_pre  varchar2(100);
 convoca      varchar2(50);
 propuesta    varchar2(50);
 monto        varchar2(50);
 proc_item    varchar2(50);
 contrato     varchar2(50);

 CURSOR cCodPresupuesto (panhoentidad varchar2,entidad varchar2, convoca varchar2)
 IS
   SELECT distinct m.proy_codigo cod_presupuestal, m.proy_descripcion descripcion
      FROM REG_PROCESOS.mef_proyectos_entidades p
        join REG_PROCESOS.mef_proyectos m on p.proy_codigo = m.proy_codigo
        join REG_PROCESOS.convocatoria_cod_presup s on s.cod_presupuestal = m.proy_codigo
      WHERE
            p.codconsucode = LPAD(entidad, 6, '0')
        and p.anhoentidad  = panhoentidad
        and m.proy_estado  = 'A'
        and s.n_convoca    = convoca;

 CURSOR cCodPresuItem(convoca varchar2,item varchar2, contrato varchar2, propuesta varchar2)
 IS
    select a.cod_presupuestal,a.descripcion,a.monto_asignado, a.n_propuesta
       from reg_procesos.contrato_cod_presupuestal a,
            reg_procesos.convocatoria_propuesta_item b
       where b.n_convoca = convoca         and
             a.n_convoca = b.n_convoca     and
             b.proc_item = item            and
             a.proc_item = item            and
             a.n_propuesta = b.n_propuesta and
             a.n_cod_contrato = contrato;


BEGIN

  anhoentidad := trim(anho_entidad);
  entidad     := session__eue_codigo;
  editar      := edicion;
  codigo_pre  := codigo;
  descrip_pre := descripcion;
  convoca     := session__n_convoca;
  propuesta   := ag_n_propuesta;
  monto       := ag_monto_codPre;
  proc_item   := ag_proc_item;

  if ag_cod_contrato is null then
    contrato  := session__AG_COD_CONTRATO;
  else
    contrato  := session__AG_COD_CONTRATO;
  end if;

  /*usp_print('anhoentidad: '||anhoentidad||'<br>');
  usp_print('entidad    : '||entidad||'<br>');
  usp_print('editar     : '||editar||'<br>');
  usp_print('codigo_pre : '||codigo_pre||'<br>');
  usp_print('descrip_pre: '||descrip_pre||'<br>');
  usp_print('convoca: '||convoca||'<br>');
  usp_print('propuesta: '||propuesta||'<br>');
  --usp_print('ag_tipo_operacion: '||ag_tipo_operacion||'<br>');
  usp_print('contrato: '||session__AG_COD_CONTRATO||'<br>');
  usp_print('proc_item: '||proc_item||'<br>');
  usp_print('contrata: '||contrata||'<br>');
  --ag_tipo_operacion
  return;*/

  usp_print('
  <input type=hidden name=ag_n_propuesta value='||propuesta||'>
  <input type=hidden name=anho_entidad value='||anhoentidad||'>
  <input type=hidden name=ag_proc_item value='||proc_item||'>
  <input type=hidden name=edicion value="">
  <input type=hidden name=codigo value="">
  <input type=hidden name=descripcion value="">
  <input type=hidden name=contrata value="'||contrata||'">
  <input type=hidden name=ag_tipo_operacion value="'||ag_tipo_operacion||'">
  <input type=hidden name=ag_n_propuesta value="'||ag_n_propuesta||'">
  <input type=hidden name=ag_cod_contrato value="'||ag_cod_contrato||'">
  <input type=hidden name=ag_proc_item value="'||ag_proc_item||'">
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
        IF ag_tipo_operacion = 1 THEN
            FOR xd IN cCodPresupuesto(anhoentidad,entidad,convoca)LOOP
            usp_print('
            <tr>
              <td><img src=images/Eliminar.gif onclick="IngresarCod('''||xd.cod_presupuestal||''','''||xd.descripcion||''','''');"></td>
              <td>'||xd.cod_presupuestal||'<input type=hidden name=ag_codPre_codpresupuestal value="'||xd.cod_presupuestal||'"></td>
              <td>'||xd.descripcion||'<input type=hidden name=ag_codPre_descripcion value="'||xd.descripcion||'"></td>
            </tr>
            ');
            END LOOP;
         /*END IF;
         IF ag_tipo_operacion = 2 THEN     */
        ELSE
            /*usp_print(ag_tipo_operacion);
            return;*/
            FOR xd IN cCodPresuItem(convoca,proc_item,contrato,propuesta)LOOP
              /*usp_print(convoca||','||proc_item||','||contrato||','||propuesta);
              return;*/
            usp_print('
            <tr>
              <td><img src=images/Eliminar.gif onclick="IngresarCod('''||xd.cod_presupuestal||''','''||xd.descripcion||''','''||ag_tipo_operacion||''');"></td>
              <td>'||xd.cod_presupuestal||'<input type=hidden name=ag_codPre_codpresupuestal value="'||xd.cod_presupuestal||'"></td>
              <td>'||xd.descripcion||'<input type=hidden name=ag_codPre_descripcion value="'||xd.descripcion||'"></td>
            </tr>
            ');
            END LOOP;
         END IF;
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
                <input type="button" name="enviar" value="Enviar" onclick="Agregar('''||codigo_pre||''','''||ag_tipo_operacion||''');">
              </td>
            </tr>
          </table>
           ');

       ELSE
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
          IF ag_tipo_operacion = 1 THEN
              SELECT proy_descripcion descripcion into descrip_pre
               FROM REG_PROCESOS.mef_proyectos
                WHERE proy_codigo = codigo_pre
                  and proy_estado = 'A';

              insert into reg_procesos.tmp_contrato_cod_presupuestal
                  ( n_convoca    , anho_entidad  ,  cod_preupuestal,
                    descripcion  , monto_asignado,  proc_item,
                    n_propuesta)
                  values
                  ( convoca      , anhoentidad   ,  codigo_pre,
                    descrip_pre  , monto         ,  proc_item,
                    propuesta );
              commit;

              usp_print('
               <script language=javascript>
                   var wo = window.opener
                   wo.RecargaContrato("'||ag_n_propuesta||'",1)
                   window.close();
               </script>
               ');
          ELSE

              SELECT proy_descripcion descripcion into descrip_pre
               FROM REG_PROCESOS.mef_proyectos
                WHERE proy_codigo = codigo
                  and proy_estado = 'A';

              IF contrata IS NULL THEN

                  insert into reg_procesos.tmp_contrato_op_cod_presu
                  ( n_convoca, n_propuesta, proc_item, tipo_operacion,
                   cod_presupuestal, descripcion, monto_asignado,
                   anho_entidad,n_cod_contrato,userid)
                  values
                  ( convoca, ag_n_propuesta, ag_proc_item, ag_tipo_operacion,
                    codigo , descrip_pre   , monto       , anhoentidad,
                    contrato, session__userid);
                  commit;

               ELSE

                  /*usp_print(convoca||','||ag_n_propuesta||','||ag_tipo_operacion||','||codigo||','||descrip_pre||','||monto||','||anhoentidad||','||contrata||','||session__userid);
                  return;*/

                  insert into reg_procesos.tmp_contrato_op_cod_presu
                  ( n_convoca, n_propuesta, proc_item, tipo_operacion,
                   cod_presupuestal, descripcion, monto_asignado,
                   anho_entidad,n_cod_contrato,userid)
                  values
                  ( REG_PROCESOS.f_get_max_n_convoca(convoca), ag_n_propuesta, ag_proc_item, ag_tipo_operacion,
                    codigo , descrip_pre   , monto       ,
                    anhoentidad, contrata, session__userid);
                  commit;
               END IF;

              usp_print('
               <script language=javascript>
                   var wo = window.opener;
                   wo.RecargaContrato("'||ag_n_propuesta||'",1);
                   window.close();
               </script>
               ');

          END IF;
         --select * from reg_procesos.tmp_contrato_cod_presupuestal;
       END IF;

  END IF;

  usp_print('
  <script language=javascript>
    function IngresarCod(codigo,descripcion,operacion)
     {
       var descrip = descripcion;
       var cod = codigo;
       thisform.codigo.value=cod;
       thisform.descripcion.value=descrip;
       thisform.edicion.value  = "1";
       if (operacion == 2 || operacion == 3)
       {
         thisform.scriptdo.value = "SearchCod";
       }
       else
       {
         thisform.scriptdo.value = "SearchCodPresupuestal";
       }
       thisform.submit();
     }

    function Agregar(codigo,operacion)
     {
       thisform.codigo.value=codigo;
       thisform.edicion.value  = "2";
       if (operacion == 2 || operacion == 3)
       {
         thisform.scriptdo.value = "SearchCod";
       }
       else
       {
         thisform.scriptdo.value = "SearchCodPresupuestal";
       }
       thisform.submit();
     }
  </script>
  ');
       /*var wo = window.opener
       wo.RtnCatNU(codNU,value)
       window.close();*/

END;

PROCEDURE usplistcontratosdoview_v3 (
    ag_n_convoca              VARCHAR2 DEFAULT NULL,
    an_codconsucode           VARCHAR2 DEFAULT NULL,
    ag_anhoentidad            VARCHAR2 DEFAULT NULL,
    session__userid           VARCHAR2 DEFAULT NULL,
    ag_proc_tipo              VARCHAR2 DEFAULT NULL,
    ag_proc_desc              VARCHAR2 DEFAULT NULL,
    ag_proc_sigla             VARCHAR2 DEFAULT NULL,
    ag_currenpage             VARCHAR2 DEFAULT NULL,
    session__eue_codigo       VARCHAR2 DEFAULT NULL,
    session__anhoentidad      VARCHAR2 DEFAULT NULL,
    session__filesingedhttp   VARCHAR2 DEFAULT NULL,
    convoca                   VARCHAR2 DEFAULT '',
    contrato                  VARCHAR2 DEFAULT '',
    control_sesion            NUMBER   DEFAULT 0,
    av_ind_resumen            VARCHAR  DEFAULT NULL,
    av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL,
    session__n_convoca        VARCHAR  DEFAULT NULL)
IS
     -- Items del contrato
    CURSOR citemscontrato (p_ncod_contrato IN NUMBER)
    IS
       SELECT TRIM(TO_CHAR (c.proc_item, reg_procesos.pku_ss_constantes.gv_constante_numerico)) proc_item
           FROM reg_procesos.item_contrato c
          WHERE c.n_cod_contrato = p_ncod_contrato
       ORDER BY proc_item;

      -- Resumen de los Contratos

      cursor cdocs2(pn_convoca in number, pn_contrato in number) is
      select replace(cd.doc_url, '\', '/') archivo,
           --  tipo_archivo.icon_tipo_file,
             replace('bootstrap/'||tipo_archivo.icon_tipo_file, 'jpg', 'png') icon_tipo_file,
             (cd.tamano_bytes) tamano,
             cd.fec_upload fecha_creacion
        from reg_procesos.convocatoria_doc cd
  inner join reg_procesos.tipo_archivo on (cd.cod_tipo_file=tipo_archivo.cod_tipo_file)
       where cd.cod_tipo_doc = 600
         and cd.n_convoca = pn_convoca
         and cd.n_cod_contrato = pn_contrato
       order by cd.fec_upload desc ;

    cursor c_doc_seacev3(p_contrato number) is
        select n_id_documento,
       'bootstrap/images/icon_pdf.png' icon_tipo_file,
       n_tamarc tamano,
       d_feccre fecha_creacion
       from con.det_con_documento@AIXSEACE
       where n_id_contrato = p_contrato
       and n_tipdoc = 2;  

      -- Datos de la pantalla
      ln_nconvoca                    NUMBER;
      ln_codconsucode                NUMBER;
      ln_anhoentidad                 VARCHAR2 (20);
      ln_contcontratos               NUMBER;
      lv_estilo_fila                 VARCHAR2 (50);
      ln_num_fila                    NUMBER;
      -- Cursores
      ccontratos                     ref_cursor;
      -- Items del contrato
      ln_numitemscontrato            NUMBER;
      ln_draw_coma                   NUMBER;
      -- Datos de los contratos
      lv_desc_entidad                VARCHAR2 (150);
      lv_des_contrato                VARCHAR2 (500);
      ln_n_cod_contrato              NUMBER;
      ln_n_convoca_pad               VARCHAR2 (20);
      ln_n_cod_contrato_pad          VARCHAR2 (20);
      ln_codconsucode_cursor         VARCHAR2 (6);
      ln_cod_condicion               NUMBER;
      ln_cod_documento_liquidacion   VARCHAR2 (20);
      lv_ruc_contratista             VARCHAR2 (11);
      lv_nom_contratista             VARCHAR2 (2000);
      lv_f_contrato                  VARCHAR2 (20);
      lv_m_contratado                VARCHAR2 (40);
      lv_estado_rnp                  VARCHAR2 (500);
      lv_fintervenvion               VARCHAR2 (20);
      ld_fliquidacion                DATE;
      lv_descconv                    VARCHAR2 (320);
      ln_proctipo                    NUMBER;
      lv_procsigla                   VARCHAR2 (50);
      lv_proc_tiposigla              VARCHAR2 (50);
      ln_objeto_convoca              NUMBER;
      ln_indPubContratos             NUMBER;
      -- Datos de los items
      ln_items_resueltos             NUMBER;
      ln_items_en_ejecucion          NUMBER;
      -- Datos de fechas del contrato
      ld_fec_contrato                DATE;
      ld_fec_culimnacion             DATE;
      ln_dummy                       NUMBER;
      ln_estado                      NUMBER;
      ln_contador_loop               NUMBER;
      ln_tabulacion_item             NUMBER;
      lv_doc_url                     reg_procesos.convocatoria_doc.doc_url%TYPE;
      lv_icon_tipo_file              reg_procesos.tipo_archivo.icon_tipo_file%TYPE;
      lv_tamano                      reg_procesos.convocatoria_doc.tamano_bytes%TYPE;
      lv_fecha_creacion              reg_procesos.convocatoria_doc.fec_upload%TYPE;
      ln_cant_doc                    NUMBER;
      ln_moneda_conv                 NUMBER;
      valida_arbitro                 NUMBER;  --SE AGREGA VALIDACION PARA QUE SE VISUALICE CONTRATOS DE LOS PROCESOS DEL SEACEV3 EL ARBITRO
      lc_idprocsel                   varchar2(25);--modificar con la fecha de pase 
      ld_fec_reqMEF                  date := to_date('20112015','ddmmyyyy'); -- Jcerda req MEF 19/10/2015  
      ld_f_registro                  date; -- Jcerda req MEF 19/10/2015  

      ln_valida_origen      number;
--cambios arbitro nueva ley
    cursor cValidaUser is
    select count(a.usu_codigo) cvalidauser1  from sease.usuario a
    where trim(a.usu_codigo) = trim(session__userid)
    and usu_activo = 1
    and usu_tipo = 3;

    n_cvalidauser number;
    ln_modulo number;        -- (1/3) 12.09.2020 , permite verificar si las acciones sobre el contrato deben estas habilitados

BEGIN

-- (2/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
select F_CON_CONTRATO_MOD('DESACTIVAR', 'CONTRATO',sysdate  ) into ln_modulo from dual;



--cambios arbitro nueva ley
for a1 in cValidaUser loop
  n_cvalidauser:=a1.cvalidauser1;
end loop;
--- usp_print('ag_n_convoca:'||ag_n_convoca);
    -- Javascript
    PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos;

    -- Datos de la pantalla
    ln_nconvoca      := nvl(ag_n_convoca,session__n_convoca);
    ln_codconsucode  := session__eue_codigo;
    ln_anhoentidad   := nvl(ag_anhoentidad, session__anhoentidad);

    SELECT CODMONEDA INTO  ln_moneda_conv FROM REG_PROCESOS.CONVOCATORIAS WHERE N_CONVOCA = ln_nconvoca;

    usp_print ('<SESSION_EXPORT>
                    <N_CONVOCA>'||ln_nconvoca||'</N_CONVOCA>
                    <AG_COD_CONTRATO>'||NULL||'</AG_COD_CONTRATO>
                    <COD_CONTRATO>'||NULL||'</COD_CONTRATO>
                  <COD_MONEDA>'||ln_moneda_conv||'</COD_MONEDA>
                </SESSION_EXPORT>');

    /*
    usp_print ('<SESSION_EXPORT>
                    <AG_N_CONVOCA>'||ln_nconvoca||'</AG_N_CONVOCA>
                    <N_CONVOCA>'||ln_nconvoca||'</N_CONVOCA>
                    <AG_COD_CONTRATO>'||NULL||'</AG_COD_CONTRATO>
                    <COD_CONTRATO>'||NULL||'</COD_CONTRATO>
                  <COD_MONEDA>'||ln_moneda_conv||'</COD_MONEDA>
                </SESSION_EXPORT>');
                */
    -- Ocultos
    usp_print ('<input type="hidden" name="av_ind_resumen"         value="'||av_ind_resumen||'">');
    usp_print ('<input type="hidden" name="ag_n_convoca"           value="'||ln_nconvoca||'">');
    usp_print ('<input type="hidden" name="ag_cod_contrato"        value="">');
    usp_print ('<input type="hidden" name="ag_operacion_va"        value="">');
    usp_print ('<input type="hidden" name="ag_tipo_op"             value="1">');
    usp_print ('<input type="hidden" name="an_codconsucode"        value='||ln_codconsucode||'>');
    usp_print ('<input type="hidden" name="ag_eue_codigo"          value="'||ln_codconsucode||'">');
    usp_print ('<input type="hidden" name="ag_anhoentidad"         value="'||ln_anhoentidad||'">');
    usp_print ('<input type="hidden" name="ag_proc_tipo"           value="'||ag_proc_tipo||'">');
    usp_print ('<input type="hidden" name="ag_proc_desc"           value="'||ag_proc_desc||'">');
    usp_print ('<input type="hidden" name="ag_proc_sigla"          value="'|| ag_proc_sigla||'">');
    usp_print ('<input type="hidden" name="ag_currenpage"          value="'||ag_currenpage||'">');
    usp_print ('<input type="hidden" name="ag_ncor_orden_pedido"   value="">');
    usp_print ('<input type="hidden" name="ag_cm_opc"              value="">');
    usp_print ('<input type="hidden" name="ag_cm_oper_compra"      value="">');
    usp_print ('<input type="hidden" name="contrato"               value="'||contrato||'">');
    usp_print ('<input type="hidden" name="convoca"                value="'||convoca||'">');


 usp_print('<input type="hidden" name="av_id_expede"           value="'||av_id_expede||'"/>');
 usp_print('<input type="hidden" name="av_id_proc"             value="'||av_id_proc||'"/>');
 usp_print('<input type="hidden" name="av_id_con_pub"          value="'||av_id_con_pub||'"/>');



    -- inicializamos los cursores
    ccontratos := f_get_contratos( ln_nconvoca, ln_codconsucode, session__userid, ln_contcontratos );

        select count(1) into ln_cant_doc
            from(
                select
                cd.doc_url,
                --tipo_archivo.icon_tipo_file,
                 replace('bootstrap/'||tipo_archivo.icon_tipo_file, 'jpg', 'png') icon_tipo_file,
                (cd.tamano_bytes) tamano,
                cd.fec_upload
                from
                reg_procesos.convocatoria_doc cd
                inner join reg_procesos.tipo_archivo on (cd.cod_tipo_file=tipo_archivo.cod_tipo_file)
                where cd.cod_tipo_doc = 600
                and cd.n_cod_contrato is null
                and cd.n_convoca = ln_nconvoca
                order by cd.fec_upload desc
                )
            where  rownum = 1;

    usp_print('

    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">
        <tr>');
    usp_print( reg_procesos.PKU_PROCESOS_COMUN.f_get_titulo_v3 ( ln_nconvoca, 'Consola de Contratos') );

            usp_print('<td align="right" valign=top width="50%">
                       <input type="button" name="g" value="Volver" OnClick="volver()"/>&nbsp;&nbsp;');

           -- (3/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
           if ln_modulo = 1 then 
              if (n_cvalidauser = 0) then --No aparece boton si es Arbitro - ddrodriguez
                  usp_print('<input type="button" name="h" value="Crear Contrato" OnClick="crear()"/>');
              end if;
           end if;
            usp_print('</td>
        </tr>
    </table>
        ');

     if ln_cant_doc > 0 then
      usp_print('
      <table border="0" width=100% align=center class="table table-striped" cellpadding=3 cellspacing=0>');
                PKU_GESTOR_CONT_MAKE_CONTRATOS.usp_documento(session__filesingedhttp,ln_nconvoca);
                usp_print ('
        <TR>
            <TD COLSPAN="3" class=c1b>&nbsp;</TD>
        </TR>
      </table>');
    end if;
usp_print('<div style="background-color:#F6FF8A;">Si requiere registrar un nuevo contrato, deber&aacute; ingresar al nuevo M&oacute;dulo de Ejecuci&oacute;n Contractual.</div>');
    usp_print('
    <br>
    <table border="0" width=100% align=center class="table table-striped table-bordered table-hover data Table no-footer" cellpadding=3 cellspacing=0>
        <th class="th1">Descripci&oacute;n</th>
        <th class="th1">Fecha de Contrataci&oacute;n</th>
        <th class="th1">Monto Contratado</th>
        <th class="th1">Situacion</th>
        <th class="th1">Estado<br/>RNP</th>
        <th class="th1">Items</th>
        <th class="th1">Documento<br>Liquidaci&oacute;n</th>
        <th class="th1">Archivo de Contrato</th>
    ');

    IF ln_contcontratos > 0 THEN
        ln_contador_loop := 0;
        LOOP FETCH ccontratos
             INTO ln_num_fila, lv_desc_entidad, lv_des_contrato,
                  ln_n_cod_contrato, ln_n_convoca_pad, ln_n_cod_contrato_pad,
                  ln_codconsucode_cursor, ln_cod_condicion,
                  ln_cod_documento_liquidacion, lv_ruc_contratista,
                  lv_nom_contratista, lv_f_contrato, lv_m_contratado,
                  ld_fliquidacion, lv_estado_rnp, lv_fintervenvion,
                  lv_descconv, ln_proctipo, ln_objeto_convoca, lv_procsigla,
                  lv_proc_tiposigla,ln_indPubContratos, 
                  ld_f_registro; -- Jcerda req MEF 19/10/2015
        EXIT WHEN ccontratos%NOTFOUND;
            ln_draw_coma := NULL;

            IF MOD (ln_num_fila, 2) = 0 THEN
                lv_estilo_fila := 'bgcolor="#ECE9D8"';
            ELSE
               lv_estilo_fila := '';
            END IF;

            ln_dummy := PKU_GESTOR_CONT_MAKE_CONTRATOS.f_get_fechasprorroga(ln_n_cod_contrato, ld_fec_contrato, ld_fec_culimnacion );

            --valida controversias en procesos del seacev3

          select   count(*) INTO valida_arbitro from reg_procesos.contrato_arbitraje where ruc_presidente = trim(session__userid)
          and n_cod_contrato = ln_n_cod_contrato_pad and ind_ultimo = 1;

   -- Inicio Validacion SEACE3: Mostrar contratos que corresponden solo al Arbitro  n_cvalidauser=1 y valida_arbitro>1 (cantidad de contratos) - ddrodriguez
        IF ((n_cvalidauser = 0) or (valida_arbitro > 0 and n_cvalidauser > 0)) THEN 

          -- Jcerda req MEF 19/10/2015
          select (case when av_id_expede is not null and trunc(ld_f_registro) >= ld_fec_reqmef then lpad(av_id_expede,8,'0') else lpad(ln_n_convoca_pad,8,'0') end) 
            into lc_idprocsel
            from dual;

            usp_print ('
        <tr '||lv_estilo_fila||' >
            <td colspan="7">
                <b>'||makea('ag_cod_contrato='||ln_n_cod_contrato_pad||'&ag_n_convoca='||ln_n_convoca_pad||'&ag_indConsola='||ln_contcontratos||'&ag_proc_tipo='|| ag_proc_tipo||'&ag_proc_desc='|| ag_proc_desc||'&ag_proc_sigla='|| ag_proc_sigla||'&ag_currenpage='|| ag_currenpage||'&ag_codconsucode='|| an_codconsucode||'&ag_anhoentidad='|| ln_anhoentidad||'&scriptdo=doEditContrato&av_id_expede='||av_id_expede||'&av_id_proc='||av_id_proc||'&av_id_con_pub='||av_id_con_pub,ln_codconsucode_cursor||'-'||/*ln_n_convoca_pad||*/lc_idprocsel||'-'||ln_n_cod_contrato_pad)||'&nbsp;&nbsp;&nbsp;<b>'||lv_ruc_contratista||' - '||lv_nom_contratista ||'</b>&nbsp;&nbsp;&nbsp;');-- Jcerda req MEF 19/10/2015

        --cambios arbitros nueva ley
        IF n_cvalidauser = 0 THEN
          if ln_indPubContratos = 1 then
              usp_print('<a href="#" onclick="showTransferencia('''||to_number(ln_n_cod_contrato)||''','''||to_number(ln_n_convoca_pad)||''','''||to_number(ln_anhoentidad)||''','''||to_number(ln_codconsucode)||''')">(Mostrar Transferencia al MEF)</a>');
          end if;
          elsif  ln_indPubContratos = 0 then
              usp_print('<font color="red">(Por Publicar)</font>');
        END IF;

    usp_print('
            </td>
            <td align="center">');
           -- usp_print(makea2(ln_nconvoca||','||ln_n_cod_contrato||',600','EnviarResumen','Adjuntar Contrato/OC, OS ('||pku_ss_utiles.f_get_numContratos(ln_n_cod_contrato,ln_nconvoca)||')'));
            usp_print('</td>
        </tr>

        <tr '||lv_estilo_fila||' valign="top" >
            <td>'||lv_des_contrato||'</td>
            <td align="center">'||lv_f_contrato||'</td>
            <td align="center">'||lv_m_contratado||'&nbsp;');

           /* if ln_indPubContratos = 1 then
            usp_print('<a href="#" onclick="showResumen('''||TO_NUMBER(ln_n_cod_contrato)||''','''||TO_NUMBER(ln_n_convoca_pad)||''')">(Resumen)</a></td>');
            end if;
            */
            -- Estado del contrato
            ln_items_resueltos    := f_get_cantitemsresueltos( ln_n_cod_contrato );
            ln_items_en_ejecucion := f_get_cantitemsenejecucion( ln_n_cod_contrato );

            SELECT COUNT (*) INTO ln_estado
            FROM reg_procesos.contrato_resolucion
            WHERE n_cod_contrato = ln_n_cod_contrato AND estado_contrato = 2;

            IF ( ln_estado > 0 ) THEN
                usp_print('
            <td align="center"><font color="red"><b>NULIDAD</b></font></td>');
            ELSE
                usp_print('
            <td align="center">'||f_get_estadocontrato(ld_fec_contrato, ld_fec_culimnacion,ld_fliquidacion, TO_DATE(lv_fintervenvion, reg_procesos.pku_ss_constantes.gv_formato_fecha),ln_items_resueltos, ln_items_en_ejecucion ));
            END IF;

            usp_print ('
            </td>

            <td align="center">');
            IF ln_cod_condicion = 5 THEN
                usp_print ('
                <font color="red">'||lv_estado_rnp||'<br/>A LA FECHA DE SUSCRIPCION DEL CONTRATO EL PROVEEDOR NO POSEE RNP VIGENTE </font>');
            END IF;

            usp_print ('
                &nbsp;
            </td>

            <td width=10% align="center">');
            -- numeros de items del contrato
            SELECT COUNT (1) INTO ln_numitemscontrato
            FROM reg_procesos.item_contrato c
            WHERE c.n_cod_contrato = ln_n_cod_contrato;

            ln_tabulacion_item := 0;

            IF ln_numitemscontrato > 0 THEN
                FOR xrow IN citemscontrato (ln_n_cod_contrato) LOOP
                    ln_tabulacion_item := ln_tabulacion_item + 1;
                    IF ln_draw_coma IS NOT NULL THEN
                        IF ln_tabulacion_item = 10 THEN
                          usp_print (',<br>');
                        ELSE
                          usp_print (',');
                        END IF;
                    END IF;
                    usp_print (xrow.proc_item);
                    ln_draw_coma := ln_numitemscontrato;
                END LOOP;
            END IF;
            usp_print ('
            </td>

            <td width=5% align="center">');
            IF ln_cod_documento_liquidacion IS NULL THEN
                usp_print('<font color="red"><b>NO</b></font>');
            ELSE
                SELECT replace(reg_procesos.convocatoria_doc.doc_url, '\', '/') doc_url, 
                --nvl(reg_procesos.tipo_archivo.icon_tipo_file,99)
               nvl(replace('bootstrap/'||tipo_archivo.icon_tipo_file, 'jpg', 'png'),99) icon_tipo_file,
               (reg_procesos.convocatoria_doc.tamano_bytes) tamano,
               reg_procesos.convocatoria_doc.fec_upload fecha_creacion  

                INTO lv_doc_url, lv_icon_tipo_file, lv_tamano, lv_fecha_creacion
                FROM
                    reg_procesos.tipo_documento LEFT OUTER
                    JOIN reg_procesos.convocatoria_doc
                        ON reg_procesos.tipo_documento.cod_tipo_doc = reg_procesos.convocatoria_doc.cod_tipo_doc
                        AND reg_procesos.convocatoria_doc.cod_doc = ln_cod_documento_liquidacion
                      --  AND reg_procesos.convocatoria_doc.cod_doc = reg_procesos.f_get_max_cod_doc( convocatoria_doc.n_convoca, tipo_documento.cod_tipo_doc )
                    LEFT OUTER JOIN reg_procesos.tipo_archivo
                        ON reg_procesos.convocatoria_doc.cod_tipo_file = reg_procesos.tipo_archivo.cod_tipo_file
                WHERE reg_procesos.tipo_documento.cod_tipo_doc = 700
                ORDER BY reg_procesos.tipo_documento.cod_tipo_doc;

                IF (lv_doc_url IS NOT NULL) THEN
                    --     usp_print ('<a target=_blank href="DownloadFileServlet?fileName='||lv_doc_url||'"><img src="'||lv_icon_tipo_file||'" border="0" width="30" height="30"/></a>');        
              --  usp_print ('<a target="_blank" href="DownloadFileServlet?fileName='||lv_doc_url||'">');
                if (INSTR(lv_doc_url, 'particion1') > 0) then
                    usp_print ('<a target="_blank" href="'||url_azure_app1||lv_doc_url||'">');
                else
                    usp_print ('<a target="_blank" href="'||url_azure_app||lv_doc_url||'">');
                end if;
                usp_print ('<img src="'||lv_icon_tipo_file||'" width="30" height="30" border="0">
                <br>'||to_char(lv_fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b>
                <br>Tamaño '||to_char(lv_tamano,'999,999,999')||' Kb.<br></b><br>');

                END IF;

            END IF;
             select count(1) into  ln_valida_origen from  reg_procesos.tbl_con_contrato_mig  a where a.n_id_contrato = ln_n_cod_contrato;

            usp_print ('
            </td>
            <td align="center" valign="top">');
        if ln_valida_origen = 0 then
             for xx in cdocs2(ln_nconvoca,ln_n_cod_contrato)loop
                if (INSTR(lv_doc_url, 'particion1') > 0) then
                    usp_print ('<a target="_blank" href="'||url_azure_app1||xx.archivo||'">');
                else
                    usp_print ('<a target="_blank" href="'||url_azure_app||xx.archivo||'">');
                end if;

                usp_print ('<img src="'||xx.icon_tipo_file||'" width="30" height="30" border="0">
                <br>'||to_char(xx.fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b>
                <br>Tamaño '||to_char(xx.tamano,'999,999,999')||' Kb.<br></b><br>');
            end loop;
        else 
            for xx in c_doc_seacev3(ln_n_cod_contrato)loop
                usp_print ('
                <a target="_blank" href="http://contratos.seace.gob.pe:9045/api/documentos/descargar/' || xx.n_id_documento || '">
                <img src="'||xx.icon_tipo_file||'" width="30" height="30" border="0">
                <br>'||to_char(xx.fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b>
                <br>Tamaño '||to_char(xx.tamano,'999,999,999')||' Kb.<br></b><br>');
            end loop;

           end if;  

            usp_print('</td>
        </tr>');

             END IF ; -- Finaliza Validacion Arbitro SEACE3, mostrar contratos que corresponden - ddrodriguez

        END LOOP;
        usp_print ('
        <input type="hidden" name="ln_contador_loop" value='||to_char(ln_contador_loop)||'>');

    END IF;

    usp_print ('
    </table>');

    ln_estado := 0;

    SELECT COUNT (*) INTO ln_estado
    FROM reg_procesos.contrato_resolucion
    WHERE n_cod_contrato = ln_n_cod_contrato AND estado_contrato = 2;

    IF ( ln_estado = 0 ) THEN
        usp_print('<input type="hidden" value="0" name="ag_estado" >');
    ELSE
        usp_print('<input type="hidden" value="'||ln_estado||'" name="ag_estado">');
    END IF;


    usp_print('
    <script>
    function EnviarResumen(convocatoria,contrato)
    {
       //var pag = window.open("portlet5open.asp?_portletid_=mod_popup_contratos&scriptdo=doAddResumen&ag_n_convoca="+ convocatoria +"&ag_cod_contrato="+ contrato,"Items","toolbar=no,Width=750,Height=220,scrollbars=yes,modal=yes,dependent,alwaysRaised");
         var pag = window.open("ControllerServletOpen?portletid=mod_popup_contratos&scriptdo=doAddResumen&ag_n_convoca="+ convocatoria +"&ag_cod_contrato="+ contrato,"Items","toolbar=no,Width=750,Height=220,scrollbars=yes,modal=yes,dependent,alwaysRaised");
       return pag;
    }


    function showResumen(cod_contrato, n_convoca)
    {
        //window.open("portlet5open.asp?_portletid_=mod_ConsolaContratos&scriptdo=doViewResumen&ag_cod_contrato="+cod_contrato+"&ag_n_convoca="+n_convoca,"","toolbar=no,Width=600,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised");
          window.open("ControllerServletOpen?portletid=mod_ConsolaContratos&scriptdo=doViewResumen&ag_cod_contrato="+cod_contrato+"&ag_n_convoca="+n_convoca,"","toolbar=no,Width=600,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised");
    }

    function showTransferencia(cod_contrato, n_convoca, anhoentidad, codconsucode)
    {
        //window.open("portlet5open.asp?_portletid_=mod_ConsolaContratos&scriptdo=doViewTransferencias&ag_cod_contrato="+cod_contrato+"&ag_n_convoca="+n_convoca+"&ag_anhoentidad="+anhoentidad+"&ag_eue_codigo="+codconsucode,"","toolbar=no,Width=800,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised");
          window.open("ControllerServletOpen?portletid=mod_ConsolaContratos&scriptdo=doViewTransferencias&ag_cod_contrato="+cod_contrato+"&ag_n_convoca="+n_convoca+"&ag_anhoentidad="+anhoentidad+"&ag_eue_codigo="+codconsucode,"","toolbar=no,Width=900,Height=500,scrollbars=yes,modal=yes,dependent,alwaysRaised");
    }

    function volver()
    {
        thisform.scriptdo.value = "doView";
        thisform.submit();
    }

    function crear()
    {
        thisform.scriptdo.value = "doNewContrato";
        thisform.submit();
    }
    </script>
    ');
END;

/*******************************************************************************
/ Procedimiento : uspRepResumenContratos
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Jorge Casta¿eda                          Version Inicial
/******************************************************************************/
PROCEDURE usprepresumencontratos (
    ag_n_convoca      VARCHAR2 DEFAULT NULL,
    ag_cod_contrato   VARCHAR2 DEFAULT NULL
)
IS
    cont                      NUMBER;
    etiqueta                  NUMBER;
    ln_monto_reajuste         NUMBER;
    ln_total_reajuste         NUMBER;
    ln_monto_contrato         NUMBER;
    ln_total_contrato         NUMBER;
    ln_monto_sancion          NUMBER;
    ln_total_sancion          NUMBER;
    ln_monto_adicional        NUMBER;
    ln_total_adicional        NUMBER;
    ln_monto_complementario   NUMBER;
    ln_total_complementario   NUMBER;
    ln_monto_prorroga         NUMBER;
    ln_total_prorroga         NUMBER;
    ln_monto_final            NUMBER;
    ls_detalle_sancion        VARCHAR2 (50);

    CURSOR csanciones IS
    SELECT a.penalidad_monto, b.des_sancion
    FROM reg_procesos.sancion a INNER JOIN reg_procesos.tipo_sancion b ON a.cod_sancion = b.cod_sancion
    WHERE a.n_cod_contrato = ag_cod_contrato;

    CURSOR cadicionales IS
    SELECT monto_adicional
    FROM reg_procesos.adicional_reduccion
    WHERE n_cod_contrato = ag_cod_contrato;

    CURSOR ccomplementarios IS
    SELECT m_contratado
    FROM reg_procesos.contrato
    WHERE n_cod_contrato_de_renovac = ag_cod_contrato
    AND cod_operacion_contrato = 6;

    CURSOR cprorrogas IS
    SELECT m_contratado
    FROM reg_procesos.contrato
    WHERE n_cod_contrato_de_renovac = ag_cod_contrato
    AND cod_operacion_contrato = 2;
BEGIN
    -------- Inicializa Reajuste ---
    ln_monto_reajuste := 0;
    etiqueta := 0;
    -------- Campos Ocultos --------
    usp_print (   '<input type="hidden" value='
                 || ag_n_convoca
                 || ' name="ag_n_convoca" >'
                );
    usp_print (   '<input type="hidden" value='
                 || ag_cod_contrato
                 || ' name="ag_cod_contrato" >'
                );

    -------- Consulta -------------
    SELECT COUNT (*)
    INTO cont
    FROM reg_procesos.contrato
    WHERE n_cod_contrato = ag_cod_contrato AND n_convoca = ag_n_convoca;

    IF cont > 0 THEN
        SELECT m_contratado, costo_final INTO ln_monto_contrato, ln_monto_final
        FROM reg_procesos.contrato
        WHERE n_cod_contrato = ag_cod_contrato AND n_convoca = ag_n_convoca;
    ELSE
        ln_monto_contrato := 0;
        ln_monto_final := 0;
    END IF;

    ---------- Cabecera de Ventana-----------
    usp_print ('
    <table border="0" class=tableform cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
        <tr>
            <td><h3>Resumen de Montos del Contrato</h3></td>
        </tr>
    </table>
    <br/>
    <table border="1" class=tableform cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
        <tr>
            <th class="th1" width="70%" align="center">Detalle</th>
            <th class="th1" width="30%" align="center" colspan="2">Monto (S/.)</th>
        </tr>
        <tr>
            <td align="left" width="70%"><B>CONTRATO</B></td>
            <td align="right" width="20%"><b>'
                ||TO_CHAR(ln_monto_contrato, reg_procesos.pku_ss_constantes.gv_formato_dinero)
                ||'<b>
            </td>
            <td align="center" width="10%">&nbsp;</td>
     </tr>');
    /* usp_print('<tr>
            <td align="left" width="70%">Reajuste</td>
            <td align="right" width="20%">'
                ||TO_CHAR(ln_monto_reajuste, reg_procesos.pku_ss_constantes.gv_formato_dinero)||'
            </td>
            <td align="center" width="10%">(+)</td>
      </tr>');*/
    -- Adicionales
    SELECT COUNT (*) INTO cont
    FROM reg_procesos.adicional_reduccion
    WHERE n_cod_contrato = ag_cod_contrato;

    IF cont > 0 THEN
        ln_total_adicional := 0;
        FOR xrow IN cadicionales LOOP
            etiqueta := etiqueta + 1;
            ln_total_adicional := ln_total_adicional + xrow.monto_adicional;
            usp_print('
        <tr>
            <td align="left" width="70%">Adicional-'||TO_CHAR(etiqueta)||'</td>
            <td align="right" width="20%">'||TO_CHAR(xrow.monto_adicional,reg_procesos.pku_ss_constantes.gv_formato_dinero)||'</td>
            <td align="center" width="10%">(+)</td>
        </tr>');
        END LOOP;
    ELSE
        ln_monto_adicional := 0;
        ln_total_adicional := 0;
        usp_print('
        <tr>
            <td align="left" width="70%">Adicional</td>
            <td align="right" width="20%">'||TO_CHAR (ln_monto_adicional,reg_procesos.pku_ss_constantes.gv_formato_dinero)||'</td>
            <td align="center" width="10%">(+)</td>
        </tr>');
    END IF;
    -- Sanciones
    SELECT COUNT (*) INTO cont
    FROM reg_procesos.sancion a INNER JOIN reg_procesos.tipo_sancion b ON a.cod_sancion = b.cod_sancion
    WHERE a.n_cod_contrato = ag_cod_contrato;

    IF cont > 0 THEN
        ln_total_sancion := 0;
        FOR xrow IN csanciones LOOP
            ln_total_sancion := ln_total_sancion + xrow.penalidad_monto;
            usp_print('
        <tr>
            <td align="left" width="70%">Penalidad Econ&oacute;mica - '||xrow.des_sancion||'</td>
            <td align="right" width="20%">'||TO_CHAR(xrow.penalidad_monto,reg_procesos.pku_ss_constantes.gv_formato_dinero)||'</td>
            <td align="center" width="10%">(-)</td>
        </tr>');
        END LOOP;
    ELSE
        ln_monto_sancion := 0;
        ln_total_sancion := 0;
        ls_detalle_sancion := '';
        usp_print('
        <tr>
            <td align="left" width="70%">Penalidad Econ&oacute;mica - '||ls_detalle_sancion||'</td>
            <td align="right" width="20%">'||TO_CHAR(ln_monto_sancion,reg_procesos.pku_ss_constantes.gv_formato_dinero)||'</td>
            <td align="center" width="10%">(-)</td>
        </tr>');
    END IF;
    -- Complementarios
    SELECT COUNT (*) INTO cont
    FROM reg_procesos.contrato
    WHERE n_cod_contrato_de_renovac = ag_cod_contrato AND cod_operacion_contrato = 6;

    IF cont > 0 THEN
        ln_monto_complementario := 0;
        ln_total_complementario := 0;
        FOR xrow IN ccomplementarios LOOP
            usp_print('
        <tr>
            <td align="left" width="70%">Complementario</td>
            <td align="right" width="20%">'||TO_CHAR(xrow.m_contratado,reg_procesos.pku_ss_constantes.gv_formato_dinero)||'</td>
            <td align="center" width="10%">(+)</td>
        </tr>');
            ln_total_complementario := ln_total_complementario + xrow.m_contratado;
        END LOOP;
    ELSE
        ln_monto_complementario := 0;
        ln_total_complementario := 0;
        usp_print('
        <tr>
            <td align="left" width="70%">Complementario</td>
            <td align="right" width="20%">'||TO_CHAR(ln_monto_complementario,reg_procesos.pku_ss_constantes.gv_formato_dinero)||'</td>
            <td align="center" width="10%">(+)</td>
        </tr>');
    END IF;
    -- Prorrogas
    SELECT COUNT (*) INTO cont
    FROM reg_procesos.contrato
    WHERE n_cod_contrato_de_renovac = ag_cod_contrato AND cod_operacion_contrato = 2;

    IF cont > 0 THEN
        ln_monto_prorroga := 0;
        ln_total_prorroga := 0;
        FOR xrow IN ccomplementarios LOOP
            usp_print('
        <tr>
            <td align="left" width="70%">Pr&oacute;rrogas</td>
            <td align="right" width="20%">'||TO_CHAR(xrow.m_contratado,reg_procesos.pku_ss_constantes.gv_formato_dinero)||'</td>
            <td align="center" width="10%">(+)</td>
        </tr>');
            ln_total_prorroga := ln_total_prorroga + xrow.m_contratado;
        END LOOP;
    ELSE
        ln_monto_prorroga := 0;
        ln_total_prorroga := 0;
        usp_print('
        <tr>
            <td align="left" width="70%">Pr&oacute;rrogas</td>
            <td align="right" width="20%">'||TO_CHAR(ln_monto_prorroga,reg_procesos.pku_ss_constantes.gv_formato_dinero)||'</td>
            <td align="center" width="10%">(+)</td>
        </tr>');
    END IF;

    ln_monto_final := (ln_monto_contrato - ln_total_sancion) + ln_total_adicional + ln_total_complementario +  ln_total_prorroga;
    usp_print('
        <tr>
            <td align="right" width="70%"><b>MONTO FINAL</b></td>
            <td align="right" width="20%"><b>'||TO_CHAR(ln_monto_final, reg_procesos.pku_ss_constantes.gv_formato_dinero)||'</b></td>
            <td align="center" width="10%">&nbsp;</td>
        </tr>
    <table>');
END;









/*PROCEDURE uspsancallactualizar (
    ag_cod_contrato             NUMBER default null,
    ag_tiposancion              NUMBER default null,
    ag_penalidad_fecha          VARCHAR2 default null,
    ag_penalidad_moneda         NUMBER default null,
    ag_penalidad_monto          NUMBER default null,
    ag_penalidad_causal         VARCHAR2 default null,
    ag_n_sancion                NUMBER default null,
    ag_sangar_monto             VARCHAR2 default null,
    ag_sangar_nums              VARCHAR2 default null,
    ag_n_convoca                NUMBER default null
    --session__AG_N_CONVOCA       VARCHAR2 default null,
    /*session__AG_COD_CONTRATO    VARCHAR2 default null)
/*IS
    -- datos de la sancion
    ln_cod_contrato       NUMBER;
    ln_cod_sancion        NUMBER;
    lv_penalidad_fecha    VARCHAR2 (20);
    ln_penalidad_moneda   NUMBER;
    ln_penalidad_monto    NUMBER;
    lv_penalidad_causal   VARCHAR2 (500);
    ln_nsancion           NUMBER;
    -- datos del las garantias
    lv_sangar_monto       VARCHAR2 (1000);
    lv_sangar_nums        VARCHAR2 (1000);
    ln_numorden           NUMBER;
    ln_garantia           NUMBER;
    ln_monto              NUMBER;
    -- cursor
    csanciones            ref_cursor;
BEGIN
    -- Javascript
    sp_javascript_contratos;
    -- datos de las sanciones
    ln_cod_contrato     := session__AG_COD_CONTRATO;
    ln_cod_sancion      := ag_tiposancion;
    lv_penalidad_fecha  := ag_penalidad_fecha;
    ln_penalidad_moneda := ag_penalidad_moneda;
    ln_penalidad_monto  := ag_penalidad_monto;
    lv_penalidad_causal := ag_penalidad_causal;
    ln_nsancion         := ag_n_sancion;
    -- datos de las garantias seleccionadas
    lv_sangar_monto     := ag_sangar_monto;
    lv_sangar_nums      := ag_sangar_nums;

    usp_print('Hola pata......!!!');
    return;

    -- Actualizar Sancion
    uspsancionesdoupdate(ln_cod_contrato,ln_cod_sancion,lv_penalidad_fecha,ln_penalidad_moneda,ln_penalidad_monto,lv_penalidad_causal,ln_nsancion);
    -- uso de Garantia en caso sea pku_ss_constantes.gn_sancion_SANCIONECONOMICA
    IF ln_cod_sancion = reg_procesos.pku_ss_constantes.gn_sancion_sancioneconomica THEN
        uspsancgarantdodelete (ln_nsancion);
        csanciones := f_tmp_sanciones (ag_sangar_nums, ag_sangar_monto);
        LOOP FETCH csanciones INTO ln_numorden, ln_garantia, ln_monto;
        EXIT WHEN csanciones%NOTFOUND;
            uspsancgarantdoinsert (ln_nsancion, ln_garantia, ln_monto);
        END LOOP;
    ELSE
        uspsancgarantdodelete (ln_nsancion);
    END IF;

    -- Actualizacion del costo final
    usp_calcula_costofinal (ln_cod_contrato);
    usp_print('
    <input type="hidden" name="ag_cod_contrato" value='||session__AG_COD_CONTRATO||'>
    <input type="hidden" name="ag_n_convoca" value='||session__AG_N_CONVOCA||'>');
    usp_print('
    <script language="javascript">
        goSubmit("doViewPenalidades",document.all(''scriptdo''))
    </script>');
END;*/

/*******************************************************************************
/ Procedimiento : paginar_2
/ Proposito     :
/ Entradas      :
/ Salidas       :
/ Versiones     :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     30-10-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE paginar_2 (
      ag_hreflink       VARCHAR2 DEFAULT '',                        --LINK URL
      ag_currenpage     NUMBER DEFAULT 0,            --NUMERO DE PAGINA ACTUAL
      ag_totalrecords   NUMBER DEFAULT 0,                 --TOTAL DE REGISTROS
      ag_pagesize       NUMBER DEFAULT 0                 --TAMA¿O DE LA PAGINA
   )
   IS
      lv_numeropaginas   INTEGER NOT NULL DEFAULT 0;
      lv_iterador        NUMBER  NOT NULL DEFAULT 0;
      ln_cont            NUMBER           := 0;
      ln_cont_v          NUMBER           := 0;
      ln_cont_t          NUMBER           := 52;
   BEGIN
      lv_numeropaginas := CEIL (ag_totalrecords / ag_pagesize);
      lv_iterador := 1;
      usp_print ('<b>Pagina :</b>');

      LOOP
         IF lv_iterador = ag_currenpage
         THEN
            usp_print
               (   '&nbsp
               <font color="#FFFFFF">
               <b><span style="background-color:#111111">&nbsp;'
                || lv_iterador
                || '&nbsp;</span></b></font>'
               );
         ELSE
            usp_print (   '&nbsp;<a href="'
                       || ag_hreflink
                       || '&ag_currenpage='
                       || lv_iterador
                       || '">'
                       || lv_iterador
                       || '</a>'
                      );
         END IF;

         lv_iterador := lv_iterador + 1;

         IF ln_cont = ln_cont_t
         THEN
            usp_print ('<br>');
            ln_cont := 0;
            ln_cont_v := ln_cont_v + 1;

            IF ln_cont_v = 1  THEN
               ln_cont_t := 47;
            END IF;

            IF ln_cont_v = 2 THEN
               ln_cont_t := 34;
            END IF;
         ELSE
            ln_cont := ln_cont + 1;
         END IF;

         EXIT WHEN lv_numeropaginas < lv_iterador;
      END LOOP;
   END;

/*******************************************************************************
/ Procedimiento : uspIrOperacionDoView
/ Proposito     : Direccionar a la pagina que le corresponde deacuerdo a la
/                 operacion seleccionada para el contrato
/ Entradas      : ag_operacion -> codigo de la operacion del contrato
/                 ag_tipo_op   ->  1: nuevo   2: mantenimiento
/ Salidas       :
/ Versiones     :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     23-10-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE uspiroperaciondoview (
      ag_operacion_va   VARCHAR2 DEFAULT NULL,
      ag_tipo_op        VARCHAR2 DEFAULT NULL,
      ag_n_convoca      VARCHAR2 DEFAULT NULL,
      ag_cod_contrato   VARCHAR2 DEFAULT NULL,
      ag_proc_tipo      VARCHAR2 DEFAULT NULL,
      ag_proc_desc      VARCHAR2 DEFAULT NULL,
      ag_proc_sigla     VARCHAR2 DEFAULT NULL,
      ag_currenpage     VARCHAR2 DEFAULT NULL,
      ag_anhoentidad    VARCHAR2 DEFAULT NULL
   )
   IS
      lv_porletpagenew   VARCHAR2 (120);
      lv_porletpageman   VARCHAR2 (120);
      lv_porletgo        VARCHAR2 (120);
   BEGIN
      -- Javascript
      PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos;
      -- hidden
      usp_print (   '<input type="hidden" name="ag_tipo_op"      value="'
                 || ag_tipo_op
                 || '"></input>'
                );
      usp_print (   '<input type="hidden" name="ag_n_convoca"    value="'
                 || ag_n_convoca
                 || '"></input>'
                );
      usp_print (   '<input type="hidden" name="ag_cod_contrato" value="'
                 || ag_cod_contrato
                 || '"></input>'
                );
      usp_print (   '<input type="hidden" value="'
                 || ag_anhoentidad
                 || '"  name="ag_anhoentidad">'
                );
      usp_print (   '<input type="hidden" value="'
                 || ag_proc_tipo
                 || '"    name="ag_proc_tipo">'
                );
      usp_print (   '<input type="hidden" value="'
                 || ag_proc_desc
                 || '"    name="ag_proc_desc">'
                );
      usp_print (   '<input type="hidden" value="'
                 || ag_proc_sigla
                 || '"   name="ag_proc_sigla">'
                );
      usp_print (   '<input type="hidden" value="'
                 || ag_currenpage
                 || '"   name="ag_currenpage">'
                );

      IF ag_operacion_va IS NOT NULL
      THEN
         SELECT porletnew, porletman
           INTO lv_porletpagenew, lv_porletpageman
           FROM reg_procesos.tipo_op_contratos
          WHERE cod_op_contrato = TO_NUMBER (ag_operacion_va);

         IF ag_tipo_op = 1
         THEN
            lv_porletgo := lv_porletpagenew;
         ELSE
            lv_porletgo := lv_porletpageman;
         END IF;

         usp_print (   '<script languege="javascript">goSubmit('''
                    || lv_porletgo
                    || ''',document.all(''ag_tipo_op''))</script>'
                   );
      END IF;
   END;


/*******************************************************************************
/ Procedimiento : sp_javascript_valida_RUC
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     17-01-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE sp_javascript_valida_ruc
   IS
   BEGIN
      usp_print ('<script language="javascript">');
      usp_print
         ('
function trim(cadena)
  {
  cadena2 = "";
  len = cadena.length;
  for ( var i=0; i <= len ; i++ ) if ( cadena.charAt(i) != " " ){cadena2+=cadena.charAt(i); }
  return cadena2;
  }

function esnulo(campo)
  {
  return (campo == null||campo=="");
  }

function esnumero(campo)
  {
  return (!(isNaN( campo )));
  }

function valruc(valor)
  {
  valor = trim(valor)
  if ( esnumero( valor ) )
    {
    if ( valor.length == 8 )
      {
      suma = 0
      for (i=0; i<valor.length-1;i++)
        {
        digito = valor.charAt(i) - "0";
        if ( i==0 ) suma += (digito*2)
        else suma += (digito*(valor.length-i))
        }
      resto = suma % 11;
      if ( resto == 1) resto = 11;
      if ( resto + ( valor.charAt( valor.length-1 ) - "0" ) == 11 )
        {
        return true
        }
      }
    else if ( valor.length == 11 )
      {
      suma = 0
      x = 6
      for (i=0; i<valor.length-1;i++)
        {
        if ( i == 4 ) x = 8
        digito = valor.charAt(i) - "0";
        x--
        if ( i==0 ) suma += (digito*x)
        else suma += (digito*x)
        }
      resto = suma % 11;
      resto = 11 - resto

      if ( resto >= 10) resto = resto - 10;
      if ( resto == valor.charAt( valor.length-1 ) - "0" )
        {
        return true
        }
      }
    }
  return false
  }

 function ValidaRuc(cc)
 {
  if ( cc.length == 11 )
    {
      return true;}
  else
    {
      alert("El N¿mero de RUC no es v¿lido ...")
      return false;}
 }');

   usp_print ('</script>');

   END;



/*******************************************************************************
/ Procedimiento : sp_javascript_contratos_ficha
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     23-10-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE sp_javascript_contratos_ficha
   IS
   BEGIN
      usp_print ('<script language="javascript">');
      usp_print
         ('

  function OpCalItemInsertNew(pagina,obj,codmoneda,userid){
        if (thisform.ag_fechapago.value=="")
        {
            alert("Ingrese la fecha de pago");
            return 0;
        }
        if (thisform.ag_MONTOPAGO.value=="")
        {
            alert("Ingrese el monto a pagar");
            return 0;
        }

         thisform.ag_fecha_pago.value   = thisform.ag_fechapago.value;
         thisform.ag_monto_pago.value   = thisform.ag_MONTOPAGO.value;
         thisform.ag_codmoneda.value    = codmoneda;
         thisform.ag_userId.value       = userid;
         thisform.scriptdo.value        = "ProcesarInsertTMPCal";
         thisform.submit();

    }

 function OpCalItemInsert(pagina,operacion,obj,codmoneda,userid){
        if (thisform.ag_fechapago.value==""){
            alert("por favor, ingrese la fecha de pago");
            return 0;
        }
        if (thisform.ag_MONTOPAGO.value==""){
            alert("por favor, ingrese el monto a pagar");
            return 0;
        }

        thisform.ag_fecha_pago.value   = thisform.ag_fechapago.value;
        thisform.ag_monto_pago.value   = thisform.ag_MONTOPAGO.value;
        thisform.ag_codmoneda.value    = codmoneda;
        thisform.ag_userId.value       = userid;
        thisform.scriptdo.value        = "ProcesarInsertTMPCal";
        thisform.submit();
        //return;
        //goSubmit(pagina,obj);
    }

 function Escribir(layer_name, htmltext )
  {
  if(document.layers)
    {
    fredlayer = document.layers[layer_name];
    if (fredlayer)
      {
      fredlayer.document.open();
      fredlayer.document.write(htmltext);
      fredlayer.document.close();
      }
    }
   if(document.all)
     {
      fredlayer = document.all[layer_name];
    if (fredlayer)
      {
      fredlayer.innerHTML=htmltext;
      }
    }
  if(!document.all && document.getElementById)
    {
      fredlayer = document.getElementById(layer_name);
    if (fredlayer)
      {
      fredlayer.innerHTML =htmltext;
      }
    }
  }

  function OpItemActualiza(pagina,obj,proc_item,codmodsubasta){

        var controMonto     = thisform + ".ag_item_monto"     + proc_item;
        var controcantidad  = thisform + ".ag_item_cantidad"  + proc_item;
        var controunmcodigo = thisform + ".ag_item_unmcodigo" + proc_item;

        if ( codmodsubasta == 2 || codmodsubasta == 3) {

           if (eval(controMonto + ".value" )==""){
                alert("Por favor ingrese el Monto a pagar modificado ");
                eval(controMonto + ".focus()");
                return;}
           if (eval(controcantidad + ".value" )==""){
                alert("Por favor ingrese la cantidad modificado ");
                eval(controcantidad + ".focus()");
                return;}
           if (eval(controunmcodigo + ".value" )==""){
                alert("Por favor ingrese la unidad de medida modificado ");
                eval(controunmcodigo + ".focus()");
                return;}

         thisform.ag_item_monto.value     = eval(controMonto + ".value" );
         thisform.ag_item_cantidad.value  = eval(controcantidad + ".value" );
         thisform.ag_item_unmcodigo.value = eval(controunmcodigo + ".value" );
         thisform.ag_item_proc_item.value = proc_item;

        }
        goSubmit(pagina,obj);
    }

  function OpCalItemActualizaNew(pagina,obj,fechapago,codmoneda,idfila, numpago,userid,montopago){

        var controMonto = "thisform.ag_montoPAGO" + numpago;
        var controfecha = "thisform.ag_fechapago" + numpago;

        if (eval(controMonto + ".value" )==""){
            alert("Por favor ingrese el Monto a pagar modificado ");
            eval(controMonto + ".focus()");
            return;}

        if (eval(controfecha + ".value" )==""){
            alert("Por favor ingrese la fecha modificado ");
            eval(controfecha + ".focus()");
            return;}

        thisform.ag_monto_pago.value  = eval(controMonto + ".value" );
        thisform.ag_fecha_pago.value  = eval(controfecha + ".value" );
        thisform.ag_codmoneda.value   = codmoneda;
        thisform.ag_idfila.value      = idfila;
        thisform.ag_num_pago.value    = numpago;
        thisform.ag_userId.value      = userid;
        thisform.scriptdo.value       = pagina;
        thisform.submit();
    }
    function OpCalItemActualiza(pagina,obj,operacion,fechapago,codmoneda,idfila, numpago,userid,montopago)
    {


        var controMonto = "thisform .ag_montoPAGO" + numpago + ".value";
        var controfecha = "thisform .ag_fechapago" + numpago + ".value";

        //alert(eval(controMonto));
        //return;

        if (eval(controMonto)=="")
        {
            alert("Por favor ingrese el Monto a pagar modificado ");
            eval(controMonto + ".focus()");
            return;
        }

        thisform.ag_monto_pago.value   = eval(controMonto + ".value" );
        thisform.ag_fecha_pago.value   = eval(controfecha + ".value" );
        thisform.ag_codmoneda.value    = codmoneda;
        thisform.ag_idfila.value       = idfila;
        thisform.ag_id_operacion.value = operacion;
        thisform.ag_num_pago.value     = numpago;
        thisform.ag_userId.value       = userid;
        thisform.scriptdo.value        = pagina;
        thisform.submit();
    }

      function OpCalItemElimina(pagina,obj,operacion,idfila, numpago,userid){

        thisform.ag_idfila.value       = idfila;
        thisform.ag_id_operacion.value = operacion;
        thisform.ag_num_pago.value     = numpago;
        thisform.ag_userId.value       = userid;
        goSubmit(pagina,obj);
    }

     function OpCalItemEliminaNew(pagina,obj,idfila, numpago,userid){

        thisform.ag_idfila.value       = idfila;
        thisform.ag_num_pago.value     = numpago;
        thisform.ag_userId.value       = userid;
        thisform.scriptdo.value        = pagina;
        goSubmit(pagina,obj);
    }

    function OpCalItem(pagina,obj,op,item)
    {
        thisform.ag_calop_numpago.value = item;
        thisform.ag_calop_item.value    = op;
        goSubmit("ManContratosDoEdit",obj);
    }

    function OpItem(pagina,obj,op,item){
        thisform.ag_iproc_item.value = item;
        thisform.ag_iop_item.value   = op;

        goSubmit(pagina,obj);
    }

    function cal_InsertItemRow(pagina,obj,op){

      var seleccion = thisform.ag_proc_item.value;
        if (seleccion=="" )
           {alert("Por favor seleccione Item mediante el bot¿n de b¿squeda")
            return;
           }
/*
       for (var i=2; i<tabla_fin.rows.length ;i++)
      {
        var item = tabla_fin.rows.item(i) ;
        temp = item.cells.item(2).innerHTML.toUpperCase();
        if ( seleccion == temp)
        {repetido = "true";
          alert("Ya ingreso el Item :" + seleccion );
          return;
        }
        }

*/
        thisform.ag_iop_item.value   = op;

        goSubmit(pagina,obj);

    }

'
         );
      usp_print ('</script>');
   END;

/*******************************************************************************
/ Procedimiento : sp_javascript_contratos_Buscador
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     23-10-2007 11:59  Version Inicial
/******************************************************************************/

PROCEDURE sp_javascript_contratos_busca
   IS
   BEGIN
      usp_print ('<script language="javascript">');
      usp_print
         ('
    function retornaItemsCO(pitem,pdesc,pfbcons,pubigeo,pmonto,pcantidad,unm_desc,unm_codigo)
    {

        var wo = window.opener

      window.opener.document.all(''ag_proc_item'').value   = pitem;
      window.opener.document.all(''ag_descripcion'').value = pdesc;
     window.opener.document.all(''ag_f_bp_cons'').value  = pfbcons ;
    window.opener.document.all(''ag_ubigeo'').value     = pubigeo;
    window.opener.document.all(''ag_monto'').value      = pmonto;
    window.opener.document.all(''ag_cantidad'').value   = pcantidad;
    window.opener.document.all(''ag_unidad'').value     = unm_desc;
    window.opener.document.all(''ag_unidad_codigo'').value = unm_codigo;

      //  wo.RtnItem(pitem,pdesc,pfbcons,pubigeo,pmonto,pcantidad,unm_desc,unm_codigo)
       wo.callListadoItemPaquete(pitem,pmonto);
       window.close();

    }

     function retornaItemsCO_v3(pitem,pdesc,pfbcons,pubigeo,pmonto,pcantidad,psc_codigo,psc_des,pmc_codigo,pmc_des, unm_desc,unm_codigo)
    {
     var wo = window.opener
    //    wo.RtnItem_v3(pitem,pdesc,pfbcons,pubigeo,pmonto,pcantidad,unm_desc,unm_codigo,psc_codigo,psc_des,pmc_codigo,pmc_des);


       window.opener.document.all(''ag_proc_item'').value   = pitem;
      window.opener.document.all(''ag_descripcion'').value = pdesc;
     window.opener.document.all(''ag_f_bp_cons'').value  = pfbcons ;
    window.opener.document.all(''ag_ubigeo'').value     = pubigeo;
    window.opener.document.all(''ag_monto'').value      = pmonto;
    window.opener.document.all(''ag_cantidad'').value   = pcantidad;
    window.opener.document.all(''ag_unidad'').value     = unm_desc;
    window.opener.document.all(''ag_unidad_codigo'').value = unm_codigo;
    window.opener.document.all(''ag_sis_des'').value = psc_des;
    window.opener.document.all(''ag_mod_des'').value = pmc_des;
        window.opener.document.all(''ag_sis_cont'').value = psc_codigo;
    window.opener.document.all(''ag_mod_cont'').value = pmc_codigo;


       wo.callListadoItemPaquete(pitem,pmonto);
        window.close();
    }

    function retornaItemsCO2(pitem, pdesc,pfbp,pubigeo,pmonto,pcantidad,punidaddesc,punidad)
    {


        var wo = window.opener
        window.opener.document.all(''ag_proc_item'').value     = pitem;
        window.opener.document.all(''ag_descripcion'').value   = pdesc;
        window.opener.document.all(''ag_f_bp_cons'').value     = pfbp;
        window.opener.document.all(''ag_ubigeo'').value        = pubigeo;
        window.opener.document.all(''ag_monto'').value         = pmonto;
        window.opener.document.all(''ag_unidad'').value        = punidaddesc;
        window.opener.document.all(''ag_cantidad'').value      = pcantidad;
        window.opener.document.all(''ag_unidad_codigo'').value = punidad;

        wo.callListadoItemPaquete(pitem,pmonto);


        window.close();
    }

     function retornaItemsCO2_v3(pitem, pdesc,pfbp,pubigeo,pmonto,pcantidad,punidaddesc,punidad, psc_codigo, psc_desc, pmc_codigo, pmc_desc)
    {

        var wo = window.opener
        window.opener.document.all(''ag_proc_item'').value     = pitem;
        window.opener.document.all(''ag_descripcion'').value   = pdesc;
        window.opener.document.all(''ag_f_bp_cons'').value     = pfbp;
        window.opener.document.all(''ag_ubigeo'').value        = pubigeo;
        window.opener.document.all(''ag_monto'').value         = pmonto;
        window.opener.document.all(''ag_unidad'').value        = punidaddesc;
        window.opener.document.all(''ag_cantidad'').value      = pcantidad;
        window.opener.document.all(''ag_unidad_codigo'').value = punidad;
         window.opener.document.all(''ag_sis_cont'').value = psc_codigo;
          window.opener.document.all(''ag_mod_cont'').value = pmc_codigo;
           window.opener.document.all(''ag_sis_des'').value = psc_desc;
            window.opener.document.all(''ag_mod_des'').value = pmc_desc;

        wo.callListadoItemPaquete(pitem,pmonto);

        window.close();
    }
'
         );
      usp_print ('</script>');
   END;




/*******************************************************************************
/ Procedimiento : f_get_contrato_renov_fcontra
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     25-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_contrato_renov_fcontra (
      ag_ncod_contrato   IN       NUMBER,
      ag_fcontrato       OUT      VARCHAR2,
      ag_fculminacion    OUT      VARCHAR2
   )
      RETURN NUMBER
   IS
   BEGIN
      SELECT TO_CHAR (f_contrato, reg_procesos.pku_ss_constantes.gv_formato_fecha),
             TO_CHAR (f_culminacion, reg_procesos.pku_ss_constantes.gv_formato_fecha)
        INTO ag_fcontrato,
             ag_fculminacion
        FROM reg_procesos.contrato
       WHERE n_cod_contrato_de_renovac = ag_ncod_contrato
         AND f_contrato =  (SELECT MAX (f_contrato)
                            FROM reg_procesos.contrato
                           WHERE n_cod_contrato_de_renovac = ag_ncod_contrato);

      RETURN 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
      WHEN OTHERS
      THEN
         RETURN NULL;
   END;

/*******************************************************************************
/ Procedimiento : f_get_documento_contrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     26-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_documentoscontrato (
      ag_cod_doc_liq      IN       VARCHAR2 DEFAULT NULL,
      ag_doc_url          OUT      VARCHAR2,
      ag_icon_tipo_file   OUT      VARCHAR2,
      ag_doc_nombre       OUT      VARCHAR2
   )
      RETURN NUMBER
   IS
      ln_num_items   NUMBER;
   BEGIN
      SELECT c.doc_url, 
      --t.icon_tipo_file, 
      replace('bootstrap/'||t.icon_tipo_file, 'jpg', 'png') icon_tipo_file,
      c.doc_nombre
        INTO ag_doc_url, ag_icon_tipo_file, ag_doc_nombre
        FROM reg_procesos.convocatoria_doc c, reg_procesos.tipo_archivo t
       WHERE c.cod_tipo_file = t.cod_tipo_file AND c.cod_doc = ag_cod_doc_liq;

      RETURN 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
      WHEN OTHERS
      THEN
         RETURN NULL;
   END;


/*******************************************************************************
/ Procedimiento : f_get_cantItemsEnEjecucion
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     25-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_cantitemsenejecucion (ag_ncod_contrato NUMBER)
      RETURN NUMBER
   IS
      ln_num_items   NUMBER;
   BEGIN
      SELECT COUNT (1)
        INTO ln_num_items
        FROM reg_procesos.item_contrato
       WHERE n_cod_contrato = ag_ncod_contrato AND n_cod_resolucion IS NULL;

      RETURN ln_num_items;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
      WHEN OTHERS
      THEN
         RETURN NULL;
   END;

/*******************************************************************************
/ Procedimiento : f_get_ItemsContratoPropuesta
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     16-11-2007 11:03  Version Inicial
/******************************************************************************/
   FUNCTION f_get_itemscontratopropuesta (
      ag_codconsucode   VARCHAR2,
      ag_n_convoca      NUMBER,
      ag_proc_item      NUMBER,
      ag_n_propuesta    NUMBER
   )
      RETURN ref_cursor
   IS
      lrs_res   ref_cursor;
   BEGIN
      OPEN lrs_res
       FOR
          SELECT NVL (c.n_contrato, 'SIN NUMERO') n_contrato, c.n_propuesta,
                 ict.proc_item, ict.n_convoca, c.m_contratado, ict.monto
            FROM reg_procesos.item_contrato ict,
                 reg_procesos.contrato c,
                 reg_procesos.item_convoca icv
           WHERE ict.n_convoca = icv.n_convoca
             AND ict.proc_item = icv.proc_item
             AND c.n_cod_contrato = ict.n_cod_contrato
             AND c.codconsucode = LPAD (ag_codconsucode, 6, '0')
             AND ict.n_convoca = ag_n_convoca
             AND ict.proc_item = ag_proc_item
             AND c.n_propuesta = ag_n_propuesta;

      RETURN lrs_res;
   END;

/*******************************************************************************
/ Procedimiento : f_get_ciiudesc
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     19-11-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_ciiudesc (ag_cod_ciiu VARCHAR2, ag_esp_ciiu VARCHAR2)
      RETURN VARCHAR2
   IS
      descciiu   VARCHAR2 (250);
   BEGIN
      SELECT ci.ciu_vdesc
        INTO descciiu
        FROM sease.ciiuinei ci
       WHERE ci.ciu_ccodigo = ag_cod_ciiu AND ci.ciu_cespecial = ag_esp_ciiu;

      RETURN descciiu;
   END;


/*******************************************************************************
/ Procedimiento : f_get_ciiu
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     19-11-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE f_get_ciiu (
      ag_n_convoca            VARCHAR2,
      ag_ciu_codigo     OUT   VARCHAR2,
      ag_ciu_especial   OUT   VARCHAR2,
      ag_ciu_desc       OUT   VARCHAR2
   )
   IS
      ln_proc_tipo   NUMBER;
   BEGIN
      SELECT s.proc_tipo
        INTO ln_proc_tipo
        FROM reg_procesos.convocatorias s
       WHERE s.n_convoca = ag_n_convoca;

      SELECT ci.ciu_ccodigo, ci.ciu_cespecial, ci.ciu_vdesc
        INTO ag_ciu_codigo, ag_ciu_especial, ag_ciu_desc
        FROM sease.ciiuinei ci, reg_procesos.convocatorias co
       WHERE ci.ciu_ccodigo = co.codciiu
         AND ci.ciu_cespecial = co.especial
         AND co.n_convoca = ag_n_convoca;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         IF ln_proc_tipo <= 9
         THEN
            usp_print
               ('Error: No se ha encontrado los datos del CIIU de la convocatoria<br>'
               );
         END IF;

         --usp_print(SQLERRM);
         RETURN;
      WHEN OTHERS
      THEN
         usp_print
            ('Error: Al intentar hallar los datos del CIIU de la convocatoria<br>'
            );
         --usp_print(SQLERRM);
         RETURN;
   END;

/*******************************************************************************
/ Procedimiento : f_get_ind_consorcio
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     19-11-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE usp_change_ruc_contratista (
      ag_ruc_contratista              VARCHAR2,
      ag_ruc_destino_pago             NUMBER,
      ag_n_propuesta                  NUMBER,
      ag_ind_consorcio                NUMBER,
      ag_ruc_destino_pago_out   OUT   VARCHAR2,
      ag_ind_consorcio_out      OUT   NUMBER
   )
   IS
      ln_cod_consorcio   NUMBER;

      CURSOR ccursormiembrosc (p_cod_consorcio NUMBER)
      IS
         SELECT c.cod_consorcio, c.nsec_miembro, c.ruc_miembro,
                c.nom_miembro, c.cod_tipo_postor, c.porc_participacion,
                DECODE (c.cod_pais, 0, '', c.cod_pais) cod_pais, p.des_pais
           FROM reg_procesos.consorcio_miembro c
           LEFT OUTER JOIN reg_procesos.t_pais p ON c.cod_pais = p.cod_pais
          WHERE cod_consorcio = p_cod_consorcio;

      ln_ruc_consorcio   NUMBER := 0;
   BEGIN
      --Se le asigna al ruc destino pago el RUC del contratista
      IF (ag_ruc_destino_pago IS NULL)
      THEN
         ag_ruc_destino_pago_out := ag_ruc_contratista;
      END IF;

      IF ag_ind_consorcio = 1
      THEN
         SELECT s.cod_consorcio
           INTO ln_cod_consorcio
           FROM reg_procesos.convocatoria_propuesta s
          WHERE s.n_propuesta = ag_n_propuesta;

         IF ag_ind_consorcio = 1
         THEN
            FOR xrow IN ccursormiembrosc (ln_cod_consorcio)
            LOOP
               IF xrow.ruc_miembro = ag_ruc_contratista THEN
                  ag_ind_consorcio_out := 1;
               END IF;
            END LOOP;

            --Si no encuentra al ruc contratista dentro del consorcio
            IF ln_ruc_consorcio = 0
            THEN
               ag_ind_consorcio_out := 2;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         usp_print
            ('Error: Datos no encontrados al procesar datos del consorcio<br>'
            );
         --usp_print(SQLERRM);
         RETURN;
      WHEN OTHERS
      THEN
         usp_print ('Error: Al procesar datos del consorcio<br>');
         --usp_print(SQLERRM);
         RETURN;
   END;

/*******************************************************************************
/ Procedimiento : f_get_itemsContratos
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     25-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_itemscontratos (ag_ncod_contrato NUMBER)
      RETURN ref_cursor
   IS
      lrs_res   ref_cursor;
   BEGIN
      OPEN lrs_res
       FOR
          SELECT   c.proc_item
              FROM reg_procesos.item_contrato c
             WHERE c.n_cod_contrato = ag_ncod_contrato
          ORDER BY proc_item;

      RETURN lrs_res;
   END;

    /*******************************************************************************
   / Procedimiento : f_get_ncontrato
   / Proposito :
   / Entradas :
   / Salidas:
   / Versiones :
   / Nombre               Fecha y hora      Modificacion
   / -------------------- ----------------  ---------------------
   / Gerardo Millones                          Version Inicial
   /******************************************************************************/
   FUNCTION f_get_datospostorbp (
      ag_n_convoca     IN       NUMBER,
      ag_n_propuesta   IN       NUMBER,
      ag_postorruc     OUT      VARCHAR2,
      ag_postornom     OUT      VARCHAR2
   )
      RETURN NUMBER
   IS
      ln_cont   NUMBER;
   BEGIN
      SELECT COUNT (1)
        INTO ln_cont
        FROM (SELECT DISTINCT convocatoria_propuesta.ruc_postor postor_ruc,
                              convocatoria_propuesta.nom_postor postor_nom
                         FROM reg_procesos.buena_pro,
                              reg_procesos.items_bp,
                              reg_procesos.convocatoria_propuesta
                        WHERE buena_pro.n_convoca = ag_n_convoca
                          AND convocatoria_propuesta.n_propuesta = ag_n_propuesta
                          AND buena_pro.n_buenapro = items_bp.n_buenapro
                          AND items_bp.n_propuesta = convocatoria_propuesta.n_propuesta
                          AND items_bp.monto_adjudicado > 0
                          AND buena_pro.ind_ultimo = 1);

      SELECT DISTINCT convocatoria_propuesta.ruc_postor postor_ruc,
                      convocatoria_propuesta.nom_postor postor_nom
                 INTO ag_postorruc,
                      ag_postornom
                 FROM reg_procesos.buena_pro,
                      reg_procesos.items_bp,
                      reg_procesos.convocatoria_propuesta
                WHERE buena_pro.n_convoca = ag_n_convoca
                  AND convocatoria_propuesta.n_propuesta = ag_n_propuesta
                  AND buena_pro.n_buenapro = items_bp.n_buenapro
                  AND items_bp.n_propuesta = convocatoria_propuesta.n_propuesta
                  AND items_bp.monto_adjudicado > 0
                  AND buena_pro.ind_ultimo = 1;

      RETURN (CASE
                 WHEN ln_cont = 1
                    THEN reg_procesos.pku_ss_constantes.gn_opexito
                 WHEN ln_cont > 1
                    THEN reg_procesos.pku_ss_constantes.gn_operror
                 WHEN ln_cont = 0
                    THEN reg_procesos.pku_ss_constantes.gn_opnodatos
              END
             );
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN reg_procesos.pku_ss_constantes.gn_operror;
      WHEN OTHERS
      THEN
         RETURN reg_procesos.pku_ss_constantes.gn_operror;
   END;

    /*******************************************************************************
   / Procedimiento : f_get_ncontrato
   / Proposito :
   / Entradas :
   / Salidas:
   / Versiones :
   / Nombre               Fecha y hora      Modificacion
   / -------------------- ----------------  ---------------------
   / Gerardo Millones                          Version Inicial
   /******************************************************************************/
   FUNCTION f_get_ncontrato (
      ag_ncodcontrato     IN       VARCHAR2,
      ag_n_convoca        IN       VARCHAR2,
      ag_ncontrato        OUT      VARCHAR2,
      ag_nomcontratista   OUT      VARCHAR2,
      ag_ruccontratista   OUT      VARCHAR2
   )
      RETURN VARCHAR2
   IS
      ln_cont   NUMBER;
   BEGIN
      SELECT COUNT (1)
        INTO ln_cont
        FROM (SELECT DISTINCT c.n_contrato
                         FROM reg_procesos.contrato c,
                              reg_procesos.buena_pro bp,
                              reg_procesos.items_bp ibp
                        WHERE c.n_convoca = ag_n_convoca
                          AND c.n_cod_contrato = ag_ncodcontrato
                          AND bp.n_convoca = c.n_convoca
                          AND bp.n_buenapro = ibp.n_buenapro
                          AND c.ruc_contratista = ibp.postor_ruc);

      IF ln_cont = 1
      THEN
         SELECT DISTINCT c.n_contrato, c.ruc_contratista, ibp.postor_nom
                    INTO ag_ncontrato, ag_ruccontratista, ag_nomcontratista
                    FROM reg_procesos.contrato c,
                         reg_procesos.buena_pro bp,
                         reg_procesos.items_bp ibp
                   WHERE c.n_convoca = ag_n_convoca
                     AND c.n_cod_contrato = ag_ncodcontrato
                     AND bp.n_convoca = c.n_convoca
                     AND bp.n_buenapro = ibp.n_buenapro
                     AND c.ruc_contratista = ibp.postor_ruc;
      END IF;

      RETURN 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
      WHEN OTHERS
      THEN
         RETURN NULL;
   END;

/*******************************************************************************
/ Procedimiento : f_get_itemsAdjudicados
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     25-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_itemsadjudicados (ag_n_convoca NUMBER, ag_codconsucode NUMBER)
      RETURN ref_cursor
   IS
      lrs_res           ref_cursor;
      ln_nconvoca_max   NUMBER;
   BEGIN
      ln_nconvoca_max := reg_procesos.f_get_max_n_convoca (ag_n_convoca);

      OPEN lrs_res
       FOR
          SELECT   itc.n_convoca, itc.unm_codigo, m.unm_desc, itc.proc_item,
                   REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,
                   i.cant_adjudicada cantidad, i.monto_adjudicado monto,
                   suma.suma_cant, suma.suma_monto,
                   CASE suma.suma_monto
                      WHEN suma.suma_monto
                         THEN CASE
                      WHEN (bp.f_registro >=
                                          TO_DATE ('29/05/2007', 'DD/MM/YYYY')
                           )
                         THEN i.monto_adjudicado - suma.suma_monto
                      ELSE i.monto_adjudicado
                   END
                      ELSE i.monto_adjudicado
                   END monto_max,
                   CASE suma.suma_cant
                      WHEN suma.suma_cant
                         THEN CASE
                      WHEN (bp.f_registro >=
                                          TO_DATE ('29/05/2007', 'DD/MM/YYYY')
                           )
                         THEN i.cant_adjudicada - suma.suma_cant
                      ELSE i.cant_adjudicada
                   END
                      ELSE i.cant_adjudicada
                   END cant_max,
                   itc.dep_codigo, itc.pro_codigo, itc.dis_codigo,
                   dep.dep_desc, pro.pro_desc, dis.dis_desc,
                      '['
                   || itc.dep_codigo
                   || itc.pro_codigo
                   || itc.dis_codigo
                   || ']'
                   || '['
                   || itc.dep_codigo
                   || ']'
                   || dep.dep_desc
                   || ' / ['
                   || itc.pro_codigo
                   || ']'
                   || pro.pro_desc
                   || ' / ['
                   || itc.dis_codigo
                   || ']'
                   || dis.dis_desc ubigeo,
                   TO_CHAR (cd.fec_upload, 'dd/mm/yyyy') f_bp_cons,
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
                   LEFT OUTER JOIN (
                   SELECT   c.n_propuesta,
                                   ict.proc_item,
                                   ict.n_convoca,
                                   SUM
                                      (ict.cantidad
                                      )
                                      suma_cant,
                                   SUM
                                      (ict.monto
                                      )
                                      suma_monto
                              FROM reg_procesos.item_contrato ict INNER JOIN reg_procesos.item_convoca icv ON ict.n_convoca =
                                                                                                                icv.n_convoca
                                                                                                         AND ict.proc_item =
                                                                                                                icv.proc_item INNER JOIN reg_procesos.contrato c ON c.n_cod_contrato =
                                                                                                                                                                      ict.n_cod_contrato
                             WHERE c.n_convoca =
                                      ag_n_convoca
                               AND ict.n_convoca =
                                      ln_nconvoca_max
                               AND c.codconsucode !=
                                      LPAD
                                         (ag_codconsucode,
                                          6,
                                          '0'
                                         )
                          GROUP BY c.n_propuesta,
                                   ict.proc_item,
                                   ict.n_convoca) suma ON suma.proc_item =
                                                            i.proc_item
                                                     AND suma.n_propuesta =
                                                            i.n_propuesta
             WHERE itc.n_convoca = ln_nconvoca_max
               AND itc.dep_codigo = dis.dep_codigo
               AND itc.pro_codigo = dis.pro_codigo
               AND itc.dis_codigo = dis.dis_codigo
               AND dis.dep_codigo = pro.dep_codigo
               AND dis.pro_codigo = pro.pro_codigo
               AND pro.dep_codigo = dep.dep_codigo
               AND itc.unm_codigo = m.unm_codigo
               AND c.n_convoca = itc.n_convoca
               AND bp.n_convoca = ag_n_convoca
               AND bp.n_buenapro = i.n_buenapro
               AND itc.proc_item = i.proc_item
               AND i.n_propuesta IN (
                      SELECT DISTINCT convocatoria_propuesta.n_propuesta
                                 FROM reg_procesos.buena_pro,
                                      reg_procesos.items_bp,
                                      reg_procesos.convocatoria_propuesta
                                WHERE buena_pro.n_convoca = ag_n_convoca
                                  AND buena_pro.n_buenapro =
                                                           items_bp.n_buenapro
                                  AND items_bp.n_propuesta =
                                            convocatoria_propuesta.n_propuesta
                                  AND items_bp.monto_adjudicado > 0
                                  AND buena_pro.ind_ultimo = 1)
               AND i.monto_adjudicado > 0
               AND bp.ind_ultimo = 1
               AND cd.cod_tipo_doc = 1600
               AND cd.n_convoca = bp.n_convoca
               AND ice.cod_doc = cd.cod_doc
               AND ice.proc_item = i.proc_item
               AND NOT EXISTS (
                      SELECT iccc.proc_item
                        FROM reg_procesos.contrato c,
                             reg_procesos.item_contrato iccc
                       WHERE c.n_convoca = ag_n_convoca
                         AND c.n_cod_contrato = iccc.n_cod_contrato
                         AND iccc.n_convoca = ln_nconvoca_max
                         AND iccc.proc_item = itc.proc_item
                         AND c.n_propuesta = i.n_propuesta
                         AND c.codconsucode = LPAD (ag_codconsucode, 6, '0'))
          ORDER BY itc.proc_item;

      RETURN lrs_res;
   END;

/*******************************************************************************
/ Procedimiento : uspVerConvocatoriaDoView
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     06-11-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE uspverconvocatoriadoview (
      ag_n_convoca            IN       VARCHAR2,
      ag_codconsucode         OUT      VARCHAR2,
      ag_n_convocaout         OUT      NUMBER,
      ag_codmoneda            OUT      NUMBER,
      ag_anhoentidad          OUT      VARCHAR2,
      ag_proc_tipo            OUT      NUMBER,
      ag_proc_num             OUT      NUMBER,
      ag_proc_sigla           OUT      VARCHAR2,
      ag_proc_tipo_sigla      OUT      VARCHAR2,
      ag_cod_tipo_modalidad   OUT      NUMBER,
      ag_resultado            OUT      NUMBER,
      ag_objeto               OUT      NUMBER
   )
   IS
      ln_cont                 NUMBER;
      ag_n_feerrata           NUMBER;
      ag_n_convoca_origen     varchar2(20);
   BEGIN

      --usp_print('ag_n_convoca en uspverconvocatoriadoview: '||ag_n_convoca);
      --return;

       IF ln_cont > 0 THEN
         SELECT c.codconsucode, c.n_convoca, c.codmoneda,
                c.anhoentidad, c.proc_tipo, c.proc_num, c.proc_sigla,
                t.proc_tipo_sigla,
                NVL (c.cod_tipo_modalidad, 0) cod_tipo_modalidad, c.codobjeto
           INTO ag_codconsucode, ag_n_convocaout, ag_codmoneda,
                ag_anhoentidad, ag_proc_tipo, ag_proc_num, ag_proc_sigla,
                ag_proc_tipo_sigla,
                ag_cod_tipo_modalidad, ag_objeto
           FROM reg_procesos.convocatorias c, reg_procesos.tipo_procesos t
          WHERE c.n_convoca = reg_procesos.f_get_max_n_convoca(ag_n_convoca) AND
                t.proc_tipo = c.proc_tipo;
         ag_resultado := 0;
      ELSE
         ag_resultado := 1;
      END IF;
   END;

/*******************************************************************************
/ Procedimiento : uspVerSancionDoView
/ Proposito :   ver los datos de una sancion
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     06-11-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE uspversanciondoview (
      ag_n_sancion            IN       NUMBER,
      ag_cod_contrato         OUT      NUMBER,
      ag_n_sancionout         OUT      NUMBER,
      ag_cod_sancion          OUT      NUMBER,
      ag_penalidadcodmoneda   OUT      NUMBER,
      ag_penalidad_monto      OUT      NUMBER,
      ag_penalidad_fecha      OUT      VARCHAR2,
      ag_penalidad_causal     OUT      VARCHAR2
   )
   IS
      ln_nsancion   NUMBER;
   BEGIN
      ln_nsancion := ag_n_sancion;

      SELECT n_cod_contrato, n_sancion, cod_sancion,
             penalidad_cod_moneda, penalidad_monto,
             TO_CHAR (penalidad_fecha, reg_procesos.pku_ss_constantes.gv_formato_fecha) penalidad_fecha,
             penalidad_causal
        INTO ag_cod_contrato, ag_n_sancionout, ag_cod_sancion,
             ag_penalidadcodmoneda, ag_penalidad_monto,
             ag_penalidad_fecha,
             ag_penalidad_causal
        FROM reg_procesos.sancion
       WHERE n_sancion = ln_nsancion;
   END;

/*******************************************************************************
/ Procedimiento : f_get_costoFinal
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     14-01-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE usp_calcula_costofinal (ag_ncod_contrato NUMBER)
   IS
      ln_num_items    NUMBER;
      ln_montofinal   NUMBER;
   BEGIN
      SELECT SUM (monto)INTO ln_montofinal
        FROM (

          SELECT s.m_contratado monto FROM reg_procesos.contrato s WHERE s.n_cod_contrato = ag_ncod_contrato

          UNION ALL

          SELECT SUM (NVL (s.m_contratado, 0)) monto FROM reg_procesos.contrato s WHERE cod_operacion_contrato IN (2, 6)AND s.n_cod_contrato_de_renovac = ag_ncod_contrato

          UNION ALL

          SELECT NVL(monto_adicional, 0) monto FROM reg_procesos.adicional_reduccion s WHERE s.n_cod_contrato = ag_ncod_contrato AND ind_adicional_reduccion = 1
/*    UNION ALL

    select SIGN(-1) * NVL(Penalidad_monto ,0) monto
      from reg_procesos.sancion
     where cod_sancion = pku_ss_constantes.gn_sancion_SANCIONECONOMICA
       and n_cod_contrato = ag_ncod_contrato
*/
             );


      UPDATE reg_procesos.contrato s SET s.costo_final = ln_montofinal WHERE s.n_cod_contrato = ag_ncod_contrato;

      COMMIT;

   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         usp_print
            ('Error: No se encontraron datos al actualizar el costo final del contrato'
            );
         usp_print ('<p>' || SQLERRM || '</p>');
         ROLLBACK;
      WHEN OTHERS
      THEN
         usp_print ('Error: Al actualizar el costo Final');
         usp_print ('<p>' || SQLERRM || '</p>');
         ROLLBACK;
   END;

/*******************************************************************************
/ Procedimiento : f_get_cantItemsResueltos
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     25-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_cantitemsresueltos (ag_ncod_contrato NUMBER)
      RETURN NUMBER
   IS
      ln_num_items   NUMBER;
   BEGIN
      SELECT COUNT (1)
        INTO ln_num_items
        FROM reg_procesos.item_contrato
       WHERE n_cod_contrato = ag_ncod_contrato
             AND n_cod_resolucion IS NOT NULL;

      RETURN ln_num_items;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
      WHEN OTHERS
      THEN
         RETURN NULL;
   END;



/*******************************************************************************
/ Procedimiento :   uspVerContratoDoView
/ Proposito :       devuelve los datos de un contrato
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     19-11-2007 12:23  Version Inicial
/******************************************************************************/
   PROCEDURE uspvercontratodoview (
      ag_cod_contrato            IN       varchar2,
      ag_cod_contrato_res        OUT      reg_procesos.contrato.n_cod_contrato%TYPE,
      ag_n_convoca               OUT      reg_procesos.contrato.n_convoca%TYPE,
      ag_item                    OUT      reg_procesos.contrato.n_item%TYPE,
      ag_des_contrato            OUT      reg_procesos.contrato.des_contrato%TYPE,
      ag_ciu_ccodigo             OUT      reg_procesos.contrato.ciu_ccodigo%TYPE,
      ag_ciu_cespecial           OUT      reg_procesos.contrato.ciu_cespecial%TYPE,
      ag_ruc_contratista         OUT      reg_procesos.contrato.ruc_contratista%TYPE,
      ag_ruc_destino_pago        OUT      reg_procesos.contrato.ruc_destino_pago%TYPE,
      ag_nom_destino_pago        OUT      reg_procesos.contrato.nom_destino_pago%TYPE,
      ag_f_contrato              OUT      VARCHAR2,
      ag_codmoneda_contrato      OUT      reg_procesos.contrato.codmoneda_contrato%TYPE,
      ag_m_contratado            OUT      VARCHAR2,
      ag_m_contrato              OUT      VARCHAR2,
      ag_cod_situacion           OUT      reg_procesos.contrato.cod_situacion%TYPE,
      ag_cod_causa_resoucion     OUT      reg_procesos.contrato.cod_causa_resoucion%TYPE,
      ag_f_liquidacion           OUT      VARCHAR2,
      ag_f_intervencion          OUT      VARCHAR2,
      ag_cod_sist_adquisicion    OUT      reg_procesos.contrato.cod_sist_adquisicion%TYPE,
      ag_cod_modalidad_finan     OUT      reg_procesos.contrato.cod_modalidad_finan%TYPE,
      ag_cod_modalidad_alcance   OUT      reg_procesos.contrato.cod_modalidad_alcance%TYPE,
      ag_plazo_real              OUT      reg_procesos.contrato.plazo_real%TYPE,
      ag_mon_codigo              OUT      reg_procesos.contrato.mon_codigo%TYPE,
      ag_mon_desc                OUT      VARCHAR2,
      ag_costo_final             OUT      VARCHAR2,
      ag_cod_sancion             OUT      reg_procesos.contrato.cod_sancion%TYPE,
      ag_penalidad               OUT      VARCHAR2,
      ag_cod_ejec_garantias      OUT      reg_procesos.contrato.cod_ejec_garantias%TYPE,
      ag_observaciones           OUT      reg_procesos.contrato.observaciones%TYPE,
      ag_n_contrato              OUT      reg_procesos.contrato.n_contrato%TYPE,
      ag_codconsucode            OUT      reg_procesos.contrato.codconsucode%TYPE,
      ag_f_vigencia_ini          OUT      VARCHAR2,
      ag_f_vigencia_fin          OUT      VARCHAR2,
      ag_convoca_pad             OUT      VARCHAR2,
      ag_cod_contrato_pad        OUT      VARCHAR2,
      ag_nom_contratista         OUT      reg_procesos.contrato.nom_contratista%TYPE,
      ag_ind_consorcio           OUT      reg_procesos.contrato.ind_consorcio%TYPE,
      ag_n_propuesta             OUT      reg_procesos.contrato.n_propuesta%TYPE,
      ag_cod_tipo_contrato       OUT      reg_procesos.contrato.cod_tipo_contrato%TYPE,
      ag_cod_tipo_postor         OUT      reg_procesos.contrato.cod_tipo_postor%TYPE,
      ag_cod_pais_destino_pago   OUT      reg_procesos.contrato.cod_pais_destino_pago%TYPE,
      ag_des_pais                OUT      reg_procesos.t_pais.des_pais%TYPE,
      ag_cod_tipo_modalidad      OUT      reg_procesos.convocatorias.cod_tipo_modalidad%TYPE,
      ag_id_opereacion           OUT      reg_procesos.contrato.id_operacion%TYPE,
      ag_codentidadpaga          OUT      reg_procesos.contrato.codconsucode_paga%TYPE,
      ag_anhoentidadpaga         OUT      reg_procesos.contrato.anhoentidad_paga%TYPE,
      ag_error                   OUT      NUMBER
   )
   IS
      ln_cod_contrato_in   NUMBER;
   BEGIN

      ln_cod_contrato_in := to_number(ag_cod_contrato);

      --usp_print('ag_cod_contrato en uspvercontratodoview: '||ag_cod_contrato);
      --return;

      SELECT c.n_cod_contrato, c.n_convoca, c.n_item, c.des_contrato,
             c.ciu_ccodigo, c.ciu_cespecial, c.ruc_contratista,
             c.ruc_destino_pago, c.nom_destino_pago,
             TO_CHAR (c.f_contrato, reg_procesos.pku_ss_constantes.gv_formato_fecha)     f_contrato,
             c.codmoneda_contrato,
             c.m_contratado    m_contratado,
             m_contratado,
             c.cod_situacion, c.cod_causa_resoucion,
             TO_CHAR (c.f_liquidacion, reg_procesos.pku_ss_constantes.gv_formato_fecha) f_liquidacion,
             c.fec_intervencion, c.cod_sist_adquisicion,
             c.cod_modalidad_finan, c.cod_modalidad_alcance,
             c.plazo_real, c.mon_codigo, m.mon_desc,
             TO_CHAR (c.costo_final, reg_procesos.pku_ss_constantes.gv_formato_dinero) costo_final,
             c.cod_sancion, c.penalidad, c.cod_ejec_garantias,
             c.observaciones, c.n_contrato, c.codconsucode,
             TO_CHAR (c.f_vigencia_ini, reg_procesos.pku_ss_constantes.gv_formato_fecha)
                                                               f_vigencia_ini,
             TO_CHAR (c.f_vigencia_fin, reg_procesos.pku_ss_constantes.gv_formato_fecha)
                                                               f_vigencia_fin,
             c.codconsucode, LPAD (c.n_convoca, 8, '0') n_convoca_pad,
             LPAD (c.n_cod_contrato, 8, '0') n_cod_contrato_pad,
             TRIM (nom_contratista) nom_contratista, ind_consorcio,
             n_propuesta, cod_tipo_contrato, cod_tipo_postor,
             cod_pais_destino_pago, des_pais, conv.cod_tipo_modalidad,
             c.id_operacion,
             c.codconsucode_paga,
             c.anhoentidad_paga
        INTO ag_cod_contrato_res, ag_n_convoca, ag_item, ag_des_contrato,
             ag_ciu_ccodigo, ag_ciu_cespecial, ag_ruc_contratista,
             ag_ruc_destino_pago, ag_nom_destino_pago,
             ag_f_contrato,
             ag_codmoneda_contrato,
             ag_m_contratado,
             ag_m_contrato,
             ag_cod_situacion, ag_cod_causa_resoucion,
             ag_f_liquidacion,
             ag_f_intervencion, ag_cod_sist_adquisicion,
             ag_cod_modalidad_finan, ag_cod_modalidad_alcance,
             ag_plazo_real, ag_mon_codigo, ag_mon_desc,
             ag_costo_final,
             ag_cod_sancion, ag_penalidad, ag_cod_ejec_garantias,
             ag_observaciones, ag_n_contrato, ag_codconsucode,
             ag_f_vigencia_ini,
             ag_f_vigencia_fin,
             ag_codconsucode, ag_convoca_pad,
             ag_cod_contrato_pad,
             ag_nom_contratista, ag_ind_consorcio,
             ag_n_propuesta, ag_cod_tipo_contrato, ag_cod_tipo_postor,
             ag_cod_pais_destino_pago, ag_des_pais, ag_cod_tipo_modalidad,
             ag_id_opereacion,
             ag_codentidadpaga,
             ag_anhoentidadpaga
        FROM sease.moneda m,
        reg_procesos.convocatorias conv,
        reg_procesos.contrato c
        LEFT OUTER JOIN reg_procesos.t_pais tp  ON tp.cod_pais = c.cod_pais_destino_pago
        WHERE c.mon_codigo = m.mon_codigo
        AND c.n_convoca = conv.n_convoca
        AND c.n_cod_contrato = ln_cod_contrato_in;

        ag_error := reg_procesos.pku_ss_constantes.gn_opexito;

   EXCEPTION
      WHEN OTHERS
      THEN
         ag_error := reg_procesos.pku_ss_constantes.gn_operror;
         usp_print ('Datos del contrato no encontrados.............!!!!');
         usp_print ('<br>' || SQLERRM);
         usp_print ('<br>variables:');
         usp_print ('<br>Codigo del contrato:' || ag_cod_contrato || '');
         RETURN;
   END;



/*******************************************************************************
/ Procedimiento : f_cRucs_contrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     25-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_crucs_contrato (ag_n_convoca NUMBER)
      RETURN ref_cursor
   IS
      lrs_res   ref_cursor;
   BEGIN
      OPEN lrs_res
       FOR
          SELECT DISTINCT convocatoria_propuesta.ruc_postor postor_ruc,
                          convocatoria_propuesta.nom_postor postor_nom,
                          convocatoria_propuesta.n_propuesta
                     FROM reg_procesos.buena_pro,
                          reg_procesos.items_bp,
                          reg_procesos.convocatoria_propuesta
                    WHERE buena_pro.n_convoca  = ag_n_convoca
                      AND buena_pro.n_buenapro = items_bp.n_buenapro
                      AND items_bp.n_propuesta = convocatoria_propuesta.n_propuesta
                      AND buena_pro.ind_ultimo = 1
                      AND items_bp.monto_adjudicado > 0;

      RETURN lrs_res;
   END;


/*******************************************************************************
/ Procedimiento : f_get_validaIngContrato
/ Proposito :   Verificar si se registro el resumen
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     9-01-2007 11:59  Version Inicial
/******************************************************************************/
/*revizar*/
   FUNCTION f_get_validaingcontrato (
      ag_nconvoca       NUMBER,
      ag_proc_tipo      NUMBER,
      ag_codconsucode   NUMBER
   )
      RETURN NUMBER
   IS
      ln_cant_cont      NUMBER;
      ln_cant_resumen   NUMBER;
      ln_proc_tipo      NUMBER;
   BEGIN
      ln_proc_tipo := ag_proc_tipo;

      -- Verificamos si existe algun contrato registrado
      SELECT COUNT (1)
        INTO ln_cant_cont
        FROM reg_procesos.contrato
       WHERE n_convoca = ag_nconvoca AND codconsucode = ag_codconsucode;

      IF ln_cant_cont = 0
      THEN
         IF ln_proc_tipo IN
               (reg_procesos.pku_ss_constantes.gn_tipo_proceso_lp,
                reg_procesos.pku_ss_constantes.gn_tipo_proceso_cp,
                reg_procesos.pku_ss_constantes.gn_tipo_proceso_adp,
                reg_procesos.pku_ss_constantes.gn_tipo_proceso_ads,
                reg_procesos.pku_ss_constantes.gn_tipo_proceso_amc
               )
         THEN
            -- Verificamos si existe registrado el resumen del contrato
            SELECT COUNT (1)
              INTO ln_cant_resumen
              FROM reg_procesos.convocatoria_doc
             WHERE cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_contrato
               AND n_convoca = ag_nconvoca;

            IF ln_cant_resumen = 0
            THEN
               RETURN 1;
            ELSE
               RETURN 0;
            END IF;
         ELSE
            RETURN 0;
         END IF;
      ELSE
         RETURN 0;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         usp_print
            ('<p>No se encontro datos, al tratar de verificar la existencia del resumen del contrato</p>'
            );
         usp_print ('<p>' || SQLERRM || '</p>');
         RETURN reg_procesos.pku_ss_constantes.gn_operror;
      WHEN OTHERS
      THEN
         usp_print
            ('<p>Error al tratar de verificar la existencia del resumen del contrato</p>'
            );
         usp_print ('<p>' || SQLERRM || '</p>');
         RETURN reg_procesos.pku_ss_constantes.gn_operror;
   END;

/*******************************************************************************
/ Procedimiento : f_get_contratos
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     28-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_contratos (
      ag_n_convoca      IN       NUMBER,
      ag_codconsucode   IN       NUMBER,
      session__userid   IN       VARCHAR2,
      ag_count          OUT      NUMBER
   )
      RETURN ref_cursor
   IS
      lrs_res   ref_cursor;
   BEGIN
      -- Numero de filas
      SELECT COUNT (1)
        INTO ag_count
        FROM reg_procesos.contrato c,
             reg_procesos.convocatorias conv,
             reg_procesos.entidades e
       WHERE c.n_convoca = ag_n_convoca
         AND c.n_convoca = conv.n_convoca
         AND c.codconsucode = e.codconsucode
         AND c.anhoentidad = e.anhoentidad
         AND c.n_cod_contrato_de_renovac IS NULL
       /*  AND (   c.codconsucode = ag_codconsucode
              OR sease.f_is_grant_to_rol (session__userid,'ADM_PROC_SEL_MONITOREO') = 1 )*/;

      OPEN lrs_res
       FOR
          SELECT DISTINCT ROWNUM num, e.descripcion desc_entidad,
                          c.des_contrato, c.n_cod_contrato,
                          LPAD (c.n_convoca, 8, '0') n_convoca_pad,
                          LPAD (c.n_cod_contrato, 8, '0') n_cod_contrato_pad,
                          c.codconsucode, cod_condicion,
                          c.cod_documento_liquidacion, c.ruc_contratista,
                          CASE WHEN SUBSTR(c.ruc_contratista,0,1)='C' THEN
                             (select nom_postor from reg_procesos.convocatoria_propuesta
                                  where ruc_postor = c.ruc_contratista and n_convoca  = c.n_convoca)
                          ELSE c.nom_contratista
                          END postor,
                          TO_CHAR(c.f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha ) f_contrato,
                          TO_CHAR(c.m_contratado,reg_procesos.pku_ss_constantes.gv_formato_dinero ) m_contratado,
                          f_liquidacion, estado_rnp, c.fec_intervencion,
                          conv.des_objeto, conv.proc_tipo, conv.codobjeto,
                          conv.proc_sigla, tp.proc_tipo_sigla,
                          nvl(c.ind_contrato_pub,0) ind_contrato_pub, 
                          c.f_registro -- Jcerda req MEF 19/10/2015
                     FROM reg_procesos.contrato c,
                          reg_procesos.convocatorias conv,
                          reg_procesos.entidades e,
                          reg_procesos.tipo_procesos tp
                    WHERE c.n_convoca = ag_n_convoca
                      AND c.n_convoca = conv.n_convoca
                      AND c.codconsucode = e.codconsucode
                      AND c.anhoentidad = e.anhoentidad
                      AND conv.proc_tipo = tp.proc_tipo
                      AND c.n_cod_contrato_de_renovac IS NULL
                  /*    AND (   c.codconsucode = ag_codconsucode
                           OR sease.f_is_grant_to_rol (session__userid,'ADM_PROC_SEL_MONITOREO' ) = 1  )*/

                 ORDER BY e.descripcion, c.n_cod_contrato;

      RETURN lrs_res;
   END;

/*******************************************************************************
/ Procedimiento : f_getfechasContrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     28-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_fechasprorroga (
      ag_ncodcontrato      IN       NUMBER,
      ag_fec_contrato      OUT      DATE,
      ag_fec_culminacion   OUT      DATE
   )
      RETURN NUMBER
   IS
   BEGIN
      SELECT f_contrato, f_culminacion
        INTO ag_fec_contrato, ag_fec_culminacion
        FROM reg_procesos.contrato
       WHERE n_cod_contrato_de_renovac = ag_ncodcontrato
         AND f_contrato = (SELECT MAX (f_contrato)
                             FROM reg_procesos.contrato
                            WHERE n_cod_contrato_de_renovac = ag_ncodcontrato);

      RETURN 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
      WHEN OTHERS
      THEN
         RETURN NULL;
   END;

/*******************************************************************************
/ Procedimiento : f_get_contratoResultadoTX
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     28-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_contratoresultadotx (ag_cod_contrato NUMBER)
      RETURN ref_cursor
   IS
      lrs_res   ref_cursor;
   BEGIN
      OPEN lrs_res
       FOR
          SELECT   a.id_operacion id_transaccion,
                      tp.proc_tipo_sigla
                   || '-'
                   || cnv.proc_num
                   || '-'
                   || cnv.anhoentidad
                   || '-'
                   || cnv.proc_sigla id_proceso,
                      c.codconsucode
                   || '-'
                   || LPAD (c.n_convoca, 8, '0')
                   || '-'
                   || LPAD (c.n_cod_contrato, 8, '0') id_contrato,
                   a.ind_modificacion cod_operacion,
                   DECODE (a.ind_modificacion,
                           1, 'nuevo',
                           2, 'modif.'
                          ) des_operacion,
                   a.cod_operacion_contrato id_motivo,
                   TO_CHAR
                       (a.fec_operacion,
                        reg_procesos.pku_ss_constantes.gv_formato_fecha_hora
                       ) fec_operacion,
                   DECODE (a.cod_operacion_contrato,
                           1, a.n_cod_contrato,
                           2, a.n_cod_contrato_prorroga,
                           3, a.cod_adicional,
                           4, a.cod_adicional,
                           5, a.cod_adicional
                          ) id_operacion,
                   a.cod_estado_transferencia,
                   tt.des_estado_transferencia des_estado_transferencia,
                   TO_CHAR
                      (a.fec_transferencia,
                       reg_procesos.pku_ss_constantes.gv_formato_fecha_hora
                      ) fec_transferencia,
                   a.xml_data, a.usu_creacion, a.ip_creacion,
                   LOWER (toc.des_operacion_contrato) des_operacion_contrato,
                   UPPER (a.usuario_transfer) usuario_transfer
              FROM reg_procesos.contrato_operacion a,
                   reg_procesos.contrato c,
                   reg_procesos.convocatorias cnv,
                   reg_procesos.t_tipo_estado_transf tt,
                   reg_procesos.tipo_procesos tp,
                   reg_procesos.tipo_operacion_contrato toc
             WHERE a.n_cod_contrato = c.n_cod_contrato
               AND c.n_convoca = cnv.n_convoca
               AND cnv.proc_tipo = tp.proc_tipo
               AND a.cod_operacion_contrato = toc.cod_operacion_contrato
               AND c.n_cod_contrato = ag_cod_contrato
               AND tt.cod_estado_transferencia = a.cod_estado_transferencia
          ORDER BY a.id_operacion;

      RETURN lrs_res;
   END;

/*******************************************************************************
/ Procedimiento : f_get_contrato_MensajeError_TX
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     28-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_contratomensajeerrortx (ag_idtx NUMBER, ag_showerror NUMBER)
      RETURN VARCHAR2
   IS
      lv_descerror   VARCHAR2 (500);
      lrs_res        ref_cursor;
   BEGIN
      SELECT    '( '
             || TO_CHAR (a.fec_transferencia,
                         reg_procesos.pku_ss_constantes.gv_formato_fecha_hora
                        )
             || ' ) '
             || a.des_error des_error
        INTO lv_descerror
        FROM reg_procesos.contrato_operacion_error a
       WHERE a.id_operacion = ag_idtx AND ag_showerror = 1;

      RETURN lv_descerror;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN NULL;
      WHEN OTHERS
      THEN
         RETURN NULL;
   END;

/*******************************************************************************
/ Procedimiento : f_get_EstadoContrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     28-10-2007 11:59  Version Inicial
/******************************************************************************/
   FUNCTION f_get_estadocontrato (
      f_contrato_pro      IN   DATE,
      f_culminacion_pro   IN   DATE,
      f_liquidacion       IN   DATE,
      fec_intervencion    IN   DATE,
      cant_items          IN   VARCHAR2,
      cant_items2         IN   VARCHAR2
   )
      RETURN VARCHAR2
   IS
      lv_estado   VARCHAR2 (250) := 'EN EJECUCION';
   BEGIN
/*
usp_print('<br>f_contrato_pro:'||f_contrato_pro);
usp_print('<br>f_culminacion_pro:'||f_culminacion_pro);
usp_print('<br>f_liquidacion:'||f_liquidacion);
usp_print('<br>fec_intervencion:'||fec_intervencion);
usp_print('<br>cant_items:'||cant_items);
usp_print('<br>cant_items2:'||cant_items2);
*/
      IF f_liquidacion IS NOT NULL
      THEN
         lv_estado := 'CONTRATO LIQUIDADO';
      ELSIF (cant_items != 0 AND cant_items2 != 0)
      THEN
         lv_estado :=
               cant_items
            || 'ITEM(s) RESUELTO(s)'
            || cant_items2
            || 'ITEM(s) EN EJECUCION';
      ELSIF (cant_items != 0 AND cant_items2 = 0)
      THEN
         lv_estado := cant_items || 'ITEM(s) RESUELTO(s)';
      ELSIF (   (fec_intervencion IS NOT NULL AND f_contrato_pro IS NULL)
             OR (TRUNC (fec_intervencion) > TRUNC (f_contrato_pro))
            )
      THEN
         lv_estado := 'CON INTERVENCION ECONOMICA';
      ELSIF (   (f_contrato_pro IS NOT NULL AND fec_intervencion IS NULL)
             OR (TRUNC (f_contrato_pro) > TRUNC (fec_intervencion))
            )
      THEN
         lv_estado :=
               'PRORROGADO del '
            || TO_CHAR (f_contrato_pro, reg_procesos.pku_ss_constantes.gv_formato_fecha)
            || ' al '
            || TO_CHAR (f_culminacion_pro, reg_procesos.pku_ss_constantes.gv_formato_fecha);
      END IF;

      RETURN lv_estado;
   END;


procedure usp_documento(
    session__filesingedhttp   VARCHAR2 DEFAULT NULL,
    vi_n_convoca number )
is
     cursor cdocs(pn_convoca in number) is
            select *
            from(
                select
                cd.doc_url archivo,
                --tipo_archivo.icon_tipo_file,
                replace('bootstrap/'||tipo_archivo.icon_tipo_file, 'jpg', 'png') icon_tipo_file,
                (cd.tamano_bytes) tamano,
                cd.fec_upload fecha_creacion,
                cd.nro_doc,
                cd.fec_aprob,
                cd.user_upload

                from
                reg_procesos.convocatoria_doc cd
                inner join reg_procesos.tipo_archivo on (cd.cod_tipo_file=tipo_archivo.cod_tipo_file)
                where cd.cod_tipo_doc = 600
                and cd.n_cod_contrato is null
                and cd.n_convoca = pn_convoca
                order by cd.fec_upload desc
                )
            where  rownum = 1;

   ls_titulo       varchar2(500);
    ls_detalle   varchar2(10000);
    cant_cols number;

begin


    ls_titulo := ls_titulo||'<th class=th1>Archivo de Contrato</th>';

       cant_cols:=2;

   /*   for xid in cdocs(vi_n_convoca)loop
                usp_print ('
                <a target="_blank" href="'||session__FileSingedHTTP||xid.archivo||'"><img src="'||xid.icon_tipo_file||'" width="30" height="30" border="0"><br>'||to_char(xid.fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b><br>Tama¿o <br>'||to_char(xid.tamano,'999,999,999')||' Kb.<br></b>');
            end loop;
  */

    for i_docs in cdocs(vi_n_convoca)loop


            ls_detalle:=ls_detalle||'<b>Documento : '||i_docs.nro_doc||'</b> <br>';
            ls_detalle:=ls_detalle||'Fecha del Documento : '||i_docs.fec_aprob||' <br>';
            ls_detalle:=ls_detalle||'Nombre del Usuario : '||i_docs.user_upload||' <br>';
           -- ls_detalle:=ls_detalle||'<a target="_blank" href="'||session__FileSingedHTTP||i_docs.archivo||'"><img src="'||i_docs.icon_tipo_file||'" width="30" height="30" border="0"><br>'||to_char(i_docs.fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b><br>Tama¿o <br>'||to_char(i_docs.tamano,'999,999,999')||' Kb.<br></b>';
           -- ls_detalle:=ls_detalle||'<a target="_blank"  href="DownloadFileServlet?fileName='||i_docs.archivo||'"><img src="'||i_docs.icon_tipo_file||'" width="30" height="30" border="0"><br>'||to_char(i_docs.fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b><br>Tamaño <br>'||to_char(i_docs.tamano,'999,999,999')||' Kb.<br></b>';
           -- MMAUTINO: VISUALIZACION DE DOCUMENTOS DE CONTRATOS QUE NO TIENEN N_COD_CONTRATO
           -- ls_detalle:=ls_detalle||'<a target="_blank" href="'||'http://'||reg_procesos.f_get_conexiones(10)||'/'||i_docs.archivo||'"><img src="'||i_docs.icon_tipo_file||'" width="30" height="30" border="0"><br>'||to_char(i_docs.fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b><br>Tamaño <br>'||to_char(i_docs.tamano,'999,999,999')||' Kb.<br></b>';

           --INICIO
           ls_detalle:=ls_detalle||'
           <a target="_blank" href="'||'http://'||reg_procesos.f_get_conexiones(10)||'/'||replace(i_docs.archivo,' ','%20')||'">
           <img src="'||i_docs.icon_tipo_file||'" width="30" height="30" border="0"><br>'||to_char(i_docs.fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b><br>Tamaño <br>'||to_char(i_docs.tamano,'999,999,999')||' Kb.<br></b>';
           --FIN

     end loop;

     usp_print('<tr>');
    usp_print('<table border=0 width=100% class=tableform  cellpadding=3px cellspacing=0px>');
    usp_print('<tr>');
    usp_print(ls_titulo);
    usp_print('</tr>');
    usp_print('<tr>');


        usp_print('<td valign=top width="'||(100/cant_cols)||'%">');
        usp_print(ls_detalle);
        usp_print('</td></tr></table></tr>');

end;
/*******************************************************************************
/ Procedimiento : uspListContratosDoView
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                          Version Inicial
/******************************************************************************/
PROCEDURE usplistcontratosdoview (
    ag_n_convoca              VARCHAR2 DEFAULT NULL,
    an_codconsucode           VARCHAR2 DEFAULT NULL,
    ag_anhoentidad            VARCHAR2 DEFAULT NULL,
    session__userid           VARCHAR2 DEFAULT NULL,
    ag_proc_tipo              VARCHAR2 DEFAULT NULL,
    ag_proc_desc              VARCHAR2 DEFAULT NULL,
    ag_proc_sigla             VARCHAR2 DEFAULT NULL,
    ag_currenpage             VARCHAR2 DEFAULT NULL,
    session__eue_codigo       VARCHAR2 DEFAULT NULL,
    session__anhoentidad      VARCHAR2 DEFAULT NULL,
    session__filesingedhttp   VARCHAR2 DEFAULT NULL,
    convoca                   VARCHAR2 DEFAULT '',
    contrato                  VARCHAR2 DEFAULT '',
    control_sesion            NUMBER   DEFAULT 0,
    av_ind_resumen            VARCHAR  DEFAULT NULL,
    session__n_convoca        VARCHAR  DEFAULT NULL,
    session__seacedocument    VARCHAR2  DEFAULT NULL)
IS
    -- Items del contrato
    CURSOR citemscontrato (p_ncod_contrato IN NUMBER)
    IS
       SELECT TRIM(TO_CHAR (c.proc_item, reg_procesos.pku_ss_constantes.gv_constante_numerico)) proc_item
           FROM reg_procesos.item_contrato c
          WHERE c.n_cod_contrato = p_ncod_contrato
       ORDER BY proc_item;

      -- Resumen de los Contratos

      cursor cdocs2(pn_convoca in number, pn_contrato in number) is
      select replace(cd.doc_url, '\', '/') archivo,
             --tipo_archivo.icon_tipo_file,
             replace('bootstrap/'||tipo_archivo.icon_tipo_file, 'jpg', 'png') icon_tipo_file,
             (cd.tamano_bytes) tamano,
             cd.fec_upload fecha_creacion
        from reg_procesos.convocatoria_doc cd
  inner join reg_procesos.tipo_archivo on (cd.cod_tipo_file=tipo_archivo.cod_tipo_file)
       where cd.cod_tipo_doc = 600
         and cd.n_convoca = pn_convoca
         and cd.n_cod_contrato = pn_contrato
       order by cd.fec_upload desc ;


      -- Datos de la pantalla
      ln_nconvoca                    NUMBER;
      ln_codconsucode                NUMBER;
      ln_anhoentidad                 VARCHAR2 (20);
      ln_contcontratos               NUMBER;
      lv_estilo_fila                 VARCHAR2 (50);
      ln_num_fila                    NUMBER;
      -- Cursores
      ccontratos                     ref_cursor;
      -- Items del contrato
      ln_numitemscontrato            NUMBER;
      ln_draw_coma                   NUMBER;
      -- Datos de los contratos
      lv_desc_entidad                VARCHAR2 (120);
      lv_des_contrato                VARCHAR2 (500);
      ln_n_cod_contrato              NUMBER;
      ln_n_convoca_pad               VARCHAR2 (20);
      ln_n_cod_contrato_pad          VARCHAR2 (20);
      ln_codconsucode_cursor         VARCHAR2 (6);
      ln_cod_condicion               NUMBER;
      ln_cod_documento_liquidacion   VARCHAR2 (20);
      lv_ruc_contratista             VARCHAR2 (11);
      lv_nom_contratista             VARCHAR2 (2000);
      lv_f_contrato                  VARCHAR2 (20);
      lv_m_contratado                VARCHAR2 (40);
      lv_estado_rnp                  VARCHAR2 (500);
      lv_fintervenvion               VARCHAR2 (20);
      ld_fliquidacion                DATE;
      lv_descconv                    VARCHAR2 (320);
      ln_proctipo                    NUMBER;
      lv_procsigla                   VARCHAR2 (20);
      lv_proc_tiposigla              VARCHAR2 (20);
      ln_objeto_convoca              NUMBER;
      ln_indPubContratos             NUMBER;
      -- Datos de los items
      ln_items_resueltos             NUMBER;
      ln_items_en_ejecucion          NUMBER;
      -- Datos de fechas del contrato
      ld_fec_contrato                DATE;
      ld_fec_culimnacion             DATE;
      ln_dummy                       NUMBER;
      ln_estado                      NUMBER;
      ln_contador_loop               NUMBER;
      ln_tabulacion_item             NUMBER;
      lv_doc_url                     reg_procesos.convocatoria_doc.doc_url%TYPE;
      lv_icon_tipo_file              reg_procesos.tipo_archivo.icon_tipo_file%TYPE;
      lv_tamano                      reg_procesos.convocatoria_doc.tamano_bytes%TYPE;
      lv_fecha_creacion              reg_procesos.convocatoria_doc.fec_upload%TYPE;

      ln_cant_doc                    NUMBER;
      ln_moneda_conv                 NUMBER;
      valida_arbitro                   NUMBER; 

      ld_f_registro                  date; -- Jcerda req MEF 19/10/2015  

--cambios arbitro nueva ley
    cursor cValidaUser is
    select count(a.usu_codigo) cvalidauser1  from sease.usuario a
    where trim(a.usu_codigo) = trim(session__userid)
    and usu_activo = 1
    and usu_tipo = 3;

    n_cvalidauser number;

BEGIN
--cambios arbitro nueva ley
for a1 in cValidaUser loop
  n_cvalidauser:=a1.cvalidauser1;
end loop;
--- usp_print('ag_n_convoca:'||ag_n_convoca);
    -- Javascript
    PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos;

    -- Datos de la pantalla
    ln_nconvoca      := nvl(ag_n_convoca,session__n_convoca);
    ln_codconsucode  := session__eue_codigo;
    ln_anhoentidad   := nvl(ag_anhoentidad, session__anhoentidad);

    SELECT CODMONEDA INTO  ln_moneda_conv FROM REG_PROCESOS.CONVOCATORIAS WHERE N_CONVOCA = ln_nconvoca;

    usp_print ('<SESSION_EXPORT>
                    <N_CONVOCA>'||ln_nconvoca||'</N_CONVOCA>
                    <AG_COD_CONTRATO>'||NULL||'</AG_COD_CONTRATO>
                    <COD_CONTRATO>'||NULL||'</COD_CONTRATO>
                  <COD_MONEDA>'||ln_moneda_conv||'</COD_MONEDA>
                </SESSION_EXPORT>');

    /*
    usp_print ('<SESSION_EXPORT>
                    <AG_N_CONVOCA>'||ln_nconvoca||'</AG_N_CONVOCA>
                    <N_CONVOCA>'||ln_nconvoca||'</N_CONVOCA>
                    <AG_COD_CONTRATO>'||NULL||'</AG_COD_CONTRATO>
                    <COD_CONTRATO>'||NULL||'</COD_CONTRATO>
                  <COD_MONEDA>'||ln_moneda_conv||'</COD_MONEDA>
                </SESSION_EXPORT>');
                */
    -- Ocultos
    usp_print ('<input type="hidden" name="av_ind_resumen"         value="'||av_ind_resumen||'">');
    usp_print ('<input type="hidden" name="ag_n_convoca"           value="'||ln_nconvoca||'">');
    usp_print ('<input type="hidden" name="ag_cod_contrato"        value="">');
    usp_print ('<input type="hidden" name="ag_operacion_va"        value="">');
    usp_print ('<input type="hidden" name="ag_tipo_op"             value="1">');
    usp_print ('<input type="hidden" name="an_codconsucode"        value='||ln_codconsucode||'>');
    usp_print ('<input type="hidden" name="ag_eue_codigo"          value="'||ln_codconsucode||'">');
    usp_print ('<input type="hidden" name="ag_anhoentidad"         value="'||ln_anhoentidad||'">');
    usp_print ('<input type="hidden" name="ag_proc_tipo"           value="'||ag_proc_tipo||'">');
    usp_print ('<input type="hidden" name="ag_proc_desc"           value="'||ag_proc_desc||'">');
    usp_print ('<input type="hidden" name="ag_proc_sigla"          value="'|| ag_proc_sigla||'">');
    usp_print ('<input type="hidden" name="ag_currenpage"          value="'||ag_currenpage||'">');
    usp_print ('<input type="hidden" name="ag_ncor_orden_pedido"   value="">');
    usp_print ('<input type="hidden" name="ag_cm_opc"              value="">');
    usp_print ('<input type="hidden" name="ag_cm_oper_compra"      value="">');
    usp_print ('<input type="hidden" name="contrato"               value="'||contrato||'">');
    usp_print ('<input type="hidden" name="convoca"                value="'||convoca||'">');

    -- inicializamos los cursores
    ccontratos := f_get_contratos( ln_nconvoca, ln_codconsucode, session__userid, ln_contcontratos );

        select count(1) into ln_cant_doc
            from(
                select
                cd.doc_url,
                --tipo_archivo.icon_tipo_file,
                replace('bootstrap/'||tipo_archivo.icon_tipo_file, 'jpg', 'png') icon_tipo_file,
                (cd.tamano_bytes) tamano,
                cd.fec_upload
                from
                reg_procesos.convocatoria_doc cd
                inner join reg_procesos.tipo_archivo on (cd.cod_tipo_file=tipo_archivo.cod_tipo_file)
                where cd.cod_tipo_doc = 600
                and cd.n_cod_contrato is null
                and cd.n_convoca = ln_nconvoca
                order by cd.fec_upload desc
                )
            where  rownum = 1;

    usp_print('

    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">
        <tr>');
    usp_print( reg_procesos.PKU_PROCESOS_COMUN.f_get_titulo ( ln_nconvoca, 'Consola de Contratos') );

            usp_print('<td align="right" valign=top width="50%">
                       <input type="button" name="g" value="Volver" OnClick="volver()"/>&nbsp;&nbsp;');
            if (n_cvalidauser = 0) then --No aparece boton si es Arbitro - ddrodriguez
                usp_print('<input type="button" name="h" value="Crear Contrato" OnClick="crear()"/>');
            end if;
            usp_print('</td>
        </tr>
    </table>
        ');

     if ln_cant_doc > 0 then
      usp_print('
      <table border="0" width=100% align=center class="table table-striped" cellpadding=3 cellspacing=0>');
                usp_documento(session__filesingedhttp,ln_nconvoca);
                usp_print ('
        <TR>
            <TD COLSPAN="3" class=c1b>&nbsp;</TD>
        </TR>
      </table>');
    end if;

    usp_print('
    <br>
    <table border="0" width=100% align=center class="table table-striped table-bordered table-hover data Table no-footer" cellpadding=3 cellspacing=0>
        <th class="th1">Descripci&oacute;n</th>
        <th class="th1">Fecha de Contrataci&oacute;n</th>
        <th class="th1">Monto Contratado</th>
        <th class="th1">Situacion</th>
        <th class="th1">Estado<br/>RNP</th>
        <th class="th1">Items</th>
        <th class="th1">Documento<br>Liquidaci&oacute;n</th>
        <th class="th1">Archivo de Contrato</th>
    ');

    IF ln_contcontratos > 0 THEN
        ln_contador_loop := 0;
        LOOP FETCH ccontratos
             INTO ln_num_fila, lv_desc_entidad, lv_des_contrato,
                  ln_n_cod_contrato, ln_n_convoca_pad, ln_n_cod_contrato_pad,
                  ln_codconsucode_cursor, ln_cod_condicion,
                  ln_cod_documento_liquidacion, lv_ruc_contratista,
                  lv_nom_contratista, lv_f_contrato, lv_m_contratado,
                  ld_fliquidacion, lv_estado_rnp, lv_fintervenvion,
                  lv_descconv, ln_proctipo, ln_objeto_convoca, lv_procsigla,
                  lv_proc_tiposigla,ln_indPubContratos,ld_f_registro; -- Jcerda req MEF 19/10/2015;

        EXIT WHEN ccontratos%NOTFOUND;
            ln_draw_coma := NULL;

            IF MOD (ln_num_fila, 2) = 0 THEN
                lv_estilo_fila := 'bgcolor="#ECE9D8"';
            ELSE
               lv_estilo_fila := '';
            END IF;

            ln_dummy := PKU_GESTOR_CONT_MAKE_CONTRATOS.f_get_fechasprorroga(ln_n_cod_contrato, ld_fec_contrato, ld_fec_culimnacion );



               --valida controversias

          select   count(*) INTO valida_arbitro from reg_procesos.contrato_arbitraje where ruc_presidente = trim(session__userid)
          and n_cod_contrato = ln_n_cod_contrato_pad and ind_ultimo = 1;


          if ((n_cvalidauser = 0) or (valida_arbitro > 0 and n_cvalidauser > 0)) then 


                    usp_print ('
                <tr '||lv_estilo_fila||' >
                    <td colspan="7">
                        <b>'||makea('ag_cod_contrato='||ln_n_cod_contrato_pad||'&ag_n_convoca='||ln_n_convoca_pad||'&ag_indConsola='||ln_contcontratos||'&ag_proc_tipo='|| ag_proc_tipo||'&ag_proc_desc='|| ag_proc_desc||'&ag_proc_sigla='|| ag_proc_sigla||'&ag_currenpage='|| ag_currenpage||'&ag_codconsucode='|| an_codconsucode||'&ag_anhoentidad='|| ln_anhoentidad||'&scriptdo=doEditContrato',ln_codconsucode_cursor||'-'||ln_n_convoca_pad||'-'||ln_n_cod_contrato_pad)||'&nbsp;&nbsp;&nbsp;<b>'||lv_ruc_contratista||' - '||lv_nom_contratista ||'</b>&nbsp;&nbsp;&nbsp;');

       --cambios arbitros nueva ley
        IF n_cvalidauser = 0 THEN
           if ln_indpubcontratos = 1 then
                usp_print('<a href="#" onclick="showTransferencia('''||to_number(ln_n_cod_contrato)||''','''||to_number(ln_n_convoca_pad)||''','''||to_number(ln_anhoentidad)||''','''||to_number(ln_codconsucode)||''')">(Mostrar Transferencia al MEF)</a>');
           end if;
           elsif  ln_indpubcontratos = 0 then
               usp_print('<font color="red">(Por Publicar)</font>');
        END IF;

    usp_print('
            </td>
            <td align="center">');
           -- usp_print(makea2(ln_nconvoca||','||ln_n_cod_contrato||',600','EnviarResumen','Adjuntar Contrato/OC, OS ('||pku_ss_utiles.f_get_numContratos(ln_n_cod_contrato,ln_nconvoca)||')'));
            usp_print('</td>
        </tr>

        <tr '||lv_estilo_fila||' valign="top" >
            <td>'||lv_des_contrato||'</td>
            <td align="center">'||lv_f_contrato||'</td>
            <td align="center">'||lv_m_contratado||'&nbsp;');

           /* if ln_indPubContratos = 1 then
            usp_print('<a href="#" onclick="showResumen('''||TO_NUMBER(ln_n_cod_contrato)||''','''||TO_NUMBER(ln_n_convoca_pad)||''')">(Resumen)</a></td>');
            end if;
            */
            -- Estado del contrato
            ln_items_resueltos    := f_get_cantitemsresueltos( ln_n_cod_contrato );
            ln_items_en_ejecucion := f_get_cantitemsenejecucion( ln_n_cod_contrato );

            SELECT COUNT (*) INTO ln_estado
            FROM reg_procesos.contrato_resolucion
            WHERE n_cod_contrato = ln_n_cod_contrato AND estado_contrato = 2;

            IF ( ln_estado > 0 ) THEN
                usp_print('
            <td align="center"><font color="red"><b>NULIDAD</b></font></td>');
            ELSE
                usp_print('
            <td align="center">'||f_get_estadocontrato(ld_fec_contrato, ld_fec_culimnacion,ld_fliquidacion, TO_DATE(lv_fintervenvion, reg_procesos.pku_ss_constantes.gv_formato_fecha),ln_items_resueltos, ln_items_en_ejecucion ));
            END IF;

            usp_print ('
            </td>

            <td align="center">');
            IF ln_cod_condicion = 5 THEN
                usp_print ('
                <font color="red">'||lv_estado_rnp||'<br/>A LA FECHA DE SUSCRIPCION DEL CONTRATO EL PROVEEDOR NO POSEE RNP VIGENTE </font>');
            END IF;

            usp_print ('
                &nbsp;
            </td>

            <td width=10% align="center">');
            -- numeros de items del contrato
            SELECT COUNT (1) INTO ln_numitemscontrato
            FROM reg_procesos.item_contrato c
            WHERE c.n_cod_contrato = ln_n_cod_contrato;

            ln_tabulacion_item := 0;

            IF ln_numitemscontrato > 0 THEN
                FOR xrow IN citemscontrato (ln_n_cod_contrato) LOOP
                    ln_tabulacion_item := ln_tabulacion_item + 1;
                    IF ln_draw_coma IS NOT NULL THEN
                        IF ln_tabulacion_item = 10 THEN
                          usp_print (',<br>');
                        ELSE
                          usp_print (',');
                        END IF;
                    END IF;
                    usp_print (xrow.proc_item);
                    ln_draw_coma := ln_numitemscontrato;
                END LOOP;
            END IF;
            usp_print ('
            </td>

            <td width=5% align="center">');
            IF ln_cod_documento_liquidacion IS NULL THEN
                usp_print('<font color="red"><b>NO</b></font>');
            ELSE
                SELECT replace(reg_procesos.convocatoria_doc.doc_url, '\', '/') doc_url, 
                --nvl(reg_procesos.tipo_archivo.icon_tipo_file,99)
               nvl(replace('bootstrap/'||tipo_archivo.icon_tipo_file, 'jpg', 'png'),99) icon_tipo_file,
               (reg_procesos.convocatoria_doc.tamano_bytes) tamano,
               reg_procesos.convocatoria_doc.fec_upload fecha_creacion  

                INTO lv_doc_url, lv_icon_tipo_file, lv_tamano, lv_fecha_creacion
                FROM
                    reg_procesos.tipo_documento LEFT OUTER
                    JOIN reg_procesos.convocatoria_doc
                        ON reg_procesos.tipo_documento.cod_tipo_doc = reg_procesos.convocatoria_doc.cod_tipo_doc
                        AND reg_procesos.convocatoria_doc.cod_doc = ln_cod_documento_liquidacion
                      --  AND reg_procesos.convocatoria_doc.cod_doc = reg_procesos.f_get_max_cod_doc( convocatoria_doc.n_convoca, tipo_documento.cod_tipo_doc )
                    LEFT OUTER JOIN reg_procesos.tipo_archivo
                        ON reg_procesos.convocatoria_doc.cod_tipo_file = reg_procesos.tipo_archivo.cod_tipo_file
                WHERE reg_procesos.tipo_documento.cod_tipo_doc = 700
                ORDER BY reg_procesos.tipo_documento.cod_tipo_doc;


               if(ln_n_cod_contrato IS NOT NULL ) then

                if (INSTR(lv_doc_url, 'particion1') > 0) then
                    usp_print ('<a target="_blank" href="'||url_azure_app1||replace(lv_doc_url,' ','%20')||'">');
                else
                    usp_print ('<a target="_blank" href="'||url_azure_app||replace(lv_doc_url,' ','%20')||'">');
                end if;

                usp_print ('<img src="'||lv_icon_tipo_file||'" width="30" height="30" border="0">
                <br>'||to_char(lv_fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b>
                <br>Tamaño '||to_char(lv_tamano,'999,999,999')||' Kb.<br></b><br>');

                  else

                 usp_print ('
                <a target="_blank" href="http://'||reg_procesos.f_get_conexiones(10)||replace(lv_doc_url,' ','%20')||'">
                <img src="'||lv_icon_tipo_file||'" width="30" height="30" border="0">
                <br>'||to_char(lv_fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b>
                <br>Tamaño '||to_char(lv_tamano,'999,999,999')||' Kb.<br></b><br>');

                  end if;

            END IF;

            usp_print ('
            </td>
            <td align="center" valign="top">');

             for xx in cdocs2(ln_nconvoca,ln_n_cod_contrato)loop

             if(lv_doc_url IS NOT NULL ) then
                if (INSTR(xx.archivo, 'particion1') > 0) then
                   usp_print('<a target="_blank" href="'||url_azure_app1||replace(xx.archivo,' ','%20')||'">');
                else
                    usp_print('<a target="_blank" href="'||url_azure_app||replace(xx.archivo,' ','%20')||'">');
                end if;

                 usp_print('<img src="'||xx.icon_tipo_file||'" width="30" height="30" border="0">
                <br>'||to_char(xx.fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b>
                <br>Tamaño '||to_char(xx.tamano,'999,999,999')||' Kb.<br></b><br>');
              else
              if (INSTR(xx.archivo, 'particion1') > 0) then
                   usp_print ('<a target="_blank" href="'||url_azure_app1||replace(xx.archivo,' ','%20')||'">');
                else
                   usp_print ('<a target="_blank" href="'||url_azure_app||replace(xx.archivo,' ','%20')||'">');
                end if;

                usp_print (' <img src="'||xx.icon_tipo_file||'" width="30" height="30" border="0">
                <br>'||to_char(xx.fecha_creacion,'dd/mm/yyyy hh24:mi')||'</a><b>
                <br>Tamaño '||to_char(xx.tamano,'999,999,999')||' Kb.<br></b><br>');
              end if; 
            end loop;

            usp_print('</td>
        </tr>');

             END IF ;

        END LOOP;
        usp_print ('
        <input type="hidden" name="ln_contador_loop" value='||to_char(ln_contador_loop)||'>');

    END IF;

    usp_print ('
    </table>');

    ln_estado := 0;

    SELECT COUNT (*) INTO ln_estado
    FROM reg_procesos.contrato_resolucion
    WHERE n_cod_contrato = ln_n_cod_contrato AND estado_contrato = 2;

    IF ( ln_estado = 0 ) THEN
        usp_print('<input type="hidden" value="0" name="ag_estado" >');
    ELSE
        usp_print('<input type="hidden" value="'||ln_estado||'" name="ag_estado">');
    END IF;


    usp_print('
    <script>
    function EnviarResumen(convocatoria,contrato)
    {
       //var pag = window.open("portlet5open.asp?_portletid_=mod_popup_contratos&scriptdo=doAddResumen&ag_n_convoca="+ convocatoria +"&ag_cod_contrato="+ contrato,"Items","toolbar=no,Width=750,Height=220,scrollbars=yes,modal=yes,dependent,alwaysRaised");
       var pag = window.open("ControllerServletOpen?portletid=mod_popup_contratos&scriptdo=doAddResumen&ag_n_convoca="+ convocatoria +"&ag_cod_contrato="+ contrato,"Items","toolbar=no,Width=750,Height=220,scrollbars=yes,modal=yes,dependent,alwaysRaised");
       return pag;
    }


    function showResumen(cod_contrato, n_convoca)
    {
       // window.open("portlet5open.asp?_portletid_=mod_ConsolaContratos&scriptdo=doViewResumen&ag_cod_contrato="+cod_contrato+"&ag_n_convoca="+n_convoca,"","toolbar=no,Width=600,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised");
        window.open("ControllerServletOpen?portletid=mod_ConsolaContratos&scriptdo=doViewResumen&ag_cod_contrato="+cod_contrato+"&ag_n_convoca="+n_convoca,"","toolbar=no,Width=600,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised");
    }

    function showTransferencia(cod_contrato, n_convoca, anhoentidad, codconsucode)
    {
        //window.open("portlet5open.asp?_portletid_=mod_ConsolaContratos&scriptdo=doViewTransferencias&ag_cod_contrato="+cod_contrato+"&ag_n_convoca="+n_convoca+"&ag_anhoentidad="+anhoentidad+"&ag_eue_codigo="+codconsucode,"","toolbar=no,Width=800,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised");
        window.open("ControllerServletOpen?portletid=mod_ConsolaContratos&scriptdo=doViewTransferencias&ag_cod_contrato="+cod_contrato+"&ag_n_convoca="+n_convoca+"&ag_anhoentidad="+anhoentidad+"&ag_eue_codigo="+codconsucode,"","toolbar=no,Width=900,Height=500,scrollbars=yes,modal=yes,dependent,alwaysRaised");
    }

    function volver()
    {
        thisform.scriptdo.value = "doView";
        thisform.submit();
    }

    function crear()
    {
        thisform.scriptdo.value = "doNewContrato";
        thisform.submit();
    }
    </script>
    ');
END;

/*******************************************************************************
/ Procedimiento : uspListSearchItems
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     30-10-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE usplistsearchitems (
      ag_cod_contrato     NUMBER default null,
      ag_n_convoca        NUMBER ,
      ag_n_propuesta      NUMBER default null,
      an_codconsucode     NUMBER default null,
      ag_descripcion      VARCHAR2 DEFAULT NULL,
      ag_currenpage       VARCHAR2 := '1',
      ag_currenpageco     VARCHAR2 DEFAULT NULL

   )
   IS
      -- Items del Contrato para una propuesta para un  item
      ln_contrato_prop      VARCHAR2 (120);
      ln_propuesta_prop     NUMBER;
      ln_procitem_prop      NUMBER;
      ln_nconvoca_prop      NUMBER;
      ln_mcontratado        FLOAT;
      ln_monto              FLOAT;
      -- Cursor
      citemscontratoprop    ref_cursor;
      -- datos presentacion de las filas
      lv_clase              VARCHAR2 (80);
      -- datos para los cursores
      ln_cod_contrato       NUMBER;
      ln_n_convoca          NUMBER;
      ln_n_propuesta        NUMBER;
      ln_codconsucode       NUMBER;
      lv_descripcion        VARCHAR2 (500);
      ln_max_nconvoca       NUMBER;
      -- Paginacion Items adjudicados
      lv_currentpage        NUMBER;
      lv_pagesize           NUMBER;
      lv_totalregistros     NUMBER;
      -- Paginacion Items adjudicados con Contrato
      lv_currentpageco      NUMBER;
      lv_totalregistrosco   NUMBER;
      -- Datos del proveedor
      lv_postorruc          reg_procesos.convocatoria_propuesta.ruc_postor%TYPE;
      lv_postornom          reg_procesos.convocatoria_propuesta.nom_postor%TYPE;
      lv_resultado1         NUMBER;

      -- Cursor Items Adjudicados - con  contratos
      CURSOR citemsadjudicadosco (
         p_n_convoca          NUMBER,
         p_n_propuesta        NUMBER,
         p_max_n_convoca      NUMBER,
         p_descripcion        VARCHAR2,
         p_currentpage        NUMBER,
         p_session_pagesize   NUMBER
      )
      IS
         SELECT DISTINCT itc.n_convoca, itc.unm_codigo, m.unm_desc,
                         itc.proc_item,
                         REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,
                         i.cant_adjudicada cantidad,
                         i.monto_adjudicado monto, itc.dep_codigo,
                         itc.pro_codigo, itc.dis_codigo, dep.dep_desc,
                         pro.pro_desc, dis.dis_desc,
                         to_char(ice.f_registro,'dd/mm/yyyy') f_bp_cons,
                       /*  TO_CHAR(cd.fec_upload,reg_procesos.pku_ss_constantes.gv_formato_fecha) f_bp_cons,*/
                         i.n_propuesta,
                         case itc.cod_tipo_detalle_bien 
                              when 1 then 'Item' 
                              when 5 then 'Item paquete'
                              else '-'
                         end  item_paquete
                    FROM reg_procesos.item_convoca itc,
                         reg_procesos.items_bp i,
                         reg_procesos.buena_pro bp,
                         reg_procesos.convocatorias c,
                         sease.unidad_medida m,
                         sease.dep_ubigeo dep,
                         sease.prov_ubigeo pro,
                         sease.dist_ubigeo dis,
                         (
                             select icei.* from  reg_procesos.item_convoca_estado icei
                             where  icei.n_convoca_src = reg_procesos.f_get_min_n_convoca(p_n_convoca )
                             and icei.cod_tipo_Estado_item = 500
                             and icei.f_registro = (
                                           select max(f_registro)
                                           from reg_procesos.item_convoca_estado ice2
                                           where ice2.n_convoca_src  = icei.n_convoca_src
                                           and ice2.proc_item = icei.proc_item
                                         )
                           ) ice
                         /*(
                         select * from (
                                select *
                                from reg_procesos.convocatoria_doc
                                where n_convoca = ln_n_convoca and cod_tipo_doc   = 1600 order by 1 desc ) where rownum = 1

                          )cd,*/
                       /*  reg_procesos.convocatoria_doc cd,*/
                         /*reg_procesos.item_convoca_estado ice*/
                   WHERE itc.n_convoca = p_max_n_convoca
                     AND (   UPPER (itc.descripcion) LIKE UPPER ('%' || p_descripcion || '%')
                          OR UPPER (itc.proc_item) LIKE UPPER ('%' || p_descripcion || '%')
                          OR p_descripcion IS NULL)
                     AND itc.dep_codigo = dis.dep_codigo
                     AND itc.pro_codigo = dis.pro_codigo
                     AND itc.dis_codigo = dis.dis_codigo
                     AND dis.dep_codigo = pro.dep_codigo
                     AND dis.pro_codigo = pro.pro_codigo
                     AND pro.dep_codigo = dep.dep_codigo
                     AND itc.unm_codigo = m.unm_codigo
                     AND c.n_convoca = itc.n_convoca
                     AND bp.n_convoca = p_n_convoca
                     AND bp.n_buenapro = i.n_buenapro
                     AND itc.proc_item = i.proc_item
                     AND i.n_propuesta = p_n_propuesta
                     AND i.monto_adjudicado > 0
                     AND bp.ind_ultimo = 1
               /*      AND cd.cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                     AND cd.n_convoca = bp.n_convoca
                     AND cd.cod_doc   = ice.cod_doc */
                     AND ice.proc_item = i.proc_item
                ORDER BY itc.proc_item;

      -- Cursor Items adjudicados
      CURSOR citemsadjudicados (
         p_cod_contrato       NUMBER,
         p_n_convoca          NUMBER,
         p_n_propuesta        NUMBER,
         p_codconsucode       NUMBER,
         p_max_n_convoca      NUMBER,
         p_descripcion        VARCHAR2,
         p_currentpage        NUMBER,
         p_session_pagesize   NUMBER
      )
      IS
         SELECT *
           FROM (SELECT ROWNUM num, a.*
                   FROM (SELECT DISTINCT itc.n_convoca, itc.unm_codigo,
                               m.unm_desc, itc.proc_item,
                               REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,
                               i.cant_adjudicada cantidad,
                              i.monto_adjudicado monto,
                               suma.suma_cant,
                               suma.suma_monto,
                               CASE suma.suma_monto
                                  WHEN suma.suma_monto
                                     THEN CASE
                                  -- WHEN (bp.f_registro >= TO_DATE(bp.f_bp,reg_procesos.pku_ss_constantes.gv_formato_fecha ))
                                  WHEN (bp.f_registro >= TO_DATE('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha ))
                                     THEN   i.monto_adjudicado - suma.suma_monto
                                  ELSE i.monto_adjudicado
                               END
                                  ELSE i.monto_adjudicado
                               END monto_max,
                               CASE suma.suma_cant
                                  WHEN suma.suma_cant
                                     THEN CASE
                                --  WHEN (bp.f_registro >= TO_DATE(bp.f_bp,reg_procesos.pku_ss_constantes.gv_formato_fecha ) )
                                  WHEN (bp.f_registro >= TO_DATE('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha ) )
                                     THEN   i.cant_adjudicada - suma.suma_cant
                                  ELSE i.cant_adjudicada
                               END
                                  ELSE i.cant_adjudicada
                               END cant_max,
                               itc.dep_codigo, itc.pro_codigo,
                               itc.dis_codigo, dep.dep_desc,
                               pro.pro_desc, dis.dis_desc,
                               to_char(ice.f_registro,'dd/mm/yyyy') f_bp_cons,
                              /* TO_CHAR(cd.fec_upload,reg_procesos.pku_ss_constantes.gv_formato_fecha ) f_bp_cons,*/
                               nvl(c.cod_tipo_modalidad, 0) cod_tipo_modalidad,
                              case itc.cod_tipo_detalle_bien 
                              when 1 then 'Item' 
                              when 5 then 'Item paquete'
                              else '-'
                              end  item_paquete
                          FROM reg_procesos.item_convoca itc,
                               reg_procesos.buena_pro bp,
                               reg_procesos.convocatorias c,
                               sease.unidad_medida m,
                               sease.dep_ubigeo dep,
                               sease.prov_ubigeo pro,
                               sease.dist_ubigeo dis,
                               /*(
                         select * from (
                                select *
                                from reg_procesos.convocatoria_doc
                                where n_convoca = ln_n_convoca and cod_tipo_doc   = 1600 order by 1 desc ) where rownum = 1

                          )cd,

                               reg_procesos.item_convoca_estado ice,*/
                               (
                                 select icei.* from  reg_procesos.item_convoca_estado icei
                                 where  icei.n_convoca_src = reg_procesos.f_get_min_n_convoca(p_n_convoca )
                                 and icei.cod_tipo_Estado_item = 500
                                 and icei.f_registro = (
                                               select max(f_registro)
                                               from reg_procesos.item_convoca_estado ice2
                                               where ice2.n_convoca_src  = icei.n_convoca_src
                                               and ice2.proc_item = icei.proc_item
                                             )
                               ) ice,
                               reg_procesos.items_bp i

                               LEFT OUTER JOIN (
                                          SELECT   c.n_propuesta, ict.proc_item,
                                                   ict.n_convoca,
                                                   SUM(ict.cantidad )
                                                   suma_cant,
                                                   SUM(ict.monto)
                                                   suma_monto
                                                   FROM reg_procesos.item_contrato ict
                                                   INNER JOIN reg_procesos.item_convoca icv
                                                   ON ict.n_convoca = icv.n_convoca AND ict.proc_item = icv.proc_item
                                                   INNER JOIN reg_procesos.contrato c
                                                   ON c.n_cod_contrato =ict.n_cod_contrato
                                                   WHERE ict.n_convoca = p_max_n_convoca
                                                   AND c.n_convoca = p_n_convoca
                                                   AND c.codconsucode != LPAD(p_codconsucode,6,'0')
                                                   AND c.n_propuesta = p_n_propuesta
                                                   GROUP BY c.n_propuesta, ict.proc_item, ict.n_convoca)
                                                   suma ON suma.proc_item = i.proc_item
                                                   AND suma.n_propuesta = i.n_propuesta
                         WHERE itc.n_convoca = p_max_n_convoca
                           AND (   UPPER (itc.descripcion) LIKE UPPER ('%'|| p_descripcion || '%' )
                            OR UPPER (itc.proc_item) LIKE  UPPER (   '%' || p_descripcion || '%' )
                            OR p_descripcion IS NULL )
                           AND itc.dep_codigo = dis.dep_codigo
                           AND itc.pro_codigo = dis.pro_codigo
                           AND itc.dis_codigo = dis.dis_codigo
                           AND dis.dep_codigo = pro.dep_codigo
                           AND dis.pro_codigo = pro.pro_codigo
                           AND pro.dep_codigo = dep.dep_codigo
                           AND itc.unm_codigo = m.unm_codigo
                           AND c.n_convoca = itc.n_convoca
                           AND bp.n_convoca = p_n_convoca
                           AND bp.n_buenapro = i.n_buenapro
                           AND itc.proc_item = i.proc_item
                           AND i.n_propuesta = p_n_propuesta
                           AND i.monto_adjudicado > 0
                           AND bp.ind_ultimo = 1
                         /*  AND cd.cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                           AND cd.n_convoca = bp.n_convoca
                           AND cd.cod_doc   = ice.cod_doc */
                           AND ice.proc_item = i.proc_item
                           AND i.proc_item IN (
                                  SELECT ic.proc_item
                                    FROM reg_procesos.contrato c
                                    JOIN reg_procesos.item_contrato ic ON c.n_cod_contrato = ic.n_cod_contrato
                                     AND c.n_cod_contrato = p_cod_contrato
                                     AND c.n_propuesta =p_n_propuesta
                                  UNION
                                  SELECT i.proc_item
                                    FROM reg_procesos.item_convoca itc,
                                         reg_procesos.convocatorias c,
                                         reg_procesos.buena_pro bp,
                                         reg_procesos.items_bp i,
                                         reg_procesos.convocatoria_doc cd,
                                         reg_procesos.item_convoca_estado ice
                                   WHERE itc.n_convoca = p_max_n_convoca
                                     AND c.n_convoca = itc.n_convoca
                                     AND bp.n_convoca = p_n_convoca
                                     AND bp.n_buenapro = i.n_buenapro
                                     AND itc.proc_item = i.proc_item
                                     AND i.n_propuesta = p_n_propuesta
                                     AND i.monto_adjudicado > 0
                                     AND bp.ind_ultimo = 1
                                     AND cd.cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                                     AND cd.n_convoca = bp.n_convoca
                                     AND ice.cod_doc = cd.cod_doc
                                     AND ice.proc_item = i.proc_item
                                     AND NOT EXISTS (
                                            SELECT iccc.proc_item
                                              FROM reg_procesos.contrato c,
                                                   reg_procesos.item_contrato iccc
                                             WHERE c.n_convoca =         p_n_convoca
                                               AND c.n_cod_contrato =    iccc.n_cod_contrato
                                               AND iccc.n_convoca =      p_max_n_convoca
                                               AND iccc.proc_item =      itc.proc_item
                                               AND c.n_propuesta =       p_n_propuesta
                                               and c.codconsucode = lpad(p_codconsucode,6,'0' )
                                               /*permite validar que se muestre los item paquetes de obras mientras no complete sus contratos para todos los items*/
                                               and iccc.proc_item not in (
                                               select distinct(icd.proc_item) from reg_procesos.item_convoca_detalle icd
                                               where icd.n_convoca in (select n_convoca from reg_procesos.convocatorias where n_convoca = p_max_n_convoca and codobjeto =3) and icd.proc_item=itc.proc_item
                                               and (select sum(icd.cantidad) from reg_procesos.item_convoca_detalle icd where icd.n_convoca = p_max_n_convoca and icd.proc_item = itc.proc_item) != 
                                                   (select sum(ic.cantidad) from reg_procesos.item_contrato ic where ic.n_convoca = p_max_n_convoca and ic.proc_item = itc.proc_item)))
                                               )
                                ORDER BY itc.proc_item) a) b
          WHERE b.num >= p_session_pagesize * (p_currentpage - 1) + 1
            AND b.num <= p_session_pagesize * (p_currentpage);
   BEGIN

      -- Filtro de los cursores
      ln_cod_contrato  := ag_cod_contrato;
      ln_n_convoca     := ag_n_convoca;
      ln_n_propuesta   := ag_n_propuesta;
      ln_codconsucode  := an_codconsucode;
      lv_descripcion   := ag_descripcion;
      ln_max_nconvoca  := reg_procesos.f_get_max_n_convoca (ag_n_convoca);

      -- Paginacion
      lv_pagesize := 100;
      -- Paginacion Items adjudicados
      lv_currentpage := NVL (TO_NUMBER (ag_currenpage), 1);
      -- Paginacion Items adjudicados con Contrato
      lv_currentpageco := NVL (TO_NUMBER (ag_currenpageco), 1);
      -- datos del proveedor
      lv_resultado1 := f_get_datospostorbp (ln_n_convoca,
                                            ln_n_propuesta,
                                            lv_postorruc,
                                            lv_postornom);

      sp_javascript_contratos_busca;

      usp_print('

     <script language=javascript>
      function BuscarDatos()
      {
          thisform.scriptdo.value = "'||gv_pkname||'.uspListSearchItems";
          thisform.submit();
      }
     </script>');
      -- Hiddens
      usp_print('<input type="hidden" name="ag_cod_contrato"  value="'|| ln_cod_contrato || '"></input>');
      usp_print('<input type="hidden" name="ag_n_propuesta"   value="'|| ln_n_propuesta || '"></input>');
      usp_print('<input type="hidden" name="ag_n_convoca"     value="'|| ln_n_convoca || '"></input>');
      usp_print('<input type="hidden" name="an_codconsucode"  value="'|| ln_codconsucode|| '"></input>');
      usp_print('<input type="hidden" name="ag_currenpage"    value="'|| lv_currentpage|| '"></input>');
      usp_print('<input type="hidden" name="ag_currenpageCO"  value="'|| lv_currentpageco|| '"></input>');
      usp_print('<table valign="top" class="table table-striped">');
      usp_print('<tr><td>');
      usp_print('<table border=0 width=100% cellpadding="2" cellspacing="2">');
      usp_print('<tr><td width="20%" align=left>Buscar Item:</td>
                 <td width="60%" align="left"> <input name="ag_descripcion" size="4" style="height:20"></td>
                 <td width="20%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Buscar" onclick="javascript:BuscarDatos();" style="height:20">
                 </td></tr>
                 </table></td></tr>');
--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      -- Numero de registros
      SELECT COUNT (1)
        INTO lv_totalregistros
        FROM (SELECT DISTINCT itc.n_convoca, itc.unm_codigo, m.unm_desc,
                              itc.proc_item,
                              REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(itc.descripcion) descripcion,
                              i.cant_adjudicada cantidad,
                              i.monto_adjudicado monto, suma.suma_cant,
                              suma.suma_monto,
                              CASE suma.suma_monto
                                 WHEN suma.suma_monto
                                    THEN CASE
                                          WHEN (bp.f_registro >= TO_DATE('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha ))
                                          THEN i.monto_adjudicado - suma.suma_monto
                                    ELSE i.monto_adjudicado
                                    END
                                 ELSE i.monto_adjudicado
                              END monto_max,
                              CASE suma.suma_cant
                                 WHEN suma.suma_cant
                                    THEN CASE
                                 WHEN (bp.f_registro >=TO_DATE('29/05/2007',reg_procesos.pku_ss_constantes.gv_formato_fecha))
                                    THEN i.cant_adjudicada - suma.suma_cant
                                 ELSE i.cant_adjudicada
                              END
                                 ELSE i.cant_adjudicada
                              END cant_max,
                              itc.dep_codigo, itc.pro_codigo, itc.dis_codigo,
                              dep.dep_desc, pro.pro_desc, dis.dis_desc,
                              TO_CHAR(cd.fec_upload,reg_procesos.pku_ss_constantes.gv_formato_fecha ) f_bp_cons,
                              NVL (c.cod_tipo_modalidad, 0) cod_tipo_modalidad
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
                              LEFT OUTER JOIN (
                                             SELECT c.n_propuesta,
                                                    ict.proc_item,
                                                    ict.n_convoca,
                                                    SUM(ict.cantidad) suma_cant,
                                                    SUM(ict.monto) suma_monto
                                               FROM reg_procesos.item_contrato ict
                                               INNER JOIN reg_procesos.item_convoca icv ON ict.n_convoca =  icv.n_convoca
                                               AND ict.proc_item = icv.proc_item
                                               INNER JOIN reg_procesos.contrato c ON c.n_cod_contrato = ict.n_cod_contrato
                                              WHERE ict.n_convoca = ln_max_nconvoca
                                                AND c.n_convoca = ln_n_convoca
                                                AND c.codconsucode != LPAD(ln_codconsucode, 6,'0')
                                                AND c.n_propuesta = ln_n_propuesta
                                           GROUP BY c.n_propuesta, ict.proc_item,
                                                    ict.n_convoca
                                                  ) suma
                                                    ON suma.proc_item = i.proc_item
                                                    AND suma.n_propuesta = i.n_propuesta
                        WHERE itc.n_convoca = ln_max_nconvoca
                          AND (   UPPER (itc.descripcion) LIKE '%' || UPPER (lv_descripcion) || '%'
                               OR UPPER (itc.proc_item) LIKE  '%' || UPPER (lv_descripcion) || '%'
                               OR lv_descripcion IS NULL)
                          AND itc.dep_codigo = dis.dep_codigo
                          AND itc.pro_codigo = dis.pro_codigo
                          AND itc.dis_codigo = dis.dis_codigo
                          AND dis.dep_codigo = pro.dep_codigo
                          AND dis.pro_codigo = pro.pro_codigo
                          AND pro.dep_codigo = dep.dep_codigo
                          AND itc.unm_codigo = m.unm_codigo
                          AND c.n_convoca = itc.n_convoca
                          AND bp.n_convoca = ln_n_convoca
                          AND bp.n_buenapro = i.n_buenapro
                          AND itc.proc_item = i.proc_item
                          AND i.n_propuesta = ln_n_propuesta
                          AND i.monto_adjudicado > 0
                          AND bp.ind_ultimo = 1
                          AND cd.cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                          AND cd.n_convoca = bp.n_convoca
                          AND ice.cod_doc = cd.cod_doc
                          AND ice.proc_item = i.proc_item
                          AND i.proc_item IN (
                                 SELECT ic.proc_item
                                   FROM reg_procesos.contrato c JOIN reg_procesos.item_contrato ic
                                   ON c.n_cod_contrato = ic.n_cod_contrato
                                   AND c.n_cod_contrato = ln_cod_contrato
                                   AND c.n_propuesta = ln_n_propuesta
                                 UNION
                                 SELECT i.proc_item
                                   FROM reg_procesos.item_convoca itc,
                                        reg_procesos.convocatorias c,
                                        reg_procesos.buena_pro bp,
                                        reg_procesos.items_bp i,
                                        (
                                           select icei.* from  reg_procesos.item_convoca_estado icei
                                           where  icei.n_convoca_src = reg_procesos.f_get_min_n_convoca(ln_n_convoca )
                                           and icei.cod_tipo_Estado_item = 500
                                           and icei.f_registro = (
                                                         select max(f_registro)
                                                         from reg_procesos.item_convoca_estado ice2
                                                         where ice2.n_convoca_src  = icei.n_convoca_src
                                                         and ice2.proc_item = icei.proc_item
                                                       )
                                         ) ice
                                        /*(
                                           select * from (
                                                  select *
                                                  from reg_procesos.convocatoria_doc
                                                  where n_convoca = ln_n_convoca and cod_tipo_doc   = 1600 order by 1 desc ) where rownum = 1

                                            )cd,

                                        reg_procesos.item_convoca_estado ice*/
                                  WHERE itc.n_convoca = ln_max_nconvoca
                                    AND c.n_convoca = itc.n_convoca
                                    AND bp.n_convoca = ln_n_convoca
                                    AND bp.n_buenapro = i.n_buenapro
                                    AND itc.proc_item = i.proc_item
                                    AND i.n_propuesta = ln_n_propuesta
                                    AND i.monto_adjudicado > 0
                                    AND bp.ind_ultimo = 1
                                  /*  AND cd.cod_tipo_doc =  reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                                    AND cd.n_convoca = bp.n_convoca
                                    AND ice.cod_doc = cd.cod_doc*/
                                    AND ice.proc_item = i.proc_item
                                    AND NOT EXISTS (
                                           SELECT iccc.proc_item
                                             FROM reg_procesos.contrato c,
                                                  reg_procesos.item_contrato iccc
                                            WHERE c.n_convoca = ln_n_convoca
                                              AND c.n_cod_contrato =  iccc.n_cod_contrato
                                              AND iccc.n_convoca = ln_max_nconvoca
                                              AND iccc.proc_item = itc.proc_item
                                              AND c.n_propuesta = ln_n_propuesta
                                              and c.ind_contrato_pub <> 1
                                              AND c.codconsucode = LPAD (ln_codconsucode, 6,'0')
                                              and iccc.proc_item not in (
                                               select distinct(icd.proc_item) from reg_procesos.item_convoca_detalle icd
                                               where icd.n_convoca in (select n_convoca from reg_procesos.convocatorias where n_convoca = ln_max_nconvoca and codobjeto =3) and icd.proc_item=itc.proc_item
                                               and (select sum(icd.cantidad) from reg_procesos.item_convoca_detalle icd where icd.n_convoca = ln_max_nconvoca and icd.proc_item = itc.proc_item) != 
                                                   (select sum(ic.cantidad) from reg_procesos.item_contrato ic where ic.n_convoca = ln_max_nconvoca and ic.proc_item = itc.proc_item)))));

------------------------------------------------------
      SELECT COUNT (1)
        INTO lv_totalregistrosco
        FROM (SELECT DISTINCT itc.n_convoca, itc.unm_codigo, m.unm_desc,
                              itc.proc_item,
                              REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(descripcion) descripcion,
                              i.cant_adjudicada cantidad,
                              i.monto_adjudicado monto, itc.dep_codigo,
                              itc.pro_codigo, itc.dis_codigo, dep.dep_desc,
                              pro.pro_desc, dis.dis_desc,
                              to_char(ice.f_registro,'dd/mm/yyyy') f_bp_cons,
                             /* TO_CHAR(cd.fec_upload,reg_procesos.pku_ss_constantes.gv_formato_fecha) f_bp_cons,*/
                              i.n_propuesta
                         FROM reg_procesos.item_convoca itc,
                              reg_procesos.items_bp i,
                              reg_procesos.buena_pro bp,
                              reg_procesos.convocatorias c,
                              sease.unidad_medida m,
                              sease.dep_ubigeo dep,
                              sease.prov_ubigeo pro,
                              sease.dist_ubigeo dis,
                             (
                                           select icei.* from  reg_procesos.item_convoca_estado icei
                                           where  icei.n_convoca_src = reg_procesos.f_get_min_n_convoca(ln_n_convoca )
                                           and icei.cod_tipo_Estado_item = 500
                                           and icei.f_registro = (
                                                         select max(f_registro)
                                                         from reg_procesos.item_convoca_estado ice2
                                                         where ice2.n_convoca_src  = icei.n_convoca_src
                                                         and ice2.proc_item = icei.proc_item
                                                       )
                             ) ice
                             /* (
                         select * from (
                                select *
                                from reg_procesos.convocatoria_doc
                                where n_convoca = ln_n_convoca and cod_tipo_doc   = 1600 order by 1 desc ) where rownum = 1

                          )cd,
                              reg_procesos.item_convoca_estado ice*/
                        WHERE itc.n_convoca = ln_max_nconvoca
                          AND (UPPER (itc.descripcion) LIKE UPPER ('%' || lv_descripcion || '%')
                               OR UPPER (itc.proc_item) LIKE UPPER ('%' || lv_descripcion || '%')
                               OR lv_descripcion IS NULL)
                          AND itc.dep_codigo = dis.dep_codigo
                          AND itc.pro_codigo = dis.pro_codigo
                          AND itc.dis_codigo = dis.dis_codigo
                          AND dis.dep_codigo = pro.dep_codigo
                          AND dis.pro_codigo = pro.pro_codigo
                          AND pro.dep_codigo = dep.dep_codigo
                          AND itc.unm_codigo = m.unm_codigo
                          AND c.n_convoca = itc.n_convoca
                          AND bp.n_convoca = ln_n_convoca
                          AND bp.n_buenapro = i.n_buenapro
                          AND itc.proc_item = i.proc_item
                          AND i.n_propuesta = ln_n_propuesta
                          AND i.monto_adjudicado > 0
                          AND bp.ind_ultimo = 1
                         /* AND cd.cod_tipo_doc = reg_procesos.pku_ss_constantes.gn_tipo_doc_consentida
                          AND cd.n_convoca    = bp.n_convoca
                          AND cd.cod_doc      = ice.cod_doc*/
                          AND ice.proc_item = i.proc_item);

    ------------ Crear la tabla de resultados ------------
      usp_print ('<tr><td width="100%">');
      usp_print ('</table>');
      usp_print ('</td></tr>');

      -- MOSTRAMOS LOS ITEMS ADJUDICADOS - AUN SIN CONTRATO --
IF lv_totalregistros > 0 THEN
      usp_print('<tr>
                    <td align="center"  colspan="8" class="recuadro"><br><b>'
                    || lv_postorruc || ' - ' || lv_postornom || '</b><br><br></td>
                 </tr>');

       usp_print ('<tr><td width="100%">');
       ------------ Crear la tabla de resultados ------------
       usp_print
         ('<table border="1" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" width="100%">
          <tr><td colspan = 2>Resultado:&nbsp'
             ||TO_CHAR(lv_pagesize * (lv_currentpage - 1) + 1 * SIGN (lv_totalregistros))
             || '&nbsp-&nbsp'
             || (CASE lv_currentpage
                    WHEN CEIL (lv_totalregistros / lv_pagesize)
                    THEN lv_totalregistros
                    ELSE lv_pagesize * lv_currentpage * SIGN (lv_totalregistros)
                 END)
             || ' de ' || lv_totalregistros || '</td><td colspan = 6 align="left">');

         ------------ Imprimir el indice de paginas ------------
         reg_procesos.pku_xportal_utils.paginar ('?scriptdo=' || gv_pkname || '.gv_PkName&',
                                    lv_currentpage,
                                    lv_totalregistros,
                                    lv_pagesize);

         ------------ Crear los campos de cabecera ------------
         usp_print('</td></tr>');
         usp_print('
      <TR>
        <TD><center><b>Item</b></center></TD>
        <TD><center><b>Tipo de Item</b></center></TD>
        <TD><center><b>Descripcion</b></center></TD>
        <TD><center><b>Cantidad Adjudicada</b></center></TD>
        <TD><center><b>Monto Adjudicado</b></center></TD>
        <TD><center><b>U. Medida</b></center></TD>
        <TD><center><b>Cantidad Maxima</b></center></TD>
        <TD><center><b>Monto Maximo</b></center></TD>
        <TD><center><b>Lugar de ejecucion</b></center></TD>
      </TR>');

         FOR xrow IN citemsadjudicados (ln_cod_contrato,
                                        ln_n_convoca,
                                        ln_n_propuesta,
                                        ln_codconsucode,
                                        ln_max_nconvoca,
                                        lv_descripcion,
                                        lv_currentpage,
                                        lv_pagesize)
         LOOP
            usp_print ('<tr>');

            if xrow.cant_max > 0 AND xrow.monto_max > 0 THEN

               lv_clase := '';
               usp_print('<td align="right"  class="recuadro">'||
                         makea2('pitem='|| xrow.proc_item||'
                               ,pdesc='''|| REG_PROCESOS.F_GESTOR_REEMPLAZAR_TILDES(xrow.descripcion)||'''
                               ,pfbcons='''|| xrow.f_bp_cons||'''
                               ,pubigeo=''['|| xrow.dep_codigo|| xrow.pro_codigo||  xrow.dis_codigo|| ']['
                                            || xrow.dep_codigo|| '] '||xrow.dep_desc||' / ['|| xrow.pro_codigo|| '] '||
                                               xrow.pro_desc|| '/ ['|| xrow.dis_codigo|| '] '|| xrow.dis_desc|| '''
                                ,pmonto='||replace(xrow.monto_max, ',', '.')||'
                                ,pcantidad='||replace(xrow.cant_max, ',', '.')||'
                                ,unm_desc='''||xrow.unm_desc||'''
                                ,unm_codigo='|| xrow.unm_codigo,'retornaItemsCO',xrow.proc_item)||
                         '</td>');

              usp_print('<td align="center" class="recuadro">'|| xrow.item_paquete||'</td>');

              usp_print('<td align="right"  class="recuadro"><font size=1>'||
                         makea2('pitem='|| xrow.proc_item||'
                                ,pdesc='''|| xrow.descripcion||'''
                                ,pfbcons='''|| xrow.f_bp_cons||'''
                                ,pubigeo=''['|| xrow.dep_codigo|| xrow.pro_codigo||xrow.dis_codigo|| ']['|| xrow.dep_codigo|| '] '||
                                               xrow.dep_desc|| ' / ['|| xrow.pro_codigo|| '] '||
                                               xrow.pro_desc|| '/ ['|| xrow.dis_codigo|| '] '||
                                               xrow.dis_desc|| '''
                                ,pmonto='||replace(xrow.monto_max, ',', '.')||'
                                ,pcantidad='||replace(xrow.cant_max, ',', '.')||'
                                ,unm_desc='''||xrow.unm_desc||'''
                                ,unm_codigo='||xrow.unm_codigo,'retornaItemsCO',xrow.descripcion)||
                         '</font></td>');

            -- IF xrow.cant_max = 0 AND xrow.monto_max = 0  THEN
            else
               lv_clase := '<font color="red">';
               usp_print('<td align="right"  class="recuadro">'|| xrow.proc_item || '</td>' );
               usp_print('<td align="center" class="recuadro">'|| xrow.descripcion|| '</td>');


            END IF;

            usp_print('<td align="center" class="recuadro">'|| TO_CHAR (xrow.cantidad,reg_procesos.pku_ss_constantes.gv_formato_dinero )|| '</td>');
            usp_print('<td align="center" class="recuadro">'|| TO_CHAR (xrow.monto,reg_procesos.pku_ss_constantes.gv_formato_dinero)|| '</td>');
            usp_print('<td align="center" class="recuadro">'|| xrow.unm_desc|| '</td>');
            usp_print('<td align="center" class="recuadro">'|| lv_clase || TO_CHAR (xrow.cant_max,reg_procesos.pku_ss_constantes.gv_formato_dinero )|| '</td>');
            usp_print('<td align="center" class="recuadro">'|| lv_clase || TO_CHAR (xrow.monto_max, reg_procesos.pku_ss_constantes.gv_formato_dinero) || '</td>');
            usp_print('<td align="center" class="recuadro">['
            || xrow.dep_codigo|| xrow.pro_codigo || xrow.dis_codigo|| ']['
            || xrow.dep_codigo|| '] '|| xrow.dep_desc
            || ' / ['|| xrow.pro_codigo || '] '|| xrow.pro_desc|| '/ ['|| xrow.dis_codigo
                       || '] '|| xrow.dis_desc || '</td>');

            usp_print ('</tr>');
         END LOOP;

         usp_print ('</table>');
         usp_print ('</td></tr>');
END IF;

---------------------------------------------------------------
-- FIN DE MOSTRAMOS LOS ITEMS ADJUDICADOS - AUN SIN CONTRATO --
---------------------------------------------------------------
---------------------------------------------------------------
-- MUESTRA LOS ITEM CON CONTRATO --
---------------------------------------------------------------
   -- Desde aqui se muestra la lista de items adjudicados pero con saldos cero,
   -- muestra la lista de contratos para cada item

IF lv_totalregistros = 0 THEN
     -- Si hay items con contrato los mostramos
     IF lv_totalregistrosco > 0 THEN
        usp_print ('<tr><td width="100%">');
        usp_print
           ('<table border="1" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" width="100%">');

        usp_print('<tr class="">');
        usp_print
           ('<td align="center"  colspan="8"><br/><b>'
            || lv_postorruc || ' - '  || lv_postornom || '  </b><br/><br/>
          <b>YA SE HAN REGISTRADO CONTRATOS PARA TODOS LOS ITEMS ADJUDICADOS</b><br/><br/>
          </td>');

        usp_print ('</tr>');
        ------------ Crear la tabla de resultados ------------
        usp_print
           ('
     <table border="1" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" width="100%">
       <tr><td colspan = 2>Resultado:&nbsp'
            || TO_CHAR (  lv_pagesize * (lv_currentpageco - 1)+ 1 * SIGN (lv_totalregistrosco) )
            || '&nbsp-&nbsp'
            || (CASE lv_currentpageco
                   WHEN CEIL (lv_totalregistrosco / lv_pagesize)
                      THEN lv_totalregistrosco
                   ELSE   lv_pagesize * lv_currentpageco * SIGN (lv_totalregistrosco)
                END
               )
            || ' de ' || lv_totalregistrosco || '</td><td colspan = 6 align="left">');

        ------------ Imprimir el indice de paginas ------------
        reg_procesos.pku_xportal_utils.paginar ('?scriptdo='|| gv_pkname|| '.gv_PkName&',lv_currentpageco,lv_totalregistrosco,lv_pagesize);

        ------------ Crear los campos de cabecera ------------
        usp_print ('</td></tr>');
        usp_print
           ('<TR>
           <TD><center><b>Item</b></center></TD>
           <TD><center><b>Tipo de Item</b></center></TD>
           <TD><center><b>Descripcion</b></center></TD>
           <TD><center><b>Cantidad Adjudicada</b></center></TD>
           <TD><center><b>Monto Adjudicado</b></center></TD>
           <TD><center><b>U. Medida</b></center></TD>
           <TD><center><b>Nro. Contrato</b></center></TD>
           <TD><center><b>Lugar de ejecucion</b></center></TD>
           <TD><center><b>&nbsp;</b></center></TD>
           </TR>'
           );

        FOR xrow IN citemsadjudicadosco (ln_n_convoca,
                                         ln_n_propuesta,
                                         ln_max_nconvoca,
                                         lv_descripcion,
                                         lv_currentpageco,
                                         lv_pagesize
                                        )
        LOOP
           citemscontratoprop :=
              f_get_itemscontratopropuesta (ln_codconsucode,
                                            xrow.n_convoca,
                                            xrow.proc_item,
                                            xrow.n_propuesta
                                           );
           usp_print
              ('<TR>
              <TD class="recuadro" align="right" >'|| xrow.proc_item || '</TD>
              <TD class="recuadro" align="center" >'|| xrow.item_paquete||'</TD>
              <TD class="recuadro" align="center" ><font size=1>'|| xrow.descripcion || '</font></TD>
              <TD class="recuadro" align="right">'|| TO_CHAR (xrow.cantidad,reg_procesos.pku_ss_constantes.gv_formato_dinero) || '</TD>
              <TD class="recuadro" align="right">'|| TO_CHAR (xrow.monto, reg_procesos.pku_ss_constantes.gv_formato_dinero)|| '</TD>
              <TD class="recuadro" align="center">'|| xrow.unm_desc || '</TD>
              <TD class="recuadro">');

           usp_print
              ('<table border="1" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" width="100%">' );

           LOOP
              FETCH citemscontratoprop
               INTO ln_contrato_prop, ln_propuesta_prop,
                    ln_procitem_prop, ln_nconvoca_prop, ln_mcontratado,
                    ln_monto;

              EXIT WHEN citemscontratoprop%NOTFOUND;
              usp_print
                 ('<tr><td lign="left">Nro:'|| ln_contrato_prop || '</td></tr>');
              usp_print
                 ('<tr><td lign="left">Monto x Item:'|| ln_monto|| '</td></tr>');
           END LOOP;

           usp_print('</table>');
           usp_print('</TD>
           <TD class="recuadro">['|| xrow.dep_codigo || xrow.pro_codigo || xrow.dis_codigo || ']
                                ['|| xrow.dep_codigo || '] ' || xrow.dep_desc || '/
                                ['|| xrow.pro_codigo || '] ' || xrow.pro_desc || '/
                                ['|| xrow.dis_codigo || '] ' || xrow.dis_desc || '</TD>');

        usp_print('<TD><input type="button" value="Agregar" onclick="retornaItemsCO2('|| xrow.proc_item ||','''||xrow.descripcion||''','''|| xrow.f_bp_cons||''',''['|| xrow.dep_codigo|| xrow.pro_codigo||xrow.dis_codigo|| ']['|| xrow.dep_codigo|| '] '|| xrow.dep_desc|| ' / ['|| xrow.pro_codigo|| '] '|| xrow.pro_desc|| '/ ['|| xrow.dis_codigo|| '] '|| xrow.dis_desc|| ''','||replace(xrow.monto, ',', '.')||','||replace(xrow.cantidad, ',', '.')||','''||xrow.unm_desc||''','||xrow.unm_codigo || ')" /></TD>');

        USP_PRINT('</TR>' );
        END LOOP;

        usp_print ('</table>');
        usp_print ('</td></tr>');
     END IF;
    -- Fin -- Si hay items con contrato los mostramos
  END IF;

---------------------------------------------------------------
-- FIN - MUESTRA LOS ITEM CON CONTRATO --
---------------------------------------------------------------
      usp_print ('</table><br><br>');
   END;

/*******************************************************************************
/ Procedimiento : uspListTransferenciasDoView
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre
/ -------------------- ----------------  ---------------------
/ Gerardo Millones     29-10-2007 11:59  Version Inicial
/******************************************************************************/
   PROCEDURE usplisttransferenciasdoview (ag_ncod_contrato VARCHAR2)
   IS
      -- cursores
      ctx                        ref_cursor;

      -- cursores Mensajes de Error
      CURSOR ctxerrores (p_nshowerror NUMBER, p_noperacion NUMBER)
      IS
         SELECT    '( '
                || TO_CHAR (a.fec_transferencia,
                            reg_procesos.pku_ss_constantes.gv_formato_fecha_hora
                           )
                || ' ) '
                || a.des_error des_error
           FROM reg_procesos.contrato_operacion_error a
          WHERE a.id_operacion = p_noperacion AND 1 = p_nshowerror;

      -- datos de la TX
      lv_id_contrato             VARCHAR2 (25);
      ln_id_transaccion          NUMBER;
      ln_id_motivo               NUMBER;
      lv_des_operacioncontrato   VARCHAR2 (20);
      lv_cod_operacion           NUMBER;
      lv_des_operacion           VARCHAR2 (120);
      lv_fec_operacion           VARCHAR2 (20);
      lv_cod_estadotx            NUMBER;
      lv_des_estadotx            VARCHAR2 (500);
      lv_id_proceso              VARCHAR2 (600);
      lv_id_operacion            NUMBER;
      lv_fec_transferencia       VARCHAR2 (20);
      lv_xml_data                VARCHAR2 (4000);
      lv_usu_creacion            VARCHAR2 (50);
      lv_ip_creacion             VARCHAR2 (50);
      lv_usuario                 VARCHAR2 (50);
   BEGIN
      -- Estilos
      --pku_ss_estilo_css.estilos;
      -- Iniciamos los cursores
      ctx := f_get_contratoresultadotx (ag_ncod_contrato);
      usp_print
         ('<table vlaign="top" border="0" cellpadding="1" cellspacing="1" width="100%">'
         );
      usp_print ('<tr>');
      usp_print ('<td class="Titulo" valign="top">');
      usp_print
           (   '<font size="2">Operaciones transferidas el MEF del contrato :'
            || ag_ncod_contrato
            || ''
           );
      usp_print ('</font>');
      usp_print ('</tr>');
      usp_print ('</table>');
      usp_print
         ('<table align="center" BORDER="0" CELLPADDING="1" CELLSPACING="0" WIDTH="100%" class="TabFilMan"
   style="FONT-FAMILY: Verdana;FONT-SIZE: 7pt;" >'
         );
      usp_print
         ('<tr align="center" valign = "top">
                <td class="recuadro"><b>id_trans</b></td>
                <td class="recuadro"><b>id_motivo</b></td>
                <td class="recuadro"><b>cod_operacion</b></td>
                <td class="recuadro"><b>fec_Registro</b></td>
                <td class="recuadro"><b>Estado Transferencia</b></td>
                <td class="recuadro"><b>Fecha de transferencia</b></td>
                <td class="recuadro"><b>Usuario</b></td>
              </tr>'
         );

      LOOP
         FETCH ctx
          INTO lv_id_contrato, ln_id_transaccion, ln_id_motivo,
               lv_des_operacioncontrato, lv_cod_operacion, lv_des_operacion,
               lv_fec_operacion, lv_cod_estadotx, lv_des_estadotx,
               lv_id_proceso, lv_id_operacion, lv_fec_transferencia,
               lv_xml_data, lv_usu_creacion, lv_ip_creacion, lv_usuario;

         EXIT WHEN ctx%NOTFOUND;
         usp_print ('<tr>');
         usp_print ('<td class="recuadro" >' || ln_id_transaccion || '</td>');
         usp_print (   '<td class="recuadro">'
                    || ln_id_motivo
                    || '-'
                    || lv_des_operacioncontrato
                    || '</td>'
                   );
         usp_print (   '<td class="recuadro">'
                    || lv_cod_operacion
                    || '-'
                    || lv_des_operacion
                    || '</td>'
                   );
         usp_print ('<td class="recuadro"></td>');
         usp_print ('<td class="recuadro"></td>');
         usp_print ('<td class="recuadro">');
         usp_print (lv_fec_transferencia);

         IF lv_cod_estadotx NOT IN (10, 5, 3)
         THEN
            usp_print
               (   '<input type="button" value="Enviar" OnClick="ReenviarTransf('
                || ln_id_transaccion
                || ')"/>'
               );
         END IF;

         usp_print ('</td>');
         usp_print ('<td class="recuadro">' || lv_usuario || '</td>');
         usp_print ('</tr>');

         --- falta el 1
         FOR xrow IN ctxerrores (ln_id_transaccion, 1)
         LOOP
            usp_print
               (   '<tr bgcolor="#ff9999">
        <td colspan="10" class="recuadro">'
                || xrow.des_error
                || '</td>
        </tr>'
               );
         END LOOP;
      END LOOP;

      usp_print ('</table>');
   END;

/*******************************************************************************
/ Procedimiento : uspNewContratosDoEdit
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                          Version Inicial
/******************************************************************************/

  PROCEDURE uspnewcontratosdoedit (
      session__userid            VARCHAR2 DEFAULT NULL,
      session__n_convoca         VARCHAR2 DEFAULT NULL,
      session__eue_codigo        VARCHAR2 DEFAULT NULL,
      session__anhoentidad       VARCHAR2 DEFAULT NULL,
      session__cod_moneda        VARCHAR2 DEFAULT NULL,
      ag_des_contrato            VARCHAR2 DEFAULT NULL,
      ag_cod_tipo_contrato       VARCHAR2 DEFAULT NULL,
      ag_n_contrato              VARCHAR2 DEFAULT NULL,
      ag_ciu_ccodigo             VARCHAR2 DEFAULT NULL,
      ag_ciu_cespecial           VARCHAR2 DEFAULT NULL,
      ag_ruc_contratista         VARCHAR2 DEFAULT NULL,
      ag_ind_consorcio           VARCHAR2 DEFAULT NULL,
      ag_f_contrato              VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_ini          VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_fin          VARCHAR2 DEFAULT NULL,
      ag_cod_sist_adquisicion    VARCHAR2 DEFAULT NULL,
      ag_cod_modalidad_alcance   VARCHAR2 DEFAULT NULL,
      ag_observaciones           VARCHAR2 DEFAULT NULL,
      ag_n_propuesta             VARCHAR2 DEFAULT NULL,
      ag_currenpage              VARCHAR2 DEFAULT NULL,
      ag_trama_calendario        VARCHAR2 DEFAULT NULL
   )
   IS

       -- datos de la pantalla
      ln_ag_codconsucode             NUMBER;
      ln_indsiaf                     NUMBER;

      -- Cursores
      ctipocontrato                  ref_cursor;
      cmodalidadalcance              ref_cursor;
      csistemaadquisicion            ref_cursor;
      cmontocontratado               ref_cursor;
      crucscontrato                  ref_cursor;
      ccodpresupuestal               ref_cursor;

      -- datos de los rucs contratistas
      lv_postor_ruc                  VARCHAR2 (11);
      lv_postor_nom                  VARCHAR2 (500);
      ln_propuesta                   VARCHAR2 (50);

      -- CIIU
      lv_descciiu                    VARCHAR2 (250);
      lv_ciu_ccodigo                 reg_procesos.contrato.ciu_ccodigo%TYPE;
      lv_ciu_cespecial               reg_procesos.contrato.ciu_cespecial%TYPE;

      -- datos de la convocatoria
      lv_ag_codconsucode             VARCHAR2 (10);

      -- datos del contrato
      lv_f_contrato                  VARCHAR2 (35);
      ln_cod_sist_adquisicion        reg_procesos.contrato.cod_sist_adquisicion%TYPE;
      ln_cod_modalidad_alcance_res   reg_procesos.contrato.cod_modalidad_alcance%TYPE;
      lv_observaciones               reg_procesos.contrato.observaciones%TYPE;
      ln_n_contrato                  reg_procesos.contrato.n_contrato%TYPE;
      lv_f_vigencia_ini              VARCHAR2 (35);
      lv_f_vigencia_fin              VARCHAR2 (35);
      ln_ind_consorcio               reg_procesos.contrato.ind_consorcio%TYPE;
      ln_n_propuesta                 reg_procesos.contrato.n_propuesta%TYPE;
      ln_cod_tipo_contrato_res       reg_procesos.contrato.cod_tipo_contrato%TYPE;


      -- datos de la entidad pagadora
      lv_codconsucode_paga           reg_procesos.contrato_tipo_entidad.codconsucode_paga%TYPE;
      lv_anhoenidad_paga             reg_procesos.contrato_tipo_entidad.anhoentidad_paga%TYPE;
      lv_descentidad_paga            sease.entidades.descripcion%TYPE;
      ln_cont_paga                   NUMBER;
      lv_anho_convocatoria           NUMBER;
      lv_ruta_file                   VARCHAR2(250);

      --  Variables combos
      lv_combo_tipocontrato          varchar2(4000);
      lv_combo_modalidad_alcance     varchar2(4000);
      lv_combo_sistemaadquisicion    varchar2(4000);
      lv_combo_moneda                varchar2(4000);

      -- Validadores
      ln_cont_codpres                NUMBER;
      ls_cod_presup                  VARCHAR2(10);
      ln_monto_presup                NUMBER;

      -- Codigo Presupuesta
      lv_trama_codPresup             VARCHAR2(32000);

   BEGIN

    -- datos del contrato x grabar
    ln_cod_tipo_contrato_res     := ag_cod_tipo_contrato;
    ln_n_contrato                := ag_n_contrato;
    ln_ind_consorcio             := ag_ind_consorcio;
    lv_f_contrato                := ag_f_contrato;
    lv_f_vigencia_ini            := ag_f_vigencia_ini;
    lv_f_vigencia_fin            := ag_f_vigencia_fin;
    ln_cod_sist_adquisicion      := ag_cod_sist_adquisicion;
    ln_cod_modalidad_alcance_res := ag_cod_modalidad_alcance;
    lv_observaciones             := ag_observaciones;
    ln_n_propuesta               := ag_n_propuesta;

    -- datos de la pantalla
    ln_ag_codconsucode           := session__EUE_CODIGO;
    lv_ag_codconsucode           := lpad(session__eue_codigo,6,'0');
    ln_indsiaf                   := reg_procesos.pku_ss_utiles.f_get_indsiaf (session__N_CONVOCA);

    lv_ruta_file := gpk_directorio_liquidacion||'\'||session__anhoentidad||'\'||session__eue_codigo||'\'||session__N_CONVOCA;

    -- datos de la convocatoria



    -- Javascript
    PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos;
    PKU_GESTOR_CONT_MAKE_CONTRATOS.sp_javascript_valida_ruc;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos_insert;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlContratos(session__anhoentidad,lv_ag_codconsucode,session__N_CONVOCA );
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlGeneral;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlPresupuesto;

    select anho_convoca into lv_anho_convocatoria
      from reg_procesos.convocatorias
      where n_convoca = session__N_CONVOCA;

    -- Descripcion del CIIU

    IF (ag_ciu_ccodigo IS NULL OR ag_ciu_cespecial IS NULL) THEN

      If lv_anho_convocatoria < 2009 Then
           f_get_ciiu (session__N_CONVOCA,lv_ciu_ccodigo,lv_ciu_cespecial,lv_descciiu);
      Else
           PKU_SS_UTILES.f_get_CodNU(session__N_CONVOCA,lv_ciu_ccodigo,lv_descciiu);
      End if;

    ELSE
      If lv_anho_convocatoria < 2009 then
           lv_ciu_ccodigo := ag_ciu_ccodigo;
           lv_ciu_cespecial := ag_ciu_cespecial;
          /* lv_descciiu := agdesciiu;*/
      Else
           lv_ciu_ccodigo := ag_ciu_ccodigo;
          /* lv_descciiu    := agdesciiu;*/
      End if;
    END IF;


    -- datos de la entidad q paga
    reg_procesos.pku_ss_utiles.p_entidad_pagadora (ln_ag_codconsucode,
                                      session__anhoentidad,
                                      2,
                                      ln_cont_paga,
                                      lv_codconsucode_paga,
                                      lv_anhoenidad_paga,
                                      lv_descentidad_paga
                                     );



    usp_print('<input type="hidden" name="an_codconsucode"             value="'||lv_ag_codconsucode|| '"></input>');
    usp_print('<input type="hidden" name=ag_anho_enti_pagadora         value="'||lv_anhoenidad_paga||'">');
    usp_print('<input type="hidden" name=ag_cod_enti_pagadora          value="'||lv_codconsucode_paga||'">');
    usp_print('<input type="hidden" name=ag_InsertarCod                value="">');
    usp_print('<input type="hidden" name="ag_url_pagina"               value="DoNewContrato"></input>');
    usp_print('<input type="hidden" name="ag_currenpage"               value="'||ag_currenpage||'"></input>');
    usp_print('<input type="hidden" name="ag_item_proc_item"           value=""></input>');
    usp_print('<input type="hidden" name="ag_item_monto"               value=""></input>');
    usp_print('<input type="hidden" name="ag_item_cantidad"            value=""></input>');
    usp_print('<input type="hidden" name="ag_item_unmcodigo"           value=""></input>');
    usp_print('<input type="hidden" name="ag_monto_pago"               value=""></input>');
    usp_print('<input type="hidden" name="ag_fecha_pago"               value=""></input>');
    usp_print('<input type="hidden" name="ag_codmoneda"                value=""></input>');
    usp_print('<input type="hidden" name="ag_id_operacion"             value=""></input>');
    usp_print('<input type="hidden" name="ag_num_pago"                 value=""></input>');

    usp_print('<input type="hidden" name="WriteFileDirectory"          value="FileSinged">');
    usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"   value="'||lv_ruta_file||'"></input>');
    usp_print('<input type="hidden" name="v_calendario_total"          value=""/>');

    usp_print('<input type="hidden" name="op_calendario"               value="1"/>');
    usp_print('<input type="hidden" name="ag_trama_items"              value=""/>');
    usp_print('<input type="hidden" name="ag_trama_items_xml"          value=""/>');
    usp_print('<input type="hidden" name="ag_trama_items_codpresup"    value=""/>');


    -- Inicializacion de Cursores

    ctipocontrato            := reg_procesos.pku_ss_utiles.f_ctipo_contrato;
    cmodalidadalcance        := reg_procesos.pku_ss_utiles.f_ctipo_mod_alcance;
    csistemaadquisicion      := reg_procesos.pku_ss_utiles.f_csistema_finance;
    cmontocontratado         := reg_procesos.pku_ss_utiles.f_cmonedas;
    crucscontrato            := f_crucs_contrato (session__N_CONVOCA);
    ccodpresupuestal         := reg_procesos.pku_ss_utiles.f_ccod_presupuesto_conv(lv_ag_codconsucode,session__anhoentidad,session__N_CONVOCA);

    -- Inicializamos los combos
    lv_combo_tipocontrato       := f_retorna_combo(ctipocontrato, 'ag_cod_tipo_contrato', ln_cod_tipo_contrato_res,null,null);
    lv_combo_modalidad_alcance  := f_retorna_combo(cmodalidadalcance, 'ag_cod_modalidad_alcance', ln_cod_modalidad_alcance_res,'--- Seleccionar ---','style="width:339px;"');
    lv_combo_sistemaadquisicion := f_retorna_combo(csistemaadquisicion, 'ag_cod_sist_adquisicion', ln_cod_sist_adquisicion,'--- Seleccionar ---','style="width:339px;"');
    lv_combo_moneda             := f_retorna_combo(cmontocontratado, 'ag_codmoneda_contrato_sel', session__cod_moneda,'--- Seleccionar ---','disabled="true"');

    -- Valida si tiene Codigo Presupuestal --
    ln_cont_codpres := pku_ss_utiles.f_valida_codpresup(session__EUE_CODIGO,session__anhoentidad,session__N_CONVOCA) ;


    usp_print ('<table border=0 width="100%">');
    usp_print ('<tr width="100%"><td>');
    usp_print
       ('<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">');

    usp_print ('<tr>');

    usp_print( REG_PROCESOS.PKU_PROCESOS_COMUN.f_get_titulo(session__N_CONVOCA, 'Creacion de Contratos') );

    usp_print('
       <td align=right valign=top>
         <input type=button value="Volver" onclick="VolverListaContratos()">
         <input type=button value="Grabar" onclick="goInsert('||ln_indsiaf||',''ProcesarInsertContrato'',xmlItems,''ag_trama_items'',xmlItemsCP)">
       </td>
    </tr>
    </table>
    </td></tr>');

    usp_print ('<tr><td>');
    usp_print
       ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="tableform">
            <tr><td><h3>Datos del Contrato<h3></td></tr>
            <tr><td colspan="3" class=c1b>&nbsp;</td></tr>');

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Entidad Pagadora:',
                '<b>'||lv_descentidad_paga||'</b>',
                '&nbsp;'));

    usp_print('<input type="hidden"  name="ag_anho_enti_pagadora" value='||lv_anhoenidad_paga||'>');
    usp_print('<input type="hidden"  name="ag_cod_enti_pagadora"  value='||lv_codconsucode_paga||'>');

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Descripci¿n del contrato/Orden de Compra o Servicio:',
                '<input type=text value="'||ag_des_contrato||'" name="ag_des_contrato" size="54">',
                '&nbsp;Ingrese la descripcion del Contrato'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N¿mero de Contrato u Orden de Compra o Servicio:',
                lv_combo_tipocontrato
                ||'&nbsp;&nbsp;<input size="30" maxlength="250" name="ag_n_contrato" value="'||ln_n_contrato||'">',
                '&nbsp;Ingrese el N¿mero de Contrato'));


    If lv_anho_convocatoria < 2009 then
    -- CIIU


    usp_print('<input type="hidden"  size="3" name="ag_ciu_ccodigo"   maxlength="4" value="'||lv_ciu_ccodigo||'">
               <input type="hidden"  size="1" name="ag_ciu_cespecial" maxlength="2"  value="'||lv_ciu_cespecial||'">');

    Else
          -- CodNU

    usp_print
     (   '<input type="hidden"  size="3" name="ag_ciu_ccodigo" maxlength="4" value="'||lv_ciu_ccodigo||'">
          <input type="hidden"  size="1" name="ag_ciu_cespecial" maxlength="2"  value="">');


    End if;

      -- ruc contratistas

      usp_print
         ('<tr>
               <td class=c1>(*)Ruc Contratista: </td>
               <td class=c2>
                 <select id="combo" style="width:339px;" name="ag_n_propuesta" onchange="cargaRUC(''doNewContrato'');" >
                   <option> Seleccionar </option>');

      LOOP
         FETCH crucscontrato  INTO lv_postor_ruc, lv_postor_nom, ln_propuesta;
         EXIT WHEN crucscontrato%NOTFOUND;
         usp_print ('<option value='||ln_propuesta);

         IF to_char(ln_n_propuesta) = to_char(ln_propuesta) THEN
            usp_print (' selected ');
         END IF;

         usp_print ('>' || lv_postor_ruc || ' - ' || lv_postor_nom  || '</option>');
      END LOOP;

      usp_print ('</select>');
      usp_print
         (   '<input name="ag_ruc_contratista" value="'||ag_ruc_contratista||'" type="hidden">
              <input name="ag_nom_contratista" type="hidden" value="'||reg_procesos.F_WS_RNP_GET_RAZON_SOCIAL(ag_ruc_contratista)||'">
              <input name="ag_ind_consorcio"   type="hidden" value="'||ln_ind_consorcio|| '">'
         );
      usp_print ('</td>
                  <td class=c3>&nbsp;Seleccione el Contratista</td>');
      usp_print ('</tr>');

      usp_print
         ('<tr>
              <td class=c1>Ruc Destinatario del pago: </td>
              <td class=c2><input name="ag_ruc_destino_pago" size="54" value="'||ag_ruc_contratista||'" ></td>
              <td class=c3>&nbsp;Ingrese el Ruc del destinatario del pago</td>
          </tr>
          <tr>
              <td class=c1>Nombre del Destinatario del Pago</td>
              <td class=c2><input name="ag_nom_destino_pago" size="54" value="'||reg_procesos.F_WS_RNP_GET_RAZON_SOCIAL(ag_ruc_contratista)||'" ></td>
              <td class=c3>&nbsp;</td>
          </tr>');

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha de Suscripci¿n del Contrato / notificaci&oacute;n de la Orden de Compra o Servicio:',
                '<input  class=CalSelect type=text size=50 name="ag_f_contrato" readonly onclick="calendario(this)" value="'||lv_f_contrato||'">',
                '&nbsp;Ingrese la Fecha de Suscripcion'));

    usp_print(
              PKU_PROCESOS_COMUN.f_putRowForm('(*)Vigencia del contrato:',
                  '&nbsp;&nbsp;Inicio: <input class=CalSelect type="text" readonly name="ag_f_vigencia_ini" onclick="calendario(this)" value="'
               || lv_f_vigencia_ini
               || '" size=16>&nbsp;&nbsp;&nbsp;Fin: <input class=CalSelect type="text" readonly name="ag_f_vigencia_fin" onclick="calendario(this)" value="'
               || lv_f_vigencia_fin
               || '" size=16>',
                  '&nbsp;Ingrese la fecha de Vigencia del contrato'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Monto Contratado:',
                lv_combo_moneda||'&nbsp;
                <input value="'||session__cod_moneda||'" type="hidden"  name="ag_codmoneda_contrato">
                <input value="" size="30" type="text" readonly name="ag_m_contratado">',
                '&nbsp;Seleccione la Moneda del Contrato'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Situaci¿n:',
                '<b>EN EJECUCI¿N<b>',
                '&nbsp;'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Sistema de Contrataci&oacute;n:',
                lv_combo_sistemaadquisicion,
                '&nbsp;Seleccione el Sistema de Contrataci&oacute;n'));

    -- Modalidad de financiamiento
    usp_print('<input type="hidden"  name="ag_cod_modalidad_finan" value="">');

    -- Modalidad de Alcance
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Modalidad de ejecuci&oacute;n contractual:',
                lv_combo_modalidad_alcance,
                '&nbsp;Ingrese la Modalidad de ejecuci&oacute;n contractual'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
                '<input value=""  size="54" type="text" name="ag_observaciones" value="'||lv_observaciones||'">',
                '&nbsp;Ingrese las Observaciones'));

    usp_print('</table>');
    usp_print ('</td></tr>');
    usp_print ('<tr><td>');

    --  DATOS DEL UPLOAD
    usp_print
         ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="tableform">
              <tr><td colspan=3><h3>Registro de Contrato/Orden de Compra o Servicio</h3></td></tr>
              <tr><td colspan=3 class=c1b>&nbsp;</td></tr>');

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjuntar Archivo',
                '<input type="file"  name="pfiletoupload" size="41"  value="">',
                'Seleccione el archivo que contiene el Contrato/Orden de Compra o Servicio, solo se permiten archivos *.doc o *.pdf'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha del Documento de Contrato',
                '<input readonly name="ag_fec_aprob" size="50" class=CalSelect onclick="calendario(this)" value="">',
                'Seleccione la fecha de aprobaci¿n del documento.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
                '<input value=""  size="54" type="text" name="doc_obs" value="">',
                '&nbsp;Ingrese las Observaciones'));

    usp_print ('</table>');
    usp_print ('</td></tr>');


  IF (ln_indsiaf  = 1)  THEN

      -----------------  Calendario de pagos ------------
      usp_print('
      <tr id="trCalendarioTitle">
      <td></br>
      <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
      <tr><td><h3>Calendario de pagos</h3></td></tr>
      <tr align=center id="trCalendarioBody">');
      usp_print('<TD colspan="4" align=center>');
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlCalendario(session__cod_moneda,ag_trama_calendario,'v_calendario_total');
      usp_print('</td></tr></table></br>');
      usp_print('</td></tr>');

  END IF;

    usp_print( PKU_SS_UTILES.f_getXmlItemsNewContrato(ag_n_propuesta,session__n_convoca,ln_ag_codconsucode,lv_trama_codPresup));

    --- Codigo Presupuesta --
    usp_print(lv_trama_codPresup);
    -------------------------

    usp_print('<script language=javascript>thisform.ag_m_contratado.value =  parseFloat(sumaTotalesItems(xmlItems)) </script>');

    -- Items --

    usp_print ('<tr><td colspan=3>');

    usp_print
     ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="tableform">
          <tr><td colspan=3><h3>Items del Contrato</h3></td></tr>
          <tr>
           <td align="center"colspan=9>
            <input type="button" name="btnAgregaItem" value="Agregar Nuevo Item al Contrato" OnClick="agregaNodoItem(thisform.ag_proc_item.value,''tabla_fin'',xmlItems,thisform.ag_f_bp_cons.value,thisform.ag_ubigeo.value,thisform.ag_descripcion.value,thisform.ag_monto.value,thisform.ag_unidad.value,thisform.ag_cantidad.value,thisform.ag_unidad_codigo.value,'||ln_cont_codpres||' ,'||session__EUE_CODIGO||','||session__anhoentidad||','||session__N_CONVOCA||' );" />
           </td></tr>
          <tr><td colspan=9>&nbsp;</td></tr>');

    usp_print ('<tr><td >');

    usp_print
         ('<table datasrc="#xmlItems" id="tabla_fin" class="TabFilMan" border="0" cellpadding="3" width="100%" cellspacing="0">');

    usp_print
         ('    <thead> <tr>
               <td rowspan=2 class=th1 align=center>&nbsp;</td>
               <td rowspan=2 class=th1 align=center>Nro.</td>
               <td rowspan=2 class=th1 align=center>Item</td>
               <td rowspan=2 class=th1 align=center>Descripci¿n</td>
               <td rowspan=2 class=th1 align=center>Fecha de BP<br> Consentida</td>
               <td rowspan=2 class=th1 align=center>Lugar de la ejecuci¿n<br> de la Prestaci¿n</td>
               <td rowspan=2 class=th1 align=center>U.Medida</td>
               <td rowspan=2 class=th1 align=center>Cantidad</td>
               <td rowspan=2 class=th1 align=center>Monto Contratado</td>
               <td colspan=9 class=th1 align=center>Codigo Presupuestal</td>');
     usp_print('</tr><tr>');

      LOOP
        FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup;
        EXIT WHEN ccodpresupuestal%NOTFOUND;
          usp_print('<td class=th1 align=center>
                         <br />'||ls_cod_presup||'
                         <br /><div style="font-size : 0.9em;" id="divTotal'||ls_cod_presup||'" ></div>
                     </td>');
        END LOOP;
      CLOSE ccodpresupuestal;

    usp_print
         ('</tr>
           <tr bgcolor="#ECE9D8">
               <td><input name="ag_unidad_codigo" type="hidden" value="">&nbsp;</input></td>
               <td align="center"><input name="button1"  value="..." type="button" onclick="VerItemContrato('||session__N_CONVOCA||','||TO_NUMBER (lv_ag_codconsucode)||')"></td>
               <td align="center"><input name="ag_proc_item"    class="InpReadOnly" readonly="true"  size = "1"  style="font-size : 0.9em;"></input></td>
               <td align="left"><input name="ag_descripcion"    class="InpReadOnly" readonly="true"  size = "50" style="font-size : 0.9em;"></input></td>
               <td align="center"><input name="ag_f_bp_cons"    class="InpReadOnly" readonly="true"  size = "11" style="font-size : 0.9em;"></input></td>
               <td align="center"><input name="ag_ubigeo"       class="InpReadOnly" readonly="true"  size = "25" style="font-size : 0.9em;"></input></td>
               <td align="center"><input name="ag_unidad"       class="InpReadOnly" readonly="true"  size = "5"  style="font-size : 0.9em;"></td>
               <td align="center"><input name="ag_cantidad"     class="InpReadOnly" readonly="true"  size = "5"  style="font-size : 0.9em;"></td>
               <td align="center"><input name="ag_monto"        class="InpReadOnly" readonly="true"  size = "10" style="font-size : 0.9em;"></input></td>');

      ccodpresupuestal := reg_procesos.pku_ss_utiles.f_ccod_presupuesto_conv(lv_ag_codconsucode,session__anhoentidad,session__N_CONVOCA);

      LOOP
        FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup;
        EXIT WHEN ccodpresupuestal%NOTFOUND;
          usp_print('<td align="center">&nbsp;</td>');
        END LOOP;
      CLOSE ccodpresupuestal;

      usp_print('</tr></thead> ');
      usp_print('<tbody>');
      usp_print('<tr class="TabFilMan">');
      usp_print('<td align="center"><span datafld="ctr" dataformatas=html></span></td>');
      usp_print('<td align="center"><span datafld="nro"></span></td>');
      usp_print('<td align="center"><span datafld="item"></span></td>');
      usp_print('<td align="left" width="250"><span datafld="des" ></span></td>');
      usp_print('<td align="center"><span datafld="fbp"></span></td>');
      usp_print('<td align="center" width="150"><span datafld="ubi"></span></td>');
      usp_print('<td align="center"><span datafld="unm"></span></td>');
      usp_print('<td align="center"><span datafld="can"></span></td>');
      usp_print('<td align="right" width="62"><span datafld="mon"></span></td>');

      ccodpresupuestal := reg_procesos.pku_ss_utiles.f_ccod_presupuesto_conv(lv_ag_codconsucode,session__anhoentidad,session__N_CONVOCA);
      LOOP
        FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup;
        EXIT WHEN ccodpresupuestal%NOTFOUND;
         --  usp_print('<td align="center" ><input type=text datafld="cp'||ls_cod_presup||'"  onblur="calTotFila('||ls_cod_presup||');" value="" size="8"  align="center" /></td>');
          If ls_cod_presup <> 'Total' Then
                usp_print('<td align=center style="font-size : 0.9em;"><span datafld="cp'||ls_cod_presup||'" dataformatas=html></span></td>');
          Else
                usp_print('<td align=center style="font-size : 0.9em;"><span datafld="cpTotal"></span></td>');
          End if;
        END LOOP;
      CLOSE ccodpresupuestal;

      usp_print('</tr>');
      PKU_SS_UTILES.usp_print_linea_gris;

      usp_print('</tbody>');
      usp_print('</table>');

      usp_print('</td></tr>');
      usp_print('</table>');
      usp_print ('</td></tr>');

      usp_print ('
      </table>
      </td></tr>
      </table>');

  usp_print('

  <script language=javascript>

    var  i = 1;

    var xitems = xmlItems.recordset;
    var sXPath =""
    var oNode
    var xmlPresup = xmlItemsCP.XMLDocument;

    try{
      while (xitems!= null){

        sXPath  = "root/i[nro=" + i + "]";
        oNode = xmlPresup.selectSingleNode(sXPath);
     ');

      ccodpresupuestal := reg_procesos.pku_ss_utiles.f_ccod_presupuesto_conv(lv_ag_codconsucode,session__anhoentidad,session__n_convoca);
      LOOP
        FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup;
        EXIT WHEN ccodpresupuestal%NOTFOUND;
          usp_print(' xitems.Fields("cp'||ls_cod_presup||'").value  = oNode.selectSingleNode("cp'||ls_cod_presup||'").text; ');
        END LOOP;
      CLOSE ccodpresupuestal;

 usp_print('xitems.MoveNext();

       i = i + 1 ;
      }
     }catch(err){}
  ');

  usp_print('

   if(xmlItems.selectNodes("root/i").length == 0 && thisform.ag_n_propuesta.value != "" ) {
      thisform.btnAgregaItem.disabled = true;
      alert("YA SE HAN REGISTRADO CONTRATOS PARA TODOS LOS ITEMS ADJUDICADOS");
    }



    function RecargaContrato()
    {
        thisform.ag_InsertarCod.value = "1";
        thisform.scriptdo.value = "doNewContrato";
        thisform.submit();
    }

    function showCodPresupuestal(propuesta,convoca,anhoentidad,entidad,item,operacion)
    {
             window.open("portlet5open.asp?_portletid_=mod_ConsolaContratos&scriptdo=SearchCodPresupuestal&anho_entidad="+anhoentidad+"&ag_n_convoca="+convoca+"&ag_n_propuesta="+propuesta+"&ag_proc_item="+item+"ag_tipo_operacion="+operacion,"","toolbar=no,Width=600,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised");
    }

    function addcodigopresupuestal(convoca,anhoentidad,entidad,item,operacion){
             window.open("portlet5open.asp?_portletid_=mod_ConsolaContratos&scriptdo=BuscarCodPresupuestal&anho_entidad="+anhoentidad+"&ag_n_convoca="+convoca+"&ag_codconsucode="+entidad+"&ag_proc_item="+item+"&ag_tipo_operacion="+operacion,"","toolbar=no,Width=600,Height=400,scrollbars=yes,modal=yes,dependent,alwaysRaised");
    }


  </script>');

   END;


/*******************************************************************************
/ Procedimiento : uspNewContratosItemsDoEdit
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                          Version Inicial
/******************************************************************************/
PROCEDURE uspEliminaCodPresu(ag_n_convoca       VARCHAR2,
                             ag_n_propuesta     VARCHAR2,
                             ag_EliminacodPresu VARCHAR2)
IS
 ln_n_convoca      VARCHAR2(50);
 ln_n_propuesta    VARCHAR2(50);
 ln_codigo         VARCHAR2(50);
BEGIN

 /*usp_print('
  ln_n_convoca      '||ag_n_convoca||'<br>
  ln_n_propuesta    '||ag_n_propuesta||'<br>
  ln_codigo         '||ag_EliminacodPresu||'<br>
 ');
 return;*/
 ln_n_convoca      := ag_n_convoca;
 ln_n_propuesta    := ag_n_propuesta;
 ln_codigo         := ag_EliminacodPresu;

 DELETE reg_procesos.tmp_contrato_cod_presupuestal
 WHERE n_propuesta = to_number(ln_n_propuesta) and
       n_convoca   = to_number(ln_n_convoca) and
       cod_preupuestal = to_number(ln_codigo);

 COMMIT;

 usp_print('
 <input type=hidden name=ag_InsertarCod value="1">
 <input type=hidden name=ag_InsertarCod value="">
 <input type=hidden name=ag_n_convoca value="'||ln_n_convoca||'">
 <input type=hidden name=ag_n_propuesta value="'||ln_n_propuesta||'">
 <script language=javascript>
   retornar();

   function retornar()
   {
     thisform.scriptdo.value="doNewContrato";
     thisform.submit();
   }

 </script>
 ');

END;






/*******************************************************************************
/ Procedimiento : uspManContratosDoEdit
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                          Version Inicial
/******************************************************************************/
   PROCEDURE uspmancontratosdoedit (
      session__userid            VARCHAR2 DEFAULT NULL,
      session__N_CONVOCA         VARCHAR2 DEFAULT NULL,
      ag_cod_contrato            VARCHAR2 DEFAULT NULL,
      ag_proc_tipo               VARCHAR2 DEFAULT NULL,
      ag_proc_desc               VARCHAR2 DEFAULT NULL,
      ag_proc_sigla              VARCHAR2 DEFAULT NULL,
      ag_iproc_item              VARCHAR2 DEFAULT NULL,
      ag_iop_item                VARCHAR2 DEFAULT NULL,
      ag_unm_codigo              VARCHAR2 DEFAULT NULL,
      ag_calop_item              VARCHAR2 DEFAULT NULL,
      ag_calop_numpago           VARCHAR2 DEFAULT NULL,
      ag_des_contrato            VARCHAR2 DEFAULT NULL,
      ag_cod_tipo_contrato       VARCHAR2 DEFAULT NULL,
      ag_n_contrato              VARCHAR2 DEFAULT NULL,
      ag_f_contrato              VARCHAR2 DEFAULT NULL,
      ag_cod_sist_adquisicion    VARCHAR2 DEFAULT NULL,
      ag_cod_modalidad_alcance   VARCHAR2 DEFAULT NULL,
      ag_observaciones           VARCHAR2 DEFAULT NULL,
      ag_currenpage              VARCHAR2 DEFAULT NULL,
      v_calendario               VARCHAR2 DEFAULT NULL,
      session__FileSingedHTTP    VARCHAR2 DEFAULT NULL,
      session__anhoentidad       VARCHAR2,
      session__eue_codigo        VARCHAR2,
      ag_trama_calendario        VARCHAR2
   )
   IS


      CURSOR cConsorcioMiembros(ruc_consorcio VARCHAR2,n_convoca NUMBER)
       IS
         SELECT b.RUC_MIEMBRO,b.NOM_MIEMBRO FROM REG_PROCESOS.CONVOCATORIA_PROPUESTA a
              INNER JOIN  REG_PROCESOS.CONSORCIO_MIEMBRO b ON a.COD_CONSORCIO = b.COD_CONSORCIO
              WHERE a.RUC_POSTOR = ruc_consorcio AND
                    a.N_CONVOCA = n_convoca;



      -- Calendario de pago
      -- Sale de la tabla contrato_operacion_calendario

      CURSOR ccalendariopago (p_n_cod_contrato NUMBER)
      IS
         SELECT   a.num_pago,
                  TO_CHAR(a.fec_pago,reg_procesos.pku_ss_constantes.gv_formato_fecha ) fec_pago,
                  a.codmoneda, a.monto_pago, m.descripcion,
                  a.id_operacion
             FROM reg_procesos.CONTRATO_OPERACION_CALENDARIO  a,
                  reg_procesos.monedas m,
                  reg_procesos.contrato c
            WHERE c.n_cod_contrato = p_n_cod_contrato
              AND a.ID_OPERACION   = C.ID_OPERACION
              AND a.codmoneda = m.codmoneda
         ORDER BY a.num_pago;

      -- datos de la pantalla
      ln_cod_contrato                NUMBER;
      ln_n_convoca                   NUMBER;
      ln_user_adm_proc               NUMBER;
      ln_estado_rnp_despago          NUMBER;
      ln_indsiaf                     NUMBER;
      -- Cursores
      ctipopostor                    ref_cursor;
      ctipocontrato                  ref_cursor;
      cmodalidadalcance              ref_cursor;
      csistemaadquisicion            ref_cursor;
      cmoneda                        ref_cursor;
      crucscontrato                  ref_cursor;
      ccodpresupuestal               ref_cursor;

      -- datos de los rucs contratistas
      lv_postor_ruc                  VARCHAR2 (11);
      lv_postor_nom                  VARCHAR2 (500);
      ln_propuesta                   NUMBER;
      -- Datos de los items
      ln_items_resueltos             NUMBER;
      ln_items_en_ejecucion          NUMBER;
      -- Estado del contrato
      lv_estado_contrato             VARCHAR2 (200);
      -- CIIU
      lv_descciiu                    VARCHAR2 (250);
      -- Datos de fechas del contrato
      ld_fec_contrato                DATE;
      ld_fec_culimnacion             DATE;
      ln_dummy                       NUMBER;
      -- datos de la convocatoria
      lv_ag_codconsucode             VARCHAR2 (10);
      ln_ag_n_convocaout             NUMBER;
      ln_ag_codmoneda                NUMBER;
      lv_ag_anhoentidad              VARCHAR2 (10);
      ln_ag_proc_tipo                NUMBER;
      ln_ag_proc_num                 NUMBER;
      lv_ag_proc_sigla               VARCHAR2 (20);
      lv_ag_proc_tipo_sigla          VARCHAR2 (20);
      ln_ag_cod_tipo_modalidad       NUMBER;
      ln_ag_resultado                NUMBER;
      ln_ag_objeto                   NUMBER;
      -- datos del contrato por editar
      ln_cod_contrato_res            reg_procesos.contrato.n_cod_contrato%TYPE;
      ln_n_convoca_res               reg_procesos.contrato.n_convoca%TYPE;
      ln_item                        reg_procesos.contrato.n_item%TYPE;
      lv_des_contrato                reg_procesos.contrato.des_contrato%TYPE;
      lv_ciu_ccodigo                 reg_procesos.contrato.ciu_ccodigo%TYPE;
      lv_ciu_cespecial               reg_procesos.contrato.ciu_cespecial%TYPE;
      lv_ruc_contratista             reg_procesos.contrato.ruc_contratista%TYPE;
      lv_ruc_destino_pago            reg_procesos.contrato.ruc_destino_pago%TYPE;
      lv_nom_destino_pago            reg_procesos.contrato.nom_destino_pago%TYPE;
      lv_f_contrato                  VARCHAR2 (35);
      ln_codmoneda_contrato          reg_procesos.contrato.codmoneda_contrato%TYPE;
      lf_m_contratado                VARCHAR2 (35);
      lf_m_contrato                  VARCHAR2 (35);
      ln_cod_situacion               reg_procesos.contrato.cod_situacion%TYPE;
      ln_cod_causa_resoucion         reg_procesos.contrato.cod_causa_resoucion%TYPE;
      lv_f_liquidacion               VARCHAR2 (35);
      lv_f_intervencion              VARCHAR2 (35);
      ln_cod_sist_adquisicion        reg_procesos.contrato.cod_sist_adquisicion%TYPE;
      ln_cod_modalidad_finan_res     reg_procesos.contrato.cod_modalidad_finan%TYPE;
      ln_cod_modalidad_alcance_res   reg_procesos.contrato.cod_modalidad_alcance%TYPE;
      ln_plazo_real                  reg_procesos.contrato.plazo_real%TYPE;
      ln_mon_codigo                  reg_procesos.contrato.mon_codigo%TYPE;
      lf_mon_desc                    VARCHAR2 (35);
      lf_costo_final                 VARCHAR2 (35);
      ln_cod_sancion                 reg_procesos.contrato.cod_sancion%TYPE;
      lf_penalidad                   VARCHAR2 (35);
      ln_cod_ejec_garantias          reg_procesos.contrato.cod_ejec_garantias%TYPE;
      lv_observaciones               reg_procesos.contrato.observaciones%TYPE;
      ln_n_contrato                  reg_procesos.contrato.n_contrato%TYPE;
      ln_codconsucode_res            reg_procesos.contrato.codconsucode%TYPE;
      lv_f_vigencia_ini              VARCHAR2 (35);
      lv_f_vigencia_fin              VARCHAR2 (35);
      ln_convoca_pad                 VARCHAR2 (10);
      ln_cod_contrato_pad            VARCHAR2 (10);
      lv_nom_contratista             reg_procesos.contrato.nom_contratista%TYPE;
      ln_ind_consorcio               reg_procesos.contrato.ind_consorcio%TYPE;
      ln_n_propuesta                 reg_procesos.contrato.n_propuesta%TYPE;
      ln_cod_tipo_contrato_res       reg_procesos.contrato.cod_tipo_contrato%TYPE;
      ln_cod_tipo_postor             reg_procesos.contrato.cod_tipo_postor%TYPE;
      ln_cod_pais_destino_pago       reg_procesos.contrato.cod_pais_destino_pago%TYPE;
      lv_des_pais                    reg_procesos.t_pais.des_pais%TYPE;
      ln_cod_tipo_modalidad          reg_procesos.convocatorias.cod_tipo_modalidad%TYPE;
      ln_id_operacion                reg_procesos.contrato.id_operacion%TYPE;
      ln_error                       NUMBER;
      -- datos de la entidad pagadora
      lv_codconsucode_paga_vi        reg_procesos.contrato_tipo_entidad.codconsucode_paga%TYPE;
      lv_anhoenidad_paga_vi          reg_procesos.contrato_tipo_entidad.anhoentidad_paga%TYPE;
      lv_codconsucode_paga           reg_procesos.contrato_tipo_entidad.codconsucode_paga%TYPE;
      lv_anhoenidad_paga             reg_procesos.contrato_tipo_entidad.anhoentidad_paga%TYPE;
      lv_descentidad_paga            sease.entidades.descripcion%TYPE;
      ln_cont_paga                   NUMBER;
      anho_convocatoria              VARCHAR2(20);
      lv_COD_NU_SEG                  VARCHAR2(100);
      lv_DES_NU_SEG                  VARCHAR2(100);
      LN_INDPUB_CONTRATO             NUMBER;

      --  Variables combos
      lv_combo_tipocontrato          VARCHAR2(4000);
      lv_combo_modalidad_alcance     VARCHAR2(4000);
      lv_combo_sistemaadquisicion    VARCHAR2(4000);
      lv_combo_moneda                VARCHAR2(4000);

      -- variables de los datos del upload
      ln_NCOD_DOC                   NUMBER;
      lv_DOC_URL                    VARCHAR2(250);
      lv_FEC_UPLOAD                 VARCHAR2(20);
      lv_USER_UPLOAD                VARCHAR2(30);
      lv_FEC_APROB                  VARCHAR2(20);
      lv_EXT_TIPO_FILE              VARCHAR2(250);
      lv_ICON_TIPO_FILE             VARCHAR2(250);
      lv_DOC_OBS                    VARCHAR2(250);
      lv_ruta_file                  VARCHAR2(250);
      -- Tramas
      lv_trama_items                VARCHAR2(32000);
      lv_trama_calendario           VARCHAR2(4000);
      lv_trama_items_codpresup      VARCHAR2(32000);
      -- Validador
      ln_cont_codpres               NUMBER;

      ls_cod_presup                 VARCHAR2(10);
      ln_monto_presup               NUMBER;
      ln_item_presup                NUMBER;

   BEGIN

     lv_ruta_file := gpk_directorio_liquidacion||'\'||session__anhoentidad||'\'||session__eue_codigo||'\'||session__N_CONVOCA;

     ln_n_convoca             := session__N_CONVOCA;
     ln_cod_contrato          := ag_cod_contrato;
     ln_user_adm_proc         := reg_procesos.pku_ss_utiles.f_get_induseradmin (session__userid);
     ln_indsiaf               := reg_procesos.pku_ss_utiles.f_get_indsiaf (ln_n_convoca);
     LN_INDPUB_CONTRATO       := PKU_SS_UTILES.f_get_indPubContrato(ln_cod_contrato);
     -- Valida si tiene Codigo Presupuestal --
     ln_cont_codpres          := pku_ss_utiles.f_valida_codpresup(session__EUE_CODIGO,session__anhoentidad,session__N_CONVOCA) ;

     usp_print(PKU_SS_UTILES.f_getXmlItemsManContrato(ln_cod_contrato,ln_n_convoca,lv_trama_items_codpresup));

    /* lv_trama_items           := PKU_SS_UTILES.f_getXmlItemsManContrato(ln_cod_contrato,ln_n_convoca,lv_trama_items_codpresup);    */
     lv_trama_calendario      := nvl(ag_trama_calendario,PKU_SS_UTILES.f_getXmlCalContrato(ln_cod_contrato));

     /*usp_print(lv_trama_items);*/
     usp_print(lv_trama_items_codpresup);

      -- inicializamos variables de sesion
      usp_print ('<SESSION_EXPORT>
                    <AG_COD_CONTRATO>'||ln_cod_contrato||'</AG_COD_CONTRATO>
                    <COD_CONTRATO>'||ln_cod_contrato||'</COD_CONTRATO>
                  </SESSION_EXPORT>');


  -- datos de la convocatoria
 uspverconvocatoriadoview (ln_n_convoca,
                           lv_ag_codconsucode,
                           ln_ag_n_convocaout,
                           ln_ag_codmoneda,
                           lv_ag_anhoentidad,
                           ln_ag_proc_tipo,
                           ln_ag_proc_num,
                           lv_ag_proc_sigla,
                           lv_ag_proc_tipo_sigla,
                           ln_ag_cod_tipo_modalidad,
                           ln_ag_resultado,
                           ln_ag_objeto
                          );

      -- datos del contrato
      uspvercontratodoview (ln_cod_contrato,
                            ln_cod_contrato_res,
                            ln_n_convoca_res,
                            ln_item,
                            lv_des_contrato,
                            lv_ciu_ccodigo,
                            lv_ciu_cespecial,
                            lv_ruc_contratista,
                            lv_ruc_destino_pago,
                            lv_nom_destino_pago,
                            lv_f_contrato,
                            ln_codmoneda_contrato,
                            lf_m_contratado,
                            lf_m_contrato,
                            ln_cod_situacion,
                            ln_cod_causa_resoucion,
                            lv_f_liquidacion,
                            lv_f_intervencion,
                            ln_cod_sist_adquisicion,
                            ln_cod_modalidad_finan_res,
                            ln_cod_modalidad_alcance_res,
                            ln_plazo_real,
                            ln_mon_codigo,
                            lf_mon_desc,
                            lf_costo_final,
                            ln_cod_sancion,
                            lf_penalidad,
                            ln_cod_ejec_garantias,
                            lv_observaciones,
                            ln_n_contrato,
                            ln_codconsucode_res,
                            lv_f_vigencia_ini,
                            lv_f_vigencia_fin,
                            ln_convoca_pad,
                            ln_cod_contrato_pad,
                            lv_nom_contratista,
                            ln_ind_consorcio,
                            ln_n_propuesta,
                            ln_cod_tipo_contrato_res,
                            ln_cod_tipo_postor,
                            ln_cod_pais_destino_pago,
                            lv_des_pais,
                            ln_cod_tipo_modalidad,
                            ln_id_operacion,
                            lv_codconsucode_paga_vi,
                            lv_anhoenidad_paga_vi,
                            ln_error
                           );


      -- datos del upload del contrato
      REG_PROCESOS.PKU_SS_UTILES.P_last_upload_contrato(
                            ln_cod_contrato,
                            session__N_CONVOCA,
                            ln_NCOD_DOC,
                            lv_DOC_URL,
                            lv_FEC_UPLOAD ,
                            lv_USER_UPLOAD,
                            lv_FEC_APROB ,
                            lv_EXT_TIPO_FILE,
                            lv_ICON_TIPO_FILE,
                            lv_DOC_OBS );


      IF ag_f_contrato IS NOT NULL AND ag_f_contrato <> lv_f_contrato  THEN
         ln_estado_rnp_despago :=
            SUBSTR
               (reg_procesos.f_ws_rnp_get_estado
                   (lv_ruc_destino_pago,
                    ln_ag_objeto,
                    TO_CHAR(TO_DATE (ag_f_contrato, reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24 ),'yyyymmdd')),
                    1,
                    1
               );
      END IF;

      -- Javascript
      PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos;
      sp_javascript_contratos_ficha;
      PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos_update;
      sp_javascript_valida_ruc;
      PKU_GESTOR_CONT_FUNCIONES_JS_2.fOperacionesPagina;

      PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlContratos(lv_ag_anhoentidad,ln_cod_contrato,session__N_CONVOCA);
      PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlGeneral;
      PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlPresupuesto;

      IF ln_error = reg_procesos.pku_ss_constantes.gn_opexito  THEN
         select anho_convoca into anho_convocatoria from reg_procesos.convocatorias
                where n_convoca = session__N_CONVOCA;

         if anho_convocatoria < 2009 then
             -- CIIU
             lv_descciiu := f_get_ciiudesc (lv_ciu_ccodigo, lv_ciu_cespecial);
         else
             -- CodNU
             PKU_SS_UTILES.f_get_CodNU(session__N_CONVOCA,lv_COD_NU_SEG,lv_DES_NU_SEG);
         end if;

     -- Hidden
   usp_print('<input type="hidden" name="an_codconsucode"             value="'||ln_codconsucode_res|| '"></input>');
   usp_print('<input type="hidden" name="ag_cod_contrato"             value="'||ag_cod_contrato|| '"></input>');
   usp_print('<input type="hidden" name="ag_proc_tipo"                value="'||ag_proc_tipo||'"></input>');
   usp_print('<input type="hidden" name="ag_proc_desc"                value="'||ag_proc_desc||'"></input>');
   usp_print('<input type="hidden" name="ag_proc_sigla"               value="'||ag_proc_sigla||'"></input>');
   usp_print('<input type="hidden" name="ag_currenpage"               value="'||ag_currenpage||'"></input>');
   usp_print('<input type="hidden" name="ag_iop_item"                 value="'||ag_iop_item||'"></input>');
   usp_print('<input type="hidden" name="ag_iproc_item"               value="'||ag_iproc_item||'"></input>');
   usp_print('<input type="hidden" name="ag_UNM_CODIGO"               value="'||ag_unm_codigo||'"></input>');
   usp_print('<input type="hidden" name="ag_calop_item"               value="'||ag_calop_item||'"></input>');
   usp_print('<input type="hidden" name="ag_calop_numpago"            value="'||ag_calop_numpago||'"></input>');
   usp_print('<input type="hidden" name="ag_mon_codigo"               value="'||ln_mon_codigo||'"></input>');
   usp_print('<input type="hidden" name="ag_evento"                   value="doEditContrato"/>');
   usp_print('<input type="hidden" name="op_calendario"               value="2"/>');
   usp_print('<input type="hidden" name="ag_item_proc_item"           value=""></input>');
   usp_print('<input type="hidden" name="ag_item_monto"               value=""></input>');
   usp_print('<input type="hidden" name="ag_item_cantidad"            value=""></input>');
   usp_print('<input type="hidden" name="ag_item_unmcodigo"           value=""></input>');
   usp_print('<input type="hidden" name="ag_monto_pago"               value=""></input>');
   usp_print('<input type="hidden" name="ag_fecha_pago"               value=""></input>');
   usp_print('<input type="hidden" name="ag_codmoneda"                value=""></input>');
   usp_print('<input type="hidden" name="ag_idfila"                   value=""></input>');
   usp_print('<input type="hidden" name="ag_num_pago"                 value=""></input>');
   usp_print('<input type="hidden" name="ag_n_propuesta"              value="'||ln_n_propuesta||'"></input>');
   usp_print('<input type="hidden" name="ag_tipo_postor"              value="'||ln_cod_tipo_postor||'"></input>');
   usp_print('<input type="hidden" name="WriteFileDirectory"          value="FileSinged">');
   usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"   value="'||lv_ruta_file||'"></input>');
   usp_print ('<input type="hidden" name="ag_n_convoca"               value="'||ln_n_convoca||'">');
   usp_print('<input type="hidden"  name="ag_m_contrato"              value=""/>');
   usp_print('<input type="hidden"  name="ag_indpub_contrato"         value="'||LN_INDPUB_CONTRATO||'"/>');
   usp_print('<input type="hidden"  name="ag_id_operacion"            value="'||ln_id_operacion||'"/>');

   usp_print('<input type="hidden" name="v_calendario_total"          value=""/>');
   usp_print('<input type="hidden" name="ag_trama_items"              value=""/>');
   usp_print('<input type="hidden" name="ag_trama_items_xml"          value=""/>');
   usp_print('<input type="hidden" name="ag_trama_items_codpresup"    value=""/>');

   -- Estado de los items del contrato
   ln_items_resueltos    := f_get_cantitemsresueltos (ln_cod_contrato);
   ln_items_en_ejecucion := f_get_cantitemsenejecucion (ln_cod_contrato);

   -- Estado del contrato  ---
   ln_dummy := f_get_fechasprorroga (ln_cod_contrato,ld_fec_contrato,ld_fec_culimnacion);

   lv_estado_contrato :=
      f_get_estadocontrato (ld_fec_contrato,
                            ld_fec_culimnacion,
                            TO_DATE (lv_f_liquidacion,reg_procesos.pku_ss_constantes.gv_formato_fecha),
                            TO_DATE (lv_f_intervencion,reg_procesos.pku_ss_constantes.gv_formato_fecha),
                            ln_items_resueltos,
                            ln_items_en_ejecucion
                           );

     -- Inicializacion de Cursores

   ctipocontrato               := reg_procesos.pku_ss_utiles.f_ctipo_contrato;
   ctipopostor                 := reg_procesos.pku_ss_utiles.f_ctipo_postor;
   cmodalidadalcance           := reg_procesos.pku_ss_utiles.f_ctipo_mod_alcance;
   csistemaadquisicion         := reg_procesos.pku_ss_utiles.f_csistema_finance;
   cmoneda                     := reg_procesos.pku_ss_utiles.f_cmonedas;
   crucscontrato               := f_crucs_contrato (ln_n_convoca);
   ccodpresupuestal            := reg_procesos.pku_ss_utiles.f_cod_presupuesto_cont(lv_ag_anhoentidad,ln_cod_contrato,ln_n_convoca);

   lv_combo_tipocontrato       := f_retorna_combo(ctipocontrato, 'ag_cod_tipo_contrato', NVL (ag_cod_tipo_contrato, ln_cod_tipo_contrato_res),null,null);
   lv_combo_modalidad_alcance  := f_retorna_combo(cmodalidadalcance, 'ag_cod_modalidad_alcance', NVL (ag_cod_modalidad_alcance, ln_cod_modalidad_alcance_res),'--- Seleccionar ---','style="width:339px;"');
   lv_combo_sistemaadquisicion := f_retorna_combo(csistemaadquisicion, 'ag_cod_sist_adquisicion', NVL (ag_cod_sist_adquisicion, ln_cod_sist_adquisicion),'--- Seleccionar ---','style="width:339px;"');
   lv_combo_moneda             := f_retorna_combo(cmoneda, 'ag_codmoneda_contrato_sel', ln_codmoneda_contrato,null,'disabled="true" style="width:114px;"');


    -- datos de la entidad q paga
    reg_procesos.pku_ss_utiles.p_entidad_pagadora (lv_codconsucode_paga_vi,
                                           lv_anhoenidad_paga_vi,
                                           1,
                                           ln_cont_paga,
                                           lv_codconsucode_paga,
                                           lv_anhoenidad_paga,
                                           lv_descentidad_paga
                                          );

   usp_print ('
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
        <tr>
            <td>'||REG_PROCESOS.PKU_PROCESOS_COMUN.f_get_titulo(session__N_CONVOCA, 'Modificaci¿n de Contratos') ||'</td>
            <td align=right valign="top">
              <input type=button value="Volver" name="btnVolver" onclick="thisform.scriptdo.value=''doViewConsolaContratos'';thisform.submit();">');

    -- Si no es administrador de procesos, se muestra el boton "grabar"
    IF ln_user_adm_proc <> 1 THEN
               usp_print('<input type=button value="Guardar" name="btnGuardar" onclick="Grabar('||pku_ss_utiles.f_get_indsiaf (ln_n_convoca)||',xmlItems,''ag_trama_items'',xmlItemsCP);">');
    END IF;
        usp_print('<input type=button value="Publicar Contrato" name="btnPublicar" onclick="Publicar();">

            </td>
        </tr>
        </table>

        <table border="0" cellpadding="3" cellspacing="0" width="100%" class="tableform">
        <tr><td><h3>Datos del Contrato</h3></td></tr>
        <tr><td colspan="3" class=c1b>&nbsp;</td></tr>');

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Entidad Pagadora',
                '<b>'||lv_descentidad_paga||'</b>',
                'Entidad encargada de efectuar el pago.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Descripci¿n del contrato/Orden de Compra o Servicio',
                '<input type=text value="'|| NVL (TRIM (ag_des_contrato), lv_des_contrato) ||'" name="ag_des_contrato" size="54">',
                '&nbsp;Descripci¿n del contrato/Orden de Compra o Servicio'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N¿mero de Contrato u Orden de Compra o Servicio:',
                lv_combo_tipocontrato
                ||'&nbsp;<input size=30 maxlength="250" name="ag_n_contrato" value="'||NVL (ag_n_contrato, ln_n_contrato)|| '">',
                '&nbsp;N¿mero de Contrato u Orden de Compra o Servicio'));



   IF anho_convocatoria < 2009 THEN

   usp_print('<input type="hidden"  size="3" name="ag_ciu_ccodigo"   maxlength="4"  value="'||lv_ciu_ccodigo||'">
              <input type="hidden"  size="1" name="ag_ciu_cespecial" maxlength="2"  value="'||lv_ciu_cespecial||'">');

   ELSE

   usp_print('<input type="hidden"  size="3" name="ag_ciu_ccodigo"    maxlength="4"  value="'||lv_COD_NU_SEG||'">
              <input type="hidden"  size="1" name="ag_ciu_cespecial"  maxlength="2"  value="">');

   END IF;

   usp_print('
        <tr>
           <td class=c1>(*)Ruc Contratista: </td>
           <td class=c2>
                <select id="combo" name="ag_n_propuesta_dis" disabled="true" style="width:339px;">');
                LOOP
                     FETCH crucscontrato INTO lv_postor_ruc, lv_postor_nom, ln_propuesta;
                     EXIT WHEN crucscontrato%NOTFOUND;
                     usp_print ('<option value=' || ln_propuesta);
                     IF ln_n_propuesta = ln_propuesta THEN
                        usp_print (' selected ');
                        lv_nom_contratista := lv_postor_nom;
                        lv_ruc_contratista := lv_postor_ruc;
                     END IF;
                     usp_print ('>'|| lv_postor_ruc|| ' - ' || lv_postor_nom || '</option>');
                END LOOP;

usp_print ('</select>
               <input type="hidden" name="ag_nom_contratista" value="'|| lv_nom_contratista ||'">
               <input type="hidden" name="ag_ruc_contratista" value="'|| lv_ruc_contratista|| '">
            </td>
            <td class=c3>&nbsp; Ruc del Contratista Registrado&nbsp;</td>
        </tr>
        <tr>
            <td class=c1>RUC Destinatario de Pago</td>
            <td class=c2><input name="ag_ruc_destino_pago" size="54" readOnly="true" value="'||lv_ruc_destino_pago||'" ></td>
            <td class=c3>&nbsp;N&uacute;mero RUC del Destinatario de Pago</td>
        </tr>
        <tr>
            <td class=c1>Destinatario del pago: </td>
            <td class=c2><input name="ag_nom_destino_pago" readOnly="true" size="54" value="'||lv_nom_destino_pago||'" ></td>
            <td class=c3>&nbsp;Nombre del destinatario del Pago</td>
        </tr>
        <tr>
            <td class=c1>(*)Fecha de Suscripci¿n del Contrato/notificaci&oacute;n de la Orden de Compra o Servicio:</td>
            <td class=c2><input  class=CalSelect type=text style="width:311px;" name="ag_f_contrato" readOnly="true" onclick="calendario(this)" value="'||lv_f_contrato||'"></td>
            <td class=c3>&nbsp;Fecha de Suscripci¿n del Contrato/notificaci&oacute;n de la Orden de Compra o Servicio</td>
      </tr>'
        );

    usp_print
     ('<tr>
           <td class=c1>(*)Vigencia del contrato:</td>
           <td class=c2>&nbsp;Inicio: <input  class=CalSelect type=text size=16 readOnly="true" name="ag_f_vigencia_ini" onclick="calendario(this)" value="'||lv_f_vigencia_ini||'">
                        &nbsp;Fin: <input  class=CalSelect type=text size=17 readOnly="true" name="ag_f_vigencia_fin" onclick="calendario(this)" value="'||lv_f_vigencia_fin||'">
           </td>
           <td class=c3>&nbsp;Vigencia del Contrato original</td>.
      </tr>');

    usp_print
       ('<tr>
           <td class=c1>(*)Monto Contratado:</td>
           <td class=c2>'||lv_combo_moneda||'
               <input value="'|| ln_codmoneda_contrato||'" type="hidden" name="ag_codmoneda_contrato">
               <input value="'||TRIM (lf_m_contratado)|| '" readOnly="true"  size="34" type="text"  name="ag_m_contratado">
           </td>
           <td class=c3>&nbsp;Monto Contratado</td>
        </tr>
        <tr>
          <td class=c1>(*)Situaci¿n: </td>
          <td class=c2><input value="'||lv_estado_contrato||'" class="InpReadOnly" size="54" type="text" readonly name="agdestpago"/></td>
          <td class=c3>&nbsp;Estado Actual del Contrato</td>
        </tr>');

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Sistema de Contrataci&oacute;n:',
                lv_combo_sistemaadquisicion,
                '&nbsp;Sistema de Contrataci&oacute;n'));

   -- Inicializamos par¿metros
   usp_print
      ('<script languaje="javascript">
            init(document.all(''scriptdo''),'''||lv_postor_ruc||''');
        </script>');

   -- Modalidad de financiamiento
   usp_print('<input type="hidden"  name="ag_cod_modalidad_finan" value="">');

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Modalidad de ejecuci&oacute;n contractual:',
                lv_combo_modalidad_alcance,
                '&nbsp;Modalidad de ejecuci&oacute;n contractual'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
                '<input type=text name="ag_observaciones" value="'|| NVL (ag_observaciones, lv_observaciones)||'" size="54">',
                '&nbsp;Observaciones del Contrato'));


   usp_print ('</table>');

  --  DATOS DEL UPLOAD
  usp_print
       ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="tableform">
            <tr><td colspan=3><h3>Registro de Contrato/Orden de Compra o Servicio</h3></td></tr>
            <tr><td colspan=3 class=c1b>&nbsp;</td></tr>');

  usp_print(
          PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjuntar Archivo',
              '<input type="file"  name="pfiletoupload" style="width:100%"  value="">'||
              case when lv_DOC_URL is not null then '<br><a target=_blank href="'||session__FileSingedHTTP||lv_DOC_URL||'"><img src="'||lv_ICON_TIPO_FILE||'" border="0" width="25" height="25"/></a>' end ||
              case when lv_FEC_UPLOAD is not null then ' Registrado el '||lv_FEC_UPLOAD end
              ,'Seleccione el archivo que contiene el Contrato/Orden de Compra o Servicio, solo se permiten archivos *.doc o *.pdf'));

  usp_print(
          PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha del Documento de Contrato',
              '<input readonly name="ag_fec_aprob" style="width:92%" class=CalSelect onclick="calendario(this)" value="'||lv_FEC_APROB||'">',
              'Seleccione la fecha de aprobaci¿n del documento.'));

  usp_print(
          PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
              '<input size="54" type="text" name="doc_obs" value="'||lv_DOC_OBS||'">',
              '&nbsp;Ingrese las Observaciones'));

  usp_print ('</table>');
  usp_print ('</td></tr>');


 IF reg_procesos.pku_ss_utiles.f_get_indsiaf (ln_n_convoca) = 1 THEN

            ----------------------- Nuevo Calendario --------------------
    usp_print('
    <tr id="trCalendarioTitle">
    <td></br>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
    <tr><td><h3>Calendario de pagos</h3></br></td></tr>
    <tr align=center id="trCalendarioBody">');
    usp_print('<TD colspan="4" align=center>');
    reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlCalendario(ln_ag_codmoneda,lv_trama_calendario,'v_calendario_total');
    usp_print('</td></tr></table></br>');
    usp_print('</td></tr>');

 END IF;

 usp_print('</table><br>');

 usp_print('
         <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
         <tr><td><h3>Items del Contrato</h3></td></tr>
         <tr>
            <td align="center">
                <input type="button" value="Agregar Nuevo Item al Contrato"  OnClick="agregaNodoItem(thisform.ag_proc_item.value,''tabla_fin'',xmlItems,thisform.ag_f_bp_cons.value,thisform.ag_ubigeo.value,thisform.ag_descripcion.value,thisform.ag_monto.value,thisform.ag_unidad.value,thisform.ag_cantidad.value,thisform.ag_unidad_codigo.value,'||ln_cont_codpres||' ,'||lv_ag_codconsucode||','||lv_ag_anhoentidad||','||ln_n_convoca||' );"></input>
            </td>
         </tr>
         <tr><td>&nbsp;</td></tr>
         <tr>
            <td align="center">
              <table  datasrc="#xmlItems" id="tabla_fin" border="0" cellpadding="3" cellspacing="0" width="100%" class="tableform">');
      usp_print
         ('    <thead> <tr>
               <td rowspan=2 class=th1 align=center>&nbsp;</td>
               <td rowspan=2 class=th1 align=center>Nro.</td>
               <td rowspan=2 class=th1 align=center>Item</td>
               <td rowspan=2 class=th1 align=center>Descripci¿n</td>
               <td rowspan=2 class=th1 align=center>Fecha de BP<br> Consentida</td>
               <td rowspan=2 class=th1 align=center>Lugar de la ejecuci¿n<br> de la Prestaci¿n</td>
               <td rowspan=2 class=th1 align=center>U.Medida</td>
               <td rowspan=2 class=th1 align=center>Cantidad</td>
               <td rowspan=2 class=th1 align=center>Monto Contratado</td>
               <td colspan=9 class=th1 align=center>Codigo Presupuestal</td>');
        usp_print('</tr><tr>');

       LOOP

        FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup,ln_item_presup;
        EXIT WHEN ccodpresupuestal%NOTFOUND;
          usp_print('<td class=th1 align=center>
                         <br />'||ls_cod_presup||'
                         <br /><div style="font-size : 0.9em;" id="divTotal'||ls_cod_presup||'" ></div>
                     </td>');
        END LOOP;

       CLOSE ccodpresupuestal;

        usp_print('</tr>
                <tr bgcolor="#ECE9D8">
                     <td>&nbsp;<input name="ag_unidad_codigo" type="hidden" value=""></input></td>
                     <td align="left"><input name="button1"  value="..." type="button" onclick="VerItemContrato_up('''||ln_n_convoca_res||''','''||ln_cod_contrato_res||''','''||TO_NUMBER (ln_codconsucode_res)||''','''||ln_n_propuesta||''')"></td>
                     <td align="left"><input name="ag_proc_item"    class="InpReadOnly" readonly="true"  size = "1"   style="font-size : 0.9em;"></input></td>
                     <td align="left"><input name="ag_descripcion"  class="InpReadOnly" readonly="true"  size = "35"  style="font-size : 0.9em;"></input></td>
                     <td align="left"><input name="ag_f_bp_cons"    class="InpReadOnly" readonly="true"  size = "11"  style="font-size : 0.9em;"></input></td>
                     <td align="left"><input name="ag_ubigeo"       class="InpReadOnly" readonly="true"  size = "25"  style="font-size : 0.9em;"></input></td>
                     <td align="left"><input name="ag_unidad"       class="InpReadOnly" readonly="true"  size = "5"   style="font-size : 0.9em;"></input></td>
                     <td align="left"><input name="ag_cantidad"     class="InpReadOnly" readonly="true"  size = "5"   style="font-size : 0.9em;"></input></td>
                     <td align="left"><input name="ag_monto"        class="InpReadOnly" readonly="true"  size = "9"   style="font-size : 0.9em;"></input></td>
               ' );

       ccodpresupuestal := reg_procesos.pku_ss_utiles.f_cod_presupuesto_cont(lv_ag_anhoentidad,ln_cod_contrato,ln_n_convoca);

       LOOP

        FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup,ln_item_presup;
        EXIT WHEN ccodpresupuestal%NOTFOUND;
          usp_print('<td align="center">&nbsp;</td>');
        END LOOP;

       CLOSE ccodpresupuestal;


        usp_print ('</tr></thead>');
        usp_print('<tbody>');
        usp_print('<tr class="TabFilMan">');
        usp_print('<td><span datafld="ctr" dataformatas=html></span></td>');
        usp_print('<td><span datafld="nro"></span></td>');
        usp_print('<td><span datafld="item"></span></td>');
        usp_print('<td width="220" align=left><span datafld="des"></span></td>');
        usp_print('<td><span datafld="fbp"></span></td>');
        usp_print('<td width="150"><span datafld="ubi"></span></td>');
        usp_print('<td><span datafld="unm"></span></td>');
        usp_print('<td><span datafld="can"></span></td>');
        usp_print('<td width="62" align="right"><span datafld="mon"></span></td>');

       ccodpresupuestal := reg_procesos.pku_ss_utiles.f_cod_presupuesto_cont(lv_ag_anhoentidad,ln_cod_contrato,ln_n_convoca);

       LOOP

        FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup,ln_item_presup;
        EXIT WHEN ccodpresupuestal%NOTFOUND;
         -- usp_print('<td align="center" ><input type=text datafld="cp'||ls_cod_presup||'"  value="" size="8"  align="center" /></td>');
          If ls_cod_presup <> 'Total' Then
                usp_print('<td style="font-size : 0.9em;"><span datafld="cp'||ls_cod_presup||'" dataformatas=html></span></td>');
          Else
                usp_print('<td style="font-size : 0.9em;" align=right><span datafld="cpTotal"></span></td>');
          End if;
       END LOOP;

       CLOSE ccodpresupuestal;


        usp_print('</tr>');
        PKU_SS_UTILES.usp_print_linea_gris;

        usp_print('</tbody>');
        usp_print ('</table>');

        usp_print ('</td></tr>');
        usp_print ('</table>');



END IF;

    usp_print('
    <script language=javascript>
    var  i = 1;

    var xitems = xmlItems.recordset;
    var sXPath =""
    var oNode
    var xmlPresup = xmlItemsCP.XMLDocument;

    try{
      while (xitems!= null){

        sXPath  = "root/i[nro=" + i + "]";
        oNode = xmlPresup.selectSingleNode(sXPath);
');

      ccodpresupuestal := reg_procesos.pku_ss_utiles.f_ccod_presupuesto_conv(lv_ag_codconsucode,lv_ag_anhoentidad,ln_n_convoca);
      LOOP
        FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup;
        EXIT WHEN ccodpresupuestal%NOTFOUND;
          usp_print(' xitems.Fields("cp'||ls_cod_presup||'").value  = oNode.selectSingleNode("cp'||ls_cod_presup||'").text; ');
        END LOOP;
      CLOSE ccodpresupuestal;

    usp_print('xitems.MoveNext();

       i = i + 1 ;
      }
    }catch(err){}
    ');

    ccodpresupuestal := reg_procesos.pku_ss_utiles.f_ccod_presupuesto_conv(lv_ag_codconsucode,lv_ag_anhoentidad,ln_n_convoca);
    LOOP
      FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup;
      EXIT WHEN ccodpresupuestal%NOTFOUND;
       if ls_cod_presup <> 'Total' then
        usp_print('document.getElementById("divTotal'||ls_cod_presup||'").innerHTML = "Total:" + sumaTotalesItemsCPNodo(xmlItemsCP,"'||ls_cod_presup||'");');
       else
        usp_print('document.getElementById("divTotalTotal").innerHTML = sumaTotalesItemsCP(xmlItemsCP,"cpTotal");');
       end if;
      END LOOP;
    CLOSE ccodpresupuestal;

   usp_print('

    if (thisform.ag_indpub_contrato.value == 1){
            f_desabilita_ctrPag()
    }

    function calTotFila(codigo,item,valor,obj){

      if (obj.value == "" ) {
         obj.value = "0"
         valor = obj.value;
     }

      ls_div = "divTotal" + codigo;
      ls_orden = "document.getElementById(''" + ls_div + "'').innerHTML = " + "''Total:" + sumaTotalesCodPresup(xmlItems,codigo,item,valor,xmlItemsCP) + "''";
      eval(ls_orden);
    }
    </script>
  ');


END;

------------------------------------------------------------------------------------------------
/* FUNCION QUE HACE LA VALIDADCION DEL CONTRATISTA O CONSORCIO ANTES DE  REGISTRAR EL CONTRATO*/
------------------------------------------------------------------------------------------------

FUNCTION F_VALIDA_RNP_CONTRATO(
         ag_ruc_contratista   IN VARCHAR2,
         ag_n_convoca         IN VARCHAR2,
         ag_f_contrato        IN VARCHAR2,
         ag_estado_rnp       OUT VARCHAR2
         ) return BOOLEAN
IS
 CURSOR cConsorcioMiembros(ruc_consorcio VARCHAR2,n_convoca NUMBER)
 IS
   SELECT b.RUC_MIEMBRO,b.NOM_MIEMBRO
     FROM REG_PROCESOS.CONVOCATORIA_PROPUESTA a
    INNER JOIN  REG_PROCESOS.CONSORCIO_MIEMBRO b ON a.COD_CONSORCIO = b.COD_CONSORCIO
    WHERE a.RUC_POSTOR = ruc_consorcio
      AND a.N_CONVOCA = n_convoca;

      LB_RETORNO               BOOLEAN;
      lv_ruc_consorcio         VARCHAR2(50);
      lv_n_convoca             NUMBER;
      lv_id_consorcio          VARCHAR2(20);
      lv_estado_rnp            VARCHAR2(500);
      cant                     VARCHAR2(500);
      ln_proc_tipo             NUMBER;
      ln_valida_rucentidad     NUMBER;
      ld_f_contrato            DATE;
      ln_objeto                NUMBER;

BEGIN

  lv_ruc_consorcio := ag_ruc_contratista;
  lv_n_convoca     := to_number(ag_n_convoca);
  lv_id_consorcio  := substr(lv_ruc_consorcio,0,1);
  ld_f_contrato    := to_date(ag_f_contrato,'dd/mm/yyyy');
  LB_RETORNO       := TRUE;

  /*PARA EL DEMO SE QUITO LA VALIDACION */
/*  RETURN TRUE;*/

  SELECT C.CODOBJETO INTO ln_objeto FROM REG_PROCESOS.CONVOCATORIAS C WHERE C.N_CONVOCA = lv_n_convoca;

 SELECT count(1) INTO ln_proc_tipo
    FROM reg_procesos.convocatorias
   WHERE n_convoca = ag_n_convoca
     AND proc_tipo = pku_ss_constantes.gn_tipo_proceso_CN_CI;

  IF ln_proc_tipo = 0 THEN
       -- Consorcio
      IF lv_id_consorcio = 'C' then

        FOR xrow IN cConsorcioMiembros(lv_ruc_consorcio,lv_n_convoca) LOOP


          select count(1) into ln_valida_rucentidad
                 from reg_procesos.entidades e where e.n_ruc = xrow.RUC_MIEMBRO
                 and e.anhoentidad = to_char(ld_f_contrato,'yyyy');

          -- verificamos que el postor NO sea una entidad
          IF  ln_valida_rucentidad = 0 THEN

              cant := reg_procesos.F_WS_RNP_GET_ESTADO(xrow.RUC_MIEMBRO,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));

              IF cant <> '1-OK' THEN

                ag_estado_rnp := 'El Proveedor del Consorcio '||xrow.NOM_MIEMBRO||' no cuenta con inscripci¿n vigente en el RNP o est¿ inhabilitado para contratar control_estado el estado.';
                  LB_RETORNO := FALSE;
              END IF;

          END IF;

        END LOOP;

      ELSE
      -- Fin Consorcio

      SELECT count(1) INTO ln_valida_rucentidad from reg_procesos.entidades e where e.n_ruc = lv_ruc_consorcio
             and e.anhoentidad = to_char(ld_f_contrato,'yyyy');

      IF ln_valida_rucentidad = 0 THEN

            cant := reg_procesos.F_WS_RNP_GET_ESTADO(lv_ruc_consorcio,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));

            IF cant <> '1-OK' THEN

                ag_estado_rnp := 'El Proveedor con RUC '||lv_ruc_consorcio||' no cuenta con inscripci¿n vigente en el RNP o est¿ inhabilitado para contratar con el estado.';
                LB_RETORNO := FALSE;
            END IF;

      END IF;

   END IF;

 ELSE

      SELECT count(1) INTO ln_valida_rucentidad from reg_procesos.entidades e where e.n_ruc = lv_ruc_consorcio;

      IF ln_valida_rucentidad = 0 THEN

        cant := reg_procesos.F_WS_RNP_GET_ESTADO(lv_ruc_consorcio,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));

        IF cant <> '1-OK' THEN

           lv_estado_rnp := 'El Proveedor esta inhabilitado (temporal o definitivamente) en su derecho de contratar control_estado el Estado.';
           LB_RETORNO := FALSE;

        END IF;

      END IF;

 END IF;

 RETURN LB_RETORNO;

END;

-----------------------------------------------------------------------------------------------------------------
----------- REGISTRA EL CODIGO PRESUPUESTAL A NIVEL DE ITEM -----------
-----------------------------------------------------------------------------------------------------------------

PROCEDURE usp_registra_codpresup(ag_trama_items_codpresup varchar2, ag_ncodcontrato number, ag_nconvoca number,ag_anhoentidad number)
   IS

   v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(32000);

   TYPE      tab_type IS TABLE OF reg_procesos.objeto%ROWTYPE;
   t_tab     tab_type := tab_type();

   ln_procitem    number;
   ln_monto       number;
   ls_codpresup   varchar2(10);
   ln_monto_codpresup    number;

   ccodpresupuestal      ref_cursor;


   ls_cod_presup                 VARCHAR2(10);
   ln_monto_presup               NUMBER;
   ln_item_presup                NUMBER;

   BEGIN


   v_xml              := ag_trama_items_codpresup;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);

   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);
   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');


  delete from ITEM_CONTRATO_PRESUP where n_cod_contrato = ag_ncodcontrato;

  FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
   v_n := xmldom.item(v_nl, cur_emp);

   ln_procitem  := xslprocessor.valueOf(v_n,'item');
/*   ln_monto     := to_number(xslprocessor.valueOf(v_n,'mon'),'9999999999.00');
   ls_codpresup := xslprocessor.valueOf(v_n,'cod');*/

/*  INSERT INTO reg_procesos.ITEM_CONTRATO_PRESUP
          (n_cod_contrato, n_convoca,
           proc_item, COD_PRESUPUESTAL, MONTO
          )
   VALUES (ag_ncodcontrato, ag_nconvoca,
           ln_procitem, ls_codpresup,ln_monto);
*/
  ccodpresupuestal   := reg_procesos.pku_ss_utiles.f_cod_presupuesto_cont(ag_anhoentidad,ag_ncodcontrato,ag_nconvoca);
  LOOP
     FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup,ln_item_presup;
     EXIT WHEN ccodpresupuestal%NOTFOUND;
      ln_monto_codpresup :=  xslprocessor.valueOf(v_n,'cv'||ls_cod_presup);

      IF ln_monto_codpresup IS NOT NULL and ln_monto_codpresup > 0 THEN
         INSERT INTO reg_procesos.ITEM_CONTRATO_PRESUP
               (n_cod_contrato, n_convoca, proc_item, COD_PRESUPUESTAL, MONTO   )
         VALUES(ag_ncodcontrato, ag_nconvoca, ln_procitem, ls_cod_presup,ln_monto_codpresup);
      END IF;
  END LOOP;
  CLOSE ccodpresupuestal;

  END LOOP;
  xmldom.freeDocument(v_doc);


 END;

-----------------------------------------------------------------------------------------------------------------
----------- PROCEDURE USP_REGISTRA_CALENDARIO -----------
-----------------------------------------------------------------------------------------------------------------

PROCEDURE usp_registra_items(ag_trama_items varchar2, ag_ncodcontrato number, ag_nconvoca number, ag_anhoentidad number,ag_cod_consucode number)
   IS

   v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(32000);

   TYPE      tab_type IS TABLE OF reg_procesos.objeto%ROWTYPE;
   t_tab     tab_type := tab_type();

   ln_procitem           number;
   ln_monto              number;
   ln_unmcodigo          number;
   ln_cantidad           number(15,2);
/*   ln_monto_codpresup    number;
*//*   ccodpresupuestal      ref_cursor;
*/

/*   ls_cod_presup                 VARCHAR2(10);
   ln_monto_presup               NUMBER;
   ln_item_presup                NUMBER;*/

   BEGIN

/*   ccodpresupuestal   := reg_procesos.pku_ss_utiles.f_cod_presupuesto_cont(ag_anhoentidad,ag_ncodcontrato,ag_nconvoca);
*/
   v_xml              := ag_trama_items;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);

   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);
   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');

/*  delete from ITEM_CONTRATO_PRESUP where n_cod_contrato = ag_ncodcontrato;*/

FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
   v_n := xmldom.item(v_nl, cur_emp);


   ln_procitem  := xslprocessor.valueOf(v_n,'item');
   ln_monto     := xslprocessor.valueOf(v_n,'mon');
   ln_unmcodigo := xslprocessor.valueOf(v_n,'unc');
   ln_cantidad  := xslprocessor.valueOf(v_n,'can');


  INSERT INTO reg_procesos.item_contrato
          (n_cod_contrato, n_convoca,
           proc_item, monto, unm_codigo,
           cantidad)
  VALUES (ag_ncodcontrato, ag_nconvoca,
           ln_procitem, ln_monto, ln_unmcodigo,
           ln_cantidad);

/*  LOOP
     FETCH ccodpresupuestal INTO ls_cod_presup, ln_monto_presup,ln_item_presup;
     EXIT WHEN ccodpresupuestal%NOTFOUND;
      ln_monto_codpresup :=  xslprocessor.valueOf(v_n,'cp'||ls_cod_presup);
      IF ln_monto_codpresup IS NOT NULL THEN
         INSERT INTO reg_procesos.ITEM_CONTRATO_PRESUP
               (n_cod_contrato, n_convoca,
               proc_item, COD_PRESUPUESTAL, MONTO          )
         VALUES(ag_ncodcontrato, ag_nconvoca,
               ln_procitem, ls_cod_presup,ln_monto_codpresup);
      END IF;
  END LOOP;
  CLOSE ccodpresupuestal; */

END LOOP;

xmldom.freeDocument(v_doc);


END;

/*******************************************************************************
/ Procedimiento : uspProcesarUpdateContrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                          Version Inicial
/******************************************************************************/
 PROCEDURE uspprocesar_pub_contrato (
   ag_cod_contrato                  NUMBER,
   session__AG_N_CONVOCA            VARCHAR2 DEFAULT NULL,
   ag_id_operacion                  VARCHAR2

  )
  IS
      ln_indsiaf                NUMBER;


  BEGIN

  -- Verifica el indicador del SIAF
  ln_indsiaf := reg_procesos.pku_ss_utiles.f_get_indsiaf (session__AG_N_CONVOCA);

  UPDATE REG_PROCESOS.CONTRATO SET  IND_CONTRATO_PUB = 1 WHERE N_COD_CONTRATO = ag_cod_contrato;

  IF ln_indsiaf = 1 THEN

      /*    UPDATE reg_procesos.contrato
             SET id_operacion = reg_procesos.pk_convocatoria.getidoperacion()
           WHERE n_cod_contrato = ag_cod_contrato;
*/
         /* reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion
                             (reg_procesos.pk_convocatoria.getidoperacion());*/

    reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion(ag_id_operacion);


  END IF;

  COMMIT;

  usp_print('<script language="javascript">

         function goSubmit(jscriptdo,obj)
         {
           thisform.scriptdo.value = jscriptdo;
           thisform.submit();
         };
      </script>');


    usp_print('<script language="javascript">goSubmit("doViewConsolaContratos",document.all(''scriptdo''))</script>');

  END;

 -----------------------------------------------------------------------------------------------------------------
----------- PROCEDURE USP_REGISTRA_CALENDARIO -----------
-----------------------------------------------------------------------------------------------------------------

PROCEDURE usp_registra_calendario(ag_trama_calendario varchar2, ag_id_operacion number)
   IS

   v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(4000);

   TYPE      tab_type IS TABLE OF reg_procesos.objeto%ROWTYPE;

   ln_num_pago    number;
   ld_fec_pago    date;
   ln_codmoneda   number;
   ln_montoPago   number(15,2);

   BEGIN

   v_xml              := ag_trama_calendario;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);
   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);

   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/calendario');

  DELETE FROM reg_procesos.contrato_operacion_calendario WHERE ID_OPERACION = ag_id_operacion;

  FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
   v_n := xmldom.item(v_nl, cur_emp);

   ln_num_pago := xslprocessor.valueOf(v_n,'numpago');
   ld_fec_pago := to_date(xslprocessor.valueOf(v_n,'fecha'),'dd/mm/yyyy');
   ln_codmoneda := xslprocessor.valueOf(v_n,'moneda');
   ln_montoPago := xslprocessor.valueOf(v_n,'monto');



    INSERT INTO reg_procesos.contrato_operacion_calendario
                (num_pago,
                 fec_pago,
                 codmoneda,
                 monto_pago,
                 ID_OPERACION)
         VALUES (ln_num_pago,
                 ld_fec_pago,
                 ln_codmoneda,
                 ln_montoPago,
                 ag_id_operacion);
   --    dbms_output.put_line(xslprocessor.valueOf(v_n,'CODOBJETO') || '<-->'||xslprocessor.valueOf(v_n,'DESCRIPCION'));

  END LOOP;
  xmldom.freeDocument(v_doc);


 END;



/*******************************************************************************
/ Procedimiento : uspProcesarUpdateContrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                          Version Inicial
/******************************************************************************/
 PROCEDURE uspprocesarinsertcontrato (
    session__AG_N_CONVOCA           VARCHAR2 DEFAULT NULL,
    session__USERID                 VARCHAR2 DEFAULT NULL,
    ag_des_contrato                 VARCHAR2,
    ag_ciu_ccodigo                  VARCHAR2,
    ag_ciu_cespecial                VARCHAR2,
    ag_ruc_contratista              VARCHAR2,
    ag_f_contrato                   VARCHAR2,
    ag_codmoneda_contrato           VARCHAR2,
    ag_m_contratado                 VARCHAR2,
    ag_cod_sist_adquisicion         VARCHAR2,
    ag_cod_modalidad_finan          VARCHAR2,
    ag_cod_modalidad_alcance        VARCHAR2,
    ag_costo_final                  VARCHAR2,
    ag_observaciones                VARCHAR2,
    ag_n_contrato                   VARCHAR2,
    ag_f_vigencia_ini               VARCHAR2,
    ag_f_vigencia_fin               VARCHAR2,
    ag_n_propuesta                  VARCHAR2,
    ag_nom_contratista              VARCHAR2,
    ag_ind_consorcio                VARCHAR2,
    ag_cod_tipo_contrato            VARCHAR2,
    ag_ruc_destino_pago             VARCHAR2,
    ag_tipo_postor                  VARCHAR2,
    an_codconsucode                 VARCHAR2,
    ag_anhoentidad                  VARCHAR2,
    WriteFileDirectoryDynamic       VARCHAR2,
    session__IIS_REMOTE_ADDR        VARCHAR2 ,
    session__maxMBUploadFileSize    VARCHAR2 ,
    ag_iproc_item                   VARCHAR2 DEFAULT NULL,
    doc_name                        VARCHAR2 DEFAULT NULL,
    ag_calop_numpago                VARCHAR2 DEFAULT NULL,
    ag_anho_enti_pagadora           VARCHAR2 DEFAULT NULL,
    ag_cod_enti_pagadora            VARCHAR2 DEFAULT NULL,
    agdesciiu                       VARCHAR2 DEFAULT NULL,
    doc_obs                         VARCHAR2 DEFAULT NULL,
    ag_proc_desc               IN   VARCHAR2 DEFAULT NULL,
    ag_proc_sigla              IN   VARCHAR2 DEFAULT NULL,
    ag_currenpage              IN   VARCHAR2 DEFAULT NULL,
    v_calendario                    VARCHAR2,
    ag_fec_aprob                    VARCHAR2,
    ag_trama_items                  VARCHAR2,
    ag_trama_items_xml              VARCHAR2,
    iisenv__remote_host             VARCHAR2,
    pfiletoupload                   VARCHAR2,
    pfiletoupload__size             VARCHAR2,
    ag_trama_calendario             varchar2,
    ag_trama_items_codpresup        varchar2
 )
 IS

    validaPropuesta                 NUMBER;
    ln_cod_contrato                 NUMBER;
    ln_op_exito                     NUMBER;
    ln_item                         NUMBER;
    lv_estado_rnp                   VARCHAR2(500);
    control_estado                  NUMBER;
    lv_cod_tipo_postor              VARCHAR2(50);
    lb_validacion_rnp               BOOLEAN;

    -- Upload
    lvtipodocumento                 VARCHAR2(50);
    lv_codtipofile                  VARCHAR2(20);



     CURSOR cConsorcioMiembros(ruc_consorcio VARCHAR2,n_convoca NUMBER)
     IS
       SELECT b.RUC_MIEMBRO,b.NOM_MIEMBRO FROM REG_PROCESOS.CONVOCATORIA_PROPUESTA a
            INNER JOIN  REG_PROCESOS.CONSORCIO_MIEMBRO b ON a.COD_CONSORCIO = b.COD_CONSORCIO
            WHERE a.RUC_POSTOR = ruc_consorcio AND
                  a.N_CONVOCA = n_convoca;



   BEGIN

    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlGeneral;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlContratos;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fFechasGeneral;

    -- Carga de Variables -- Upload
    lvtipodocumento:=upper(substr(pfiletoupload,length(pfiletoupload)-2,length(pfiletoupload)));

    begin
        select cod_tipo_file into lv_codtipofile
        from Reg_procesos.tipo_archivo
        where ext_tipo_file=lvtipodocumento;
    exception
        when no_data_found then
            lv_codtipofile:= Null;
    end;
    -- Fin Upload

     SELECT COUNT(1) INTO validaPropuesta from reg_procesos.convocatoria_propuesta
     where n_convoca  = session__AG_N_CONVOCA and
       ruc_postor = ag_ruc_contratista;

    IF validaPropuesta > 0 THEN

     select cod_tipo_postor into lv_cod_tipo_postor from reg_procesos.convocatoria_propuesta
     where n_convoca  = session__AG_N_CONVOCA and
       ruc_postor = ag_ruc_contratista;

    END IF;

    usp_print('<script language="javascript">

         function goSubmit(jscriptdo,contrato)
         {
           thisform.scriptdo.value = jscriptdo;
           thisform.ag_cod_contrato.value = contrato;
           thisform.submit();
         };
      </script>');

   usp_print('<input type="hidden" name="v_calendario"             value="'||v_calendario||'">');
   usp_print('<input type="hidden" name="ag_proc_desc"             value="'||ag_proc_desc||'">');
   usp_print('<input type="hidden" name="ag_proc_sigla"            value="'||ag_proc_sigla||'">');
   usp_print('<input type="hidden" name="ag_currenpage"            value="'||ag_currenpage||'">');
   usp_print('<input type="hidden" name="ag_ruc_destino_pago"      value="'||ag_ruc_destino_pago||'">');
   usp_print('<input type="hidden" name="ag_des_contrato"          value="'||ag_des_contrato||'">');
   usp_print('<input type="hidden" name="ag_cod_tipo_contrato"     value="'||ag_cod_tipo_contrato||'">');
   usp_print('<input type="hidden" name="ag_n_contrato"            value="'||ag_n_contrato||'">');
   usp_print('<input type="hidden" name="ag_ciu_ccodigo"           value="'||ag_ciu_ccodigo||'">');
   usp_print('<input type="hidden" name="ag_ciu_cespecial"         value="'||ag_ciu_cespecial||'">');
   usp_print('<input type="hidden" name="agDesCIIU"                value="'||agdesciiu||'">');
   usp_print('<input type="hidden" name="ag_ruc_contratista"       value="'||ag_ruc_contratista||'">');
   usp_print('<input type="hidden" name="ag_nom_contratista"       value="'||ag_nom_contratista||'">');
   usp_print('<input type="hidden" name="ag_ind_consorcio"         value="'||ag_ind_consorcio||'">');
   usp_print('<input type="hidden" name="ag_f_contrato"            value="'||ag_f_contrato||'">');
   usp_print('<input type="hidden" name="ag_f_vigencia_ini"        value="'||ag_f_vigencia_ini||'">');
   usp_print('<input type="hidden" name="ag_f_vigencia_fin"        value="'||ag_f_vigencia_fin||'">');
   usp_print('<input type="hidden" name="ag_cod_sist_adquisicion"  value="'||ag_cod_sist_adquisicion||'">');
   usp_print('<input type="hidden" name="ag_cod_modalidad_finan"   value="'||ag_cod_modalidad_finan|| '">');
   usp_print('<input type="hidden" name="ag_cod_modalidad_alcance" value="'||ag_cod_modalidad_alcance||'">');
   usp_print('<input type="hidden" name="ag_costo_final"           value="'||ag_costo_final|| '">');
   usp_print('<input type="hidden" name="ag_observaciones"         value="'||ag_observaciones|| '">');
   usp_print('<input type="hidden" name="an_codconsucode"          value="'||an_codconsucode|| '">');
   usp_print('<input type="hidden" name="ag_iproc_item"            value="'||ag_iproc_item|| '">');
   usp_print('<input type="hidden" name="ag_calop_numpago"         value="'||ag_calop_numpago|| '">');
   usp_print('<input type="hidden" name="ag_cod_contrato"          value="">');



     --***************** VALIDA RNP DE CONTRATISTA Y CONSORCIOS **************


    lb_validacion_rnp := F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, session__AG_N_CONVOCA,ag_f_contrato, lv_estado_rnp);

    control_estado   := 0;

    IF NOT lb_validacion_rnp THEN

      control_estado   := 1;

      usp_print ('<table border=0 width="100%">');
      usp_print('<tr>
          <td align=right valign="top" colspan=3>
             <input type=button value="Volver" onclick="goSubmit(''doNewContrato'',''''));">
          </td>
      </tr>');
      usp_print('</table>');
      usp_print('<h3>'||lv_estado_rnp||'</h3>');

      return;

    END IF;

 --*************************************************************************

If (control_estado = 0) then

  -- Cargamos la trama de Items
  usp_print( ag_trama_items);
  -- Verificamos que se hayan seleccionado al menos un item tambien se valida la fecha de BP por item
  usp_print('
      <script language=javascript>
          var contItems = xmlItems.XMLDocument.selectNodes("root/i").length;
          if (contItems = 0){
                  alert("Por favor ingrese Items");
                  goSubmit("doNewContrato",'''')
          }

          validaFechaContratoBp(xmlItems,"'||ag_f_contrato||'")

      </script>');


  IF ag_m_contratado > 0 THEN
   BEGIN

      SELECT reg_procesos.s_contrato.NEXTVAL INTO ln_cod_contrato FROM DUAL;

      INSERT INTO reg_procesos.contrato
                  (n_cod_contrato,
                   n_convoca,
                   n_item,
                   des_contrato,
                   ciu_ccodigo,
                   ciu_cespecial,
                   ruc_contratista,
                   f_contrato,
                   codmoneda_contrato,
                   m_contratado,
                   cod_situacion,
                   cod_sist_adquisicion,
                   cod_modalidad_finan,
                   cod_modalidad_alcance,
                   mon_codigo,
                   costo_final,
                   observaciones, n_contrato,
                   f_vigencia_ini,
                   f_vigencia_fin,
                   n_propuesta, nom_contratista,
                   ind_consorcio,
                   cod_tipo_contrato,
                   codconsucode,
                   anhoentidad,
                   ruc_destino_pago,
                   codconsucode_paga,
                   anhoentidad_paga,
                   cod_tipo_postor
                  )
           VALUES (ln_cod_contrato,
                   session__AG_N_CONVOCA,
                   ln_item,
                   ag_des_contrato,
                   ag_ciu_ccodigo,
                   ag_ciu_cespecial,
                   ag_ruc_contratista,
                   TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   ag_codmoneda_contrato,
                   DECODE (ag_m_contratado,' ',NULL,TO_NUMBER (ag_m_contratado,'999999999999999.99')),1, ag_cod_sist_adquisicion,
                   ag_cod_modalidad_finan,
                   ag_cod_modalidad_alcance,
                   ag_codmoneda_contrato,
                   DECODE (ag_costo_final,' ', NULL,TO_NUMBER (ag_costo_final,'999999999999999.99')),
                   ag_observaciones,
                   ag_n_contrato,
                   TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   ag_n_propuesta,
                   ag_nom_contratista,
                   ag_ind_consorcio,
                   ag_cod_tipo_contrato,
                   LPAD (an_codconsucode, 6, '0'),
                   ag_anhoentidad,
                   ag_ruc_destino_pago,
                   ag_cod_enti_pagadora,
                   ag_anho_enti_pagadora,
                   lv_cod_tipo_postor
                  );



      ln_op_exito := 1;

   EXCEPTION
      WHEN OTHERS THEN

         usp_print ('Error al registrar el contrato<br>');
         ROLLBACK;
         ln_op_exito := 0;
         RETURN;
   END;


     IF ln_op_exito = 1 THEN

     BEGIN

        PKU_SS_UTILES.p_insUploadContrato(
              reg_procesos.f_get_min_n_convoca(session__AG_N_CONVOCA),
              ag_fec_aprob,
              doc_obs,
              lv_codtipofile,
              pfiletoupload,
              pfiletoupload__size,
              session__userid,
              iisenv__remote_host,
              WriteFileDirectoryDynamic                       ,
              ln_cod_contrato);



   EXCEPTION
      WHEN OTHERS THEN

      usp_print (SQLERRM);
      ROLLBACK;
      ln_op_exito := 0;
      RETURN;

   END;

       BEGIN
       -- registro de items

       usp_registra_items(ag_trama_items_xml,ln_cod_contrato,session__AG_N_CONVOCA,ag_anhoentidad,an_codconsucode);

       -- registro codigo presupuestal por item


       usp_registra_codpresup(ag_trama_items_codpresup,ln_cod_contrato,session__AG_N_CONVOCA,ag_anhoentidad);

       --------- Actualiza Calendario --------
       if ag_trama_calendario is not null then
          usp_registra_calendario(ag_trama_calendario,PK_CONVOCATORIA.gn_id_operacion);
       end if;


       ln_op_exito := 2;

       EXCEPTION
           WHEN OTHERS THEN
              usp_print (SQLERRM);
              ROLLBACK;
              ln_op_exito := 0;
              RETURN;
        END;
   END IF;

  IF ln_op_exito = 2 THEN

          UPDATE reg_procesos.contrato
             SET id_operacion = reg_procesos.pk_convocatoria.getidoperacion()
           WHERE n_cod_contrato = ln_cod_contrato;

        --  reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion
        --                     (reg_procesos.pk_convocatoria.getidoperacion());

          COMMIT;

   ELSE
          ROLLBACK;
          RETURN;
  END IF;

 ELSE
         usp_print('<script language="javascript">
                            alert("El monto del contrato no puede ser 0");
                            goSubmit("doNewContrato",document.all(''scriptdo''))
                   </script>');

 END IF;

-- usp_print('<script language="javascript">goSubmit("doViewConsolaContratos",document.all(''scriptdo''))</script>');
 usp_print('<script language="javascript">goSubmit("ManContratosDoEdit",'||ln_cod_contrato||')</script>');

 END IF;

 END;

/*******************************************************************************
/ Procedimiento : uspProcesarUpdateContrato
/ Proposito :
/ Entradas :
/ Salidas:
/ Versiones :
/ Nombre               Fecha y hora      Modificacion
/ -------------------- ----------------  ---------------------
/ Gerardo Millones                          Version Inicial
/******************************************************************************/
   PROCEDURE uspprocesarupdatecontrato (
      session__cod_contrato           VARCHAR2,
      session__n_convoca              VARCHAR2,
      session__userid                 VARCHAR2,
      ag_des_contrato                 VARCHAR2,
      ag_ciu_ccodigo                  VARCHAR2,
      ag_ciu_cespecial                VARCHAR2,
      ag_ruc_contratista              VARCHAR2,
      ag_f_contrato                   VARCHAR2,
      ag_codmoneda_contrato           VARCHAR2,
      ag_m_contratado                 VARCHAR2,
      ag_cod_sist_adquisicion         VARCHAR2,
      ag_cod_modalidad_finan          VARCHAR2,
      ag_cod_modalidad_alcance        VARCHAR2,
      ag_mon_codigo                   VARCHAR2,
      ag_costo_final                  VARCHAR2,
      ag_observaciones                VARCHAR2,
      ag_f_vigencia_ini               VARCHAR2,
      ag_f_vigencia_fin               VARCHAR2,
      ag_n_propuesta                  VARCHAR2,
      ag_nom_contratista              VARCHAR2,
      ag_ind_consorcio                VARCHAR2,
      ag_cod_tipo_contrato            VARCHAR2,
      ag_ruc_destino_pago             VARCHAR2,
      ag_nom_destino_pago             VARCHAR2,
      ag_tipo_postor                  VARCHAR2,
      ag_cod_pais_destino_pago        VARCHAR2,
      ag_proc_tipo                    VARCHAR2,
      an_codconsucode                 VARCHAR2,
      ag_calop_item                   VARCHAR2,
      ag_iop_item                     VARCHAR2,
      ag_n_contrato                   VARCHAR2,
      ag_iproc_item                   VARCHAR2 DEFAULT NULL,
      ag_calop_numpago                VARCHAR2 DEFAULT NULL,
      ag_proc_desc               IN   VARCHAR2 DEFAULT NULL,
      ag_proc_sigla                   VARCHAR2 DEFAULT NULL,
      ag_currenpage              IN   VARCHAR2 DEFAULT NULL,
      v_calendario                    VARCHAR2 DEFAULT NULL,
      pfiletoupload                   VARCHAR2 DEFAULT NULL,
      pfiletoupload__size             VARCHAR2 DEFAULT NULL,
      pfiletoupload__mimetype         VARCHAR2 DEFAULT NULL,
      WriteFileDirectoryDynamic       VARCHAR2,
      iisenv__remote_host             VARCHAR2,
      ag_fec_aprob                    VARCHAR2 DEFAULT NULL,
      doc_obs                         VARCHAR2 DEFAULT NULL,
      session__anhoentidad            VARCHAR2 ,
      session__eue_codigo             VARCHAR2 ,
      ag_trama_items                  VARCHAR2 ,
      ag_trama_items_xml              VARCHAR2 ,
      ag_id_operacion                 VARCHAR2 ,
      ag_trama_calendario             VARCHAR2 ,
      ag_trama_items_codpresup        VARCHAR2
   )
   IS

    ln_monto_cal              NUMBER;
    ln_indsiaf                NUMBER;
    ln_op_exito               NUMBER;
    ln_item                   NUMBER;
    ln_ruc_destino_pago_out   NUMBER;
    ln_ind_consorcio_out      NUMBER;
    ag_cod_contrato           VARCHAR2(50);
    ag_n_convoca              VARCHAR2(50);
    lv_anho_convocatoria      NUMBER;

    lb_validacion_rnp        boolean;
    lv_estado_rnp            varchar2(600);

    -- Upload
    lvtipodocumento          VARCHAR2(50);
    lv_codtipofile           VARCHAR2(20);

   BEGIN

    -- Carga de Variables -- Upload
    lvtipodocumento:=upper(substr(pfiletoupload,length(pfiletoupload)-2,length(pfiletoupload)));

    begin
        select cod_tipo_file into lv_codtipofile
        from Reg_procesos.tipo_archivo
        where ext_tipo_file=lvtipodocumento;
    exception
        when no_data_found then
            lv_codtipofile:= Null;
    end;
    -- Fin Upload

    select anho_convoca into lv_anho_convocatoria
      from reg_procesos.convocatorias
     where n_convoca = session__n_convoca;

    ag_cod_contrato := session__cod_contrato;
    ag_n_convoca    := session__n_convoca;

    usp_print('
    <script language="javascript">
       function goSubmit(jscriptdo,obj)
       {
         thisform.scriptdo.value = jscriptdo;
         thisform.submit(); };
    </script>');

        usp_print('
    <CENTER>
        <TABLE border="0">
            <TR>
                <TD COLSPAN="3" class=c1>
                    <div id="divEsperar" style="border:0px solid #008000"><img src="images/circle_working.gif"></div>
                </TD>
            </TR>
        </TABLE>
    </CENTER> ');

    usp_print('<input type="hidden" name="ag_proc_desc"     value="'||ag_proc_desc||'">');
    usp_print('<input type="hidden" name="ag_proc_sigla"    value="'||ag_proc_sigla||'">');
    usp_print('<input type="hidden" name="ag_currenpage"    value="'||ag_currenpage||'" >');
    usp_print('<input type="hidden" name="ag_cod_contrato"  value="'||ag_cod_contrato||'">');
    usp_print('<input type="hidden" name="ag_n_convoca"     value="'||ag_n_convoca||'">');
    usp_print('<input type="hidden" name="ag_proc_tipo"     value="'||ag_proc_tipo||'">');
    usp_print('<input type="hidden" name="an_codconsucode"  value="'||an_codconsucode||'">');
    usp_print('<input type="hidden" name="ag_iop_item"      value="'||ag_iop_item||'">');
    usp_print('<input type="hidden" name="ag_calop_item"    value="'||ag_calop_item||'">');
    usp_print('<input type="hidden" name="ag_iproc_item"    value="'||ag_iproc_item||'">');
    usp_print('<input type="hidden" name="ag_calop_numpago" value="'||ag_calop_numpago||'">');

     -- Validacion RNP
  lb_validacion_rnp := F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, ag_n_convoca, ag_f_contrato, lv_estado_rnp);

  IF NOT lb_validacion_rnp THEN

      usp_print ('<table border=0 width="100%">');
      usp_print('<tr>
          <td align=right valign="top" colspan=3>
             <input type=button value="Volver" onclick="goSubmit(''doEditContrato'',document.all(''scriptdo''));">
          </td>
      </tr>');
      usp_print('</table>');
      usp_print('<h3>'||lv_estado_rnp||'</h3>');

      return;

   END IF;
   PKU_GESTOR_CONT_FUNCIONES_JS_2.fFechasGeneral;
   PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlContratos;
  --Setea el indicardor de consorcio segun corresponda
  usp_change_ruc_contratista (  ag_ruc_contratista,
                                ag_ruc_destino_pago,
                                ag_n_propuesta,
                                ag_ind_consorcio,
                                ln_ruc_destino_pago_out,
                                ln_ind_consorcio_out);

   -- Cargamos la trama de Items
  usp_print( ag_trama_items);

  -- Verificamos que se hayan seleccionado al menos un item tambien se valida la fecha de BP por item
  usp_print('
      <script language=javascript>
          var contItems = xmlItems.XMLDocument.selectNodes("root/i").length;
          if (contItems = 0){
                  alert("Por favor ingrese Items");
                  goSubmit("ManContratosDoEdit",document.all(''scriptdo''))
          }

          validaFechaContratoBp(xmlItems,"'||ag_f_contrato||'")

  </script>');

    IF not ag_m_contratado>0 THEN
       usp_print
          ('<script language="javascript">alert("El monto del contrato no puede ser 0");</script>');
       usp_print
          ('<script language="javascript">goSubmit("ManContratosDoEdit",document.all(''scriptdo''))</script>');

    END IF;

    -- Suma de los montos
    select sum(s.MONTO) into ln_monto_cal
            from reg_procesos.item_contrato s
           where s.n_cod_contrato = ag_cod_contrato;

    -- Verifica el indicador del SIAF
    ln_indsiaf := reg_procesos.pku_ss_utiles.f_get_indsiaf (ag_n_convoca);

     /* IF (ln_indsiaf = 1 AND(ln_monto_cal<>TO_NUMBER(ag_m_contratado,reg_procesos.pku_ss_constantes.gv_formato_dinero)OR ln_monto_cal IS NULL))THEN
         usp_print
            ('<script language="javascript">alert("La suma de los montos en el Calendario de pago con coincide con el monto contratado, corrija e intente nuevamente");</script>');
         usp_print
            ('<script language="javascript">goSubmit("ManContratosDoEdit",document.all(''scriptdo''))</script>');
         RETURN;
      END IF;*/

      BEGIN
            UPDATE reg_procesos.contrato
               SET n_item                = ln_item,
                 des_contrato            = TRIM (ag_des_contrato),
                 ciu_ccodigo             = TRIM (ag_ciu_ccodigo),
                 ciu_cespecial           = ag_ciu_cespecial,
                 ruc_contratista         = ag_ruc_contratista,
                 f_contrato              = TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 codmoneda_contrato      = ag_codmoneda_contrato,
                 m_contratado            = DECODE (ag_m_contratado,' ', NULL,TO_NUMBER (ag_m_contratado,'999999999999999.99')),
                 cod_sist_adquisicion    = ag_cod_sist_adquisicion,
                 cod_modalidad_finan     = ag_cod_modalidad_finan,
                 cod_modalidad_alcance   = ag_cod_modalidad_alcance,
                 mon_codigo              = ag_mon_codigo,
                 costo_final             = DECODE (ag_costo_final,' ', NULL,TO_NUMBER (ag_costo_final, '999999999999999.99')),
                 observaciones           = ag_observaciones,
                 n_contrato              = ag_n_contrato,
                 f_vigencia_ini          = TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 f_vigencia_fin          = TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 n_propuesta             = ag_n_propuesta,
                 nom_contratista         = ag_nom_contratista,
                 ind_consorcio           = ln_ind_consorcio_out,
                 cod_tipo_contrato       = ag_cod_tipo_contrato,
                 ruc_destino_pago        = NVL (ln_ruc_destino_pago_out, ag_ruc_destino_pago),
                 nom_destino_pago        = ag_nom_destino_pago,
                 cod_tipo_postor         = ag_tipo_postor,
                 cod_pais_destino_pago   = ag_cod_pais_destino_pago
             WHERE n_cod_contrato        = ag_cod_contrato;

            -- borramos los items anteriores
            DELETE  reg_procesos.item_contrato s
                  WHERE s.n_cod_contrato = ag_cod_contrato;

            ln_op_exito := 1;

         EXCEPTION
            WHEN OTHERS THEN
               usp_print (SQLERRM);
               ROLLBACK;
               ln_op_exito := 0;
               RETURN;
         END;

     IF ln_op_exito = 1 THEN
     BEGIN

     if pfiletoupload is not null then
         PKU_SS_UTILES.p_insUploadContrato(
                    reg_procesos.f_get_min_n_convoca(session__n_convoca),
                    ag_fec_aprob,
                    doc_obs,
                    lv_codtipofile,
                    pfiletoupload,
                    pfiletoupload__size,
                    session__userid,
                    iisenv__remote_host,
                    WriteFileDirectoryDynamic,
                    session__cod_contrato);
     end if;

       EXCEPTION
          WHEN OTHERS THEN

          usp_print (SQLERRM);
          ROLLBACK;
          ln_op_exito := 0;
          RETURN;

       END;

      -- Insertamos los items del calendario y items del contrato
       BEGIN

        usp_registra_items(ag_trama_items_xml,ag_cod_contrato,ag_n_convoca,session__anhoentidad,an_codconsucode);

       -- registro codigo presupuestal por item
       usp_registra_codpresup(ag_trama_items_codpresup,ag_cod_contrato,ag_n_convoca,session__anhoentidad);

         -----------------Inserta Calendario---------------------
       IF ln_indsiaf = 1 THEN
         usp_registra_calendario(ag_trama_calendario,ag_id_operacion);
       END IF;

       ln_op_exito := 2;

       EXCEPTION
           WHEN OTHERS THEN
              usp_print
                       ('Error al actualizar los items del contrato:<br>');
              usp_print (SQLERRM);
              ROLLBACK;
              ln_op_exito := 0;
              RETURN;
        END;
   END IF;

/*   IF ln_op_exito = 2  THEN

        UPDATE reg_procesos.contrato
           SET id_operacion = reg_procesos.pk_convocatoria.getidoperacion()
         WHERE n_cod_contrato = ag_cod_contrato;

        reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion(reg_procesos.pk_convocatoria.getidoperacion());

        COMMIT;
   ELSE
      usp_print ('Error en la transferencia al MEF<br>');
      ROLLBACK;
      RETURN;
   END IF;*/

   -- Actualizacion del costo final
   usp_calcula_costofinal (ag_cod_contrato);
   commit;

   usp_print('<script language="javascript">goSubmit("doViewConsolaContratos",document.all(''scriptdo''))</script>');

  END;

END;

/
