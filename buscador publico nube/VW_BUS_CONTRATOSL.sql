--------------------------------------------------------
-- Archivo creado  - jueves-noviembre-19-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View VW_BUS_CONTRATOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "BUS"."VW_BUS_CONTRATOS" ("N_ID_CONTRATO", "IND_PUBLICADO", "C_DESENTCON", "C_DESCON", "C_NUMCONTRA", "C_RUCONTRA", "C_DESTPAGO", "D_FECPERFEC", "D_FECINIVIG", "D_FECFINVIG", "N_MONTO", "C_TIPMON", "C_SITUACION", "D_FECPUB", "C_ENLACE", "N_ID_CONVOCA", "C_CONTRATISTA", "C_ID_TIPDOC", "C_DESCTIPDOC", "C_NRODOCUMENTO", "C_RUCENTCON", "D_FECREGARC", "N_TAMARC", "N_CONVOCA") AS 
  Select 
    CONTRATO.N_COD_CONTRATO N_ID_CONTRATO,
	CONTRATO.IND_CONTRATO_PUB IND_PUBLICADO,
    ENTIDADUE_ANHO.EUE_DESC C_DESENTCON,
    CONTRATO.DES_CONTRATO C_DESCON,
    CONTRATO.N_CONTRATO C_NUMCONTRA,
    CAST (CONTRATO.RUC_CONTRATISTA AS VARCHAR2(11)) C_RUCONTRA,
    CONTRATO.NOM_DESTINO_PAGO C_DESTPAGO,
    CONTRATO.F_CONTRATO D_FECPERFEC,
    CONTRATO.F_VIGENCIA_INI D_FECINIVIG,
    CONTRATO.F_VIGENCIA_FIN D_FECFINVIG,
    CAST (CONTRATO.M_CONTRATADO AS NUMBER) N_MONTO,
    CAST (MONEDAS.DESCRIPCION AS VARCHAR2(50)) C_TIPMON,
    CAST (TIPO_SITUACION_CONTRACT.DESC_SITUACION AS VARCHAR2(400)) C_SITUACION,
    Contrato.F_Publica D_Fecpub,
    CAST (DECODE(CONVOCATORIA_DOC.DOC_URL,NULL,NULL,'https://zonasegura2.seace.gob.pe/documentos/'
    || Convocatoria_Doc.Doc_Url) As Varchar2(1000)) C_Enlace,
    CONTRATO.N_INDSEACEV3 N_ID_CONVOCA,
    CONTRATO.NOM_CONTRATISTA C_CONTRATISTA,
    CAST (CONVOCATORIA_DOC.COD_TIPO_DOC AS VARCHAR(10)) C_ID_TIPDOC,
    CAST (TIPO_DOCUMENTO.DES_TIPO_DOC AS   VARCHAR(200)) C_DESCTIPDOC,
    CAST (CONVOCATORIA_DOC.NRO_DOC AS      VARCHAR(250)) C_NRODOCUMENTO,
    CAST (ENTIDADUE_ANHO.EUE_RUC AS VARCHAR2(11)) C_RUCENTCON,
    CONVOCATORIA_DOC.FEC_UPLOAD  D_FECREGARC,
    convocatoria_doc.tamano_bytes n_tamarc ,
    CONTRATO.N_CONVOCA
  from reg_procesos.contrato@aixregprodes.seace.gob.pe contrato
  INNER JOIN SEASE.ENTIDADUE_ANHO@aixregprodes.seace.gob.pe ENTIDADUE_ANHO
  ON CONTRATO.CODCONSUCODE = ENTIDADUE_ANHO.EUE_CODIGO
  and contrato.anhoentidad = entidadue_anho.eue_anho
  LEFT OUTER JOIN REG_PROCESOS.MONEDAS@aixregprodes.seace.gob.pe MONEDAS
  on contrato.mon_codigo = monedas.codmoneda
  LEFT OUTER JOIN REG_PROCESOS.TIPO_SITUACION_CONTRACT@aixregprodes.seace.gob.pe TIPO_SITUACION_CONTRACT
  on contrato.cod_situacion = tipo_situacion_contract.cod_situacion
  LEFT OUTER JOIN REG_PROCESOS.CONVOCATORIA_DOC@aixregprodes.seace.gob.pe CONVOCATORIA_DOC
  ON CONTRATO.N_COD_CONTRATO        = CONVOCATORIA_DOC.N_COD_CONTRATO
  and convocatoria_doc.cod_tipo_doc = 600
  LEFT OUTER JOIN REG_PROCESOS.TIPO_DOCUMENTO@aixregprodes.seace.gob.pe TIPO_DOCUMENTO
  on convocatoria_doc.cod_tipo_doc = tipo_documento.cod_tipo_doc
  where contrato.RUC_CONTRATISTA is not null
;
