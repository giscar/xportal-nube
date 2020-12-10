CREATE OR REPLACE FORCE VIEW "INT"."VW_INT_CONCILIACION" ("N_ID_CONCILIACION", "N_REGISTRO", "C_RUCCONCILIADOR", "C_NOMBRECONCILIADOR", "C_FECHAAUDIENCIA", "C_NOMBREDOCACTA", "C_URLDOCACTA", "N_ID_CONTRATO", "C_ESTADO", "C_NOMBRECENTRO", "C_DEMANDANTE", "C_RUTAIMAGEN", "C_FECHAACTACONCILIACION") AS 
  SELECT  c.numero N_ID_CONCILIACION, c.NUM_REGISTRO N_REGISTRO, c.RUC_CONCILIADOR C_RUCCONCILIADOR, c.NOMBRE_CONCILIADOR C_NOMBRECONCILIADOR, 
              to_char(c.FECHA_AUDIENCIA, 'dd/mm/yyyy') C_FECHAAUDIENCIA, c.nombre_doc_acta C_NOMBREDOCACTA, 'documentos/'||c.url_doc_acta C_URLDOCACTA, 
              c.N_COD_CONTRATO N_ID_CONTRATO, ec.descripcion C_ESTADO, nvl(cc.descripcion, '  ') C_NOMBRECENTRO, td.c_descripcion C_DEMANDANTE,
              case when instr(C.NOMBRE_DOC_ACTA,'.doc',1)>1 then cast('/SeaceWeb-PRO/resources/images/archivos/doc.png' as varchar2(100)) 
              when instr(C.NOMBRE_DOC_ACTA,'.pdf',1)>1 then cast('/SeaceWeb-PRO/resources/images/archivos/pdf.png' as varchar2(100)) 
              when instr(C.NOMBRE_DOC_ACTA,'.zip',1)>1 then cast('/SeaceWeb-PRO/resources/images/archivos/zip.png' as varchar2(100)) 
              else cast('' as varchar2(100)) END C_RUTAIMAGEN , to_char(c.FECHA_ACTA_CONCILIACION, 'dd/mm/yyyy') C_FECHAACTACONCILIACION
                   from  reg_procesos.contrato_conciliacion@AIXREGPRODES.SEACE.GOB.PE c 
                   left join reg_procesos.estado_conciliacion@AIXREGPRODES.SEACE.GOB.PE ec on c.TIPO_ESTADO_CONCILIACION = ec.cod_estado_conciliacion 
                   left join reg_procesos.centros_conciliacion@AIXREGPRODES.SEACE.GOB.PE cc on c.COD_CENTRO_CONCILIACION = cc.COD_CENTRO_CONCILIACION 
                   left join  (select n_id_maestro,c_descripcion from arbitraje.tbl_arb_maestro@AIXREGPRODES.SEACE.GOB.PE where n_id_tipomaestro = 12) 
           td on c.tipo_demandante = td.n_id_maestro order by  c.NUM_REGISTRO asc;

