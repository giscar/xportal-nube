set scan off
CREATE OR REPLACE PACKAGE "PKU_GESTOR_CONT_MOD_CONTRATOS" IS

  -- Author  : GMILLONES
  -- Created : 04/04/2010 09:54:12 a.m.
  -- Purpose : 

--consultoria nube migracion
  url_azure_app    varchar2(250):= 'https://zonasegura2.seace.gob.pe/documentos/';
  
 TYPE ref_cursor IS REF CURSOR;
  gpk_directorio_liquidacion      varchar2(50):= 'mon\docs\contratos';
 PROCEDURE f_msg_error(
           v_msg_error VARCHAR2, v_evento VARCHAR2);
 
 FUNCTION F_MSG_ERROR2(
           v_msg_error varchar2, v_evento varchar2) RETURN varchar2;          
           
 PROCEDURE f_msg_pantalla(
           v_msg_error varchar2, v_evento varchar2);           
           
 FUNCTION F_MSG_PANTALLA2(
           v_msg_error varchar2, v_evento varchar2) RETURN varchar2;  
		   
------------------------------------------------------------------------------------------------   
/* FUNCION QUE HACE LA VALIDADCION DEL CONTRATISTA SI ESTA INHABILITADO*/   
------------------------------------------------------------------------------------------------

FUNCTION f_valida_inhab_contrato(
         ag_ruc_contratista   IN VARCHAR2,
         ag_n_convoca         IN VARCHAR2,
         ag_f_contrato        IN VARCHAR2,
         ag_estado_rnp       OUT VARCHAR2
         ) return BOOLEAN;		   

		 
------------------------------------------------------------------------------------------------   
/* FUNCION QUE HACE LA VALIDADCION DEL CONTRATISTA O CONSORCIO ANTES DE  REGISTRAR EL CONTRATO*/   
------------------------------------------------------------------------------------------------

FUNCTION f_valida_rnp_contrato(
         ag_ruc_contratista   IN VARCHAR2, 
         ag_n_convoca         IN VARCHAR2,
         ag_f_contrato        IN VARCHAR2,
         ag_estado_rnp       OUT VARCHAR2
         ) return BOOLEAN  ;    

PROCEDURE usp_registra_calendario(ag_trama_calendario varchar2, ag_id_operacion number);
PROCEDURE uspprocesarupdatecontrato_v3(
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
    /*  ag_costo_final                  VARCHAR2,*/
      ag_observaciones                VARCHAR2,
      ag_n_contrato                   VARCHAR2,
      ag_f_vigencia_ini               VARCHAR2,
      ag_f_vigencia_fin               VARCHAR2,
      ag_n_propuesta                  VARCHAR2,
      ag_nom_contratista              VARCHAR2,
      ag_ruc_destino_pago             VARCHAR2,
      ag_cod_tipo_contrato            VARCHAR2,
      ag_id_operacion                 VARCHAR2,
      pfiletoupload1                   VARCHAR2,
      ag_fec_aprob                    VARCHAR2,
      doc_obs                         VARCHAR2,
      SizeFile                         VARCHAR2,
      iisenv__remote_host             VARCHAR2,
      WriteFileDirectoryDynamic       VARCHAR2,
      ag_trama_items              VARCHAR2,
      ag_trama_calendario             VARCHAR2,
      ag_nom_destino_pago             VARCHAR2,
      pfiletoupload_file1              VARCHAR2,
       av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL
   );
PROCEDURE uspmancontratosdoedit_v3 (
      session__n_convoca         VARCHAR2,
      session__eue_codigo        VARCHAR2,
      session__anhoentidad       VARCHAR2,
      session__cod_moneda        VARCHAR2,
      session__FileSingedHTTP    VARCHAR2,
      ag_des_contrato            VARCHAR2,
      ag_cod_contrato            VARCHAR2,
      ag_n_contrato              VARCHAR2,
      ag_cod_tipo_contrato       VARCHAR2,
      ag_n_propuesta             VARCHAR2,
      ag_cod_sist_adquisicion    VARCHAR2,
      ag_cod_modalidad_alcance   VARCHAR2,
      ag_observaciones           VARCHAR2,
      ag_trama_calendario        VARCHAR2,
       av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL
 );
  PROCEDURE uspprocesar_pub_contrato_v3 (
   session__cod_contrato            NUMBER,
   session__n_convoca               VARCHAR2,
   session__av_id_proc              VARCHAR2,
    ag_id_operacion                  VARCHAR2,
   session__userid                  VARCHAR2,
   iisenv__remote_host              varchar2,
   av_id_expede              VARCHAR2  DEFAULT NULL,--Atención de incidencia SEACE-ReqMEF 18/11/15 
   
   --validacion clc
    RequiereValidacionCLC     varchar2,
    arreglorucmiembros        varchar2  default null,
    EstadoValidacionCLC       varchar2  default null
    
  );
  FUNCTION f_retorna_total_moneda(ag_n_propuesta number, ag_nconvoca number)
RETURN NUMBER;
PROCEDURE uspprocesarinsertcontrato_v3 (
    session__USERID                 VARCHAR2,
    session__n_convoca              VARCHAR2,
    session__anhoentidad            VARCHAR2,
    session__eue_codigo             VARCHAR2,
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
    ag_cod_tipo_contrato            VARCHAR2,
    ag_ruc_destino_pago             VARCHAR2,
    ag_anho_enti_pagadora           VARCHAR2,
    ag_cod_enti_pagadora            VARCHAR2,
    pfiletoupload1                   VARCHAR2,
    ag_trama_items                  VARCHAR2,
    ag_trama_items_xml              VARCHAR2,
    ag_trama_calendario             VARCHAR2,
    ag_fec_aprob                    VARCHAR2,
    doc_obs                         VARCHAR2,
    SizeFile                    varchar2,
    iisenv__remote_host             VARCHAR2,
    WriteFileDirectoryDynamic       VARCHAR2,
    ag_nom_destino_pago             VARCHAR2,
    pfiletoupload_file1              VARCHAR2,
    av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL
 );
 
 PROCEDURE uspprocesarinsertcontrato2_v3 (
    session__USERID                 VARCHAR2,
    session__n_convoca              VARCHAR2,
    session__anhoentidad            VARCHAR2,
    session__eue_codigo             VARCHAR2,
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
    ag_cod_tipo_contrato            VARCHAR2,
    ag_ruc_destino_pago             VARCHAR2,
    ag_anho_enti_pagadora           VARCHAR2,
    ag_cod_enti_pagadora            VARCHAR2,
    pfiletoupload1                   VARCHAR2,
    ag_trama_items                  VARCHAR2,
    ag_trama_items_xml              VARCHAR2,
    ag_trama_calendario             VARCHAR2,
    ag_fec_aprob                    VARCHAR2,
    doc_obs                         VARCHAR2,
    SizeFile                    varchar2,
    iisenv__remote_host             VARCHAR2,
    WriteFileDirectoryDynamic       VARCHAR2,
    ag_nom_destino_pago             VARCHAR2,
    pfiletoupload_file1              VARCHAR2,
    av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    AV_ID_CON_PUB             VARCHAR2  DEFAULT NULL,
    resp_html                 OUT VARCHAR2
 );
PROCEDURE uspprocesarupdatecontrato2_v3(
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
      ag_observaciones                VARCHAR2,
      ag_n_contrato                   VARCHAR2,
      ag_f_vigencia_ini               VARCHAR2,
      ag_f_vigencia_fin               VARCHAR2,
      ag_n_propuesta                  VARCHAR2,
      ag_nom_contratista              VARCHAR2,
      ag_ruc_destino_pago             VARCHAR2,
      ag_cod_tipo_contrato            VARCHAR2,
      ag_id_operacion                 VARCHAR2,
      pfiletoupload1                   VARCHAR2,
      ag_fec_aprob                    VARCHAR2,
      doc_obs                         VARCHAR2,
      SizeFile                         VARCHAR2,
      iisenv__remote_host             VARCHAR2,
      WriteFileDirectoryDynamic       VARCHAR2,
      ag_trama_items              VARCHAR2,
      ag_trama_calendario             VARCHAR2,
      ag_nom_destino_pago             VARCHAR2,
      pfiletoupload_file1              VARCHAR2,
       av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    AV_ID_CON_PUB             VARCHAR2  DEFAULT NULL,
    resp_html                 OUT VARCHAR2
   );
procedure uspNewContratosDoEdit_v3(
      session__n_convoca         VARCHAR2 DEFAULT NULL,
      session__eue_codigo        VARCHAR2 DEFAULT NULL,
      session__anhoentidad       VARCHAR2 DEFAULT NULL,
      session__cod_moneda        VARCHAR2 DEFAULT NULL,
      ag_cod_tipo_contrato       VARCHAR2 DEFAULT NULL,
      ag_cod_modalidad_alcance   VARCHAR2 DEFAULT NULL,
      ag_cod_sist_adquisicion    VARCHAR2 DEFAULT NULL,
      ag_des_contrato            VARCHAR2 DEFAULT NULL,
      ag_n_contrato              VARCHAR2 DEFAULT NULL,
      ag_n_propuesta             varchar2 default null,
      ag_codmoneda_contrato_sel  varchar2 default null,   -- agregado para seleccionar moneda x item
      ag_ruc_contratista         VARCHAR2 DEFAULT NULL,
      ag_f_contrato              VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_ini          VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_fin          VARCHAR2 DEFAULT NULL,
      ag_observaciones           VARCHAR2 DEFAULT NULL,
      ag_trama_calendario        VARCHAR2 DEFAULT NULL,
      ag_ruc_destino_pago        VARCHAR2 DEFAULT NULL,
       v_ind_adm_direc            NUMBER DEFAULT 0,
        av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL
  );   
FUNCTION f_get_CodNU_V2011_v3 (  ag_n_convoca VARCHAR2, ag_evento_error varchar2 ) return reg_procesos.t_cat_grupo%RowtYPE;
 PROCEDURE uspNewContratosDoEdit(
      session__n_convoca         VARCHAR2 DEFAULT NULL,
      session__eue_codigo        VARCHAR2 DEFAULT NULL,
      session__anhoentidad       VARCHAR2 DEFAULT NULL,
      session__cod_moneda        VARCHAR2 DEFAULT NULL,
      ag_cod_tipo_contrato       VARCHAR2 DEFAULT NULL,
      ag_cod_modalidad_alcance   VARCHAR2 DEFAULT NULL,
      ag_cod_sist_adquisicion    VARCHAR2 DEFAULT NULL,
      ag_des_contrato            VARCHAR2 DEFAULT NULL,
      ag_n_contrato              VARCHAR2 DEFAULT NULL,
      ag_n_propuesta             VARCHAR2 DEFAULT NULL,
      ag_ruc_contratista         VARCHAR2 DEFAULT NULL,
      ag_f_contrato              VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_ini          VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_fin          VARCHAR2 DEFAULT NULL,
      ag_observaciones           VARCHAR2 DEFAULT NULL,
      ag_trama_calendario        VARCHAR2 DEFAULT NULL,
      ag_ruc_destino_pago        VARCHAR2 DEFAULT NULL                        
  );
  

 PROCEDURE uspprocesarinsertcontrato (
    session__USERID                 VARCHAR2,
    session__n_convoca              VARCHAR2,
    session__anhoentidad            VARCHAR2,     
    session__eue_codigo             VARCHAR2,
    ag_trama_calendario             VARCHAR2,       
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
    ag_cod_tipo_contrato            VARCHAR2,
    ag_ruc_destino_pago             VARCHAR2,
    ag_anho_enti_pagadora           VARCHAR2,
    ag_cod_enti_pagadora            VARCHAR2,
    pfiletoupload1                   VARCHAR2,
    ag_trama_items                  VARCHAR2,
    ag_trama_items_xml              VARCHAR2, 
    ag_fec_aprob                    VARCHAR2,
    doc_obs                         VARCHAR2,
    SizeFile                    varchar2,
    iisenv__remote_host             VARCHAR2,
    WriteFileDirectoryDynamic       VARCHAR2,
    ag_nom_destino_pago             VARCHAR2,
     pfiletoupload_file1              VARCHAR2
                     
 );  

   PROCEDURE usp_eliminar_contrato (
          ag_cod_contrato          NUMBER, 
          session__n_convoca       VARCHAR2
          ); 


FUNCTION f_retorna_combo(
  pc_cursor       ref_cursor, 
  ag_name         varchar2, 
  ag_codigo       varchar2, 
  ag_libre        varchar2 default null,
  ag_atributos    varchar2 default null) RETURN varchar2;
  
 PROCEDURE uspmancontratosdoedit (
      session__n_convoca         VARCHAR2,
      session__eue_codigo        VARCHAR2,
      session__anhoentidad       VARCHAR2,
      session__cod_moneda        VARCHAR2,
      session__FileSingedHTTP    VARCHAR2,
      ag_des_contrato            VARCHAR2,
      ag_cod_contrato            VARCHAR2,
      ag_n_contrato              VARCHAR2,
      ag_cod_tipo_contrato       VARCHAR2,
      ag_n_propuesta             VARCHAR2,
      ag_cod_sist_adquisicion    VARCHAR2,
      ag_cod_modalidad_alcance   VARCHAR2,
      ag_observaciones           VARCHAR2,
      ag_trama_calendario        VARCHAR2
 ); 


PROCEDURE uspprocesar_pub_contrato (
   session__cod_contrato            NUMBER,
   session__n_convoca               VARCHAR2,
   ag_id_operacion                  VARCHAR2,
   session__userid                  VARCHAR2,
   iisenv__remote_host              VARCHAR2
   
  )
  ;  
 PROCEDURE uspprocesarupdatecontrato(
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
    /*  ag_costo_final                  VARCHAR2,*/
      ag_observaciones                VARCHAR2,  
      ag_n_contrato                   VARCHAR2,  
      ag_f_vigencia_ini               VARCHAR2,
      ag_f_vigencia_fin               VARCHAR2,              
      ag_n_propuesta                  VARCHAR2,
      ag_nom_contratista              VARCHAR2,
      ag_ruc_destino_pago             VARCHAR2,
      ag_cod_tipo_contrato            VARCHAR2,
      ag_id_operacion                 VARCHAR2,      
      pfiletoupload1                   VARCHAR2,
      ag_fec_aprob                    VARCHAR2,
      doc_obs                         VARCHAR2,
      SizeFile             VARCHAR2,
      iisenv__remote_host             VARCHAR2,
      WriteFileDirectoryDynamic       VARCHAR2,
      ag_trama_items              VARCHAR2,
      ag_trama_calendario             VARCHAR2,
      ag_nom_destino_pago             VARCHAR2,
      pfiletoupload_file1              VARCHAR2
   ); 


 PROCEDURE uspPintarInput(
     ruc_de_postor                    varchar2 DEFAULT NULL,
     n_convoca                        varchar2 DEFAULT NULL,
     session__userid                  varchar2 DEFAULT NULL,
     tipo                             varchar2 DEFAULT NULL
 );
                    
PROCEDURE usp_registra_items_v3(ag_trama_items varchar2, ag_ncodcontrato number, ag_nconvoca number);
FUNCTION f_crucs_contrato (ag_n_convoca NUMBER) RETURN ref_cursor;
FUNCTION f_valida_fconsentimiento(ag_trama_items VARCHAR2, ag_nconvoca NUMBER,ag_fec_contrato VARCHAR2) RETURN boolean;
FUNCTION f_get_estadocontrato (
      f_contrato_pro      IN   DATE,
      f_culminacion_pro   IN   DATE,
      f_liquidacion       IN   DATE,
      fec_intervencion    IN   DATE,
      cant_items          IN   VARCHAR2,
      cant_items2         IN   VARCHAR2
   )
      RETURN VARCHAR2;

procedure usplistaritemspaquete (
    nconvoca number, 
    procitem number
);

END PKU_GESTOR_CONT_MOD_CONTRATOS;
/


CREATE OR REPLACE PACKAGE BODY "PKU_GESTOR_CONT_MOD_CONTRATOS" is

 PROCEDURE f_msg_error(v_msg_error varchar2, v_evento varchar2)
 IS
 BEGIN
    ROLLBACK;
    usp_print('<center><font color=red><b>'||v_msg_error||'. '||SQLERRM||'</b></font></center>');
    usp_print('<center><br><input type="button" value="Volver" onclick="thisform.scriptdo.value='||v_evento||';thisform.submit()" ></center>');
    usp_print('<script>  _error  = 1;</script>');
    RETURN;  
 END;
 
 

 
FUNCTION f_get_CodNU_V2011_v3 (  ag_n_convoca VARCHAR2, ag_evento_error varchar2 ) return reg_procesos.t_cat_grupo%RowtYPE
   IS
/*POR INCIDENCIA 227-2011 AMOLINARI - CATALOGO AL 5TO NIVEL*/
     row_ciu  reg_procesos.t_cat_grupo%RowtYPE;
   BEGIN

  SELECT d.* into row_ciu
        FROM reg_procesos.t_cat_grupo d
       WHERE d.grupo_bien in (
                           SELECT nvl(c.COD_NU_SEG,'99') COD_NU_SEG
                             FROM reg_procesos.convocatorias c
                            WHERE c.n_convoca = ag_n_convoca )
          AND d.tipo_fuente = 'A';

      RETURN row_ciu;

    EXCEPTION
      WHEN OTHERS THEN
            f_msg_error('Error al intentar hallar los datos del CIIU de la convocatoria',''||ag_evento_error||'');


   END;

 FUNCTION f_get_CodNU_V2011 (  ag_n_convoca VARCHAR2, ag_evento_error varchar2 ) return reg_procesos.t_cat_grupo%RowtYPE
   IS
/*POR INCIDENCIA 227-2011 AMOLINARI - CATALOGO AL 5TO NIVEL*/
     row_ciu  reg_procesos.t_cat_grupo%RowtYPE;
   BEGIN

  SELECT d.* into row_ciu
        FROM reg_procesos.t_cat_grupo d
       WHERE d.grupo_bien in (
                           SELECT c.COD_NU_SEG
                             FROM reg_procesos.convocatorias c
                            WHERE c.n_convoca = ag_n_convoca )
          AND d.tipo_fuente = 'A';

      RETURN row_ciu;

    EXCEPTION
      WHEN OTHERS THEN
            f_msg_error('Error al intentar hallar los datos del CIIU de la convocatoria',''||ag_evento_error||'');


   END;

 PROCEDURE f_msg_pantalla(v_msg_error varchar2, v_evento varchar2)
 IS
 BEGIN
    ROLLBACK;
    usp_print('<center><font color=red><b>'||v_msg_error||'</b></font></center>');
    usp_print('<center><br><input type="button" value="Volver" onclick="thisform.scriptdo.value='||v_evento||';thisform.submit()" ></center>');
    usp_print('<script>  _error  = 1;</script>');
    RETURN;
 END;



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
  for ( var i=0; i <= len ; i++ ) if ( cadena.charAt(i) != " " ){cadena2+=cadena.charAt(i);  }
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
      alert("El Nmero de RUC no es vlido ...")
      return false;}
 }');

   usp_print ('</script>');

   END;



 /*******************************************************************************/

 FUNCTION f_get_CodNU (  ag_n_convoca VARCHAR2, ag_evento_error varchar2 ) return reg_procesos.t_cat_grupo%RowtYPE
   IS

     row_ciu  reg_procesos.t_cat_grupo%RowtYPE;
     cant number;
   BEGIN


     SELECT count(*) into cant
        FROM reg_procesos.t_cat_grupo d
       WHERE d.grupo_bien in (
                           SELECT c.COD_NU_SEG
                             FROM reg_procesos.convocatorias c
                            WHERE c.n_convoca = ag_n_convoca )
          AND d.tipo_fuente = 'U';

       if cant > 0 then

      SELECT d.* into row_ciu
        FROM reg_procesos.t_cat_grupo d
       WHERE d.grupo_bien in (
                           SELECT c.COD_NU_SEG
                             FROM reg_procesos.convocatorias c
                            WHERE c.n_convoca = ag_n_convoca )
          AND d.tipo_fuente = 'U';
       else

        SELECT d.* into row_ciu
        FROM reg_procesos.t_cat_grupo d
       WHERE d.grupo_bien in (
                           SELECT c.COD_NU_SEG
                             FROM reg_procesos.convocatorias c
                            WHERE c.n_convoca = ag_n_convoca )
          AND d.tipo_fuente = 'A';
    end if;



      RETURN row_ciu;

    EXCEPTION
      WHEN OTHERS THEN
            f_msg_error('Error al intentar hallar los datos del CIIU de la convocatoria',''||ag_evento_error||'');


   END;


/*******************************************************************************/
  Function f_get_ciiu ( ag_n_convoca  VARCHAR2, ag_evento_error varchar2 ) return sease.ciiuinei%RowtYPE
  IS

   row_ciu  sease.ciiuinei%RowtYPE := null;

   BEGIN

      SELECT ci.* into row_ciu
        FROM sease.ciiuinei ci, reg_procesos.convocatorias co
       WHERE ci.ciu_ccodigo     = co.codciiu
         AND ci.ciu_cespecial   = co.especial
         AND co.n_convoca       = ag_n_convoca;

         return row_ciu;

   EXCEPTION

      WHEN OTHERS THEN
          return row_ciu;
          f_msg_error('Error: Al intentar hallar los datos del CIIU de la convocatoria','"'||ag_evento_error||'"');

   END;


/*******************************************************************************/

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


   END;

 PROCEDURE usp_fechasprorroga (
      ag_ncodcontrato      IN       NUMBER,
      ag_fec_contrato      OUT      DATE,
      ag_fec_culminacion   OUT      DATE
   )

   IS
    CURSOR C_Prorrogas(pv_ncodcontrato varchar2) is
    SELECT f_contrato,  f_culminacion
        INTO ag_fec_contrato, ag_fec_culminacion
        FROM reg_procesos.contrato
       WHERE n_cod_contrato_de_renovac = pv_ncodcontrato
         AND f_contrato = (SELECT MAX (f_contrato)
                             FROM reg_procesos.contrato
                            WHERE n_cod_contrato_de_renovac = pv_ncodcontrato);

   BEGIN

   For xrow in C_Prorrogas(ag_ncodcontrato) loop
      ag_fec_contrato := xrow.f_contrato;
      ag_fec_culminacion := xrow.f_culminacion;
   End loop;


   END;


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

   END;
   
   -- inicio SM 230-2018 ddrodriguez
   FUNCTION F_GET_ITEMPUBLICAR (ag_ncod_contrato NUMBER)
      RETURN VARCHAR2
   IS
      VALOR    VARCHAR2(200);
      TIPOSEL  VARCHAR2(20);
      ESTPRO   NUMBER;
      NROITEM  VARCHAR2(45);
      TOTAL   NUMBER;
   BEGIN
      VALOR:='N-0';
      
      SELECT COUNT(*) INTO TOTAL FROM PRO.TBL_ACT_ITEM@AIXSEACE I
      INNER JOIN PRO.TBL_ACT_EXPEDIENTE@AIXSEACE E ON E.N_ID_EXPEDE = I.N_ID_EXPEDE
      WHERE 
      I.N_ID_ITEM IN (SELECT ICN.N_ID_ITEM FROM REG_PROCESOS.ITEM_CONVOCA ICN
                      INNER JOIN REG_PROCESOS.ITEM_CONTRATO IC ON ICN.N_CONVOCA = IC.N_CONVOCA AND ICN.PROC_ITEM = IC.PROC_ITEM
                      WHERE IC.N_COD_CONTRATO = ag_ncod_contrato)
      AND (I.N_ESTPRO <> 22)
      AND (I.N_ESTPRO <> 19)
      AND ((E.C_TIPSEL NOT IN (77,81,293,790,84)) OR (I.N_ESTPRO <> 4) AND (E.C_TIPSEL IN (77,81,293,790,84))); -- 790 ABR Produccioon 776 Pre-produccion
      
      IF TOTAL > 0 THEN
        SELECT E.C_TIPSEL,I.N_ESTPRO,I.C_NROITEM INTO TIPOSEL,ESTPRO,NROITEM FROM PRO.TBL_ACT_ITEM@AIXSEACE I
        INNER JOIN PRO.TBL_ACT_EXPEDIENTE@AIXSEACE E ON E.N_ID_EXPEDE = I.N_ID_EXPEDE
        WHERE 
        I.N_ID_ITEM IN (SELECT ICN.N_ID_ITEM FROM REG_PROCESOS.ITEM_CONVOCA ICN
                        INNER JOIN REG_PROCESOS.ITEM_CONTRATO IC ON ICN.N_CONVOCA = IC.N_CONVOCA AND ICN.PROC_ITEM = IC.PROC_ITEM
                        WHERE IC.N_COD_CONTRATO = ag_ncod_contrato)
        AND (I.N_ESTPRO <> 22)
        AND (I.N_ESTPRO <> 19)
        AND ((E.C_TIPSEL NOT IN (77,81,293,790,84)) OR (I.N_ESTPRO <> 4) AND (E.C_TIPSEL IN (77,81,293,790,84))) AND ROWNUM=1; -- 790 ABR Produccioon 776 Pre-produccion
        
       IF (TIPOSEL IN (77,81,293,790,84)) AND (ESTPRO IS NOT NULL) THEN -- 790 ABR Produccioon 776 Pre-produccion
       VALOR := 'A-'||NROITEM;
       END IF;
       
       IF (TIPOSEL NOT IN (77,81,293,790  ,84)) AND (ESTPRO IS NOT NULL) THEN -- 790 ABR Produccioon 776 Pre-produccion
       VALOR := 'C-'||NROITEM;
       END IF;
      END IF;
      
      RETURN VALOR;

   END;
   -- Fin SM 230-2018 ddrodriguez

PROCEDURE uspmancontratosdoedit_v3 (
      session__n_convoca         VARCHAR2,
      session__eue_codigo        VARCHAR2,
      session__anhoentidad       VARCHAR2,
      session__cod_moneda        VARCHAR2,
      session__FileSingedHTTP    VARCHAR2,
      ag_des_contrato            VARCHAR2,
      ag_cod_contrato            VARCHAR2,
      ag_n_contrato              VARCHAR2,
      ag_cod_tipo_contrato       VARCHAR2,
      ag_n_propuesta             VARCHAR2,
      ag_cod_sist_adquisicion    VARCHAR2,
      ag_cod_modalidad_alcance   VARCHAR2,
      ag_observaciones           VARCHAR2,
      ag_trama_calendario        VARCHAR2,
       av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL
 )
 IS



      CURSOR C_contrato(p_cod_contrato varchar2) is
      SELECT c.n_cod_contrato,
             c.n_convoca,
             c.n_item,
             c.des_contrato,
             c.ciu_ccodigo,
             c.ciu_cespecial,
             c.ruc_contratista,
             c.ruc_destino_pago,
             c.nom_destino_pago,
             TO_CHAR (c.f_contrato, reg_procesos.pku_ss_constantes.gv_formato_fecha)     f_contrato,
             c.mon_codigo codmoneda_contrato, --c.codmoneda_contrato,
             c.m_contratado ,
             c.cod_situacion,
             c.cod_causa_resoucion,
             TO_CHAR (c.f_liquidacion, reg_procesos.pku_ss_constantes.gv_formato_fecha) f_liquidacion,
             c.fec_intervencion,
             c.cod_sist_adquisicion,
             c.cod_modalidad_finan,
             c.cod_modalidad_alcance,
             c.plazo_real,
             c.mon_codigo,
             m.mon_desc,
             TO_CHAR (c.costo_final, reg_procesos.pku_ss_constantes.gv_formato_dinero) costo_final,
             c.cod_sancion,
             c.penalidad,
             c.cod_ejec_garantias,
             c.observaciones,
             c.n_contrato,
             c.codconsucode,
             TO_CHAR (c.f_vigencia_ini, reg_procesos.pku_ss_constantes.gv_formato_fecha) f_vigencia_ini,
             TO_CHAR (c.f_vigencia_fin, reg_procesos.pku_ss_constantes.gv_formato_fecha) f_vigencia_fin,
             LPAD (c.n_convoca, 8, '0') n_convoca_pad,
             LPAD (c.n_cod_contrato, 8, '0') n_cod_contrato_pad,
             TRIM (nom_contratista) nom_contratista,
             ind_consorcio,
             n_propuesta,
             cod_tipo_contrato,
             cod_tipo_postor,
             cod_pais_destino_pago,
             des_pais,
             conv.cod_tipo_modalidad,
             c.id_operacion,
             c.codconsucode_paga,
             c.anhoentidad_paga
     FROM
             reg_procesos.contrato c
             left outer join  reg_procesos.convocatorias conv on c.n_convoca = conv.n_convoca
             left outer join sease.moneda m on  c.mon_codigo = m.mon_codigo
        LEFT OUTER JOIN reg_procesos.t_pais tp  ON tp.cod_pais = c.cod_pais_destino_pago
         where c.n_cod_contrato = p_cod_contrato;
         
         
    ---INICIO MANTENIMIENTO 84-2018
	
 CURSOR cConsorcioMiembrostc(ruc_consorcio VARCHAR2,n_convoca NUMBER)
 is
   SELECT b.tipo,b.RUC_MIEMBRO,b.NOM_MIEMBRO
     FROM REG_PROCESOS.CONVOCATORIA_PROPUESTA a
    INNER JOIN  REG_PROCESOS.CONSORCIO_MIEMBRO b ON a.COD_CONSORCIO = b.COD_CONSORCIO
    WHERE a.RUC_POSTOR = ruc_consorcio
      AND a.N_CONVOCA = n_convoca;
	  
   ---FIN MANTENIMIENTO 84-2018 

      -- datos del contrato por editar
      lv_des_contrato                reg_procesos.contrato.des_contrato%TYPE;
      lv_ruc_destino_pago            reg_procesos.contrato.ruc_destino_pago%TYPE;
      lv_nom_destino_pago            reg_procesos.contrato.nom_destino_pago%TYPE;
      lv_f_contrato                  VARCHAR2 (35);
      ln_codmoneda_contrato          reg_procesos.contrato.codmoneda_contrato%TYPE;
      lf_m_contratado                VARCHAR2 (35);
      lv_f_liquidacion               VARCHAR2 (35);
      lv_f_intervencion              VARCHAR2 (35);
      ln_cod_sist_adquisicion        reg_procesos.contrato.cod_sist_adquisicion%TYPE;
      ln_cod_modalidad_alcance_res   reg_procesos.contrato.cod_modalidad_alcance%TYPE;
      lv_observaciones               reg_procesos.contrato.observaciones%TYPE;
      ln_n_contrato                  reg_procesos.contrato.n_contrato%TYPE;
      lv_f_vigencia_ini              VARCHAR2 (35);
      lv_f_vigencia_fin              VARCHAR2 (35);
      ln_n_propuesta                 reg_procesos.contrato.n_propuesta%TYPE;
      lv_ruc_contratista             reg_procesos.convocatoria_propuesta.ruc_postor%TYPE;
      ln_id_operacion                reg_procesos.contrato_operacion.id_operacion%TYPE;
      LN_COD_TIPO_CONTRATO           REG_PROCESOS.CONTRATO.COD_TIPO_CONTRATO%TYPE;
      LN_TIPO_PROC_30556_P           NUMBER;--ID Micro requerimiento Ley 30556
      LN_NORMATIVA_P                 VARCHAR2 (30);--MANTENIMIENTO 84-2018
      LN_PROV_EXTRANJ_SRNP_P     	 VARCHAR2 (500);--MANTENIMIENTO 84-2018
	----INICIO  SM-224-2018-SGFS-2018/SGFS
		lb_validacion_rnp               BOOLEAN;
		lv_estado_rnp                   VARCHAR2(500);
	----FIN  SM-224-2018-SGFS-2018/SGFS
      -- Garantias
      ln_v_garantias_declaradas      NUMBER;
      ln_v_declaracion               NUMBER;
      ln_v_tipos_validos             NUMBER;
      ln_v_rango                     NUMBER;

       -- Cursores
      crucscontrato                  ref_cursor;
      ctipocontrato                  ref_cursor;
      cmodalidadalcance              ref_cursor;
      csistemaadquisicion            ref_cursor;
      cmoneda                        ref_cursor;
      cmiembros_consorcio            ref_cursor;

       -- datos de la entidad pagadora
      lv_codconsucode_paga           reg_procesos.contrato_tipo_entidad.codconsucode_paga%TYPE;
      lv_anhoenidad_paga             reg_procesos.contrato_tipo_entidad.anhoentidad_paga%TYPE;
      lv_descentidad_paga            sease.entidades.descripcion%TYPE;
      ln_cont_paga                   NUMBER;

      --  Variables combos
      lv_combo_rucs                  varchar2(20000);
      lv_combo_tipocontrato          VARCHAR2(4000);
      lv_combo_moneda                VARCHAR2(4000);
      lv_combo_modalidad_alcance     VARCHAR2(4000);
      lv_combo_sistemaadquisicion    VARCHAR2(4000);

      -- variables de los datos del upload
      ln_NCOD_DOC                    NUMBER;
      lv_DOC_URL                     VARCHAR2(250);
      lv_FEC_UPLOAD                  VARCHAR2(20);
      lv_USER_UPLOAD                 VARCHAR2(30);
      lv_FEC_APROB                   VARCHAR2(20);
      lv_EXT_TIPO_FILE               VARCHAR2(250);
      lv_ICON_TIPO_FILE              VARCHAR2(250);
      lv_DOC_OBS                     VARCHAR2(250);

      -- Datos de los items
      ln_items_resueltos             NUMBER;
      ln_items_en_ejecucion          NUMBER;

      -- Datos de fechas del contrato
      ld_fec_contrato                DATE;
      ld_fec_culimnacion             DATE;
      -- Varialbles
      lv_estado_contrato             VARCHAR2 (200);
      lv_trama_calendario            VARCHAR2(18000);
      LN_INDPUB_CONTRATO             NUMBER;
      lv_ruta_file                   VARCHAR2(1250);
      ag_item_valor                  VARCHAR2 (200);--SM 230-2018 ddrodriguez
      ag_item_publicar               VARCHAR2 (200);--SM 230-2018 ddrodriguez
      ag_item_nro                    VARCHAR2 (200);--SM 230-2018 ddrodriguez
      -- Garantias
      ln_proc_tipo                   NUMBER;
      ln_valida_inicio               NUMBER;
      ln_app                         number;
        ln_garantia                    number;
      
      -- Consorcios
      ln_ind_consorcio               NUMBER;
      ls_ruc_miembro                 VARCHAR2(11);
      ls_nom_miembro                 VARCHAR2(150);
      temp                           varchar2(100);
       lv_anho_convocatoria           NUMBER;
        ln_tipo_modalidad              NUMBER;
	
	--CONSTANCIA CLC 
	lv_requiere_const_clc			varchar2(4);
	lv_objeto						      NUMBER;--3:OBRAS
	ln_c_tipsel						    number;
  ln_c_causal						    number;
  arrayrucs                 varchar2(220);
  ln_prov_exeptuado         varchar2(20);
  ejecutor_obras            varchar2(200);
  es_ejecutor_obras         number;
  contador                  NUMBER;

 BEGIN 

           SELECT nvl(anhoentidad, anho_convoca),nvl(COD_TIPO_MODALIDAD,0) INTO lv_anho_convocatoria,ln_tipo_modalidad FROM reg_procesos.convocatorias WHERE n_convoca = session__N_CONVOCA;
    --Inicio Micro requerimiento Ley 30556
      SELECT CONVOC1.PROC_TIPO INTO LN_TIPO_PROC_30556_P FROM CONVOCATORIAS CONVOC1 WHERE CONVOC1.N_CONVOCA=SESSION__N_CONVOCA AND ROWNUM = 1;
    --Fin Micro requerimiento Ley 30556
  
/*usp_print('<br>session__n_convoca:'||session__n_convoca);*/
  --usp_print('entra al metodo');

     pku_gestor_cont_funciones_js_2.fvalidacadenas_js; --SEGUN MEMORANDO N 312-2016/SGFS-SM 054-2016
      PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos;
--      sp_javascript_contratos_ficha;
      PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos_update;
--      sp_javascript_valida_ruc;
      PKU_GESTOR_CONT_FUNCIONES_JS_2.fOperacionesPagina;

    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlGeneral;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlContratos(session__anhoentidad,lpad(session__eue_codigo,6,'0'),session__N_CONVOCA );
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fFechasGeneral;

    -- Vemos si esta publicado el contrato
    LN_INDPUB_CONTRATO         := PKU_GESTOR_CONT_UTILES_2.f_get_indPubContrato(ag_cod_contrato);


    -- Trama del Calendario
    lv_trama_calendario        := nvl(ag_trama_calendario,PKU_GESTOR_CONT_UTILES_2.f_getXmlCalContrato(ag_cod_contrato));

    ln_v_garantias_declaradas  := REG_PROCESOS.Pku_Ss_Garantias.f_valida_declaracion(ag_cod_contrato);
    ln_v_declaracion           := REG_PROCESOS.Pku_Ss_Garantias.f_existe_declaracion(ag_cod_contrato);
    ln_v_tipos_validos         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_tipo_validos_v3(session__N_CONVOCA);
    ln_v_rango                 := reg_procesos.Pku_Ss_Garantias.f_valida_inicio_v3(session__N_CONVOCA);

      -- inicializamos variables de sesion
    usp_print ('<SESSION_EXPORT>
                       <COD_CONTRATO>'||ag_cod_contrato||'</COD_CONTRATO>
                       <PUBLICADO>'||LN_INDPUB_CONTRATO||'</PUBLICADO>
                       <AV_ID_PROC>'||av_id_proc ||'</AV_ID_PROC>
                </SESSION_EXPORT>');

    -- datos del contrato
    For xrow in C_contrato(ag_cod_contrato) loop
        lv_des_contrato               := xrow.des_contrato;
        ln_n_contrato                 := xrow.n_contrato;
        ln_n_propuesta                := xrow.n_propuesta;
        lv_ruc_destino_pago           := xrow.ruc_destino_pago;
        lv_nom_destino_pago           := xrow.nom_destino_pago;
        lv_f_contrato                 := xrow.f_contrato;
        lv_f_vigencia_ini             := xrow.f_vigencia_ini;
        lv_f_vigencia_fin             := xrow.f_vigencia_fin;
        ln_codmoneda_contrato         := xrow.codmoneda_contrato;
        ln_cod_sist_adquisicion       := xrow.cod_sist_adquisicion;
        ln_cod_modalidad_alcance_res  := xrow.cod_modalidad_alcance;
        lv_f_liquidacion              := xrow.f_liquidacion;
        lv_f_intervencion             := xrow.fec_intervencion;
        lf_m_contratado               := xrow.m_contratado;
        ln_id_operacion               := xrow.id_operacion;
        lv_observaciones              := xrow.observaciones;
        ln_cod_tipo_contrato          := xrow.cod_tipo_contrato;
      --  lv_ruc_contratista            := xrow.ruc_contratista;
    End loop;
/*usp_print('session__N_CONVOCA:'||session__N_CONVOCA);
usp_print('<br>ag_n_propuesta:'||ag_n_propuesta);
usp_print('<br>ln_n_propuesta:'||ln_n_propuesta);
usp_print('<br>ag_cod_contrato:'||ag_cod_contrato);*/

    -- Inicializacion de Cursores
    ctipocontrato                   := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_ctipo_contrato;
    crucscontrato                   := f_crucs_contrato (session__N_CONVOCA);
    cmodalidadalcance               := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_ctipo_mod_alcance;
    csistemaadquisicion             := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_csistema_finance;
    cmoneda                         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cmonedas;
    cmiembros_consorcio             := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cMiembros_postor(ln_n_propuesta);

    -- Inicializamos los combos
    lv_combo_tipocontrato       := f_retorna_combo(ctipocontrato, 'ag_cod_tipo_contrato', nvl(ag_cod_tipo_contrato,ln_cod_tipo_contrato),null,null);
    lv_combo_rucs               := f_retorna_combo(crucscontrato, 'ag_n_propuesta_', nvl(ag_n_propuesta,ln_n_propuesta),'--- Seleccionar ---','style="width:339px;" onchange="cargaRUC(''doEditContrato'');" disabled="disabled">');
    lv_combo_modalidad_alcance  := f_retorna_combo(cmodalidadalcance, 'ag_cod_modalidad_alcance', NVL (ag_cod_modalidad_alcance, ln_cod_modalidad_alcance_res),'--- Seleccionar ---','style="width:339px;"');
    lv_combo_sistemaadquisicion := f_retorna_combo(csistemaadquisicion, 'ag_cod_sist_adquisicion', NVL (ag_cod_sist_adquisicion, ln_cod_sist_adquisicion),'--- Seleccionar ---','style="width:339px;"');
    lv_combo_moneda             := f_retorna_combo(cmoneda, 'ag_codmoneda_contrato_sel', ln_codmoneda_contrato,null,'disabled="true" style="width:114px;"');

    -- datos del upload del contrato
   
    REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.P_last_upload_contrato( ag_cod_contrato, session__N_CONVOCA, ln_NCOD_DOC,lv_DOC_URL,lv_FEC_UPLOAD ,lv_USER_UPLOAD,lv_FEC_APROB ,lv_EXT_TIPO_FILE,lv_ICON_TIPO_FILE, lv_DOC_OBS );

    -- datos de la entidad q paga
  
   reg_procesos.PKU_GESTOR_CONT_UTILES_2.p_entidad_pagadora (session__eue_codigo, session__anhoentidad,1,ln_cont_paga,lv_codconsucode_paga,  lv_anhoenidad_paga, lv_descentidad_paga  );
    lv_ruta_file                := gpk_directorio_liquidacion||'\'||session__anhoentidad||'\'||session__eue_codigo||'\'||session__N_CONVOCA;

   -- Estado de los items del contrato
   ln_items_resueltos         := f_get_cantitemsresueltos (ag_cod_contrato);
   ln_items_en_ejecucion      := f_get_cantitemsenejecucion (ag_cod_contrato);
    
   ag_item_valor           := F_GET_ITEMPUBLICAR (ag_cod_contrato); -- SM 230-2018 ddrodriguez
   
   ag_item_publicar := SUBSTR(ag_item_valor,0,1);
   ag_item_nro := SUBSTR(ag_item_valor,3,8);
   
  usp_fechasprorroga (ag_cod_contrato,ld_fec_contrato,ld_fec_culimnacion);


   lv_estado_contrato :=
      f_get_estadocontrato (ld_fec_contrato,
                            ld_fec_culimnacion,
                            TO_DATE (lv_f_liquidacion,reg_procesos.pku_ss_constantes.gv_formato_fecha),
                            TO_DATE (lv_f_intervencion,reg_procesos.pku_ss_constantes.gv_formato_fecha),
                            ln_items_resueltos,
                            ln_items_en_ejecucion
                           );

--   select ind_consorcio into ln_ind_consorcio from reg_procesos.convocatoria_propuesta where ruc_postor = lv_ruc_contratista and n_convoca = session__n_convoca;

 
  
   select c.ruc_postor, c.ind_consorcio into lv_ruc_contratista ,ln_ind_consorcio from reg_procesos.convocatoria_propuesta c where c.n_propuesta = nvl(ag_n_propuesta,ln_n_propuesta);
   
          
     
          
    ---INICIO MANTENIMIENTO 84-2018   Hallamos la normativa
 
          if (av_id_expede is null) or (av_id_expede = '') then
          LN_NORMATIVA_P:='SN';
          else 
             begin
                 ----SI tiene normativa lo recupera del SEACEv3
               select distinct(tcn.C_NORAPL)  into LN_NORMATIVA_P  from PRO.TBL_ACT_EXPEDIENTE@AIXSEACE tcn  where  tcn.N_ID_EXPEDE=av_id_expede;
               
               if (LN_NORMATIVA_P is null) or (LN_NORMATIVA_P = '') then    ----para los expediente que no tienen normativa
                            LN_NORMATIVA_P:='SN';
               end if;
               
               exception when others then
                             LN_NORMATIVA_P:='SN';
             end;
            end if;
            
       
       
      LN_PROV_EXTRANJ_SRNP_P:='NO_EXTRANJERO_SNRP';
         IF ln_ind_consorcio = 1 then

            FOR xrowtc IN cConsorcioMiembrostc(lv_ruc_contratista,session__N_CONVOCA) LOOP

      ---verificamos si el proveedor  es un provedor Extranjero sin RNP registrado mediante la funcionalidad de "Administrar Proveedor Extranjero Sin RNP"  del SEACEv3    
          
             if (xrowtc.ruc_miembro is not null) then
                begin
                
              if LN_PROV_EXTRANJ_SRNP_P='NO_EXTRANJERO_SNRP' then
               select distinct(tcei.C_RUC) into LN_PROV_EXTRANJ_SRNP_P from ADM.TBL_ADM_PROV_EXCEPTUADO@AIXSEACE tcei
                         where tcei.C_RUC= xrowtc.ruc_miembro
                           and tcei.C_VERSIONESTADO='VER_VIG'
                           and tcei.C_IDTIPOEXCEPTUADO='EXTRJ';
                if (LN_PROV_EXTRANJ_SRNP_P is not null) then    ---- si encontro Proveedor estranjero Sin RNP
                            LN_PROV_EXTRANJ_SRNP_P:='EXTRANJERO_SNRP';
                 end if;
               end if;
                exception when others then
                             LN_PROV_EXTRANJ_SRNP_P:='NO_EXTRANJERO_SNRP';
                             
            end;
           end if;
      
            END LOOP;
        
        ELSE
         if (lv_ruc_contratista is not null) then
            begin
               select distinct(tceia.C_RUC) into LN_PROV_EXTRANJ_SRNP_P from ADM.TBL_ADM_PROV_EXCEPTUADO@AIXSEACE tceia
                         where tceia.C_RUC= lv_ruc_contratista
                           and tceia.C_VERSIONESTADO='VER_VIG'
                           and tceia.C_IDTIPOEXCEPTUADO='EXTRJ';
                if (LN_PROV_EXTRANJ_SRNP_P is not null) then    ----para los expediente que no tienen normativa
                              LN_PROV_EXTRANJ_SRNP_P:='EXTRANJERO_SNRP';
                            
                end if;
               
                exception when others then
                             LN_PROV_EXTRANJ_SRNP_P:='NO_EXTRANJERO_SNRP';
                             
                             
            end;
         END IF;
        END IF;
     
	--inicio validacion clc
	lv_requiere_const_clc := 'NP';
	select distinct(tcn.C_TIPSEL)  into LN_C_TIPSEL  from PRO.TBL_ACT_EXPEDIENTE@AIXSEACE tcn  where  tcn.N_ID_EXPEDE=av_id_expede;
	--R1
	select c.codobjeto into lv_objeto from reg_procesos.convocatorias c where c.n_convoca = session__n_convoca;--recuperamos el tipo de objeto del proceso

  --RECUPERAMOS SI ES EXCEPTUADO
  
  select count(*) into contador from adm.tbl_adm_prov_exceptuado@aixseace tceia where tceia.C_RUC= lv_ruc_contratista;
  if ((contador)>0) then
  select distinct(tceia.c_ruc) into ln_prov_exeptuado from adm.tbl_adm_prov_exceptuado@aixseace tceia where tceia.c_ruc= lv_ruc_contratista;
  end if;
--extranjero no domiciliado sin RNP ("L","0")  o proveedor exceptuado 
if ( (substr(lv_ruc_contratista,1,1) in ('0','I','L')) OR (ln_prov_exeptuado is not null)  )then
	lv_requiere_const_clc := 'No';
else
begin

	if (lv_objeto = 3) then
		begin
			--validamos la norma aplicable
    if(LN_NORMATIVA_P <> 'SN') then
			if (LN_NORMATIVA_P = 383) or (LN_NORMATIVA_P = 34) then
				begin
					--validamos tipo seleccion
					IF (LN_C_TIPSEL = 82) or (LN_C_TIPSEL = 271) then 
						lv_requiere_const_clc := 'Si';
					end if;
          			
          			--Cont. Directa con causal: derivado contrato nulo art 44
		          	if (LN_C_TIPSEL = 293) then
			            begin
			            
                    select distinct(tcn.c_causal)  into ln_c_causal  from pro.tbl_act_expediente@aixseace tcn  where  tcn.n_id_expede=av_id_expede;
				            
                    IF (ln_c_causal = 305) then 
				                lv_requiere_const_clc := 'Si';
				            end if;
	            
	            		end;
					end if;
          
          
				end;
        end if;
			end if;
		end;
	end if;
end;
end if;
	--fin validacion clc

   USP_PRINT('<input type="hidden" name="V_LN_NORMATIVA_P"   value="'||LN_NORMATIVA_P||'"></input>');--MANTENIMIENTO 84-2018 
   USP_PRINT('<input type="hidden" name="V_LN_PROV_EXTRANJ_SRNP_P"   value="'||LN_PROV_EXTRANJ_SRNP_P||'"></input>');--MANTENIMIENTO 84-2018
            
      ---FIN MANTENIMIENTO 84-2018
	  
   ----INICIO  SM-224-2018-SGFS-2018/SGFS
	lb_validacion_rnp :=f_valida_inhab_contrato(lv_ruc_contratista, session__n_convoca,lv_f_contrato, lv_estado_rnp);

	USP_PRINT('<input type="hidden" name="V_LV_ESTADO_RNP"   value="'||TO_CHAR(lv_estado_rnp)||'"></input>');
  ----FIN  SM-224-2018-SGFS-2018/SGFS  

   USP_PRINT('<input type="hidden" name="V_LN_TIPO_PROC_30556_P"   value="'||TO_CHAR(LN_TIPO_PROC_30556_P)||'"></input>');--Micro requerimiento Ley 30556
   usp_print('<input type="hidden" name="v_calendario_total"         value=""/>');
   usp_print('<input type="hidden" name="ag_trama_items"             value=""/>');
   usp_print('<input type="hidden" name="ag_trama_items_xml"         value=""/>');
   usp_print('<input type="hidden" name="ag_n_convoca"               value="'||session__n_convoca||'"/>');
   usp_print('<input type="hidden" name="WriteFileDirectory"         value="FileSinged">');
   usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"  value="'||lv_ruta_file||'"></input>
   <input type="hidden" name="SizeFile"></input>
   ');

   --input clc inicio
   usp_print('<input type="hidden" name="RequiereValidacionCLC"      value="'||lv_requiere_const_clc||'"/>');--indica si debe verificar constancia clc
   
   if (ln_ind_consorcio != 1) then
      usp_print('<input type="hidden" name="ArregloRucMiembros"      value="'||lv_ruc_contratista||'"/>');--cuando no es consorcio se recupera solo el ruc original
   end if;
   --input clc fin
   
   -- Nombre de contratista
   usp_print('<input type="hidden" name="ag_ruc_contratista"         value="'||lv_ruc_contratista||'" >
              <input type="hidden" name="ag_nom_contratista"         value="provedor">');

 /*  usp_print('<input type="hidden" name="ag_ruc_contratista"         value="'||lv_ruc_contratista||'" >
              <input type="hidden" name="ag_nom_contratista"         value="'||reg_procesos.F_WS_RNP_GET_RAZON_SOCIAL(lv_ruc_contratista)||'">');
*/   -- Moneda del contrato
   usp_print('<input type="hidden" name="ag_codmoneda_contrato"      value="'||ln_codmoneda_contrato||'"  >');
   usp_print('<input type="hidden" name="ag_cod_contrato"            value="'||ag_cod_contrato||'"  >');
   usp_print('<input type="hidden" name="ag_id_operacion"            value="'||ln_id_operacion||'"  >');
   usp_print('<input type="hidden" name="ag_n_propuesta"             value="'||ln_n_propuesta||'"  >');
   -- Garantias
   usp_print('<input type="hidden" name="ag_v_garantias_decla"       value="'||ln_v_garantias_declaradas||'"  >');
   usp_print('<input type="hidden" name="ag_v_declaracion"           value="'||ln_v_declaracion||'"  >');
   usp_print('<input type="hidden" name="ag_v_tipos_validos"         value="'||ln_v_tipos_validos||'"  >');
   usp_print('<input type="hidden" name="ag_v_rango"                 value="'||ln_v_rango||'"  >');
   usp_print('<input type="hidden" name="ag_tipo_modalidad"           value="'||ln_tipo_modalidad||'"/>'); 
  
  usp_print('<input type="hidden" name="av_id_expede"           value="'||av_id_expede||'"/>');
 usp_print('<input type="hidden" name="av_id_proc"           value="'||av_id_proc||'"/>');
 usp_print('<input type="hidden" name="av_id_con_pub"           value="'||av_id_con_pub||'"/>');
 usp_print('<input type="hidden" name="ag_item_publicar"           value="'||ag_item_publicar||'"/>'); --SM 230-2018 ddrodriguez 
 usp_print('<input type="hidden" name="ag_item_nro"           value="'||ag_item_nro||'"/>'); --SM 230-2018 ddrodriguez 

   usp_print ('
        <table border="0" cellpadding="0" cellspacing="0" width="100%" >
      <tr>
          <td>'||REG_PROCESOS.PKU_PROCESOS_COMUN.f_get_titulo_v3(session__N_CONVOCA, 'Modificar Contrato') ||'</td>
            <td align=right valign="top">
                <input type=button value="Volver" name="btnVolver" onclick="thisform.scriptdo.value=''doViewConsolaContratos'';thisform.submit();">');

                         IF nvl(LN_INDPUB_CONTRATO,0) = 0 THEN
                           -- usp_print('<input type=button value="Eliminar" name="btnGuardar" onclick=goSubmit("usp_eliminar_contrato",this);>');
                           -- usp_print('<input type=button value="Guardar" name="btnGuardar" onclick="Grabar_v3('||PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__N_CONVOCA)||',''xmlItems'',''ag_trama_items'');">');
          
                            select proc_tipo into ln_proc_tipo from convocatorias where n_convoca = session__n_convoca;
                            ln_valida_inicio := pku_ss_garantias.f_valida_inicio_v3(session__N_CONVOCA) ;
          
                            select count(1) into ln_app from GARANTIA_DECLARACION d INNER JOIN REG_PROCESOS.GARANTIA_CLASE cl on d.cod_clase = cl.cod_clase   left outer join reg_procesos.garantia_razon ra on d.cod_razon = ra.cod_razon     where d.n_cod_contrato  = ag_cod_contrato;
                            
                            select count(1) into ln_garantia from REG_PROCESOS.GARANTIA WHERE n_cod_contrato = ag_cod_contrato;
                           
                           /*Formato de incidencia 53 - Contratos 2.9 - Publicación de Contratos-  Obligación del registro de garantias - Denis Llantoy*/ 
                           /* INICIO if ( ln_proc_tipo in (11,23,40,74,63) or ln_valida_inicio > 1 or ( ln_app > 0 and ln_valida_inicio = 1 and PKU_SS_GARANTIAS.f_valida_declaracion(ag_cod_contrato) > 0 ) and  ln_garantia > 0 ) then */
                           -- if ( ln_proc_tipo in (11,23,40) or ln_valida_inicio > 1 or ( ln_app > 0 and ln_valida_inicio = 1 and PKU_SS_GARANTIAS.f_valida_declaracion(ag_cod_contrato) > 0 ) and  ln_garantia > 0 ) then
                           --     usp_print('<input type=button value="Publicar Contrato1" name="btnPublicar" onclick="Publicar();">');
                             --   else 
                                 /* FIN if (ln_proc_tipo in (11,23,40,74,63) or ln_valida_inicio > 1 or ( ln_app > 0 and ln_valida_inicio = 1 and PKU_SS_GARANTIAS.f_valida_declaracion(ag_cod_contrato) = 0 )) then */
                              --   if (ln_proc_tipo in (11,23,40) or ln_valida_inicio > 1 or ( ln_app > 0 and ln_valida_inicio = 1 and PKU_SS_GARANTIAS.f_valida_declaracion(ag_cod_contrato) = 0 )) then
                              --    usp_print('<input type=button value="Publicar Contrato2" name="btnPublicar" onclick="Publicar();">');
                              --    end if;
                           -- end if;
                              /*se comenta la opcion de publicar contrato para todos los casos  13-09-2020*/
                         END IF;
                             
   usp_print('</td>
        </tr>
        </table>
        </td></tr>');

   usp_print('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="table table-striped">
        <tr><td colspan=3><h3>Datos del Contrato</h3></td></tr>
       ');

 /*  usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Entidad Contratante',
                '<b>'||lv_descentidad_paga||'</b>',
                'Entidad encargada de efectuar el pago.'));*/
                
                
usp_print
       (' <tr><td width=35%>Entidad Contratante:</td><td width=35%><b>'||lv_descentidad_paga||'</b></td><td width=30%>Entidad encargada de efectuar el pago.</td></tr>');

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Descripci&oacute;n del contrato/Orden de Compra o Servicio',
                '<input type=text value="'|| NVL (TRIM (ag_des_contrato), lv_des_contrato) ||'" name="ag_des_contrato" size="54">',
                'Descripcion del contrato/Orden de Compra o Servicio'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero de Contrato u Orden de Compra o Servicio:',
                lv_combo_tipocontrato
                ||'<input size=30 maxlength="250" name="ag_n_contrato" value="'||NVL (ag_n_contrato, ln_n_contrato)|| '">',
                'N&uacute;mero de Contrato u Orden de Compra o Servicio'));


   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Ruc o Codigo de Proveedor Extranjero no Domiciliado del Contratista:',
                lv_combo_rucs,
                'Seleccione el Contratista'));

  IF ln_ind_consorcio = 1 THEN

       usp_print
         ('<tr>
              <td class=c1>&nbsp;</td>
              <td class=c2><b>Miembros del Consorcio:</b><BR>');

              usp_print('<table>');

      --se obtiene el arreglo de rucs
      arrayRucs := '';
      
      LOOP
      FETCH cmiembros_consorcio INTO ls_ruc_miembro, ls_nom_miembro;
      exit when cmiembros_consorcio%notfound;
      --inicio rucs clc
      --ejecutor_obras := to_char(ld_fec_contrato,'yyyymmdd');
      
      ejecutor_obras := reg_procesos.f_ws_rnp_get_estado_d(ls_ruc_miembro,3,to_char(to_date(sysdate),'yyyymmdd')); 
      dbms_output.put_line('ejecutor_obras clc: '||ejecutor_obras); 
      
      if ((substr(ejecutor_obras,1,1)) = '1') then 
          arrayrucs := arrayrucs || ls_ruc_miembro||'-';
      end if;
      --fin rucs clc
            usp_print
               ('<tr>
                    <td>'||ls_ruc_miembro||'&nbsp; - &nbsp;'||ls_nom_miembro||'</td>
                </tr>');
      END LOOP;
      close cmiembros_consorcio;
      --input rucs clc
      usp_print('<input type="hidden" name="ArregloRucMiembros"      value="'||arrayRucs||'"/>');--arreglo de los rucs
      
              usp_print('</table>');
      usp_print('</td>
              <td class=c3>&nbsp;</td>
          </tr>');

  END IF;

  --IF   lv_ruc_destino_pago  is null THEN  temp := lv_ruc_contratista ELSE  temp := lv_ruc_destino_pago  END IF
  


   usp_print('<tr>
            <td class=c1>RUC Destinatario de Pago</td>
            <td class=c2><input name="ag_ruc_destino_pago" size="54" readOnly="true" value="'|| lv_ruc_destino_pago  ||'" style="background:#e9f4fe"  ></td>
            <td class=c3>N&uacute;mero RUC del Destinatario de Pago</td>
        </tr>
        <tr>
            <td class=c1>Destinatario del pago: </td>
            <td class=c2><div id=divnombre style="border:0px solid #008000"></div></td>
            <td class=c3>Nombre del destinatario del Pago</td>
        </tr>
         <tr>
            <td class=c1>(*)Fecha de Suscripci&oacute;n del Contrato/notificaci&oacute;n de la Orden de Compra o Servicio:</td>
            <td class=c2><div class="input-group datepicker" id="idDivTxtFechaContrato">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
<input  type=text data-format="dd/MM/yyyy" class="form-control" name="ag_f_contrato" readOnly  value="'||lv_f_contrato||'">
           
        </div> 
            </td>
            <td class=c3>&nbsp;Fecha de Suscripcion del Contrato/notificaci&oacute;n de la Orden de Compra o Servicio</td>
      </tr>
      '
        );
        
        


  usp_print
     ('<tr>
           <td class=c1>(*)Vigencia del contrato:</td>
           <td class=c2>Inicio:
           <div class="input-group datepicker" id="idDivTxtFechaIni">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
           <input type=text size=16 readOnly="true" name="ag_f_vigencia_ini" data-format="dd/MM/yyyy" class="form-control" value="'||lv_f_vigencia_ini||'">
           </div>Fin:
          <div class="input-group datepicker" id="idDivTxtFechaFin">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
           <input  type=text size=17 readOnly="true" name="ag_f_vigencia_fin" data-format="dd/MM/yyyy" class="form-control" value="'||lv_f_vigencia_fin||'">
          </div>
           </td>
           <td class=c3>&nbsp;Vigencia del Contrato original</td>.
      </tr>');
      

   usp_print
       ('<tr>
           <td class=c1>(*)Monto Contratado:</td>
           <td class=c2>'||lv_combo_moneda||' <input value="" readOnly="true"  size="34" type="text"  name="ag_m_contratado" id="ag_m_contratado" onkeyup="validarInputNumDecimal(this)"></td>
           <td class=c3>Monto Contratado</td>
        </tr>
        <tr>
          <td class=c1>(*)Situaci&oacute;n: </td>
          <td class=c2><input value="'||lv_estado_contrato||'" class="InpReadOnly" size="54" type="text" readonly name="agdestpago"/></td>
          <td class=c3>Estado Actual del Contrato</td>
        </tr>');

   

usp_print('<input type="hidden"  name="ag_cod_sist_adquisicion" value="">');
  usp_print('<input type="hidden"  name="ag_cod_modalidad_alcance" value="">');

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
                '<input type=text name="ag_observaciones" id="ag_observaciones" value="'|| NVL (ag_observaciones, lv_observaciones)||'" size="54">',
                'Observaciones del Contrato'));

   usp_print('</table>');

 --  DATOS DEL UPLOAD
  usp_print
       ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="table table-striped">
            <tr><td colspan=3><h3>Registro de Contrato/Orden de Compra o Servicio</h3></td></tr>
          ');



/*usp_print( '<tr><td width=35%>(*)Adjuntar Archivo</td><td width=35%><input type="file" id="pfiletoupload1"  name="pfiletoupload1" class="form-control" size="41"  value="">'
|| case when lv_DOC_URL is not null then '<br><a target=_blank href="DownloadFileServlet?fileName='||lv_DOC_URL||'">');*/

usp_print( '<tr><td width=35%>(*)Adjuntar Archivo</td><td width=35%><input type="file" id="pfiletoupload1"  name="pfiletoupload1" class="form-control" size="41"  value="">'
|| case when lv_DOC_URL is not null then '<br><a target=_blank href="'||url_azure_app||''||lv_DOC_URL||'">

<img src="'||lv_ICON_TIPO_FILE||'" border="0" width="25" height="25"/></a>' 
end || case when lv_FEC_UPLOAD is not null then ' Registrado el '||lv_FEC_UPLOAD end
||
              '<input type="hidden" name="pfiletoupload_file1" value=""/></td>
              <td width=30%>Seleccione el archivo que contiene el Contrato/Orden de Compra o Servicio, solo se permiten archivos *.doc o *.pdf</td></tr>');

 
 
  usp_print(
          PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha del Documento de Contrato',
              '<div class="input-group datepicker" id="idDivTxtFechaDoc">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div><input readonly name="ag_fec_aprob" data-format="dd/MM/yyyy" class="form-control" value="'||lv_FEC_APROB||'"></div>',
              'Seleccione la fecha de aprobacion del documento.'));
              
  usp_print(
          PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
              '<input size="54" type="text" name="doc_obs" value="'||lv_DOC_OBS||'">',
              'Ingrese las Observaciones'));

  usp_print ('</table>');
  usp_print ('</td></tr>');

  

    usp_print('
         <script language="javascript" event=onchange for=ag_ruc_destino_pago>
                 divnombre.innerHTML = "";
                 callconsor(this.value,"'||session__n_convoca||'");
         </script>

        <script language="javascript">
            callconsor(thisform.ag_ruc_destino_pago.value,"'||session__n_convoca||'");
        </script>

     ');


 IF reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__n_convoca) = 1 THEN

            ----------------------- Nuevo Calendario --------------------
    
 -----------------  Calendario de pagos ------------
      usp_print('
      <tr>
      <td></br>
      <table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">
      <tr><td colspan="3"><h3>Calendario de pagos</h3></td></tr>');
      usp_print('<tr><td width=33% ></td>
      <td width=33%>
      <table border=1 width=100%  align=center cellpadding=3 cellspacing=0>
      <thead> <tr style=''background-color: #BDBDBD;color:#111111''>
      <td width=20% >Nro. de pago</td>
      <td width=30% >Fecha de pago</td>
      <td width=30% > <div id=''dv_tot_val_item''></div></td>
      <td width=20% >Operación</td></tr>
      <tr><td width=10%><input type=hidden name=v_ind_modificar value=0 /><input type=hidden value="" name="v_item" /></td>
      <td align=center width=20%><div class="input-group datepicker" id="idDivTxtFechaPago"> <div class="input-group-addon add-on">
      <span class="glyphicon glyphicon-calendar"></span></div>
      <input   name="ag_cal_fec_pago" data-format="dd/MM/yyyy" class="form-control" align=center readOnly=true/></div></td>
      <td align=center width=20%><input name=ag_cal_monto_pago  type=text onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this)"  /></td>
      <td align=center width=10%><input type=button name=it_b_agregar  value=''Agregar''></td>
      </tr></thead>
      ');
      usp_print('<tr><td colspan=4><div id="divCalendario">&nbsp;</div></td></tr>');
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlCalendario(session__cod_moneda,replace(lv_trama_calendario, ',', '.'),'v_calendario_total');
      usp_print('</table></td><td width=34% ></td></tr>');

    
    usp_print('
           
        
        <script language="javascript" event="onclick" for="it_b_agregar">
        AdicionarCalendario(thisform.ag_cal_fec_pago.value, thisform.ag_cal_monto_pago.value);
      
    </script>
        ');


 END IF;

 usp_print('</table><br>');

 usp_print('
         <table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">
         <tr><td><h3>Items del Contrato</h3></td></tr>
         <tr>
            <td align="center">
                <input type="button" value="Agregar Nuevo Item al Contrato"  OnClick="AdicionarElemento3(thisform.ag_proc_item.value,thisform.ag_f_bp_cons.value,thisform.ag_ubigeo.value,thisform.ag_descripcion.value,thisform.ag_monto.value,thisform.ag_unidad.value,thisform.ag_cantidad.value,thisform.ag_unidad_codigo.value,thisform.ag_sis_cont.value,thisform.ag_sis_des.value,thisform.ag_mod_cont.value,thisform.ag_mod_des.value,thisform.ag_itempaq_desc.value,thisform.ag_nivel5_cod.value,thisform.ag_cod_item.value,'||session__eue_codigo||','||session__anhoentidad||','||session__n_convoca||' );"></input>
               
            </td>
         </tr>
         <tr><td>&nbsp;</td></tr>
         <tr>
            <td align="center">
             <div id="divLista">&nbsp;</div>');
      
        -- Trama de Items
    begin

     if ag_n_propuesta  = ln_n_propuesta or ag_n_propuesta is null then
     PKU_GESTOR_CONT_UTILES_2.usp_XmlItemsManContrato_v3(ag_cod_contrato,session__N_CONVOCA,ln_n_propuesta);
     else
     PKU_GESTOR_CONT_UTILES_2.usp_xmlitemsnewcontrato_v3(ag_n_propuesta,session__n_convoca,session__eue_codigo,null);
     end if;

      usp_print('<script language=javascript>thisform.ag_m_contratado.value =   sumaTotalesItems3("xmlItems") </script>');


        EXCEPTION
        when others then

             f_msg_error('Error: Al intentar hallar los items del contrato','''doView''');
             return;
    end;
      

    
        usp_print ('</table>');

        usp_print ('</td></tr>');
        usp_print ('</table>');

        reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script('

          if(thisform.ag_tipo_modalidad.value != 0  ){
               $("#ag_monto").removeAttr("readOnly", false); //colocar readonly
                  $("#ag_cantidad").removeAttr("readOnly", false);
            }

       ');




 END;

 PROCEDURE uspprocesar_pub_contrato_v3 (
   session__cod_contrato            NUMBER,
   session__n_convoca               VARCHAR2,
   session__av_id_proc              VARCHAR2,
   ag_id_operacion                  VARCHAR2,
   session__userid                  VARCHAR2,
   iisenv__remote_host              VARCHAR2,
  av_id_expede              VARCHAR2  DEFAULT NULL,
  
  	--SM 182 CLC 
	RequiereValidacionCLC		VARCHAR2, --el valor se recupera de uspmancontratosdoedit_v3
	ArregloRucMiembros			VARCHAR2  DEFAULT NULL, --se llena cuando se trate de un consorcio
	EstadoValidacionCLC			VARCHAR2  DEFAULT NULL--llenamos con un setparameter en caliente
	
  )
  IS
  cursor c_item(cod number) is
  select *
  from reg_procesos.item_contrato icon
  where icon.n_cod_contrato =cod;
  
  ln_indsiaf                       NUMBER;
  cant                            number;
  MAXI                            NUMBER;
  BEGIN

  --recuperamos el valor del estado ian
    usp_print('<input type="hidden" name="pEstadoValidacionCLC"      value="'||EstadoValidacionCLC||'"/>');--indica estado constancia clc
    usp_print('<input type="hidden" name="pArregloRucMiembros"      value="'||ArregloRucMiembros||'"/>');--indica el ruc  constancia clc  
  
  if ((EstadoValidacionCLC = 'ACTIVA') or  (RequiereValidacionCLC  in ('NP', 'No'))) then
	  begin
		  DBMS_OUTPUT.PUT_LINE('Se publica porque esta activa o no requiere clc');
		  -- Verifica el indicador del SIAF
		  ln_indsiaf := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__n_convoca);
		  
		  select count(*) into cant from reg_procesos.item_contrato icon   where icon.n_cod_contrato =session__cod_contrato;

			UPDATE REG_PROCESOS.CONTRATO
				 SET IND_CONTRATO_PUB = 1 ,
					 f_publica = sysdate
			   WHERE N_COD_CONTRATO = session__cod_contrato;

		  IF ln_indsiaf = 1 THEN

			
			reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion(ag_id_operacion);

			UPDATE CONTRATO_OPERACION
			   SET CONTRATO_OPERACION.Usuario_Transfer = session__userid,
				   CONTRATO_OPERACION.IP_CREACION      = iisenv__remote_host
			 WHERE CONTRATO_OPERACION.id_operacion     = ag_id_operacion; --reg_procesos.pk_convocatoria.getidoperacion;

		  END IF;
		 
		  COMMIT;
		  /*actualizar items seacev3*/
		  
		  if cant > 0 then
			for xx in c_item(session__cod_contrato) loop
			
			SELECT pro.SQ_ID_EST_ITEM.nextval@AIXSEACE INTO MAXI FROM DUAL;
			insert into PRO.TBL_SEL_EST_ITEM@AIXSEACE VALUES (MAXI, xx.n_id_pub_con, xx.n_id_item, 16, sysdate, null, session__userid, sysdate, null, null, null, null, 22);
			
			update PRO.TBL_ACT_ITEM@AIXSEACE
			SET N_ESTPRO = 22
			WHERE N_ID_ITEM =xx.n_id_item;
			
			commit;
			end loop;
		  
		  end if;
	  
	  end;
	  
	  else
    if (RequiereValidacionCLC not in ('NP', 'No')) then
      begin
          --clc inicio
          usp_print('
          <script>
          alert("El proveedor "  +thisform.pArregloRucMiembros.value+ " no cuenta con la constancia de Capacidad Libre de Contratación.\n\nSolicite al proveedor el cumplimiento de este requisito para continuar con la publicación del contrato.");
          alert("estado clc : " + thisform.pEstadoValidacionCLC.value);
          </script>');
          --clc fin
      end;
    end if;
	  
  end if;
  
 

  usp_print('<input type=hidden name=ag_n_convoca value ='||session__n_convoca||'>');
  usp_print('<input type=hidden name=av_id_proc value ='||session__av_id_proc||'>');
  usp_print('<input type=hidden name=av_id_expede value ='||av_id_expede||'>'); --Atención de incidencia SEACE-ReqMEF 18/11/15

  usp_print('<script language="javascript">
                     thisform.scriptdo.value = "doViewConsolaContratos";
                     thisform.submit();
             </script>');



  
  dbms_output.put_line('clc no valido');
  DBMS_OUTPUT.PUT_LINE('estado clc: '||EstadoValidacionCLC);
  
  END;


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

      IF f_liquidacion IS NOT NULL THEN
         lv_estado := 'CONTRATO LIQUIDADO';
      ELSIF (cant_items != 0 AND cant_items2 != 0)  THEN
         lv_estado := cant_items  || 'ITEM(s) RESUELTO(s)' || cant_items2  || 'ITEM(s) EN EJECUCION';
      ELSIF (cant_items != 0 AND cant_items2 = 0) THEN
         lv_estado := cant_items || 'ITEM(s) RESUELTO(s)';
      ELSIF ((fec_intervencion IS NOT NULL AND f_contrato_pro IS NULL) OR (TRUNC (fec_intervencion) > TRUNC (f_contrato_pro))) THEN
         lv_estado := 'CON INTERVENCION ECONOMICA';
      ELSIF ((f_contrato_pro IS NOT NULL AND fec_intervencion IS NULL) OR (TRUNC (f_contrato_pro) > TRUNC (fec_intervencion))) THEN
         lv_estado := 'PRORROGADO del '|| TO_CHAR (f_contrato_pro, reg_procesos.pku_ss_constantes.gv_formato_fecha) || ' al ' || TO_CHAR (f_culminacion_pro, reg_procesos.pku_ss_constantes.gv_formato_fecha);
      END IF;

      RETURN lv_estado;

   END;




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


-----INICIO SM-224-2018-SGFS

------------------------------------------------------------------------------------------------
/* FUNCION QUE HACE LA VALIDACION DE INHABILITACION DEL CONTRATISTA O CONSORCIO ANTES DE  REGISTRAR EL CONTRATO*/
------------------------------------------------------------------------------------------------

FUNCTION f_valida_inhab_contrato(
         ag_ruc_contratista   IN VARCHAR2,
         ag_n_convoca         IN VARCHAR2,
         ag_f_contrato        IN VARCHAR2,
         ag_estado_rnp       OUT VARCHAR2
         ) return BOOLEAN
IS
 CURSOR cConsorcioMiembros(ruc_consorcio VARCHAR2,n_convoca NUMBER)
 is
   SELECT b.tipo,b.RUC_MIEMBRO,b.NOM_MIEMBRO
     FROM REG_PROCESOS.CONVOCATORIA_PROPUESTA a 
    INNER JOIN  REG_PROCESOS.CONSORCIO_MIEMBRO b ON a.COD_CONSORCIO = b.COD_CONSORCIO
    WHERE a.RUC_POSTOR = ruc_consorcio
      AND a.N_CONVOCA = n_convoca;

      LB_RETORNO               BOOLEAN;
      lv_ruc_consorcio         VARCHAR2(50);
      lv_n_convoca             NUMBER;
      lv_id_consorcio          VARCHAR2(20);
      cant                     VARCHAR2(500);
      ln_proc_tipo             NUMBER;
      ln_valida_rucentidad     NUMBER;
      ld_f_contrato            DATE;
      ln_tipo_proceso           NUMBER; 
       mensaje_inhabi          VARCHAR2(500);
      

BEGIN
  lv_ruc_consorcio := ag_ruc_contratista;
  lv_n_convoca     := to_number(ag_n_convoca);
  lv_id_consorcio  := substr(lv_ruc_consorcio,0,1);
  ld_f_contrato    := to_date(ag_f_contrato,'dd/mm/yyyy');
  LB_RETORNO       := TRUE;
  ag_estado_rnp := '';
  mensaje_inhabi:= '';
  

  /*PARA EL DEMO SE QUITO LA VALIDACION */
 /*RETURN TRUE; */

----Sacamos el tipo de proceso y la entidad
  SELECT C.PROC_TIPO INTO ln_tipo_proceso FROM REG_PROCESOS.CONVOCATORIAS C WHERE C.N_CONVOCA = lv_n_convoca;   
      
  
  SELECT count(1) INTO ln_proc_tipo  FROM reg_procesos.convocatorias  WHERE n_convoca = ag_n_convoca  AND  proc_tipo in (11,23,40);   



    ----- Consorcio
      IF lv_id_consorcio = 'C' then

        FOR xrow IN cConsorcioMiembros(lv_ruc_consorcio,lv_n_convoca) LOOP

          select count(1) into ln_valida_rucentidad
                 from reg_procesos.entidades e where e.n_ruc = xrow.RUC_MIEMBRO
                 and e.anhoentidad = to_char(ld_f_contrato,'yyyy');

          -- verificamos que el postor NO sea una entidad
          IF  ln_valida_rucentidad = 0 THEN
             
	    cant :=reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL_ESP(xrow.RUC_MIEMBRO,to_char(ld_f_contrato,'yyyymmdd'));
              -- IF cant <> '1-OK' THEN
              IF substr(cant,1,1) = '2' THEN
                mensaje_inhabi := 'El Proveedor del Consorcio: '||xrow.NOM_MIEMBRO||' se encuentra inhabilitado, no es posible publicar el contrato.';
                LB_RETORNO := FALSE;
              END IF;

              IF UPPER(cant) LIKE '%ERROR%' THEN
                  mensaje_inhabi := 'Sistema externo no disponible, vuelva a intentar';
                  LB_RETORNO    := FALSE;
              END IF;    
          END IF;

        END LOOP;

	ag_estado_rnp:=mensaje_inhabi;
      ELSE

          SELECT count(1) INTO ln_valida_rucentidad from reg_procesos.entidades e where e.n_ruc = lv_ruc_consorcio;

          IF ln_valida_rucentidad = 0 THEN
			cant := reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL_ESP(lv_ruc_consorcio,to_char(ld_f_contrato,'yyyymmdd'));
            
            ---caso de de cant= 2-SE ENCUENTRA INHABILITADO
			-- IF cant <> '1-OK' THEN
            	IF substr(cant,1,1) = '2' THEN
               		mensaje_inhabi := 'El proveedor '||lv_ruc_consorcio||' se encuentra inhabilitado, no es posible publicar el contrato.';
                    LB_RETORNO := FALSE;
            	END IF;
           
           --- caso de de cant= 9-Error Llamada al Web Service - RNP
             IF UPPER(cant) LIKE '%ERROR%' THEN
                  	mensaje_inhabi := 'Sistema externo no disponible, vuelva a intentar';
                  	LB_RETORNO    := FALSE;
              	END IF;                
           
            END IF;
	ag_estado_rnp:=mensaje_inhabi;
  END IF;  
RETURN LB_RETORNO;

END;

-----FIN SM-224-2018-SGFS

------------------------------------------------------------------------------------------------
/* FUNCION QUE HACE LA VALIDADCION DEL CONTRATISTA O CONSORCIO ANTES DE  REGISTRAR EL CONTRATO*/
------------------------------------------------------------------------------------------------

FUNCTION f_valida_rnp_contrato(
         ag_ruc_contratista   IN VARCHAR2,
         ag_n_convoca         IN VARCHAR2,
         ag_f_contrato        IN VARCHAR2,
         ag_estado_rnp       OUT VARCHAR2
         ) return BOOLEAN
IS
/*Inicio mmautino - SM 059-2020-SGFS - Modificación de validaciones al publicar un contrato de una contratación directa con supuesto de situación de emergencia*/
 lv_n_cant             NUMBER; 
/*Fin mmautino - SM 059-2020-SGFS */

 CURSOR cConsorcioMiembros(ruc_consorcio VARCHAR2,n_convoca NUMBER)
 is
   SELECT b.tipo,b.RUC_MIEMBRO,b.NOM_MIEMBRO
     FROM REG_PROCESOS.CONVOCATORIA_PROPUESTA a
    INNER JOIN  REG_PROCESOS.CONSORCIO_MIEMBRO b ON a.COD_CONSORCIO = b.COD_CONSORCIO
    WHERE a.RUC_POSTOR = ruc_consorcio
      AND a.N_CONVOCA = n_convoca;

      LB_RETORNO               BOOLEAN;
      lv_ruc_consorcio         VARCHAR2(50);
      lv_n_convoca             NUMBER;
      lv_id_consorcio          VARCHAR2(20);
      cant                     VARCHAR2(500);
      ln_proc_tipo             NUMBER;
      ln_valida_rucentidad     NUMBER;
      ld_f_contrato            DATE;
      ln_objeto                NUMBER;
      ln_tipo_proceso           NUMBER;  -------MANTENIMIENTO 84-2018
      ln_proveedor_extranjero_snrp VARCHAR2(500); -------MANTENIMIENTO 84-2018
      ln_normativa_aplicable  VARCHAR2(500);  -------MANTENIMIENTO 84-2018
      ln_nav_id_expede  NUMBER;   -------MANTENIMIENTO 84-2018

BEGIN

  lv_ruc_consorcio := ag_ruc_contratista;
  lv_n_convoca     := to_number(ag_n_convoca);
  lv_id_consorcio  := substr(lv_ruc_consorcio,0,1);
  ld_f_contrato    := to_date(ag_f_contrato,'dd/mm/yyyy');
  LB_RETORNO       := TRUE;

  /*PARA EL DEMO SE QUITO LA VALIDACION */
/*  RETURN TRUE;*/

  SELECT C.CODOBJETO INTO ln_objeto FROM REG_PROCESOS.CONVOCATORIAS C WHERE C.N_CONVOCA = lv_n_convoca;
  
  
  ---INICIO MANTENIMIENTO 84-2018
        SELECT C.PROC_TIPO INTO ln_tipo_proceso FROM REG_PROCESOS.CONVOCATORIAS C WHERE C.N_CONVOCA = lv_n_convoca;   
      
     ---Hallamos el expediente  si es que existe       
           if (lv_n_convoca is null)  then
          ln_nav_id_expede:=NULL;
          else 
             begin
                 ----SI tiene N_ID_EXPEDE lo recupera del SEACEv3
               SELECT  P.N_ID_EXPEDE INTO ln_nav_id_expede FROM REG_PROCESOS.PROCESOS P WHERE P.N_PROCESO in (SELECT CN.N_PROCESO  FROM REG_PROCESOS.CONVOCATORIAS CN WHERE CN.N_CONVOCA=lv_n_convoca) ;
               if (ln_nav_id_expede is null)  then    ----para los expediente que no tienen normativa
                            ln_nav_id_expede:=NULL;
               end if;
               
               exception when others then
                             ln_nav_id_expede:=NULL;
             end;
            end if; 
          
   ---Hallamos la normativa
 
          if (ln_nav_id_expede is null)  then
          ln_normativa_aplicable:='SN';
          else 
             begin
                 ----SI tiene normativa lo recupera del SEACEv3
               select distinct(tcni.C_NORAPL)  into ln_normativa_aplicable  from PRO.TBL_ACT_EXPEDIENTE@AIXSEACE tcni  where  tcni.N_ID_EXPEDE=ln_nav_id_expede;
               
               if (ln_normativa_aplicable is null) or (ln_normativa_aplicable = '') then    ----para los expediente que no tienen normativa
                            ln_normativa_aplicable:='SN';
               end if;
               
               exception when others then
                             ln_normativa_aplicable:='SN';
             end;
            end if;
            
       ---FIN MANTENIMIENTO 84-2018       

-----INICIO SM-211-2018-SGFS
/*
  SELECT count(1) INTO ln_proc_tipo
    FROM reg_procesos.convocatorias
   WHERE n_convoca = ag_n_convoca
     AND proc_tipo in (11,23,40); */  /*= pku_ss_constantes.gn_tipo_proceso_CN_CI;*/


  SELECT count(1) INTO ln_proc_tipo
    FROM reg_procesos.convocatorias
   WHERE n_convoca = ag_n_convoca
   AND (proc_tipo in (11,23,40) OR (proc_tipo in (75,76,77) AND codconsucode='002433' ) );

-----FIN SM-211-2018-SGFS

/*Inicio mmautino - SM 059-2020-SGFS - Modificación de validaciones al publicar un contrato de una contratación directa con supuesto de situación de emergencia*/
	SELECT COUNT(*) INTO lv_n_cant
        FROM PRO.TBL_ACT_EXPEDIENTE@AIXSEACE EXP , REG_PROCESOS.PROCESOS PROCESO, REG_PROCESOS.CONVOCATORIAS CONV
        WHERE EXP.N_ID_EXPEDE=PROCESO.N_ID_EXPEDE AND EXP.C_CAUSAL=17
        AND PROCESO.N_PROCESO=CONV.N_PROCESO
        AND CONV.N_CONVOCA=ag_n_convoca;
 /*Fin mmautino - SM 059-2020-SGFS */
 
  IF ln_proc_tipo = 0 THEN
       -- Consorcio
      IF lv_id_consorcio = 'C' then

        FOR xrow IN cConsorcioMiembros(lv_ruc_consorcio,lv_n_convoca) LOOP

          select count(1) into ln_valida_rucentidad
                 from reg_procesos.entidades e where e.n_ruc = xrow.RUC_MIEMBRO
                 and e.anhoentidad = to_char(ld_f_contrato,'yyyy');

          -- verificamos que el postor NO sea una entidad
          IF  ln_valida_rucentidad = 0 THEN
                 /*cambio por Memo 101-2011/SPLA-ECC Angie Molinari */
                -- cant := reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL(xrow.RUC_MIEMBRO,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));
                /* ddrodriguez - (Concurso Oferta) Verificar si Proveedor es Consultor de Obra(4) enviar 4 al RNP en ves de 3 (Ejecutor de Obra) en procesos tipo objeto Obra*/
                IF xrow.tipo = 2 THEN
                  cant := reg_procesos.f_ws_rnp_get_estado_d(xrow.ruc_miembro,4,to_char(ld_f_contrato,'yyyymmdd'));
                ELSE
                  cant := reg_procesos.f_ws_rnp_get_estado_d(xrow.ruc_miembro,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));
                END IF;
            
       ---INICIO MANTENIMIENTO 84-2018   
      ---verificamos si el proveedor  es un provedor Extranjero sin RNP registrado mediante la funcionalidad de "Administrar Proveedor Extranjero Sin RNP"  del SEACEv3    
          
             if (xrow.ruc_miembro is null) then
             ln_proveedor_extranjero_snrp:='NO_EXTRANJERO_SNRP';
             else
             begin
               select distinct(tceib.C_RUC) into ln_proveedor_extranjero_snrp from ADM.TBL_ADM_PROV_EXCEPTUADO@AIXSEACE tceib
                         where tceib.C_RUC= xrow.ruc_miembro
                           and tceib.C_VERSIONESTADO='VER_VIG'
                           and tceib.C_IDTIPOEXCEPTUADO='EXTRJ';
                if (ln_proveedor_extranjero_snrp is null) or (ln_proveedor_extranjero_snrp = '') then    ----para los expediente que no tienen normativa
                            ln_proveedor_extranjero_snrp:='NO_EXTRANJERO_SNRP';
                else
                            ln_proveedor_extranjero_snrp:='EXTRANJERO_SNRP';
                            
                end if;
               
                exception when others then
                             ln_proveedor_extranjero_snrp :='NO_EXTRANJERO_SNRP';
                             
                             
            end;
       
                if(ln_proveedor_extranjero_snrp='EXTRANJERO_SNRP' AND ln_normativa_aplicable='938'  AND ln_tipo_proceso=65) then
                cant :='1-OK';
                end if;
            end if;
   
    ---FIN MANTENIMIENTO 84-2018 
           
                                      IF (lv_n_cant = 1) THEN
                                                 /*Inicio mmautino - SM 059-2020-SGFS - Modificación de validaciones al publicar un contrato de una contratación directa con supuesto de situación de emergencia*/           
                                                   IF (substr(cant,1,1) = '0') THEN 
                                                      LB_RETORNO    := TRUE;
                                                 /*Fin mmautino - SM 059-2020-SGFS */      
                                                   ELSE   
                                                            IF cant <> '1-OK' THEN 
                                                                                 IF UPPER(cant) LIKE '%ERROR%' THEN
                                                                                  ag_estado_rnp := cant;
                                                                                  LB_RETORNO    := FALSE;
                                                                                 ELSE
                                                                                  /*Inicio ddrodriguez - req 51 - Nueva Ley (suspendido por multa)*/
                                                                                           IF substr(cant,1,1) = '3' THEN --suspendido por Multa
                                                                                                ag_estado_rnp := 'El Proveedor del Consorcio '||lv_ruc_consorcio||' se encuentra Suspendido por Multa.';
                                                                                                LB_RETORNO    := FALSE;
                                                                                           ELSE
                                                                                   /*Fin*/
                                                                                   /*Inicio mmautino - SM 059-2020-SGFS - Modificación de validaciones al publicar un contrato de una contratación directa con supuesto de situación de emergencia*/
                                                                                                ag_estado_rnp := 'El Proveedor del Consorcio '||lv_ruc_consorcio||' se encuentra sancionado o est&aacute; inhabilitado para contratar con el estado.';
                                                                                                lb_retorno    := false;
                                                                                  /*Fin mmautino - SM 059-2020-SGFS */              
                                                                                           END IF;
                                                                                END IF;
                                                            END IF;                                                                                                     
                                                END IF;
                                        ELSE                                                                                            
                                                            IF cant <> '1-OK' THEN
                                                                                 IF UPPER(cant) LIKE '%ERROR%' THEN
                                                                                  ag_estado_rnp := cant;
                                                                                  LB_RETORNO    := FALSE;
                                                                                 ELSE
                                                                                  /*Inicio ddrodriguez - req 51 - Nueva Ley (suspendido por multa)*/
                                                                                           IF substr(cant,1,1) = '3' THEN --suspendido por Multa
                                                                                                ag_estado_rnp := 'El Proveedor del Consorcio '||lv_ruc_consorcio||' se encuentra Suspendido por Multa.';
                                                                                                LB_RETORNO    := FALSE;
                                                                                            ELSE
                                                                                   /*Fin*/
                                                                                                ag_estado_rnp := 'El Proveedor del Consorcio '||lv_ruc_consorcio||' no cuenta con inscripci&oacute;n vigente en el RNP o est&aacute; inhabilitado para contratar con el estado.';
                                                                                                lb_retorno    := false;
                                                                                            END IF;
                                                                                 END IF;
                                                            END IF;                                                                                          
                                        END IF;
            
            
                      END IF;
            
                    END LOOP;

      ELSE
      -- Fin Consorcio

      SELECT count(1) INTO ln_valida_rucentidad from reg_procesos.entidades e where e.n_ruc = lv_ruc_consorcio
             and e.anhoentidad = to_char(ld_f_contrato,'yyyy');

      IF ln_valida_rucentidad = 0 THEN
      /*cambio por Memo 101-2011/SPLA-ECC Angie Molinari */
      --      cant := reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL(lv_ruc_consorcio,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));
              cant := reg_procesos.F_WS_RNP_GET_ESTADO_D(lv_ruc_consorcio,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));


       ---INICIO MANTENIMIENTO 84-2018   
      ---verificamos si el proveedor  es un provedor Extranjero sin RNP registrado mediante la funcionalidad de "Administrar Proveedor Extranjero Sin RNP"  del SEACEv3    
          
             if (lv_ruc_consorcio is null) then
             ln_proveedor_extranjero_snrp:='NO_EXTRANJERO_SNRP';
             else
             begin
               select distinct(tceic.C_RUC) into ln_proveedor_extranjero_snrp from ADM.TBL_ADM_PROV_EXCEPTUADO@AIXSEACE tceic
                         where tceic.C_RUC= lv_ruc_consorcio
                           and tceic.C_VERSIONESTADO='VER_VIG'
                           and tceic.C_IDTIPOEXCEPTUADO='EXTRJ';
                if (ln_proveedor_extranjero_snrp is null) or (ln_proveedor_extranjero_snrp = '') then    ----para los expediente que no tienen normativa
                            ln_proveedor_extranjero_snrp:='NO_EXTRANJERO_SNRP';
                else
                            ln_proveedor_extranjero_snrp:='EXTRANJERO_SNRP';
                            
                end if;
               
                exception when others then
                             ln_proveedor_extranjero_snrp :='NO_EXTRANJERO_SNRP';
                             
                             
            end;
            
                if(ln_proveedor_extranjero_snrp='EXTRANJERO_SNRP' AND ln_normativa_aplicable='938'  AND ln_tipo_proceso=65) then
                cant :='1-OK';
                end if;
            end if;
            
    ---FIN MANTENIMIENTO 84-2018  

                                       IF (lv_n_cant = 1) THEN
                                                     /*Inicio mmautino - SM 059-2020-SGFS - Modificación de validaciones al publicar un contrato de una contratación directa con supuesto de situación de emergencia*/        
                                                   IF (substr(cant,1,1) = '0') THEN 
                                                      LB_RETORNO    := TRUE;
                                                     /*Fin mmautino - SM 059-2020-SGFS */  
                                                   ELSE   
                                                            IF cant <> '1-OK' THEN 
                                                                                 IF UPPER(cant) LIKE '%ERROR%' THEN
                                                                                  ag_estado_rnp := cant;
                                                                                  LB_RETORNO    := FALSE;
                                                                                 ELSE
                                                                                  /*Inicio ddrodriguez - req 51 - Nueva Ley (suspendido por multa)*/
                                                                                           IF substr(cant,1,1) = '3' THEN --suspendido por Multa
                                                                                                ag_estado_rnp := 'El Proveedor con RUC '||lv_ruc_consorcio||' se encuentra Suspendido por Multa.';
                                                                                                LB_RETORNO    := FALSE;
                                                                                           ELSE
                                                                                   /*Fin*/
                                                                                   /*Inicio mmautino - SM 059-2020-SGFS - Modificación de validaciones al publicar un contrato de una contratación directa con supuesto de situación de emergencia*/
                                                                                                ag_estado_rnp := 'El Proveedor con RUC '||lv_ruc_consorcio||' se encuentra sancionado o est&aacute; inhabilitado para contratar con el estado.';
                                                                                                lb_retorno    := false;
                                                                                  /*Fin mmautino - SM 059-2020-SGFS*/              
                                                                                           END IF;
                                                                                END IF;
                                                            END IF;                                                                                                     
                                                END IF;
                                        ELSE                                                                                            
                                                            IF cant <> '1-OK' THEN
                                                                                 IF UPPER(cant) LIKE '%ERROR%' THEN
                                                                                  ag_estado_rnp := cant;
                                                                                  LB_RETORNO    := FALSE;
                                                                                 ELSE
                                                                                  /*Inicio ddrodriguez - req 51 - Nueva Ley (suspendido por multa)*/
                                                                                           IF substr(cant,1,1) = '3' THEN --suspendido por Multa
                                                                                                ag_estado_rnp := 'El Proveedor con RUC '||lv_ruc_consorcio||' se encuentra Suspendido por Multa.';
                                                                                                LB_RETORNO    := FALSE;
                                                                                            ELSE
                                                                                   /*Fin*/
                                                                                                ag_estado_rnp := 'El Proveedor con RUC '||lv_ruc_consorcio||' no cuenta con inscripci&oacute;n vigente en el RNP o est&aacute; inhabilitado para contratar con el estado.';
                                                                                                lb_retorno    := false;
                                                                                            END IF;
                                                                                 END IF;
                                                            END IF;                                                                                          
                                        END IF;
                 
                    
                          END IF;
                    
                       END IF;

  ELSE

    -- Consorcio
      IF lv_id_consorcio = 'C' then

        FOR xrow IN cConsorcioMiembros(lv_ruc_consorcio,lv_n_convoca) LOOP

          select count(1) into ln_valida_rucentidad
                 from reg_procesos.entidades e where e.n_ruc = xrow.RUC_MIEMBRO
                 and e.anhoentidad = to_char(ld_f_contrato,'yyyy');

          -- verificamos que el postor NO sea una entidad
          IF  ln_valida_rucentidad = 0 THEN
               /*cambio por Memo 101-2011/SPLA-ECC Angie Molinari */

            --  cant := reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL(xrow.RUC_MIEMBRO,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));
            cant :=reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL_ESP(xrow.RUC_MIEMBRO,to_char(ld_f_contrato,'yyyymmdd'));
              -- IF cant <> '1-OK' THEN
              IF substr(cant,1,1) = '2' THEN
                ag_estado_rnp := 'El Proveedor del Consorcio: '||xrow.NOM_MIEMBRO||' se encuentra inhabilitado para contratar con el estado.';
                LB_RETORNO := FALSE;
              END IF;

              IF UPPER(cant) LIKE '%ERROR%' THEN
                  ag_estado_rnp := cant;
                  LB_RETORNO    := FALSE;
              END IF;    
          END IF;

        END LOOP;

      ELSE

          SELECT count(1) INTO ln_valida_rucentidad from reg_procesos.entidades e where e.n_ruc = lv_ruc_consorcio;

          IF ln_valida_rucentidad = 0 THEN
  /*cambio por Memo 101-2011/SPLA-ECC Angie Molinari */
          --  cant := reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL(lv_ruc_consorcio,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));
      cant := reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL_ESP(lv_ruc_consorcio,to_char(ld_f_contrato,'yyyymmdd'));
            -- IF cant <> '1-OK' THEN
            
            IF substr(cant,1,1) = '2' THEN
               ag_estado_rnp := 'El Proveedor esta inhabilitado (temporal o definitivamente) en su derecho de contratar con el Estado.';
               LB_RETORNO := FALSE;

            END IF;
            
             IF UPPER(cant) LIKE '%ERROR%' THEN
                  ag_estado_rnp := cant;
                  LB_RETORNO    := FALSE;
              END IF;                

          END IF;
     END IF;

     /* SELECT count(1) INTO ln_valida_rucentidad from reg_procesos.entidades e where e.n_ruc = lv_ruc_consorcio;

      IF ln_valida_rucentidad = 0 THEN

        cant := reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL(lv_ruc_consorcio,ln_objeto,to_char(ld_f_contrato,'yyyymmdd'));

        IF cant <> '1-OK' THEN

           ag_estado_rnp := 'El Proveedor esta inhabilitado (temporal o definitivamente) en su derecho de contratar con el Estado.';
           LB_RETORNO := FALSE;

        END IF;

      END IF;*/

 END IF;

 RETURN LB_RETORNO;

END;

  
/*******************************************************************************/

 FUNCTION f_crucs_contrato (ag_n_convoca NUMBER)
      RETURN ref_cursor
   IS
      lrs_res   ref_cursor;
   BEGIN
      OPEN lrs_res
       FOR
        select n_propuesta, postor_ruc || ' - ' || postor_nom
        FROM (
          SELECT  DISTINCT convocatoria_propuesta.ruc_postor postor_ruc,
                          convocatoria_propuesta.nom_postor postor_nom,
                          convocatoria_propuesta.n_propuesta n_propuesta
                        
                     FROM reg_procesos.buena_pro,
                          reg_procesos.items_bp,
                          reg_procesos.convocatoria_propuesta
                    WHERE buena_pro.n_convoca  = ag_n_convoca
                      AND buena_pro.n_buenapro = items_bp.n_buenapro
                      AND items_bp.n_propuesta = convocatoria_propuesta.n_propuesta
                      AND buena_pro.ind_ultimo = 1
                      AND items_bp.monto_adjudicado > 0
        );

      RETURN lrs_res;
   END;


   PROCEDURE usp_eliminar_contrato (
          ag_cod_contrato          NUMBER,
          session__n_convoca       VARCHAR2
          )
   IS
   BEGIN

      DELETE FROM item_contrato WHERE n_cod_contrato = ag_cod_contrato ;
      DELETE FROM convocatoria_doc WHERE n_cod_contrato = ag_cod_contrato ;
    --Inicio de atención 502_OP_SEACE2_CON,522_OP_SEACE2_CON, 523_OP_SEACE2_CON  y 526_OP_SEACE2_CON 
    --25.02.2015 - mmautino
      DELETE FROM reG_procesos.Garantia  WHERE n_cod_contrato = ag_cod_contrato ;
    --Fin de atención
      DELETE FROM contrato_operacion_calendario WHERE id_operacion = ( select id_operacion from contrato where n_cod_contrato = ag_cod_contrato );
      DELETE FROM contrato_operacion  where id_operacion = ( select id_operacion from contrato where n_cod_contrato = ag_cod_contrato );
      DELETE FROM contrato WHERE n_cod_contrato = ag_cod_contrato ;



  COMMIT;

  usp_print('<input type=hidden name=ag_n_convoca value ='||session__n_convoca||'>');

  usp_print('<script language="javascript">
                    // thisform.scriptdo.value = "doViewConsolaContratos";
                     thisform.scriptdo.value = "doView";
                     thisform.submit();
             </script>');

    EXCEPTION
        when others then
             rollback;
             f_msg_error('Error: Al intentar hallar Eliminar el Contrato','''doEditContrato''');
             return;


   END;

  /*************************************************************************/

 PROCEDURE uspprocesarinsertcontrato_v3 (
    session__USERID                 VARCHAR2,
    session__n_convoca              VARCHAR2,
    session__anhoentidad            VARCHAR2,
    session__eue_codigo             VARCHAR2,
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
    ag_cod_tipo_contrato            VARCHAR2,
    ag_ruc_destino_pago             VARCHAR2,
    ag_anho_enti_pagadora           VARCHAR2,
    ag_cod_enti_pagadora            VARCHAR2,
    pfiletoupload1                   VARCHAR2,
    ag_trama_items                  VARCHAR2,
    ag_trama_items_xml              VARCHAR2,
    ag_trama_calendario             VARCHAR2,
    ag_fec_aprob                    VARCHAR2,
    doc_obs                         VARCHAR2,
    SizeFile                    varchar2,
    iisenv__remote_host             VARCHAR2,
    WriteFileDirectoryDynamic       VARCHAR2,
    ag_nom_destino_pago             VARCHAR2,
    pfiletoupload_file1              VARCHAR2,
    av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL
 )
 IS
    lb_validacion_rnp               BOOLEAN;
    lv_estado_rnp                   VARCHAR2(500);

    ln_ind_consorcio                NUMBER;
    lv_codtipofile                  VARCHAR2(20);
    ln_cod_contrato                 NUMBER;
    row_convocatoria_propuesta      reg_procesos.convocatoria_propuesta%rowtype;
    ld_fecha_cons                   DATE;
    lv_nom_contratista              reg_procesos.convocatoria_propuesta.nom_postor%type;
    ln_proc_tipo                    number;
    
    v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(32000);
   cantidad  number;
   contComas      number := 0;
  -- ln_montoPago   number(15,2);			----SM-189-2018-SGFS
  ln_montoPago   number(21,2);				----SM-189-2018-SGFS    
 BEGIN

    select proc_Tipo  into  ln_proc_tipo from convocatorias where n_convoca = session__n_convoca;

    reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' var _error = 0; ');
    
    
    usp_print('<input type=hidden value ='||av_id_expede||' name=av_id_expede id=av_id_expede>');
     usp_print('<input type=hidden value ='||av_id_proc||' name=av_id_proc id=av_id_proc>');
      usp_print('<input type=hidden value ='||av_id_con_pub||' name=av_id_con_pub id=av_id_con_pub>');

    -- Validamos la Fecha de consentimiento a nivel de Item --

    IF NOT f_valida_fconsentimiento(ag_trama_items,session__n_convoca,ag_f_contrato) THEN
         f_msg_pantalla('La Fecha del Contrato no puede ser anterior a la Fecha de Consentimiento','''doNewContrato''');
         reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' _error = 1; ');
         return;
    END IF;

    -- Correo q indica que no deberian validarse el RNp a los CE
    ------------------------- VALIDA RNP DE CONTRATISTA Y CONSORCIOS -------------------------
    if ( substr(ag_ruc_contratista,1,1) not in ('7','I','L')  /*or ln_proc_tipo <> 23*/ )then

        lb_validacion_rnp :=F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, session__n_convoca,ag_f_contrato, lv_estado_rnp);


        IF NOT lb_validacion_rnp THEN
           f_msg_pantalla(lv_estado_rnp,'''doNewContrato''');
           reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' _error = 1; ');
           return;
        END IF;

    END IF;

    BEGIN
        SELECT nom_postor INTO lv_nom_contratista FROM reg_procesos.convocatoria_propuesta pro WHERE pro.ruc_postor = ag_ruc_contratista and pro.n_convoca = session__n_convoca;
    EXCEPTION
        when others then
             f_msg_error('Error: Al intentar hallar el nombre del Contratista','''doNewContrato''');
             return;
    END;


    -- Indicador de consorcio --
    BEGIN
        select ind_consorcio into ln_ind_consorcio from reg_procesos.convocatoria_propuesta where ruc_postor = ag_ruc_contratista and n_convoca = session__n_convoca;
    EXCEPTION
        when others then
             f_msg_error('Error al intentar hallar el indicador de Consorcio','''doNewContrato''');
             return;
    END;


   ------------------------- Obtiene el tipo de archivo -------------------------------------

   BEGIN
        --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
        select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
   EXCEPTION
        when others then
             f_msg_error('Error: Al intentar hallar el tipo de documento','''doNewContrato''');
             return;
   END;

   ------------------------- Fin de Obtiene el tipo de archivo ------------------------------

   select * into row_convocatoria_propuesta from reg_procesos.convocatoria_propuesta where n_convoca  = session__n_convoca and ruc_postor = ag_ruc_contratista;


   -- Cargamos la trama de Items
 --  usp_print( ag_trama_items);

   -- Verificamos que se hayan seleccionado al menos un item tambien se valida la fecha de BP por item
  v_xml              := ag_trama_items;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);

   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);
   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');
      
   cantidad:= xmldom.getLength(v_nl);
   
 if cantidad = 0 then
  usp_print('
  
  
      <script language=javascript>
                   
                  alert("Por favor ingrese Items");
                  goSubmit("doNewContrato",'''')
          
          
      </script>');
      end if;
      
      usp_print(' <script language=javascript>
       try{
          validaFechaContratoBp("xmlItems","'||ag_f_contrato||'")
              }catch(err){}
</script>
');

 
contComas := instr(ag_m_contratado, ',');
--   ln_montoPago := xslprocessor.valueOf(v_n,'monto');
--   ln_montoPago :=  to_number(xslprocessor.valueOf(v_n,'monto'),'999999999990.00');
   if contComas > 0 then
      ln_montoPago    :=  to_number(ag_m_contratado); 
    else
 -----     ln_montoPago    :=  to_number(ag_m_contratado,'999999999990.00');       -----SM-189-2018-SGFS
		   ln_montoPago    :=  to_number(ag_m_contratado,'999999999999999999990.00'); -----SM-189-2018-SGFS
    end if;

--------inicio SM-189-2018-SGFS
 ---IF TO_NUMBER(ag_m_contratado, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' ) > 0 THEN BEGIN
 IF TO_NUMBER(ag_m_contratado, '999999999999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' ) > 0 THEN BEGIN
 ----fin SM-189-2018-SGFS

     if av_id_proc is not null then
      
      SELECT reg_procesos.s_contrato.NEXTVAL INTO ln_cod_contrato FROM DUAL;

      INSERT INTO reg_procesos.contrato
                  (n_cod_contrato,
                   n_convoca,
                   des_contrato,
                   ciu_ccodigo,
                   ciu_cespecial,
                   f_contrato,
                   codmoneda_contrato,
                   m_contratado,
                   cod_situacion,
                   cod_sist_adquisicion,
                   cod_modalidad_finan,
                   cod_modalidad_alcance,
                   mon_codigo,
                   costo_final,
                   observaciones,
                   n_contrato,
                   f_vigencia_ini,
                   f_vigencia_fin,
                   n_propuesta,
                   ind_consorcio,
                   cod_tipo_contrato,
                   codconsucode,
                   anhoentidad,
                   codconsucode_paga,
                   anhoentidad_paga,
                   cod_tipo_postor,
                   usu_Creacion,
                   ip_creacion,
                   IND_CONTRATO_PUB,
                   IND_VERSION,
                   ruc_contratista,
                   nom_contratista,
                   ruc_destino_pago,
                   nom_destino_pago,
                   N_INDSEACEV3
                  )
           VALUES (ln_cod_contrato,
                   session__n_convoca,
                   ag_des_contrato,
                   ag_ciu_ccodigo,
                   ag_ciu_cespecial,
                   TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   ag_codmoneda_contrato,
                  -- DECODE (ag_m_contratado,' ',NULL,TO_NUMBER (replace(ag_m_contratado,',','.'),'999999999999999.99')),
                   --DECODE (ag_m_contratado,' ',NULL,TO_NUMBER(ag_m_contratado, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' )),
                   --  decode(ag_m_contratado, ' ', null, to_number(replace(ag_m_contratado, '.', ','))),
                   --  decode(ag_m_contratado, ' ', null, to_number(ag_m_contratado)),
                   ln_montoPago,
                   1,
                   ag_cod_sist_adquisicion,
                   ag_cod_modalidad_finan,
                   ag_cod_modalidad_alcance,
                   ag_codmoneda_contrato,
                   --DECODE (ag_costo_final,' ', NULL,TO_NUMBER (replace(ag_costo_final,',','.'),'999999999999999.99')),
                   --DECODE (ag_costo_final,' ',NULL,TO_NUMBER(ag_costo_final, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' )),
                    -- decode(ag_costo_final, ' ', null, to_number(replace(ag_costo_final, '.', ','))),
                   --  decode(ag_costo_final, ' ', null, to_number(ag_costo_final)),
                ----to_number(ag_costo_final,'999999999990.00'),      ----SM-189-2018-SGFS
				   to_number(ag_costo_final,'999999999999999999990.00'),  ----SM-189-2018-SGFS
                   ag_observaciones,
                   ag_n_contrato,
                   TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   ag_n_propuesta,
                   ln_ind_consorcio,
                   ag_cod_tipo_contrato,
                   LPAD (session__eue_codigo, 6, '0'),
                   session__anhoentidad,
                   ag_cod_enti_pagadora,
                   ag_anho_enti_pagadora,
                   row_convocatoria_propuesta.cod_tipo_postor,
                   session__USERID,
                   iisenv__remote_host,
                   0,
                   1,
                    /*ag_ruc_contratista*/ag_ruc_destino_pago,
                   lv_nom_contratista,
                   ag_ruc_destino_pago,
                   ag_nom_destino_pago,
                   to_number(av_id_proc)
                  );
          else
           f_msg_error('Error: Al intentar registrar el Procedimiento del Contrato','''doNewContrato''');
           return;
          end if;

   EXCEPTION
      WHEN OTHERS THEN
         f_msg_error('Error: Al intentar registrar el Contrato','''doNewContrato''');
         return;
   END;

   BEGIN


        PKU_GESTOR_CONT_UTILES_2.p_insUploadContrato(
              session__N_CONVOCA,
              TO_DATE (ag_fec_aprob,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
              doc_obs,
              lv_codtipofile,
             pfiletoupload_file1,
              SizeFile,
              session__userid,
              iisenv__remote_host,
              WriteFileDirectoryDynamic                       ,
              ln_cod_contrato);    
      

      
   EXCEPTION
      WHEN OTHERS THEN
           f_msg_error('Error: Al intentar registrar el Documento del Contrato...','''doNewContrato''');
           return;

   END;


   BEGIN
      -- registro de items
      usp_registra_items_v3(ag_trama_items,ln_cod_contrato,session__N_CONVOCA);
      
   EXCEPTION
      WHEN OTHERS THEN
           f_msg_error('Error: Al intentar registrar los Items del Contrato....','''doNewContrato''');
           return;
   END;


   BEGIN
       --------- Actualiza Calendario --------
       if ag_trama_calendario is not null then    
          usp_registra_calendario(ag_trama_calendario,PK_CONVOCATORIA.gn_id_operacion);
       end if;

   EXCEPTION
      WHEN OTHERS THEN
          f_msg_error('Error: Al intentar registrar el Calendario de Pagos','''doNewContrato''');
          return;
   END;


  BEGIN
     UPDATE reg_procesos.contrato  SET id_operacion = reg_procesos.pk_convocatoria.getidoperacion() WHERE n_cod_contrato = ln_cod_contrato;
     UPDATE CONTRATO_OPERACION SET CONTRATO_OPERACION.Usuario_Transfer = session__USERID WHERE CONTRATO_OPERACION.id_operacion = reg_procesos.pk_convocatoria.getidoperacion() ;
  EXCEPTION
      WHEN OTHERS THEN
         f_msg_error('Error: Al intentar registrar el Contrato','''doNewContrato''');
         return;
  END;

   usp_print('<input type=hidden value ='||ln_cod_contrato||' name=ag_cod_contrato id=ag_cod_contrato>');
   usp_print('<script language="javascript">');


   IF PKU_GESTOR_CONT_UTILES_2.f_get_tipo_validos_v3(session__N_CONVOCA) > 0 AND PKU_SS_GARANTIAS.f_valida_inicio_v3(session__N_CONVOCA) > 0  THEN
     usp_print('
      alert("Antes de publicar el contrato debe seleccionar \nel submenu Garantias para declarar la \naplicacion o no del requisito Garantias");
      ');
   END IF;

   usp_print('thisform.scriptdo.value = ''doEditContrato'';
                   if ( _error !=1 )
                         thisform.submit();

             </script>');

 ELSE
        usp_print('<input type=hidden value ='||av_id_expede||' name=av_id_expede id=av_id_expede>');
     usp_print('<input type=hidden value ='||av_id_proc||' name=av_id_proc id=av_id_proc>');
      usp_print('<input type=hidden value ='||av_id_con_pub||' name=av_id_con_pub id=av_id_con_pub>');
         usp_print('<input type=hidden value ='||ln_cod_contrato||' name=ag_cod_contrato id=ag_cod_contrato>');
         
         usp_print('<script language="javascript">
                            alert("El monto del contrato no puede ser 0");
                            goSubmit("doNewContrato",document.all(''scriptdo''))
                   </script>');

 END IF;

END;

/*************************************************************************/
function f_msg_pantalla2(v_msg_error varchar2, v_evento varchar2) RETURN varchar2
 IS
 resp_pantalla varchar2(32000);
 BEGIN
    ROLLBACK;
    resp_pantalla := '<center><font color=red><b>'||V_MSG_ERROR||'</b></font></center>';
    resp_pantalla := resp_pantalla || '<center><br><input type="button" value="Volver" onclick="thisform.scriptdo.value='||v_evento||';thisform.submit()" ></center>';
    resp_pantalla := resp_pantalla || '<script>  _error  = 1;</script>';
    RETURN resp_pantalla;
 END;

function f_msg_error2(v_msg_error varchar2, v_evento varchar2) RETURN varchar2
 IS
 resp_error varchar2(32000);
 BEGIN
    ROLLBACK;
    resp_error := '<center><font color=red><b>'||V_MSG_ERROR||'. '||SQLERRM||'</b></font></center>';
    resp_error := resp_error || '<center><br><input type="button" value="Volver" onclick="thisform.scriptdo.value='||V_EVENTO||';thisform.submit()" ></center>';
    resp_error := resp_error || '<script>  _error  = 1;</script>';
    RETURN resp_error;  
 END;
 PROCEDURE uspprocesarinsertcontrato2_v3 (
    session__USERID                 VARCHAR2,
    session__n_convoca              VARCHAR2,
    session__anhoentidad            VARCHAR2,
    session__eue_codigo             VARCHAR2,
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
    ag_cod_tipo_contrato            VARCHAR2,
    ag_ruc_destino_pago             VARCHAR2,
    ag_anho_enti_pagadora           VARCHAR2,
    ag_cod_enti_pagadora            VARCHAR2,
    pfiletoupload1                   VARCHAR2,
    ag_trama_items                  VARCHAR2,
    ag_trama_items_xml              VARCHAR2,
    ag_trama_calendario             VARCHAR2,
    ag_fec_aprob                    VARCHAR2,
    doc_obs                         VARCHAR2,
    SizeFile                    varchar2,
    iisenv__remote_host             VARCHAR2,
    WriteFileDirectoryDynamic       VARCHAR2,
    ag_nom_destino_pago             VARCHAR2,
    pfiletoupload_file1              VARCHAR2,
    av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    AV_ID_CON_PUB             VARCHAR2  DEFAULT NULL,
    resp_html                 OUT VARCHAR2
 )
 IS
    lb_validacion_rnp               BOOLEAN;
    lv_estado_rnp                   VARCHAR2(500);

    ln_ind_consorcio                NUMBER;
    lv_codtipofile                  VARCHAR2(20);
    ln_cod_contrato                 NUMBER;
    row_convocatoria_propuesta      reg_procesos.convocatoria_propuesta%rowtype;
    ld_fecha_cons                   DATE;
    lv_nom_contratista              reg_procesos.convocatoria_propuesta.nom_postor%type;
    ln_proc_tipo                    number;
    
    v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(32000);
   cantidad  number;
   contComas      number := 0;
  --- ln_montoPago   number(15,2);   ---SM-189-2018-SGFS
  ln_montoPago   number(21,2);		 ---SM-189-2018-SGFS
 BEGIN

    select proc_Tipo  into  ln_proc_tipo from convocatorias where n_convoca = session__n_convoca;

    --reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' var _error = 0; ');
    
    RESP_HTML := '';
    RESP_HTML := RESP_HTML || '<SCRIPT LANGUAGE=JAVASCRIPT> var _error = 0; </SCRIPT>';
    RESP_HTML := RESP_HTML || '<input type=hidden value ='||TO_CHAR(AV_ID_EXPEDE)||' name=av_id_expede id=av_id_expede>';
    RESP_HTML := RESP_HTML || '<input type=hidden value ='||TO_CHAR(AV_ID_PROC)||' name=av_id_proc id=av_id_proc>';
    resp_html := resp_html || '<input type=hidden value ='||to_char(av_id_con_pub)||' name=av_id_con_pub id=av_id_con_pub>';

    -- Validamos la Fecha de consentimiento a nivel de Item --

    IF NOT F_VALIDA_FCONSENTIMIENTO(AG_TRAMA_ITEMS,SESSION__N_CONVOCA,AG_F_CONTRATO) THEN
         resp_html := resp_html || F_MSG_PANTALLA2('La Fecha del Contrato no puede ser anterior a la Fecha de Consentimiento','''doNewContrato''');
         --REG_PROCESOS.PKU_GESTOR_CONT_FUNCIONES_JS_2.JS_SCRIPT(' _error = 1; ');
         resp_html := resp_html || '<SCRIPT LANGUAGE=JAVASCRIPT> var _error = 1; </SCRIPT>';
         return;
    END IF;

    -- Correo q indica que no deberian validarse el RNp a los CE
    ------------------------- VALIDA RNP DE CONTRATISTA Y CONSORCIOS -------------------------
    if ( substr(ag_ruc_contratista,1,1) not in ('7','I','L')  /*or ln_proc_tipo <> 23*/ )then

        lb_validacion_rnp :=F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, session__n_convoca,ag_f_contrato, lv_estado_rnp);


        IF NOT LB_VALIDACION_RNP THEN
           RESP_HTML := RESP_HTML || F_MSG_PANTALLA2(LV_ESTADO_RNP,'''doNewContrato''');
           --REG_PROCESOS.PKU_GESTOR_CONT_FUNCIONES_JS_2.JS_SCRIPT(' _error = 1; ');
           resp_html := resp_html || '<SCRIPT LANGUAGE=JAVASCRIPT> var _error = 1; </SCRIPT>';
           return;
        END IF;

    END IF;

    BEGIN
        SELECT nom_postor INTO lv_nom_contratista FROM reg_procesos.convocatoria_propuesta pro WHERE pro.ruc_postor = ag_ruc_contratista and pro.n_convoca = session__n_convoca;
    EXCEPTION
        WHEN OTHERS THEN
             RESP_HTML := RESP_HTML || f_msg_error2('Error: Al intentar hallar el nombre del Contratista','''doNewContrato''');
             return;
    END;


    -- Indicador de consorcio --
    BEGIN
        select ind_consorcio into ln_ind_consorcio from reg_procesos.convocatoria_propuesta where ruc_postor = ag_ruc_contratista and n_convoca = session__n_convoca;
    EXCEPTION
        WHEN OTHERS THEN
             RESP_HTML := RESP_HTML || f_msg_error2('Error al intentar hallar el indicador de Consorcio','''doNewContrato''');
             return;
    END;


   ------------------------- Obtiene el tipo de archivo -------------------------------------

   BEGIN
        --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
        select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
   EXCEPTION
        when others then
             RESP_HTML := RESP_HTML || f_msg_error2('Error: Al intentar hallar el tipo de documento','''doNewContrato''');
             return;
   END;

   ------------------------- Fin de Obtiene el tipo de archivo ------------------------------

   select * into row_convocatoria_propuesta from reg_procesos.convocatoria_propuesta where n_convoca  = session__n_convoca and ruc_postor = ag_ruc_contratista;


   -- Cargamos la trama de Items
 --  usp_print( ag_trama_items);

   -- Verificamos que se hayan seleccionado al menos un item tambien se valida la fecha de BP por item
  v_xml              := ag_trama_items;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);

   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);
   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');
      
   cantidad:= xmldom.getLength(v_nl);
   
 if cantidad = 0 then
  RESP_HTML := RESP_HTML || '
  
  
      <script language=javascript>
                   
                  alert("Por favor ingrese Items");
                  goSubmit("doNewContrato",'''')
          
          
      </script>';
      end if;
      
      RESP_HTML := RESP_HTML || ' <script language=javascript>
       try{
          validaFechaContratoBp("xmlItems","'||ag_f_contrato||'")
              }catch(err){}
</script>
';
 
contComas := instr(ag_m_contratado, ',');
--   ln_montoPago := xslprocessor.valueOf(v_n,'monto');
--   ln_montoPago :=  to_number(xslprocessor.valueOf(v_n,'monto'),'999999999990.00');
   if contComas > 0 then
      ln_montoPago    :=  to_number(ag_m_contratado); 
    else
----inicio SM-189-2018-SGFS
     --- ln_montoPago    :=  to_number(ag_m_contratado,'999999999990.00');
 		ln_montoPago    :=  to_number(ag_m_contratado,'999999999999999999990.00');
----fin SM-189-2018-SGFS 
end if;

----inicio SM-189-2018-SGFS
 --- IF TO_NUMBER(ag_m_contratado, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' ) > 0 THEN BEGIN
 	IF TO_NUMBER(ag_m_contratado, '999999999999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' ) > 0 THEN BEGIN
----fin SM-189-2018-SGFS
      if av_id_proc is not null then
      
      SELECT reg_procesos.s_contrato.NEXTVAL INTO ln_cod_contrato FROM DUAL;

      INSERT INTO reg_procesos.contrato
                  (n_cod_contrato,
                   n_convoca,
                   des_contrato,
                   ciu_ccodigo,
                   ciu_cespecial,
                   f_contrato,
                   codmoneda_contrato,
                   m_contratado,
                   cod_situacion,
                   cod_sist_adquisicion,
                   cod_modalidad_finan,
                   cod_modalidad_alcance,
                   mon_codigo,
                   costo_final,
                   observaciones,
                   n_contrato,
                   f_vigencia_ini,
                   f_vigencia_fin,
                   n_propuesta,
                   ind_consorcio,
                   cod_tipo_contrato,
                   codconsucode,
                   anhoentidad,
                   codconsucode_paga,
                   anhoentidad_paga,
                   cod_tipo_postor,
                   usu_Creacion,
                   ip_creacion,
                   IND_CONTRATO_PUB,
                   IND_VERSION,
                   ruc_contratista,
                   nom_contratista,
                   ruc_destino_pago,
                   nom_destino_pago,
                   N_INDSEACEV3
                  )
           VALUES (ln_cod_contrato,
                   session__n_convoca,
                   ag_des_contrato,
                   ag_ciu_ccodigo,
                   ag_ciu_cespecial,
                   TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   ag_codmoneda_contrato,
                  -- DECODE (ag_m_contratado,' ',NULL,TO_NUMBER (replace(ag_m_contratado,',','.'),'999999999999999.99')),
                   --DECODE (ag_m_contratado,' ',NULL,TO_NUMBER(ag_m_contratado, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' )),
                   --  decode(ag_m_contratado, ' ', null, to_number(replace(ag_m_contratado, '.', ','))),
                   --  decode(ag_m_contratado, ' ', null, to_number(ag_m_contratado)),
                   ln_montoPago,
                   1,
                   ag_cod_sist_adquisicion,
                   ag_cod_modalidad_finan,
                   ag_cod_modalidad_alcance,
                   ag_codmoneda_contrato,
                   --DECODE (ag_costo_final,' ', NULL,TO_NUMBER (replace(ag_costo_final,',','.'),'999999999999999.99')),
                   --DECODE (ag_costo_final,' ',NULL,TO_NUMBER(ag_costo_final, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' )),
                    -- decode(ag_costo_final, ' ', null, to_number(replace(ag_costo_final, '.', ','))),
                   --  decode(ag_costo_final, ' ', null, to_number(ag_costo_final)),
             ---      to_number(ag_costo_final,'999999999990.00'),    -----SM-189-2018-SGFS
					  to_number(ag_costo_final,'999999999999999999990.00'), -----SM-189-2018-SGFS
                   ag_observaciones,
                   ag_n_contrato,
                   TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   ag_n_propuesta,
                   ln_ind_consorcio,
                   ag_cod_tipo_contrato,
                   LPAD (session__eue_codigo, 6, '0'),
                   session__anhoentidad,
                   ag_cod_enti_pagadora,
                   ag_anho_enti_pagadora,
                   row_convocatoria_propuesta.cod_tipo_postor,
                   session__USERID,
                   iisenv__remote_host,
                   0,
                   1,
                  /*ag_ruc_contratista*/ag_ruc_destino_pago,
                   lv_nom_contratista,
                   ag_ruc_destino_pago,
                   ag_nom_destino_pago,
                   to_number(av_id_proc)
                  );
          else
           RESP_HTML := RESP_HTML || f_msg_error2('Error: Al intentar registrar el Procedimiento del Contrato','''doNewContrato''');
           return;
          end if;

   EXCEPTION
      WHEN OTHERS THEN
         RESP_HTML := RESP_HTML || f_msg_error2('Error: Al intentar registrar el Contrato','''doNewContrato''');
         return;
   END;

   BEGIN


        PKU_GESTOR_CONT_UTILES_2.p_insUploadContrato(
              session__N_CONVOCA,
              TO_DATE (ag_fec_aprob,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
              doc_obs,
              lv_codtipofile,
             pfiletoupload_file1,
              SizeFile,
              session__userid,
              iisenv__remote_host,
              WriteFileDirectoryDynamic                       ,
              ln_cod_contrato);    
      

      
   EXCEPTION
      WHEN OTHERS THEN
           RESP_HTML := RESP_HTML || f_msg_error2('Error: Al intentar registrar el Documento del Contrato...','''doNewContrato''');
           return;

   END;


   BEGIN
      -- registro de items
      usp_registra_items_v3(ag_trama_items,ln_cod_contrato,session__N_CONVOCA);
      
   EXCEPTION
      WHEN OTHERS THEN
           RESP_HTML := RESP_HTML || f_msg_error2('Error: Al intentar registrar los Items del Contrato....','''doNewContrato''');
           return;
   END;


   BEGIN
       --------- Actualiza Calendario --------
       if ag_trama_calendario is not null then    
          usp_registra_calendario(ag_trama_calendario,PK_CONVOCATORIA.gn_id_operacion);
       end if;

   EXCEPTION
      WHEN OTHERS THEN
          RESP_HTML := RESP_HTML || f_msg_error2('Error: Al intentar registrar el Calendario de Pagos','''doNewContrato''');
          return;
   END;


  BEGIN
     UPDATE reg_procesos.contrato  SET id_operacion = reg_procesos.pk_convocatoria.getidoperacion() WHERE n_cod_contrato = ln_cod_contrato;
     UPDATE CONTRATO_OPERACION SET CONTRATO_OPERACION.Usuario_Transfer = session__USERID WHERE CONTRATO_OPERACION.id_operacion = reg_procesos.pk_convocatoria.getidoperacion() ;
  EXCEPTION
      WHEN OTHERS THEN
         RESP_HTML := RESP_HTML || f_msg_error2('Error: Al intentar registrar el Contrato','''doNewContrato''');
         return;
  END;

   RESP_HTML := RESP_HTML || '<input type=hidden value ='||to_char(LN_COD_CONTRATO)||' name=ag_cod_contrato id=ag_cod_contrato>';
   RESP_HTML := RESP_HTML || '<script language="javascript">';


   IF PKU_GESTOR_CONT_UTILES_2.f_get_tipo_validos_v3(session__N_CONVOCA) > 0 AND PKU_SS_GARANTIAS.f_valida_inicio_v3(session__N_CONVOCA) > 0  THEN
     RESP_HTML := RESP_HTML || '
      alert("Antes de publicar el contrato debe seleccionar \nel submenu Garantias para declarar la \naplicacion o no del requisito Garantias");
      ';
   END IF;

   RESP_HTML := RESP_HTML || 'thisform.scriptdo.value = ''doEditContrato'';
                   if ( _error !=1 )
                         thisform.submit();

             </script>';

 ELSE
        RESP_HTML := RESP_HTML || '<input type=hidden value ='||TO_CHAR(AV_ID_EXPEDE)||' name=av_id_expede id=av_id_expede>';
     RESP_HTML := RESP_HTML || '<input type=hidden value ='||TO_CHAR(AV_ID_PROC)||' name=av_id_proc id=av_id_proc>';
      RESP_HTML := RESP_HTML || '<input type=hidden value ='||TO_CHAR(AV_ID_CON_PUB)||' name=av_id_con_pub id=av_id_con_pub>';
         RESP_HTML := RESP_HTML || '<input type=hidden value ='||to_char(ln_cod_contrato)||' name=ag_cod_contrato id=ag_cod_contrato>';
         
         RESP_HTML := RESP_HTML || '<script language="javascript">
                            alert("El monto del contrato no puede ser 0");
                            goSubmit("doNewContrato",document.all(''scriptdo''))
                   </script>';

 END IF;

END;
PROCEDURE uspprocesarupdatecontrato2_v3(
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
      ag_observaciones                VARCHAR2,
      ag_n_contrato                   VARCHAR2,
      ag_f_vigencia_ini               VARCHAR2,
      ag_f_vigencia_fin               VARCHAR2,
      ag_n_propuesta                  VARCHAR2,
      ag_nom_contratista              VARCHAR2,
      ag_ruc_destino_pago             VARCHAR2,
      ag_cod_tipo_contrato            VARCHAR2,
      ag_id_operacion                 VARCHAR2,
      pfiletoupload1                   VARCHAR2,
      ag_fec_aprob                    VARCHAR2,
      doc_obs                         VARCHAR2,
      SizeFile                         VARCHAR2,
      iisenv__remote_host             VARCHAR2,
      WriteFileDirectoryDynamic       VARCHAR2,
      ag_trama_items              VARCHAR2,
      ag_trama_calendario             VARCHAR2,
      ag_nom_destino_pago             VARCHAR2,
      pfiletoupload_file1              VARCHAR2,
       av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    AV_ID_CON_PUB             VARCHAR2  DEFAULT NULL,
    resp_html                 OUT VARCHAR2
   )
   IS

    lb_validacion_rnp               BOOLEAN;
    lv_estado_rnp                   VARCHAR2(500);
   -- Upload
   lvtipodocumento                    VARCHAR2(50);
   lv_codtipofile                     VARCHAR2(20);
   ln_indsiaf                         NUMBER;
   row_convocatoria_propuesta         reg_procesos.convocatoria_propuesta%rowtype;
   ld_fecha_cons                   DATE;
   ln_proc_tipo                    number;

   BEGIN

    select proc_Tipo  into  ln_proc_tipo from convocatorias where n_convoca = session__n_convoca;

    --REG_PROCESOS.PKU_GESTOR_CONT_FUNCIONES_JS_2.JS_SCRIPT(' var _error = 0; ');
    RESP_HTML := '';
    RESP_HTML := RESP_HTML || '<SCRIPT LANGUAGE=JAVASCRIPT> var _error = 0; </SCRIPT>';
   -- Validamos la Fecha de consentimiento a nivel de Item --

    IF NOT F_VALIDA_FCONSENTIMIENTO(AG_TRAMA_ITEMS,SESSION__N_CONVOCA,AG_F_CONTRATO) THEN
             RESP_HTML := RESP_HTML || F_MSG_PANTALLA2('La Fecha del Contrato no puede ser anterior a la Fecha de Consentimiento','''doNewContrato''');
             --REG_PROCESOS.PKU_GESTOR_CONT_FUNCIONES_JS_2.JS_SCRIPT(' _error = 1; ');
             RESP_HTML := RESP_HTML || '<SCRIPT LANGUAGE=JAVASCRIPT> var _error = 1; </SCRIPT>';
             return; 
    END IF;


        -- Correo q indica que no deberian validarse el RNp a los CE
    if  ( substr(ag_ruc_contratista,1,1) not in ('7','I','L')  /*or ln_proc_tipo <> 23 */)then

        lb_validacion_rnp :=F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, session__n_convoca,ag_f_contrato, lv_estado_rnp);


        IF NOT LB_VALIDACION_RNP THEN
           RESP_HTML := RESP_HTML || F_MSG_PANTALLA2(LV_ESTADO_RNP,'''doNewContrato''');
           --reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' _error = 1; ');
           RESP_HTML := RESP_HTML || '<SCRIPT LANGUAGE=JAVASCRIPT> var _error = 1; </SCRIPT>';
           return;
        END IF;

    end if;





    RESP_HTML := RESP_HTML || '
    <CENTER>
        <TABLE border="0">
            <TR>
                <TD COLSPAN="3" class=c1>
                    <div id="divEsperar" style="border:0px solid #008000"><img src="img/circle_working.gif"></div>
                </TD>
            </TR>
        </TABLE>
    </CENTER> ';

    select *  into row_convocatoria_propuesta from reg_procesos.convocatoria_propuesta where ruc_postor = ag_ruc_contratista and n_convoca = session__n_convoca;


    BEGIN
    IF AV_ID_PROC IS NOT NULL THEN
     RESP_HTML := RESP_HTML || '<input type="hidden" name="av_id_expede"           value="'||TO_CHAR(AV_ID_EXPEDE)||'" id=av_id_expede/>';
 RESP_HTML := RESP_HTML || '<input type="hidden" name="av_id_proc"           value="'||TO_CHAR(AV_ID_PROC)||'" id=av_id_proc/>';
 RESP_HTML := RESP_HTML || '<input type="hidden" name="av_id_con_pub"           value="'||to_char(av_id_con_pub)||'" id=av_id_con_pub/>';

          UPDATE reg_procesos.contrato
             SET des_contrato            = TRIM (ag_des_contrato),
                 --ciu_ccodigo             = TRIM (ag_ciu_ccodigo),
                 ciu_cespecial           = ag_ciu_cespecial,
                 ruc_contratista         = ag_ruc_contratista,
                 f_contrato              = TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 codmoneda_contrato      = ag_codmoneda_contrato,
                 --m_contratado            =  DECODE (ag_m_contratado,' ',NULL,TO_NUMBER(ag_m_contratado, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' )),
                    m_contratado= decode(ag_m_contratado, ' ', null, to_number(replace(ag_m_contratado, '.', ','))),
                 --DECODE (ag_m_contratado,' ', NULL,TO_NUMBER (replace(ag_m_contratado,',','.'),'999999999999999.99')),
                 cod_sist_adquisicion    = ag_cod_sist_adquisicion,
                 cod_modalidad_finan     = ag_cod_modalidad_finan,
                 cod_modalidad_alcance   = ag_cod_modalidad_alcance,
                 mon_codigo              = ag_codmoneda_contrato,
              --   costo_final             = DECODE (ag_costo_final,' ', NULL,TO_NUMBER (ag_costo_final, '999999999999999.99')),
                 observaciones           = ag_observaciones,
                 n_contrato              = ag_n_contrato,
                 f_vigencia_ini          = TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 f_vigencia_fin          = TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 n_propuesta             = ag_n_propuesta,
                 nom_contratista         = NVL(reg_procesos.F_WS_RNP_GET_RAZON_SOCIAL(ruc_contratista),ag_nom_destino_pago),
                 ind_consorcio           = row_convocatoria_propuesta.ind_consorcio,
                 cod_tipo_contrato       = ag_cod_tipo_contrato,
                 ruc_destino_pago        = ag_ruc_destino_pago,
                 nom_destino_pago        = NVL(reg_procesos.F_WS_GET_RAZSOC_ALL(ag_ruc_destino_pago),ag_nom_destino_pago),
                 cod_tipo_postor         = row_convocatoria_propuesta.cod_tipo_postor,
                 n_indseacev3            = case when av_id_proc is null then n_indseacev3 else to_number(av_id_proc) end

             WHERE n_cod_contrato        = session__cod_contrato;
        ELSE
        RESP_HTML := RESP_HTML || f_msg_error2('Error al intentar Actualizar el Contrato','''doEditContrato''');
        return;
        end if;

         EXCEPTION
            WHEN OTHERS THEN
               RESP_HTML := RESP_HTML || f_msg_error2('Error al intentar Actualizar el Contrato','''doEditContrato''');
               RETURN;
    END;

    BEGIN

    IF pfiletoupload_file1 IS NOT NULL THEN

        lvtipodocumento:=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
        select cod_tipo_file into lv_codtipofile from Reg_procesos.tipo_archivo where ext_tipo_file=lvtipodocumento;

    END IF;

    EXCEPTION
            WHEN OTHERS THEN
               RESP_HTML := RESP_HTML || f_msg_error2('Error al intentar hallar el tipo de Archivo','''doEditContrato''');
               RETURN;
    END;


    BEGIN

    IF pfiletoupload_file1 IS NOT NULL THEN
         PKU_GESTOR_CONT_UTILES_2.p_insUploadContrato(
                    reg_procesos.f_get_min_n_convoca(session__n_convoca),
                    TO_DATE (ag_fec_aprob,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                    doc_obs,
                    lv_codtipofile,
                    pfiletoupload_file1,
                    SizeFile,
                    session__userid,
                    iisenv__remote_host,
                    WriteFileDirectoryDynamic,
                    session__cod_contrato);
    END IF;

       EXCEPTION
          WHEN OTHERS THEN
             RESP_HTML := RESP_HTML || f_msg_error2('Error al intentar Actualizar el Resumen del Contrato','''doEditContrato''');

    END;


    -- borramos los items anteriores

    DELETE  reg_procesos.item_contrato s  WHERE s.n_cod_contrato = session__cod_contrato;

    -- Insertamos los items del calendario y items del contrato

    usp_registra_items_v3(ag_trama_items,session__cod_contrato,session__n_convoca);
    ln_indsiaf := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__n_convoca);

    -----------------Inserta Calendario---------------------
    IF ln_indsiaf = 1 THEN
         usp_registra_calendario(ag_trama_calendario,ag_id_operacion);
    END IF;

   -- Memo 245 2010 - Garantias
   IF PKU_GESTOR_CONT_UTILES_2.F_GET_TIPO_VALIDOS_V3(SESSION__N_CONVOCA) > 0 AND PKU_SS_GARANTIAS.F_VALIDA_INICIO_V3(SESSION__N_CONVOCA) > 0  THEN
     /*reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script('
      alert("Antes de publicar el contrato debe seleccionar \nel submenu Garantias para declarar la \naplicacion o no del requisito de Garantias");
      ');*/
      RESP_HTML := RESP_HTML || '<SCRIPT LANGUAGE=JAVASCRIPT> alert("Antes de publicar el contrato debe seleccionar \nel submenu Garantias para declarar la \naplicacion o no del requisito de Garantias"); </SCRIPT>';
   END IF;

   -- Fin Memo 245 2010 - Garantias 

   
    RESP_HTML := RESP_HTML || '<input type=hidden value ='||session__cod_contrato||' name=ag_cod_contrato id=ag_cod_contrato>';
    
    RESP_HTML := RESP_HTML || '<script language="javascript">
                     thisform.scriptdo.value = "doEditContrato";
                     if ( _error !=1 ) 
                     thisform.submit();
               </script>';

   END;
   
PROCEDURE uspPintarInput(
                    ruc_de_postor               varchar2 DEFAULT NULL,
                    n_convoca                   varchar2 DEFAULT NULL,
                    session__userid             varchar2 DEFAULT NULL,
                    tipo                        varchar2 DEFAULT NULL
                    )
    IS
    raz_social  varchar2(1500):='';
    valida_rnp  varchar2(500):='';
    Objeto      varchar2(500):='';
    lv_nconvoca varchar2 (50);
    li_num      number;
    no_domiciliado varchar2(10);
    prov_extranj_snrp varchar2(500):=''; -------MANTENIMIENTO 84-2018
    BEGIN

    if (session__userid is null) then
     usp_print('<h2>Su Sesion ha expirado... Por favor, vuelva a loguearse.</h2>');
     return;
    end if;



    lv_nconvoca:=n_convoca;

    IF(tipo = 1)THEN
        SELECT codobjeto INTO Objeto
           FROM convocatorias
           WHERE n_convoca = lv_nconvoca;

--        Select count(*) into li_num from entidades where n_ruc = ruc_de_postor and anhoentidad = to_char(sysdate,'yyyy') and activo  =1 ;
        li_num := REG_PROCESOS.F_GET_ENTIDAD ( ruc_de_postor, to_char(sysdate,'yyyy') );
        IF li_num > 0 THEN
             --raz_social := F_WS_RNP_GET_RAZON_SOCIAL(ruc_de_postor);
             Select descripcion into raz_social from reg_procesos.entidades where n_ruc = ruc_de_postor and anhoentidad = to_char(sysdate,'yyyy') and activo = 1;
             usp_print('<input type="text" name="ag_nom_destino_pago" value="'||raz_social||'" size="54" >');
             usp_print('<input type="hidden"  name="ruc_valido" value="1" >');
        ELSE
            -- valida_rnp := F_WS_RNP_GET_ESTADO_D(ruc_de_postor,Objeto,to_number(to_char(to_date(sysdate),'yyyymmdd')));
             raz_social := TRIM(replace(F_WS_SUNAT_GET_RAZON_SOCIAL(ruc_de_postor),'"',''));
            /* no_domiciliado := substr(ruc_de_postor,1,2);
             IF trim(no_domiciliado) = 'I9' THEN
                 valida_rnp := '1-OK';
                 no_domiciliado := '9';
                 no_domiciliado := no_domiciliado || substr(ruc_de_postor,2,10);
                 SELECT razonsocial INTO raz_social FROM resumen.rnprucs
                   WHERE ruc = no_domiciliado;
             END IF;*/

                 /*INICIO MANTENIMIENTO 84-2018*/
            if (raz_social is null) or (raz_social = '') then
             begin
               select distinct(tcvi.C_PROVEEDOREXCEPTUADO) into prov_extranj_snrp from ADM.TBL_ADM_PROV_EXCEPTUADO@AIXSEACE tcvi
                         where tcvi.C_RUC= ruc_de_postor
                           and tcvi.C_VERSIONESTADO='VER_VIG';
               raz_social :=prov_extranj_snrp; 
                exception when others then
                             raz_social := null;
            end;
            end if;
             /*FIN MANTENIMIENTO 84-2018*/
             
             
                               
             no_domiciliado := substr(ruc_de_postor,1,1);
             IF (trim(no_domiciliado) = 'I' or trim(no_domiciliado) = '9' or trim(no_domiciliado) = 'C' or trim(no_domiciliado) = 'L' /*provenientes del SEACEV3*/) and ((raz_social is null) or (raz_social = '')) THEN
                 valida_rnp          := '1-OK';
                 no_domiciliado      := '9';

               raz_social := TRIM(replace(F_WS_GET_RAZSOC_ALL(ruc_de_postor),'"',''));
              
         
               if (raz_social is null) or (raz_social = '') then

                  begin
                 SELECT distinct upper(max(prop.nom_postor)) INTO raz_social FROM reg_procesos.convocatoria_propuesta prop
                 WHERE prop.ruc_postor = UPPER(ruc_de_postor) 
                 --and prop.n_convoca  = lv_nconvoca
                 and prop.cod_consorcio is null;
                   exception when others then
                             raz_social := null;
                 end;

                   if raz_social is null then
                   begin
                    select distinct m.nom_miembro INTO raz_social
                        from reg_procesos.consorcio_miembro m
                        where ruc_miembro = UPPER(ruc_de_postor);
                    exception when others then
                             raz_social := null;
                   end;
                   end if;
               end if;
             END IF;


             IF trim(no_domiciliado) = 'C' THEN
                 valida_rnp          := '1-OK';
                 no_domiciliado      := '9';


                begin
                        select distinct m.nom_miembro INTO raz_social
                        from reg_procesos.consorcio_miembro m
                        where ruc_miembro = UPPER(ruc_de_postor);

                   exception when others then
                   raz_social := '';
                 end;

             END IF;


        /*     IF (valida_rnp = '1-OK' or valida_rnp is not null)THEN*/
                     usp_print('<input type="text" readonly name="ag_nom_destino_pago" value="'||raz_social||'" size="54" >');
                     usp_print('<input type="hidden"  name="ruc_valido" value="1" >');
           /*  ELSE
                     usp_print('<input type="text" readonly name="ag_nom_destino_pago" value="" size="54" >');
                     usp_print('<input type="hidden"  name="ruc_valido" value="0" >');
             END IF;       */
         END IF;

    ELSE
      BEGIN
        select descripcion into Objeto from reg_procesos.entidades
         where anhoentidad=to_char(sysdate,'yyyy')
         and n_ruc = ruc_de_postor
         and activo = 1;

        IF ((Objeto is not null) or (Objeto <> ''))THEN
            usp_print('<input type="text" readonly name="ag_nom_destino_pago" value="'||Objeto||'" size="54" >');
            usp_print('<input type="hidden"  name="ruc_valido" value="1" >');
        ELSE
            usp_print('<input type="text" readonly name="ag_nom_destino_pago" value="" size="54" >');
            usp_print('<input type="hidden"  name="ruc_valido" value="0" >');
        END IF;
      EXCEPTION when others then
            usp_print('<input type="text" readonly name="ag_nom_destino_pago" value="" size="54" >');
            usp_print('<input type="hidden"  name="ruc_valido" value="0" >');
            RETURN;
      END;
    END IF;
END;

procedure uspNewContratosDoEdit_v3(
      session__n_convoca         VARCHAR2 DEFAULT NULL,
      session__eue_codigo        VARCHAR2 DEFAULT NULL,
      session__anhoentidad       VARCHAR2 DEFAULT NULL,
      session__cod_moneda        VARCHAR2 DEFAULT NULL,
      ag_cod_tipo_contrato       VARCHAR2 DEFAULT NULL,
      ag_cod_modalidad_alcance   VARCHAR2 DEFAULT NULL,
      ag_cod_sist_adquisicion    VARCHAR2 DEFAULT NULL,
      ag_des_contrato            VARCHAR2 DEFAULT NULL,
      ag_n_contrato              VARCHAR2 DEFAULT NULL,
      ag_n_propuesta             varchar2 default null,
      ag_codmoneda_contrato_sel  varchar2 default null,   -- agregado para seleccionar moneda x item
      ag_ruc_contratista         VARCHAR2 DEFAULT NULL,
      ag_f_contrato              VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_ini          VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_fin          VARCHAR2 DEFAULT NULL,
      ag_observaciones           VARCHAR2 DEFAULT NULL,
      ag_trama_calendario        VARCHAR2 DEFAULT NULL,
      ag_ruc_destino_pago        VARCHAR2 DEFAULT NULL,
       v_ind_adm_direc            NUMBER DEFAULT 0,
        av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL
  )
  is

        -- Cursores
      ctipocontrato                  ref_cursor;
      cmodalidadalcance              ref_cursor;
      csistemaadquisicion            ref_cursor;
      cmontocontratado               ref_cursor;
      crucscontrato                  ref_cursor;
      cmiembros_consorcio            ref_cursor;

      --  Variables combos
      lv_combo_tipocontrato          varchar2(4000);
      lv_combo_modalidad_alcance     varchar2(4000);
      lv_combo_sistemaadquisicion    varchar2(4000);
      lv_combo_moneda                varchar2(4000);
      lv_combo_rucs                  varchar2(20000);


      -- datos de la entidad pagadora
      lv_codconsucode_paga           reg_procesos.contrato_tipo_entidad.codconsucode_paga%TYPE;
      lv_anhoenidad_paga             reg_procesos.contrato_tipo_entidad.anhoentidad_paga%TYPE;
      lv_descentidad_paga            sease.entidades.descripcion%TYPE;
      ln_cont_paga                   NUMBER;

      -- CIIU
      lv_ciu_ccodigo                 reg_procesos.contrato.ciu_ccodigo%TYPE;
      lv_ciu_cespecial               reg_procesos.contrato.ciu_cespecial%TYPE;

      -- Variables
      ln_indsiaf                     NUMBER;
      row_ciu_old                    sease.ciiuinei%RowtYPE;
      row_ciu_nu                     reg_procesos.t_cat_grupo%RowtYPE;
      lv_anho_convocatoria           NUMBER;
      lv_ruta_file                   VARCHAR2(1250);
      ln_tipo_modalidad              NUMBER;

      ln_ind_consorcio               NUMBER;

      ls_ruc_miembro                 VARCHAR2(11);
      ls_nom_miembro                 varchar2(150);
      ln_can_moneda                  NUMBER;
      LN_IND_MONEDA                  NUMBER;
      LN_TIPO_PROC_30556             NUMBER;--ID Micro requerimiento Ley 30556
      
   --INICIO MANTENIMIENTO 84-2018   
      LN_NORMATIVA                   varchar2(30); 
      LN_PROV_EXTRANJ_SNRP       varchar2(500); 
      lv_id_consorcio                varchar2(11);
      
   ----se crea el cursor para recorrer los miebros del consorcio y determinar si algun miembro es proveedor Extranjero Sin RNP   
 CURSOR cConsorcioMiembrostk(ruc_consorcio VARCHAR2,n_convoca NUMBER)
 is
   SELECT b.tipo,b.RUC_MIEMBRO,b.NOM_MIEMBRO
     FROM REG_PROCESOS.CONVOCATORIA_PROPUESTA a
    INNER JOIN  REG_PROCESOS.CONSORCIO_MIEMBRO b ON a.COD_CONSORCIO = b.COD_CONSORCIO
    WHERE a.RUC_POSTOR = ruc_consorcio
      AND a.N_CONVOCA = n_convoca;
      
  --FIN MANTENIMIENTO 84-2018   
     
  begin

/*  usp_print('<br>session__n_convoca:'||session__n_convoca);*/
    -- Javascript
    pku_gestor_cont_funciones_js_2.fvalidacadenas_js; --SEGUN MEMORANDO N 312-2016/SGFS-SM 054-2016
    PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos;
    sp_javascript_valida_ruc;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos_insert;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlContratos(session__anhoentidad,lpad(session__eue_codigo,6,'0'),session__N_CONVOCA );
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fxmlgeneral;
    
    --Inicio Micro requerimiento Ley 30556
    IF SESSION__N_CONVOCA IS NOT NULL THEN
    BEGIN
        SELECT CONVOC1.PROC_TIPO INTO LN_TIPO_PROC_30556 FROM CONVOCATORIAS CONVOC1 
        WHERE CONVOC1.N_CONVOCA=SESSION__N_CONVOCA AND ROWNUM = 1;
    END;
    END IF;
    --Fin Micro requerimiento Ley 30556
        
    if ag_n_propuesta is not null then
    
    begin
    --    select count(distinct codmoneda) into ln_can_moneda from reg_procesos.item_convoca where n_convoca = session__n_convoca;
     --   select count(distinct proc_item) into ln_can_moneda from reg_procesos.convocatoria_propuesta_item where n_propuesta = ag_n_propuesta;
        select count(distinct ic.codmoneda) into ln_can_moneda from reg_procesos.item_convoca ic 
        inner join reg_procesos.convocatoria_propuesta_item cpi on ic.n_convoca = cpi.n_convoca and ic.proc_item = cpi.proc_item
        where cpi.n_propuesta = ag_n_propuesta;
        
        if ln_can_moneda = 1 then
        --select distinct(codmoneda) into ln_ind_moneda from reg_procesos.item_convoca where n_convoca = session__n_convoca and rownum = 1;
        select distinct ic.codmoneda into ln_ind_moneda from reg_procesos.item_convoca ic 
        inner join reg_procesos.convocatoria_propuesta_item cpi on ic.n_convoca = cpi.n_convoca and ic.proc_item = cpi.proc_item
        where cpi.n_propuesta = ag_n_propuesta and rownum = 1;
        
        end if;
 
    EXCEPTION
        when others then
             f_msg_error('Error: Al intentar encontrar el tipo de moneda','''doNewContrato''');
             return;
    end;
    end if;
    -- Inicializacion de Cursores
    ctipocontrato               := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_ctipo_contrato;
    cmodalidadalcance           := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_ctipo_mod_alcance;
    csistemaadquisicion         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_csistema_finance;
    cmontocontratado            := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_monedas_item(ag_n_propuesta);
 --   cmontocontratado            := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cmonedas;
    crucscontrato               := f_crucs_contrato (session__N_CONVOCA);
    cmiembros_consorcio         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cMiembros_postor(ag_n_propuesta);

    -- Inicializamos los combos
    lv_combo_tipocontrato       := f_retorna_combo(ctipocontrato, 'ag_cod_tipo_contrato', ag_cod_tipo_contrato,null,null);
  --  lv_combo_modalidad_alcance  := f_retorna_combo(cmodalidadalcance, 'ag_cod_modalidad_alcance', ag_cod_modalidad_alcance,'--- Seleccionar ---','style="width:339px;"');
  --  lv_combo_sistemaadquisicion := f_retorna_combo(csistemaadquisicion, 'ag_cod_sist_adquisicion', ag_cod_sist_adquisicion,'--- Seleccionar ---','style="width:339px;"');
    
    if ln_can_moneda = 1 then
         lv_combo_moneda  := f_retorna_combo(cmontocontratado, 'ag_codmoneda_contrato_sel', nvl(ag_codmoneda_contrato_sel,ln_ind_moneda) ,null,' disabled="true";"');
    else lv_combo_moneda  := f_retorna_combo(cmontocontratado, 'ag_codmoneda_contrato_sel', nvl(ag_codmoneda_contrato_sel,0) ,'--- Seleccionar ---','onchange="goSubmit(''doNewContrato'','''');"');
         ln_ind_moneda:=0;
    end if;
    lv_combo_rucs               := f_retorna_combo(crucscontrato, 'ag_n_propuesta', ag_n_propuesta,'--- Seleccionar ---','style="width:339px;"onchange="cargaRUC(''doNewContrato'');"');
   lv_ruta_file                := gpk_directorio_liquidacion||'\'||session__anhoentidad||'\'||session__eue_codigo||'\'||session__n_convoca;
  --  ln_indica := f_retorna_total_moneda(ag_n_propuesta,session__N_CONVOCA);

    BEGIN

        select nvl(anhoentidad, anho_convoca),nvl(cod_tipo_modalidad,0) into lv_anho_convocatoria,ln_tipo_modalidad from reg_procesos.convocatorias where n_convoca = session__n_convoca;
        
    EXCEPTION
        when others then

             f_msg_error('Error: Al intentar hallar el Año/Tipo de Modalidad de la Convocatoria','''doNewContrato''');
             return;
    end;

     /*
    -- CIIU
   IF lv_anho_convocatoria < 2009 THEN
         row_ciu_old      := f_get_ciiu (session__N_CONVOCA,'doViewConsolaContratos');
         lv_ciu_ccodigo   := row_ciu_old.ciu_ccodigo;
         lv_ciu_cespecial := row_ciu_old.ciu_cespecial;
    ELSE
         row_ciu_nu       := f_get_CodNU(session__N_CONVOCA,'doViewConsolaContratos');
         if row_ciu_nu.grupo_bien is not null then
                  lv_ciu_ccodigo   := row_ciu_nu.grupo_bien;
          end if;
    END IF;
 */


   -- CIIU
    IF lv_anho_convocatoria < 2009 THEN
         row_ciu_old      := f_get_ciiu (session__N_CONVOCA,'doViewConsolaContratos');
         lv_ciu_ccodigo   := row_ciu_old.ciu_ccodigo;
         lv_ciu_cespecial := row_ciu_old.ciu_cespecial;
    ELSE
         if lv_anho_convocatoria < 2011 then ---POR INCIDENCIA 227-2011 AMOLINARI
         row_ciu_nu       := f_get_CodNU(session__N_CONVOCA,'doViewConsolaContratos');
          else
         row_ciu_nu       := f_get_CodNU_V2011_v3(session__N_CONVOCA,'doViewConsolaContratos');
         end if;
         lv_ciu_ccodigo   := row_ciu_nu.grupo_bien;
    END IF;

   -- Indicador de consorcio --
    BEGIN
       ln_ind_consorcio := 0;
       if ag_ruc_contratista is not null and ag_n_propuesta is not null then
        select ind_consorcio into ln_ind_consorcio from reg_procesos.convocatoria_propuesta where ruc_postor = ag_ruc_contratista and n_convoca = session__n_convoca;
       end if;
    EXCEPTION
        when others then
             f_msg_error('Error al intentar hallar el indicador de Consorcio','''doNewContrato''');
             return;
    END;
    
    
       ---INICIO MANTENIMIENTO 84-2018   
   
   ---Hallamos la normativa
 
          if (av_id_expede is null) or (av_id_expede = '') then
          LN_NORMATIVA:='SN';
          else 
             begin
                 ----SI tiene normativa lo recupera del SEACEv3
               select distinct(tcn.C_NORAPL)  into LN_NORMATIVA  from PRO.TBL_ACT_EXPEDIENTE@AIXSEACE tcn  where  tcn.N_ID_EXPEDE=av_id_expede;
               
               if (LN_NORMATIVA is null) or (LN_NORMATIVA = '') then    ----para los expediente que no tienen normativa
                            LN_NORMATIVA:='SN';
               end if;
               
               exception when others then
                             LN_NORMATIVA:='SN';
             end;
            end if;
            
     
  
   
    LN_PROV_EXTRANJ_SNRP:='NO_EXTRANJERO_SNRP';
   lv_id_consorcio  := substr(ag_ruc_contratista,0,1);
   
         IF lv_id_consorcio = 'C' then
            FOR xrowtc IN cConsorcioMiembrostk(ag_ruc_contratista,session__N_CONVOCA) LOOP

      ---verificamos si el proveedor  es un provedor Extranjero sin RNP registrado mediante la funcionalidad de "Administrar Proveedor Extranjero Sin RNP"  del SEACEv3    
          
             if (xrowtc.ruc_miembro is not null) then
                begin
                
              if LN_PROV_EXTRANJ_SNRP='NO_EXTRANJERO_SNRP'  then
               select distinct(tcei.C_RUC) into LN_PROV_EXTRANJ_SNRP from ADM.TBL_ADM_PROV_EXCEPTUADO@AIXSEACE tcei
                         where tcei.C_RUC= xrowtc.ruc_miembro
                           and tcei.C_VERSIONESTADO='VER_VIG'
                           and tcei.C_IDTIPOEXCEPTUADO='EXTRJ';
                if (LN_PROV_EXTRANJ_SNRP is not null) then    ---- si encontro Proveedor estranjero Sin RNP
                            LN_PROV_EXTRANJ_SNRP:='EXTRANJERO_SNRP';
                 end if;
               end if;  
                exception when others then
                             LN_PROV_EXTRANJ_SNRP:='NO_EXTRANJERO_SNRP';
                       
            end;
           end if;
      
            END LOOP;
        
        ELSE
         if (ag_ruc_contratista is not null) then
            begin
               select distinct(tceia.C_RUC) into LN_PROV_EXTRANJ_SNRP from ADM.TBL_ADM_PROV_EXCEPTUADO@AIXSEACE tceia
                         where tceia.C_RUC= ag_ruc_contratista
                           and tceia.C_VERSIONESTADO='VER_VIG'
                           and tceia.C_IDTIPOEXCEPTUADO='EXTRJ';
                if (LN_PROV_EXTRANJ_SNRP is not null) then    ----para los expediente que no tienen normativa
                              LN_PROV_EXTRANJ_SNRP:='EXTRANJERO_SNRP';
                            
                end if;
               
                exception when others then
                             LN_PROV_EXTRANJ_SNRP:='NO_EXTRANJERO_SNRP';
                             
                             
            end;
         END IF;
        END IF;
    
    USP_PRINT('<input type="hidden" name="V_LN_NORMATIVA"   value="'||LN_NORMATIVA||'"></input>');--MANTENIMIENTO 84-2018
    USP_PRINT('<input type="hidden" name="V_LN_PROV_EXTRANJ_SNRP"   value="'||LN_PROV_EXTRANJ_SNRP||'"></input>');--MANTENIMIENTO 84-2018
            
    ---FIN MANTENIMIENTO 84-2018

    -- Campos ocultos
    USP_PRINT('<input type="hidden" name="V_LN_TIPO_PROC_30556"   value="'||TO_CHAR(LN_TIPO_PROC_30556)||'"></input>');--Micro requerimiento Ley 30556
    usp_print('<input type="hidden" name="v_calendario_total"          value=""/>');
    usp_print('<input type="hidden" name="ag_trama_items"              value=""/>');
    usp_print('<input type="hidden" name="ag_trama_items_xml"          value=""/>');
    usp_print('<input type="hidden" name="WriteFileDirectory"          value="FileSinged">');
    usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"   value="'||lv_ruta_file||'"></input>');
    usp_print('<input type="hidden" name="ag_tipo_modalidad"           value="'||ln_tipo_modalidad||'"/>');
 usp_print('<input type="hidden" name="v_ind_adm_direc"           value="'||v_ind_adm_direc||'"/>');
 usp_print('<input type="hidden" name="av_id_expede"           value="'||av_id_expede||'"/>');
 usp_print('<input type="hidden" name="av_id_proc"           value="'||av_id_proc||'"/>');
 usp_print('<input type="hidden" name="av_id_con_pub"           value="'||av_id_con_pub||'"/>
 <input type="hidden" name="SizeFile">
 ');


    -- Variables
    ln_indsiaf         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__N_CONVOCA);

    -- datos de la entidad q paga
    reg_procesos.PKU_GESTOR_CONT_UTILES_2.p_entidad_pagadora (session__EUE_CODIGO,session__anhoentidad,  2,ln_cont_paga,lv_codconsucode_paga,lv_anhoenidad_paga, lv_descentidad_paga );


    usp_print ('<table border=0 width="100%">');
    usp_print ('<tr width="100%"><td>');
    usp_print
       ('<table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">');

    usp_print ('<tr>');

    usp_print( REG_PROCESOS.PKU_PROCESOS_COMUN.f_get_titulo_v3(session__N_CONVOCA, 'Crear Contrato') );

    usp_print('
       <td align=right valign=top>
         <input type=button value="Volver" onclick="VolverListaContratos()">
         <input type=button value="Grabar" onclick="goInsert_v3('||ln_indsiaf||',''ProcesarInsertContrato'',''xmlItems'',''ag_trama_items'',''xmlItemsCP'')">
       </td>
    </tr>
    </table>
    </td></tr>');

    -- Inicio de Datos del Contrato
  

  usp_print ('<tr><td>');
    usp_print
       ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="table table-striped">
            <tr><td colspan="3"><h3>Datos del Contrato<h3></td></tr>
            ');

 /*   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Entidad Contratante:',
                '<b>'||lv_descentidad_paga||'</b>',
                '&nbsp;'));
*/

usp_print
       (' <tr><td width=35%>Entidad Contratante:</td><td width=35%><b>'||lv_descentidad_paga||'</b></td><td width=30%>&nbsp;</td></tr>');
    usp_print('<input type="hidden"  name="ag_anho_enti_pagadora" value='||lv_anhoenidad_paga||'>');
    usp_print('<input type="hidden"  name="ag_cod_enti_pagadora"  value='||lv_codconsucode_paga||'>');


   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Descripci&oacute;n del contrato/Orden de Compra o Servicio:',
                '<input type=text value="'||ag_des_contrato||'" name="ag_des_contrato" size="54">',
                'Ingrese la descripcion del Contrato'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero de Contrato u Orden de Compra o Servicio:',
                lv_combo_tipocontrato
                ||'<input size="30" maxlength="250" name="ag_n_contrato" value="'||ag_n_contrato||'">',
                'Ingrese el Nmero de Contrato'));

   If lv_anho_convocatoria < 2009 then
    -- CIIU
    usp_print('<input type="hidden"  name="ag_ciu_ccodigo"   value="'||lv_ciu_ccodigo||'">
               <input type="hidden"  name="ag_ciu_cespecial" value="'||lv_ciu_cespecial||'">');
   Else
   -- CodNU
    usp_print
     (   '<input type="hidden"  name="ag_ciu_ccodigo"     value="'||lv_ciu_ccodigo||'">
          <input type="hidden"  name="ag_ciu_cespecial"   value="">');

   End if;

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Ruc o Codigo de Proveedor Extranjero no Domiciliado del Contratista:',
                lv_combo_rucs,
                'Seleccione el Contratista'));

   usp_print
         ('<input name="ag_ruc_contratista" value="'||ag_ruc_contratista||'" type="hidden">');

  IF ln_ind_consorcio = 1 THEN

       usp_print
         ('<tr>
              <td class=c1>&nbsp;</td>
              <td class=c2><b>Miembros del Consorcio:</b><BR>');

              usp_print('<table>');

      LOOP
      FETCH cmiembros_consorcio INTO ls_ruc_miembro, ls_nom_miembro;
      EXIT WHEN cmiembros_consorcio%NOTFOUND;
            usp_print
               ('<tr>
                    <td>'||ls_ruc_miembro||'&nbsp; - &nbsp;'||ls_nom_miembro||'</td>
                </tr>');
      END LOOP;
      CLOSE cmiembros_consorcio;
              usp_print('</table>');
      usp_print('</td>
              <td class=c3>&nbsp;</td>
          </tr>');

  END IF;

   usp_print
         ('<tr>
              <td class=c1>Ruc Destinatario del pago: </td>
              <td class=c2><input name="ag_ruc_destino_pago" id=ag_ruc_destino_pago size="54" value="'||ag_ruc_destino_pago||'" maxlength=11 ></td>
              <td class=c3>Ingrese el Ruc del destinatario del pago</td>
          </tr>
          <tr>
              <td class=c1>Nombre del Destinatario del Pago</td>
              <td class=c2>
                  <div id=divnombre style="border:0px solid #008000"></div>
              </td>
                <td><table border = "0" style="background-color: #DF0101;color:#111111" lenght = "200"><tr><td><FONT COLOR="#FFFFFF" bold><b>Verifique que los datos  del destinatario del pago sean correctos y que el RUC ingresado exista en la SUNAT!</b><td></td></tr></table></td>

          </tr>');

                 usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha de Suscripcion del Contrato / notificaci&oacute;n de la Orden de Compra o Servicio:',
                '<div class="input-group datepicker" id="idDivTxtFechaCont">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
                <input  type=text size=50 name="ag_f_contrato" data-format="dd/MM/yyyy" class="form-control" readonly value="'||ag_f_contrato||'"></div>',
                'Ingrese la Fecha de Suscripcion'));

  usp_print(
              PKU_PROCESOS_COMUN.f_putRowForm('(*)Vigencia del contrato:',
                  'Inicio: 
                  <div class="input-group datepicker" id="idDivTxtFechaIni">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
                  <input type="text" data-format="dd/MM/yyyy" class="form-control" readonly name="ag_f_vigencia_ini" value="'
               || ag_f_vigencia_ini
               || '" size=16></div>
               Fin: 
               <div class="input-group datepicker" id="idDivTxtFechaFin">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
               <input type="text" readonly name="ag_f_vigencia_fin" data-format="dd/MM/yyyy" class="form-control" value="'
               || ag_f_vigencia_fin
               || '" size=16></div>',
                  'Ingrese la fecha de Vigencia del contrato'));
   -- SE REALIZA VALIDACION CUANDO SELECCIONA MONEDA, se quita el valor default session__cod_moneda
     usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Monto Contratado:',
                lv_combo_moneda||'&nbsp;
                <input value="'||case when ln_can_moneda = 1 then ln_ind_moneda else ag_codmoneda_contrato_sel  end||'" type="hidden"  name="ag_codmoneda_contrato"> 
                <input value="" size="30" type="text" readonly name="ag_m_contratado" onkeyup="validarInputNumDecimal(this)">',
                'Seleccione la Moneda del Contrato'));              

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Situacion:',
                '<b>EN EJECUCION<b>',
                '&nbsp;'));

/*
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Sistema de Contrataci&oacute;n:',
                lv_combo_sistemaadquisicion,
                '&nbsp;Seleccione el Sistema de Contrataci&oacute;n'));*/

 usp_print('<input type="hidden"  name="ag_cod_sist_adquisicion" value="">');
  usp_print('<input type="hidden"  name="ag_cod_modalidad_alcance" value="">');
    -- Modalidad de financiamiento
    usp_print('<input type="hidden"  name="ag_cod_modalidad_finan" value="">');

    -- Modalidad de Alcance
/*    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Modalidad de ejecuci&oacute;n contractual:',
                lv_combo_modalidad_alcance,
                '&nbsp;Ingrese la Modalidad de ejecuci&oacute;n contractual'));*/

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
                '<input value=""  size="54" type="text" name="ag_observaciones" value="'||ag_observaciones||'">',
                'Ingrese las Observaciones'));

    usp_print ('</td></tr>');
    usp_print('</table>');

    -- Fin de Datos del Contrato

   usp_print ('<tr><td>');

    --  DATOS DEL UPLOAD
    usp_print
         ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="table table-striped">
              <tr><td colspan=3><h3>Registro de Contrato/Orden de Compra o Servicio</h3></td></tr>
             ');

 
usp_print( '<tr><td width=35%>(*)Adjuntar Archivo</td><td width=35%><input type="file" id="pfiletoupload1"  name="pfiletoupload1" class="form-control" size="41"  value="">
                <input type="hidden" name="pfiletoupload_file1" value=""/></td><td width=30%>Seleccione el archivo que contiene el Contrato/Orden de Compra o Servicio, solo se permiten archivos *.doc o *.pdf</td></tr>');
   /*         PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjuntar Archivo',
                '<input type="file" id="pfiletoupload1"  name="pfiletoupload1" class="form-control" size="41"  value="">
                <input type="hidden" name="pfiletoupload_file1" value=""/>',
                'Seleccione el archivo que contiene el Contrato/Orden de Compra o Servicio, solo se permiten archivos *.doc o *.pdf'));
*/
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha del Documento de Contrato',
                '<div class="input-group datepicker" id="idDivTxtFechaDoc">
                <div class="input-group-addon add-on">
                <span class="glyphicon glyphicon-calendar"></span>
                </div>
                <input readonly name="ag_fec_aprob" size="50"  data-format="dd/MM/yyyy" class="form-control" value=""></div>           
                ',
                'Seleccione la fecha de aprobacin del documento.'));


    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
                '<input value=""  size="54" type="text" name="doc_obs" value="">',
                '&nbsp;Ingrese las Observaciones'));

    usp_print ('</table>');
    usp_print ('</td></tr>');


    usp_print('</td></tr>');
     -- DATOS DEL UPLOAD

    usp_print('
         <script language="javascript" event=onchange for=ag_ruc_destino_pago>
                 divnombre.innerHTML = "";
                 callconsor(thisform.ag_ruc_destino_pago.value,"'||session__n_convoca||'");
         </script>

        <script language="javascript">
            callconsor(thisform.ag_ruc_destino_pago.value,"'||session__n_convoca||'");
        </script>

     ');

    IF (ln_indsiaf  = 1)  THEN

      -----------------  Calendario de pagos ------------
    -----------------  Calendario de pagos ------------
      usp_print('
      <tr>
      <td></br>
      <table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">
      <tr><td colspan="3"><h3>Calendario de pagos</h3></td></tr>');
      usp_print('<tr><td width=33% ></td>
      <td width=33%>
      <table border=1 width=100%  align=center cellpadding=3 cellspacing=0>
      <thead> <tr style=''background-color: #BDBDBD;color:#111111''>
      <td width=20% >Nro. de pago</td>
      <td width=30% >Fecha de pago</td>
      <td width=30% > <div id=''dv_tot_val_item''></div></td>
      <td width=20% >Operación</td></tr>
      <tr><td width=10%><input type=hidden name=v_ind_modificar value=0 /><input type=hidden value="" name="v_item" /></td>
      <td align=center width=20%><div class="input-group datepicker" id="idDivTxtFechaPago"> <div class="input-group-addon add-on">
      <span class="glyphicon glyphicon-calendar"></span></div>
      <input   name="ag_cal_fec_pago" data-format="dd/MM/yyyy" class="form-control" align=center readOnly=true/></div></td>
      <td align=center width=20%><input name=ag_cal_monto_pago  type=text onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this)"  /></td>
      <td align=center width=10%><input type=button name=it_b_agregar  value=''Agregar''></td>
      </tr></thead>
      ');
      usp_print('<tr><td colspan=4><div id="divCalendario">&nbsp;</div></td></tr>');
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlCalendario(session__cod_moneda,replace(ag_trama_calendario, ',', '.'),'v_calendario_total');
      usp_print('</table></td><td width=34% ></td></tr>');

    
    usp_print('
           
        
        <script language="javascript" event="onclick" for="it_b_agregar">
        AdicionarCalendario(thisform.ag_cal_fec_pago.value, thisform.ag_cal_monto_pago.value);
      
    </script>
        ');

    END IF;
    
    

    usp_print('</table>');
    
   
    -- Items --

    usp_print ('<tr><td colspan=3>');

    usp_print
     ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="table table-striped">
          <tr><td colspan=3><h3>Items del Contrato</h3></td></tr>
          <tr>
           <td align="center"colspan=9>
            <input type="button" name="btnAgregaItem" value="Agregar Nuevo Item al Contrato" OnClick="AdicionarElemento3(thisform.ag_proc_item.value,thisform.ag_f_bp_cons.value,thisform.ag_ubigeo.value,thisform.ag_descripcion.value,thisform.ag_monto.value,thisform.ag_unidad.value,thisform.ag_cantidad.value,thisform.ag_unidad_codigo.value,thisform.ag_sis_cont.value,thisform.ag_sis_des.value,thisform.ag_mod_cont.value,thisform.ag_mod_des.value,thisform.ag_itempaq_desc.value,thisform.ag_nivel5_cod.value,thisform.ag_cod_item.value,'||session__EUE_CODIGO||','||session__anhoentidad||','||session__N_CONVOCA||' );" />
            
           </td></tr>
          <tr><td colspan=9>&nbsp;</td></tr>');

    usp_print ('<tr><td >');

    usp_print
         (' <div id="divLista">&nbsp;</div>');
      
 PKU_GESTOR_CONT_UTILES_2.usp_xmlitemsnewcontrato_v3(ag_n_propuesta,session__n_convoca,session__eue_codigo,nvl(ag_codmoneda_contrato_sel,ln_ind_moneda));
    PKU_GESTOR_CONT_UTILES_2.f_postor_paq_obra(ag_n_propuesta,session__n_convoca);
 
    -- JAVA CONSOLA SEACE 3
    usp_print('<script language=javascript>

    if (thisform.ag_codmoneda_contrato_sel.value != 0)
    {
    thisform.ag_m_contratado.value = sumaTotalesItems3("xmlItems")    
    }
    else (thisform.ag_m_contratado.value =0)
      
    </script>');

    
      usp_print('</table>');
      usp_print ('</td></tr>');

      usp_print ('
      </table>
     ');

      -- En la tabla tipo_modalidad_conv los valores son distintos , realizar mejora
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script('

      if(thisform.ag_tipo_modalidad.value != 0 ){
               $("#ag_monto").removeAttr("readOnly", false); //colocar readonly
                  $("#ag_cantidad").removeAttr("readOnly", false);
            }

       ');

  -- Fin de Items --


  END;
/************Procedimiento para listar items del paquete***************/
procedure uspListarItemsPaquete (nconvoca number, procitem number) is

fecha_registro                 VARCHAR2(8);

    cursor items_paquete (nconvoca number,procitem number,fecha_registro varchar2) is
    
/*        select icd.n_item_convoca_detalle,icd.unm_codigo,um.unm_desc,n5.nivel5,n5.descripcion,icd.cantidad from reg_procesos.item_convoca_detalle icd
        inner join sease.unidad_medida um on um.unm_codigo=icd.unm_codigo
        inner join reg_procesos.t_cat_nivel5 n5 on n5.nivel5=icd.nivel5
        where icd.n_convoca in (select n_convoca from reg_procesos.convocatorias where n_convoca = nconvoca and codobjeto =3) and icd.proc_item=procitem and icd.nivel5 not in (
        select nvl(ic.nivel5,0) from reg_procesos.item_contrato ic where ic.n_convoca = nconvoca and ic.proc_item=procitem);
*/

        select i.n_id_item,um.unm_codigo,um.unm_desc,trim(substr(i.c_ccubso,9, 8)) nivel5,nvl(i.c_dsitem,i.c_dcubso) descripcion, i.c_cantid cantidad,fecha_registro fecha_registro
        from pro.tbl_act_item@aixseace i
        inner join sease.unidad_medida um on um.unm_codigo=(select l.n_cod_referencia from pro.tbl_cnf_valor_listado@aixseace l where n_id_vallistado =i.c_unimed)
        where n_id_padre in (select n_id_item from reg_procesos.item_convoca where n_convoca in (select n_convoca from reg_procesos.convocatorias where n_convoca = nconvoca and codobjeto =3) and proc_item=procitem)
        and i.n_id_item not in (select nvl(ic.n_id_item,0) from reg_procesos.item_contrato ic where ic.n_convoca = nconvoca and ic.proc_item=procitem);
        
		
		
		
	/*  Inicio 085-2018-SGFS  tchacon */
        cursor items_paquete2 (nconvoca number,procitem number,fecha_registro varchar2) is
        select i.n_id_item,um.unm_codigo,um.unm_desc,trim(substr(i.c_ccubso,9, 8)) nivel5,nvl(i.c_dsitem,i.c_dcubso) descripcion, i.c_cantid cantidad,dp.c_monadj montoadjudicado,fecha_registro fecha_registro
        from pro.tbl_act_item@aixseace i
        inner join sease.unidad_medida um on um.unm_codigo=(select l.n_cod_referencia from pro.tbl_cnf_valor_listado@aixseace l where n_id_vallistado =i.c_unimed)
        inner join PRO.DET_SEL_DE_PAQ@aixseace dp on dp.n_id_item=i.n_id_item
        inner join PRO.TBL_SEL_OTOR_ITEM_PAQ@aixseace tp  on  tp.N_ID_OTOR_ITEM_PAQ=dp.N_ID_OTOR_ITEM_PAQ and tp.C_ESTADO='A'
        where n_id_padre in (select n_id_item from reg_procesos.item_convoca where n_convoca in (select n_convoca from reg_procesos.convocatorias where n_convoca = nconvoca and codobjeto =3) and proc_item=procitem)
        and i.n_id_item not in (select nvl(ic.n_id_item,0) from reg_procesos.item_contrato ic where ic.n_convoca = nconvoca and ic.proc_item=procitem);
    /*  Fin 085-2018-SGFS  tchacon */   
	
BEGIN

    usp_print ('<select name="selectItem" id="selectItem" onchange=actualizarDatosItemPaquete()> ');
    usp_print ('<option value="-" >---Seleccione---</option>');
	
	 /*  Inicio 085-2018-SGFS  tchacon */ 
    select to_char(F_REGISTRO,'yyyymmdd' ) into fecha_registro from reg_procesos.convocatorias where n_convoca  = nconvoca;
    
    if (fecha_registro>='20181006') then
    
        for x in items_paquete2 (nconvoca,procitem,fecha_registro) loop
     
            usp_print ('<option unm_codigo="'||x.unm_codigo||'" unm_desc="'||x.unm_desc||'" cantidad="'||x.cantidad||'" nivel5="'||x.nivel5||'" cod_item="'||x.n_id_item||'" montoadjudicado="'||x.montoadjudicado||'" fecharegistro="'||fecha_registro||'" value="'||x.descripcion||'">'||x.descripcion||'</option>');
        
        end loop;
            usp_print ('</select>');
            usp_print('<input type="hidden" name="ag_monto_suma_cont" value="'||PKU_GESTOR_CONT_UTILES_2.f_SumaMontoItemCont(nconvoca,procitem)||'"/>');

    
    else
        /*  Fin 085-2018-SGFS  tchacon */
	
    for x in items_paquete (nconvoca,procitem,fecha_registro) loop
          --usp_print ('<option unm_codigo="'||x.unm_codigo||'" unm_desc="'||x.unm_desc||'" cantidad="'||x.cantidad||'" nivel5="'||x.nivel5||'"value="'||x.descripcion||'">'||x.descripcion||'</option>');
           usp_print ('<option unm_codigo="'||x.unm_codigo||'" unm_desc="'||x.unm_desc||'" cantidad="'||x.cantidad||'" nivel5="'||x.nivel5||'" cod_item="'||x.n_id_item||'" fecharegistro="'||fecha_registro||'"  value="'||x.descripcion||'">'||x.descripcion||'</option>');
    end loop;

    usp_print ('</select>');
    usp_print('<input type="hidden" name="ag_monto_suma_cont" value="'||PKU_GESTOR_CONT_UTILES_2.f_SumaMontoItemCont(nconvoca,procitem)||'"/>');

	end if;
END;


  /*************************************************************************/

  procedure uspNewContratosDoEdit(
      session__n_convoca         VARCHAR2 DEFAULT NULL,
      session__eue_codigo        VARCHAR2 DEFAULT NULL,
      session__anhoentidad       VARCHAR2 DEFAULT NULL,
      session__cod_moneda        VARCHAR2 DEFAULT NULL,
      ag_cod_tipo_contrato       VARCHAR2 DEFAULT NULL,
      ag_cod_modalidad_alcance   VARCHAR2 DEFAULT NULL,
      ag_cod_sist_adquisicion    VARCHAR2 DEFAULT NULL,
      ag_des_contrato            VARCHAR2 DEFAULT NULL,
      ag_n_contrato              VARCHAR2 DEFAULT NULL,
      ag_n_propuesta             VARCHAR2 DEFAULT NULL,
      ag_ruc_contratista         VARCHAR2 DEFAULT NULL,
      ag_f_contrato              VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_ini          VARCHAR2 DEFAULT NULL,
      ag_f_vigencia_fin          VARCHAR2 DEFAULT NULL,
      ag_observaciones           VARCHAR2 DEFAULT NULL,
      ag_trama_calendario        VARCHAR2 DEFAULT NULL,
      ag_ruc_destino_pago        VARCHAR2 DEFAULT NULL
  )
  is

        -- Cursores
      ctipocontrato                  ref_cursor;
      cmodalidadalcance              ref_cursor;
      csistemaadquisicion            ref_cursor;
      cmontocontratado               ref_cursor;
      crucscontrato                  ref_cursor;
      cmiembros_consorcio            ref_cursor;

      --  Variables combos
      lv_combo_tipocontrato          varchar2(4000);
      lv_combo_modalidad_alcance     varchar2(4000);
      lv_combo_sistemaadquisicion    varchar2(4000);
      lv_combo_moneda                varchar2(4000);
      lv_combo_rucs                  varchar2(20000);


      -- datos de la entidad pagadora
      lv_codconsucode_paga           reg_procesos.contrato_tipo_entidad.codconsucode_paga%TYPE;
      lv_anhoenidad_paga             reg_procesos.contrato_tipo_entidad.anhoentidad_paga%TYPE;
      lv_descentidad_paga            sease.entidades.descripcion%TYPE;
      ln_cont_paga                   NUMBER;

      -- CIIU
      lv_ciu_ccodigo                 reg_procesos.contrato.ciu_ccodigo%TYPE;
      lv_ciu_cespecial               reg_procesos.contrato.ciu_cespecial%TYPE;

      -- Variables
      ln_indsiaf                     NUMBER;
      row_ciu_old                    sease.ciiuinei%RowtYPE;
      row_ciu_nu                     reg_procesos.t_cat_grupo%RowtYPE;
      lv_anho_convocatoria           NUMBER;
      lv_ruta_file                   VARCHAR2(1250);
      ln_tipo_modalidad              NUMBER;

      ln_ind_consorcio               NUMBER;

      ls_ruc_miembro                 VARCHAR2(11);
      ls_nom_miembro                 VARCHAR2(150);

  begin

 
    -- Javascript
    pku_gestor_cont_funciones_js_2.fvalidacadenas_js; --SEGUN MEMORANDO N 312-2016/SGFS-SM 054-2016
    PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos;
    sp_javascript_valida_ruc;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos_insert;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlContratos(session__anhoentidad,lpad(session__eue_codigo,6,'0'),session__N_CONVOCA );
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlGeneral;
    


    -- Inicializacion de Cursores
    ctipocontrato               := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_ctipo_contrato;
    cmodalidadalcance           := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_ctipo_mod_alcance;
    csistemaadquisicion         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_csistema_finance;
    cmontocontratado            := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cmonedas;
    crucscontrato               := f_crucs_contrato (session__N_CONVOCA);
    cmiembros_consorcio         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cMiembros_postor(ag_n_propuesta);

    -- Inicializamos los combos
    lv_combo_tipocontrato       := f_retorna_combo(ctipocontrato, 'ag_cod_tipo_contrato', ag_cod_tipo_contrato,null,null);
    lv_combo_modalidad_alcance  := f_retorna_combo(cmodalidadalcance, 'ag_cod_modalidad_alcance', ag_cod_modalidad_alcance,'--- Seleccionar ---','style="width:339px;"');
    lv_combo_sistemaadquisicion := f_retorna_combo(csistemaadquisicion, 'ag_cod_sist_adquisicion', ag_cod_sist_adquisicion,'--- Seleccionar ---','style="width:339px;"');
    lv_combo_moneda             := f_retorna_combo(cmontocontratado, 'ag_codmoneda_contrato_sel', session__cod_moneda,'--- Seleccionar ---','disabled="true"');
    lv_combo_rucs               := f_retorna_combo(crucscontrato, 'ag_n_propuesta', ag_n_propuesta,'--- Seleccionar ---','style="width:339px;" onchange="cargaRUC(''doNewContrato'');"');
    lv_ruta_file                := gpk_directorio_liquidacion||'\'||session__anhoentidad||'\'||session__eue_codigo||'\'||session__N_CONVOCA;


    BEGIN

        SELECT nvl(anhoentidad, anho_convoca),nvl(COD_TIPO_MODALIDAD,0) INTO lv_anho_convocatoria,ln_tipo_modalidad FROM reg_procesos.convocatorias WHERE n_convoca = session__N_CONVOCA;

    EXCEPTION
        when others then

             f_msg_error('Error: Al intentar hallar el Ao/Tipo de Modalidad de la Convocatoria','''doNewContrato''');
             return;
    END;

     -- CIIU
    IF lv_anho_convocatoria < 2009 THEN
         row_ciu_old      := f_get_ciiu (session__N_CONVOCA,'doViewConsolaContratos');
         lv_ciu_ccodigo   := row_ciu_old.ciu_ccodigo;
         lv_ciu_cespecial := row_ciu_old.ciu_cespecial;
    ELSE
         if lv_anho_convocatoria < 2011 then ---POR INCIDENCIA 227-2011 AMOLINARI
         row_ciu_nu       := f_get_CodNU(session__N_CONVOCA,'doViewConsolaContratos');
          else
         row_ciu_nu       := f_get_CodNU_V2011(session__N_CONVOCA,'doViewConsolaContratos');
         end if;
         lv_ciu_ccodigo   := row_ciu_nu.grupo_bien;
    END IF;

   -- Indicador de consorcio --
    BEGIN
       ln_ind_consorcio := 0;
       if ag_ruc_contratista is not null and ag_n_propuesta is not null then
        select ind_consorcio into ln_ind_consorcio from reg_procesos.convocatoria_propuesta where ruc_postor = ag_ruc_contratista and n_convoca = session__n_convoca;
       end if;
    EXCEPTION
        when others then
             f_msg_error('Error al intentar hallar el indicador de Consorcio','''doNewContrato''');
             return;
    END;

    -- Campos ocultos
    usp_print('<input type="hidden" name="v_calendario_total"          value="'||ag_n_propuesta||'"/>');
    usp_print('<input type="hidden" name="ag_trama_items"              value=""/>');
    usp_print('<input type="hidden" name="ag_trama_items_xml"          value=""/>');
    usp_print('<input type="hidden" name="WriteFileDirectory"          value="FileSinged">');
    usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"   value="'||lv_ruta_file||'"></input>');
    usp_print('<input type="hidden" name="ag_tipo_modalidad"           value="'||ln_tipo_modalidad||'"/>
    <input type="hidden" name="SizeFile">');


    -- Variables
    ln_indsiaf         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__N_CONVOCA);

    -- datos de la entidad q paga
    reg_procesos.PKU_GESTOR_CONT_UTILES_2.p_entidad_pagadora (session__EUE_CODIGO,session__anhoentidad,  2,ln_cont_paga,lv_codconsucode_paga,lv_anhoenidad_paga, lv_descentidad_paga );


    usp_print ('<table border=0 width="100%">');
    usp_print ('<tr width="100%"><td>');
    usp_print
       ('<table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">');

    usp_print ('<tr>');

    usp_print( REG_PROCESOS.PKU_PROCESOS_COMUN.f_get_titulo(session__N_CONVOCA, 'Crear Contrato') );

    usp_print('
       <td align=right valign=top>
         <input type=button value="Volver" onclick="VolverListaContratos()">
         <input type=button value="Grabar" onclick="goInsert('||ln_indsiaf||',''ProcesarInsertContrato'',''xmlItems'',''ag_trama_items'',xmlItemsCP)">
       </td>
    </tr>
    </table>
    </td></tr>');

    -- Inicio de Datos del Contrato
    usp_print ('<tr><td>');
    usp_print
       ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="table table-striped">
            <tr><td colspan="3"><h3>Datos del Contrato<h3></td></tr>
            ');

  /*  usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Entidad Contratante:',
                '<b>'||lv_descentidad_paga||'</b>',
                '&nbsp;')); */
                usp_print
       (' <tr><td width=35%>Entidad Contratante:</td><td width=35%><b>'||lv_descentidad_paga||'</b></td><td width=30%>&nbsp;</td></tr>');

    usp_print('<input type="hidden"  name="ag_anho_enti_pagadora" value='||lv_anhoenidad_paga||'>');
    usp_print('<input type="hidden"  name="ag_cod_enti_pagadora"  value='||lv_codconsucode_paga||'>');


   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Descripci&oacute;n del contrato/Orden de Compra o Servicio:',
                '<input type=text value="'||ag_des_contrato||'" name="ag_des_contrato" size="54">',
                '&nbsp;Ingrese la descripcion del Contrato'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero de Contrato u Orden de Compra o Servicio:',
                lv_combo_tipocontrato
                ||'<input maxlength="250" name="ag_n_contrato" value="'||ag_n_contrato||'">',
                'Ingrese el Numero de Contrato'));

   If lv_anho_convocatoria < 2009 then
    -- CIIU
    usp_print('<input type="hidden"  name="ag_ciu_ccodigo"   value="'||lv_ciu_ccodigo||'">
               <input type="hidden"  name="ag_ciu_cespecial" value="'||lv_ciu_cespecial||'">');
   Else
   -- CodNU
    usp_print
     (   '<input type="hidden"  name="ag_ciu_ccodigo"     value="'||lv_ciu_ccodigo||'">
          <input type="hidden"  name="ag_ciu_cespecial"   value="">');

   End if;

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Ruc o Codigo de Proveedor Extranjero no Domiciliado del Contratista:',
                lv_combo_rucs,
                'Seleccione el Contratista'));

   usp_print
         ('<input name="ag_ruc_contratista" value="'||ag_ruc_contratista||'" type="hidden">');

  IF ln_ind_consorcio = 1 THEN

       usp_print
         ('<tr>
              <td class=c1>&nbsp;</td>
              <td class=c2><b>Miembros del Consorcio:</b><BR>');

              usp_print('<table>');

      LOOP
      FETCH cmiembros_consorcio INTO ls_ruc_miembro, ls_nom_miembro;
      EXIT WHEN cmiembros_consorcio%NOTFOUND;
             usp_print
               ('<tr>
                    <td>'||ls_ruc_miembro||'&nbsp; - &nbsp;'||ls_nom_miembro||'</td>
                </tr>');
      END LOOP;
      CLOSE cmiembros_consorcio;
              usp_print('</table>');
      usp_print('</td>
              <td class=c3>&nbsp;</td>
          </tr>');

  END IF;

   usp_print
         ('<tr>
              <td class=c1>Ruc Destinatario del pago: </td>
              <td class=c2><input name="ag_ruc_destino_pago" id=ag_ruc_destino_pago size="54" value="'||ag_ruc_destino_pago||'" maxlength=11 ></td>
              <td class=c3>&nbsp;Ingrese el Ruc del destinatario del pago</td>
          </tr>
          <tr>
              <td class=c1>Nombre del Destinatario del Pago</td>
              <td class=c2>
                  <div id=divnombre style="border:0px solid #008000"></div>
              </td>
              <td><table border = "0" style="background-color: #DF0101;color:#111111" lenght = "200"><tr><td><FONT COLOR="#FFFFFF" bold><b>Verifique que los datos  del destinatario del pago sean correctos!</b><td></td></tr></table></td>
          </tr>');

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha de Suscripcion del Contrato / notificaci&oacute;n de la Orden de Compra o Servicio:',
                '<div class="input-group datepicker" id="idDivTxtFechaCont">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
                <input  type=text size=50 name="ag_f_contrato" data-format="dd/MM/yyyy" class="form-control" readonly value="'||ag_f_contrato||'"></div>',
                '&nbsp;Ingrese la Fecha de Suscripcion'));

   usp_print(
              PKU_PROCESOS_COMUN.f_putRowForm('(*)Vigencia del contrato:',
                  'Inicio: 
                  <div class="input-group datepicker" id="idDivTxtFechaIni">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
                  <input type="text" data-format="dd/MM/yyyy" class="form-control" readonly name="ag_f_vigencia_ini" value="'
               || ag_f_vigencia_ini
               || '" size=16></div>
               Fin: 
               <div class="input-group datepicker" id="idDivTxtFechaFin">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
               <input type="text" readonly name="ag_f_vigencia_fin" data-format="dd/MM/yyyy" class="form-control" value="'
               || ag_f_vigencia_fin
               || '" size=16></div>',
                  '&nbsp;Ingrese la fecha de Vigencia del contrato'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Monto Contratado:',
                lv_combo_moneda||'&nbsp;
                <input value="'||session__cod_moneda||'" type="hidden"  name="ag_codmoneda_contrato">
                <input value="" size="30" type="text" readonly name="ag_m_contratado" onkeyup="validarInputNumDecimal(this)">',
                '&nbsp;Seleccione la Moneda del Contrato'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Situacion:',
                '<b>EN EJECUCION<b>',
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
                '<input value=""  size="54" type="text" name="ag_observaciones" value="'||ag_observaciones||'">',
                '&nbsp;Ingrese las Observaciones'));

    usp_print ('</td></tr>');
    usp_print('</table>');

    -- Fin de Datos del Contrato

    usp_print ('<tr><td>');

    --  DATOS DEL UPLOAD
    usp_print
         ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="table table-striped">
              <tr><td colspan=3><h3>Registro de Contrato/Orden de Compra o Servicio</h3></td></tr>
              ');

usp_print( '<tr><td width=35%>(*)Adjuntar Archivo</td><td width=35%><input type="file" id="pfiletoupload1"  name="pfiletoupload1" class="form-control" size="41"  value="">
                <input type="hidden" name="pfiletoupload_file1" value=""/></td><td width=30%>Seleccione el archivo que contiene el Contrato/Orden de Compra o Servicio, solo se permiten archivos *.doc o *.pdf</td></tr>');


/*
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjuntar Archivo',
                '<input type="file" id="pfiletoupload1"  name="pfiletoupload1" class="form-control" size="41"  value="">
                <input type="hidden" name="pfiletoupload_file1" value=""/>',
                'Seleccione el archivo que contiene el Contrato/Orden de Compra o Servicio, solo se permiten archivos *.doc o *.pdf'));
*/
    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha del Documento de Contrato',
                '<div class="input-group datepicker" id="idDivTxtFechaDoc">
                <div class="input-group-addon add-on">
                <span class="glyphicon glyphicon-calendar"></span>
                </div>
                <input readonly name="ag_fec_aprob" size="50"  data-format="dd/MM/yyyy" class="form-control" value=""></div>           
                ',
                'Seleccione la fecha de aprobacin del documento.'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
                '<input value=""  size="54" type="text" name="doc_obs" value="">',
                '&nbsp;Ingrese las Observaciones'));

    usp_print ('</table>');
    usp_print ('</td></tr>');


    usp_print('</td></tr>');
     -- DATOS DEL UPLOAD

    usp_print('
         <script language="javascript" event=onchange for=ag_ruc_destino_pago>
                 divnombre.innerHTML = "";
                 callconsor(thisform.ag_ruc_destino_pago.value,"'||session__n_convoca||'");
         </script>

        <script language="javascript">
            callconsor(thisform.ag_ruc_destino_pago.value,"'||session__n_convoca||'");
        </script>

     '); 

    IF (ln_indsiaf  = 1)  THEN

      -----------------  Calendario de pagos ------------
      usp_print('
      <tr>
      <td></br>
      <table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">
      <tr><td colspan="3"><h3>Calendario de pagos</h3></td></tr>');
      usp_print('<tr><td width=33% ></td>
      <td width=33%>
      <table border=1 width=100%  align=center cellpadding=3 cellspacing=0>
      <thead> <tr style=''background-color: #BDBDBD;color:#111111''>
      <td width=20% >Nro. de pago</td>
      <td width=30% >Fecha de pago</td>
      <td width=30% > <div id=''dv_tot_val_item''></div></td>
      <td width=20% >Operación</td></tr>
      <tr><td width=10%><input type=hidden name=v_ind_modificar value=0 /><input type=hidden value="" name="v_item" /></td>
      <td align=center width=20%><div class="input-group datepicker" id="idDivTxtFechaPago"> <div class="input-group-addon add-on">
      <span class="glyphicon glyphicon-calendar"></span></div>
      <input   name="ag_cal_fec_pago" data-format="dd/MM/yyyy" class="form-control" align=center readOnly=true/></div></td>
      <td align=center width=20%><input name=ag_cal_monto_pago  type=text onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this)"  /></td>
      <td align=center width=10%><input type=button name=it_b_agregar  value=''Agregar''></td>
      </tr></thead>
      ');
      usp_print('<tr><td colspan=4><div id="divCalendario">&nbsp;</div></td></tr>');
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlCalendario(session__cod_moneda,replace(ag_trama_calendario, ',', '.'),'v_calendario_total');
      usp_print('</table></td><td width=34% ></td></tr>');

    
    usp_print('
           
        
        <script language="javascript" event="onclick" for="it_b_agregar">
        AdicionarCalendario(thisform.ag_cal_fec_pago.value, thisform.ag_cal_monto_pago.value);
      
    </script>
        ');

    END IF;


    usp_print('</table>');



    -- Items --

    usp_print ('<tr><td colspan=3>');
    
    
    usp_print
     ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="table table-striped">
          <tr><td colspan=3><h3>Items del Contrato</h3></td></tr>
          <tr>
           <td align="center"colspan=9>
            <input type="button" name="btnAgregaItem" value="Agregar Nuevo Item al Contrato" OnClick="AdicionarElemento(thisform.ag_proc_item.value,thisform.ag_f_bp_cons.value,thisform.ag_ubigeo.value,thisform.ag_descripcion.value,thisform.ag_monto.value,thisform.ag_unidad.value,thisform.ag_cantidad.value,thisform.ag_unidad_codigo.value,thisform.ag_itempaq_desc.value,thisform.ag_nivel5_cod.value,'||session__EUE_CODIGO||','||session__anhoentidad||','||session__N_CONVOCA||' );" />
            </td></tr>
          <tr><td colspan=9>&nbsp;</td></tr>');
usp_print ('<tr><td >');
    usp_print('<div id="divLista">&nbsp;</div>');
      
  PKU_GESTOR_CONT_UTILES_2.usp_XmlItemsNewContrato(ag_n_propuesta,session__n_convoca,session__EUE_CODIGO);

    PKU_GESTOR_CONT_UTILES_2.f_postor_paq_obra(ag_n_propuesta,session__n_convoca);

    usp_print('<script language=javascript>thisform.ag_m_contratado.value =   sumaTotalesItems("xmlItems") </script>');
    

      -------------------------------------------------------------------------------
  
      usp_print('</table>'); 
      usp_print ('</td></tr>');

      usp_print ('
      </table>
   ');

      -- En la tabla tipo_modalidad_conv los valores son distintos , realizar mejora
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script('

         if(thisform.ag_tipo_modalidad.value == 1 || thisform.ag_tipo_modalidad.value == 3 ){
                 $("#ag_monto").removeAttr("readOnly", false); //colocar readonly
                  $("#ag_cantidad").removeAttr("readOnly", false);
              
            }

       ');

  -- Fin de Items --
    usp_print('
    <script language="javascript">
        
    var currentobject;
    
    </script>');
    

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
   v_xml     VARCHAR2(18000);

   ln_num_pago    number;
   ld_fec_pago    date;
   ln_codmoneda   number;
  --- ln_montoPago   number(15,2);   ---SM-189-2018-SGFS
  ln_montoPago   number(21,2);		 ---SM-189-2018-SGFS

   BEGIN

   v_xml              := ag_trama_calendario;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);
   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);

   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/calendario');

  PK_CONVOCATORIA.gn_id_operacion := ag_id_operacion;
    
  
  DELETE FROM reg_procesos.contrato_operacion_calendario WHERE ID_OPERACION = ag_id_operacion;


  FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
   v_n := xmldom.item(v_nl, cur_emp);
    
   ln_num_pago := xslprocessor.valueOf(v_n,'numpago');
   ld_fec_pago := to_date(xslprocessor.valueOf(v_n,'fecha'),'dd/mm/yyyy');
   ln_codmoneda := xslprocessor.valueOf(v_n,'moneda');
  -- ln_montoPago := TO_NUMBER(xslprocessor.valueOf(v_n,'monto'), '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' );
   
   ln_montoPago     := to_number(replace(xslprocessor.valueOf(v_n,'monto'), '.', ','));
  -- usp_print('monto: '|| TO_NUMBER(xslprocessor.valueOf(v_n,'monto'), '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' ));
 --dbms_output.put_line(TO_NUMBER(xslprocessor.valueOf(v_n,'monto'), '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' ));
 --return;
   BEGIN

      INSERT INTO reg_procesos.contrato_operacion_calendario
                  (
                   id_operacion,
                   num_pago,
                   fec_pago,
                   codmoneda,
                   monto_pago
                   )
           VALUES (
                   ag_id_operacion,
                   ln_num_pago,
                   ld_fec_pago,
                   ln_codmoneda,
                   ln_montoPago
                   );
     --    dbms_output.put_line(xslprocessor.valueOf(v_n,'CODOBJETO') || '<-->'||xslprocessor.valueOf(v_n,'DESCRIPCION'));
   EXCEPTION
      WHEN OTHERS THEN
            f_msg_error('Error: Al intentar registrar el Calendario de Pagos','''doEditContrato''');


  END;
  END LOOP;

  xmldom.freeDocument(v_doc);


 END;

FUNCTION f_retorna_total_moneda(ag_n_propuesta number, ag_nconvoca number)
RETURN NUMBER
IS 
cant number;
BEGIN
cant:=0;

select count(distinct codmoneda) into cant
from reg_procesos.item_convoca ic ,REG_PROCESOS.convocatoria_propuesta_item cpi
where  ic.n_convoca = cpi.n_convoca
and ic.proc_item = cpi.proc_item
and ic.n_convoca = ag_nconvoca
and cpi.n_propuesta = ag_n_propuesta;

return cant;
END;

FUNCTION f_valida_fconsentimiento(ag_trama_items VARCHAR2, ag_nconvoca NUMBER,ag_fec_contrato VARCHAR2)
RETURN boolean
IS

   v_parser              xmlparser.Parser;
   v_doc                 xmldom.DOMDocument;
   v_nl                  xmldom.DOMNodeList;
   v_n                   xmldom.DOMNode;
   v_xml                 VARCHAR2(32000);

   LN_PROCITEM           NUMBER;
   TOTAL                 NUMBER;--SM 112-2017
   ld_fecha_cons         DATE;

BEGIN

--usp_print('ag_trama_items:'||ag_trama_items);

   v_xml              := ag_trama_items;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);

   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);
   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');
    --INI SM 112-2017
    SELECT count(1) INTO TOTAL FROM 
    PRO.TBL_ACT_EXPEDIENTE@AIXSEACE E
    INNER JOIN REG_PROCESOS.PROCESOS P ON E.N_ID_EXPEDE = P.N_ID_EXPEDE
    INNER JOIN REG_PROCESOS.CONVOCATORIAS C ON C.N_PROCESO = P.N_PROCESO
    WHERE 
    (E.C_NORAPL=791 AND -- 791 (prod)
    E.C_TIPSEL IN (835,855))
    --INICIO SM XXX-2020
    OR (E.C_NORAPL=1278 AND 
    E.C_TIPSEL = 84) 
    --FIN SM XXX-2020
    AND -- 835 y 855 (prod)
    C.N_CONVOCA = AG_NCONVOCA;
    --FIN SM 112-2017
 FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
     v_n          := xmldom.item(v_nl, cur_emp);
     ln_procitem  := xslprocessor.valueOf(v_n,'item');

     BEGIN
        --INI SM 112-2017
        IF (TOTAL>0) THEN
            SELECT MAX(I.D_FECCON) INTO ld_fecha_cons FROM 
            PRO.TBL_ACT_EXPEDIENTE@AIXSEACE E
            INNER JOIN REG_PROCESOS.PROCESOS P ON E.N_ID_EXPEDE = P.N_ID_EXPEDE
            INNER JOIN REG_PROCESOS.CONVOCATORIAS C ON C.N_PROCESO = P.N_PROCESO
            INNER JOIN REG_PROCESOS.ITEM_CONVOCA_ESTADO ICE ON ICE.N_CONVOCA = C.N_CONVOCA
            INNER JOIN REG_PROCESOS.ITEM_CONVOCA IC ON IC.N_CONVOCA = ICE.N_CONVOCA AND ICE.PROC_ITEM = IC.PROC_ITEM
            INNER JOIN PRO.TBL_ACT_ITEM@AIXSEACE I ON I.N_ID_ITEM = IC.N_ID_ITEM
            WHERE 
            (E.C_NORAPL=791 AND -- 791 (prod)
            E.C_TIPSEL IN (835,855)) 
            OR (E.C_NORAPL=1278 AND 
            E.C_TIPSEL = 84) 
            AND -- 835 y 855 (prod)
            ICE.COD_TIPO_ESTADO_ITEM=500 AND
            ICE.PROC_ITEM = ln_procitem AND
            C.N_CONVOCA = AG_NCONVOCA;
        ELSE
        --FIN SM 112-2017
          SELECT MAX(icei.f_registro) INTO ld_fecha_cons
           FROM reg_procesos.item_convoca_estado icei
          WHERE icei.n_convoca_src         = reg_procesos.f_get_min_n_convoca(ag_nconvoca)
            AND icei.cod_tipo_Estado_item  = 500
            AND icei.proc_item             = ln_procitem
            AND icei.f_registro = (
                       SELECT MAX(f_registro)
                         FROM reg_procesos.item_convoca_estado ice2
                        WHERE ice2.n_convoca_src  = icei.n_convoca_src
                          AND ice2.proc_item = icei.proc_item
                     );
        END IF;--SM 112-2017
    EXCEPTION
        when others then
             f_msg_error('Error al intentar hallar la fecha de consentimiento del Item: '||ln_procitem,'''doNewContrato''');
             RETURN FALSE;
    END;

    IF trunc(ld_fecha_cons) > trunc(TO_DATE(ag_fec_contrato,'dd/mm/yyyy')) THEN
             RETURN FALSE;
    END IF;

 END LOOP;

 xmldom.freeDocument(v_doc);

 RETURN TRUE;

END;

PROCEDURE usp_registra_items(ag_trama_items varchar2, ag_ncodcontrato number, ag_nconvoca number)
   IS

   v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(32000);


   ln_procitem           number;
   ln_monto              number;
   ln_unmcodigo          number;
   ln_cantidad           number(15,2);
   v_des_item            varchar2(500);
   v_nivel5              char(8);


   BEGIN


   v_xml              := ag_trama_items;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);

   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);
   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');
 
 
   
FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
   v_n := xmldom.item(v_nl, cur_emp);


   ln_procitem  := xslprocessor.valueOf(v_n,'item');
 
 --  ln_monto     := TO_NUMBER(xslprocessor.valueOf(v_n,'mon'), '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' );
 --  ln_monto     := to_number(replace(xslprocessor.valueOf(v_n,'mon'), '.', ','));
 ----inicio SM-189-2018-SGFS
--- ln_monto     :=  TO_NUMBER (replace(xslprocessor.valueOf(v_n,'mon'), ',','.'), '99999999999.99');
 	 ln_monto     :=  TO_NUMBER (replace(xslprocessor.valueOf(v_n,'mon'), ',','.'), '99999999999999999999.99');
 ----fin SM-189-2018-SGFS
   ln_unmcodigo := xslprocessor.valueOf(v_n,'unc');
 
 --  ln_cantidad  := xslprocessor.valueof(v_n,'can');
     ln_cantidad     :=  TO_NUMBER (replace(xslprocessor.valueOf(v_n,'can'), ',','.'), '99999999999.99');
    
 
   v_des_item   := xslprocessor.valueof(v_n,'desitem');
 
   if v_des_item <> '-' then
      v_nivel5     := xslprocessor.valueof(v_n,'niv5');
   end if;
   
  INSERT INTO reg_procesos.item_contrato
          (n_cod_contrato,
           n_convoca,
           proc_item,
           monto,
           unm_codigo,
           cantidad,
           nivel5)
  VALUES ( ag_ncodcontrato,
           reg_procesos.f_get_max_n_convoca(ag_nconvoca),
           ln_procitem,
       --  ln_monto,
       ---    TO_NUMBER (replace(ln_monto, ',','.'), '99999999999.99'),    ----SM-189-2018-SGFS
			  TO_NUMBER (replace(ln_monto, ',','.'), '99999999999999999999.99'),   ---SM-189-2018-SGFS
           ln_unmcodigo,
           ln_cantidad,
           v_nivel5);


END LOOP;

xmldom.freeDocument(v_doc);


END;
PROCEDURE usp_registra_items_v3(ag_trama_items varchar2, ag_ncodcontrato number, ag_nconvoca number)
   IS

   v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(32000);


   ln_procitem           number;
   ln_monto              number;
   ln_unmcodigo          number;
   ln_cd_item            number;
   ln_cantidad           number(15,2);
   ln_sc                number;
   ln_mc                number;
   v_clase              char(2);
   v_grupo              char(2);
   v_familia            char(2);
   v_item               char(6);
   v_nivel5             char(8);
   v_dep                char(2);
   v_pro                char(2);
   v_dis                char(2);
   v_comodity           char(6);
   v_cod                number;
   v_pub                number;
   v_des                varchar2(500);
   v_des_item            varchar2(500);


   BEGIN


   v_xml              := ag_trama_items;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);

   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);
   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');


FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
   v_n := xmldom.item(v_nl, cur_emp);


  
   ln_procitem  := xslprocessor.valueOf(v_n,'item');
  
  -- ln_monto     :=TO_NUMBER(xslprocessor.valueOf(v_n,'mon'), '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' );
  -- ln_monto     := to_number(replace(xslprocessor.valueOf(v_n,'mon'), '.', ','));
  -- ln_monto     :=  TO_NUMBER (replace(xslprocessor.valueOf(v_n,'mon'), ',','.'), '99999999999.99');     -----SM-189-2018-SGFS
     ln_monto     :=  TO_NUMBER (replace(xslprocessor.valueOf(v_n,'mon'), ',','.'), '99999999999999999999.99');	-----SM-189-2018-SGFS
  
   ln_unmcodigo := xslprocessor.valueOf(v_n,'unc');
  
  -- ln_cantidad  := xslprocessor.valueOf(v_n,'can');
     ln_cantidad  :=  TO_NUMBER (replace(xslprocessor.valueOf(v_n,'can'), ',','.'), '99999999999.99');
  
  
    ln_sc  := xslprocessor.valueOf(v_n,'sc');
  
   ln_mc  := xslprocessor.valueof(v_n,'mc');
  
   v_des_item   := xslprocessor.valueof(v_n,'desitem');
  

  select ic.descripcion, trim(ic.clase_bien), trim(ic.grupo_bien), trim(ic.familia_bien), trim(ic.commodity_bien),trim( ic.nivel5), trim(ic.dep_codigo), trim(ic.pro_codigo), trim(ic.dis_codigo), trim(ic.tipo_bien), ic.n_id_item, ic.n_id_pub_con
  into v_des, v_clase, v_grupo, v_familia, v_comodity, v_nivel5, v_dep, v_pro, v_dis, v_item, v_cod, v_pub
  from REG_PROCESOS.item_convoca ic
  where ic.n_convoca = ag_nconvoca
  and ic.proc_item =ln_procitem;
  
   if v_des_item <> '-' then
      v_nivel5     := xslprocessor.valueof(v_n,'niv5');
      ln_cd_item   := xslprocessor.valueof(v_n,'cditem');
      v_cod := ln_cd_item;
      
        select trim(ic.clase_bien), trim(ic.grupo_bien), trim(ic.familia_bien), trim(ic.commodity_bien),trim( ic.nivel5), trim(ic.tipo_bien)
        into v_clase, v_grupo, v_familia, v_comodity, v_nivel5, v_item
        from reg_procesos.item_convoca_detalle ic
        where ic.n_convoca = ag_nconvoca
        and ic.proc_item =ln_procitem
        and ic.nivel5=v_nivel5
        and rownum = 1;        
   end if;

  INSERT INTO reg_procesos.item_contrato
          (n_cod_contrato,
           n_convoca,
           proc_item,
           monto,
           unm_codigo,
           cantidad,
           cod_sc,
           cod_mc,
           clase_bien,
           grupo_bien,
           familia_bien,
           item_bien,
           nivel5,
           dep_codigo,
           pro_codigo,
           dis_codigo,
           c_desc,
           COMMODITY_BIEN,
           N_ID_ITEM,
           N_ID_PUB_CON
           )
  VALUES ( ag_ncodcontrato,
           reg_procesos.f_get_max_n_convoca(ag_nconvoca),
           ln_procitem,
    --     ln_monto,
   ----    TO_NUMBER (replace(ln_monto, ',','.'), '99999999999.99'),   ---SM-189-2018-SGFS
		   TO_NUMBER (replace(ln_monto, ',','.'), '99999999999999999999.99'),    ---SM-189-2018-SGFS 
           ln_unmcodigo,
    --     ln_cantidad,
           TO_NUMBER (replace(ln_cantidad, ',','.'), '99999999999.99'), 
           case when to_number(ln_sc)=9999 then null else to_number(ln_sc) end,
           case when to_number(ln_mc)= 9999 then null else to_number(ln_mc)end,
           v_clase,
           v_grupo,
           v_familia,
           v_item,
           v_nivel5,
           v_dep,
           v_pro,
           v_dis,
           v_des,
           v_comodity,
           v_cod,
           v_pub
           );


END LOOP;

xmldom.freeDocument(v_doc);


END;


/******************************************************************************/
 PROCEDURE uspprocesarinsertcontrato (
   session__USERID                 VARCHAR2,
    session__n_convoca              VARCHAR2,
    session__anhoentidad            VARCHAR2,     
    session__eue_codigo             VARCHAR2,
    ag_trama_calendario             VARCHAR2,       
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
    ag_cod_tipo_contrato            VARCHAR2,
    ag_ruc_destino_pago             VARCHAR2,
    ag_anho_enti_pagadora           VARCHAR2,
    ag_cod_enti_pagadora            VARCHAR2,
    pfiletoupload1                   VARCHAR2,
    ag_trama_items                  VARCHAR2,
    ag_trama_items_xml              VARCHAR2, 
    ag_fec_aprob                    VARCHAR2,
    doc_obs                         VARCHAR2,
    SizeFile                    varchar2,
    iisenv__remote_host             VARCHAR2,
    WriteFileDirectoryDynamic       VARCHAR2,
    ag_nom_destino_pago             VARCHAR2,
     pfiletoupload_file1              VARCHAR2
 )
 IS
    lb_validacion_rnp               BOOLEAN;
    lv_estado_rnp                   VARCHAR2(500);

    ln_ind_consorcio                NUMBER;
    lv_codtipofile                  VARCHAR2(20);
    ln_cod_contrato                 NUMBER;
    row_convocatoria_propuesta      reg_procesos.convocatoria_propuesta%rowtype;
    ld_fecha_cons                   DATE;
    lv_nom_contratista              reg_procesos.convocatoria_propuesta.nom_postor%type;
    ln_proc_tipo                    number;
    
     v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(32000);
   cantidad  number;



   BEGIN


    select proc_Tipo  into  ln_proc_tipo from convocatorias where n_convoca = session__n_convoca;

    reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' var _error = 0; ');

    -- Validamos la Fecha de consentimiento a nivel de Item --

    IF NOT f_valida_fconsentimiento(ag_trama_items,session__n_convoca,ag_f_contrato) THEN
         f_msg_pantalla('La Fecha del Contrato no puede ser anterior a la Fecha de Consentimiento','''doNewContrato''');
         reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' _error = 1; ');
         return;
    END IF;

    -- Correo q indica que no deberian validarse el RNp a los CE
    ------------------------- VALIDA RNP DE CONTRATISTA Y CONSORCIOS -------------------------
    if ( substr(ag_ruc_contratista,1,1) not in ('7','I')  /*or ln_proc_tipo <> 23*/ )then

        lb_validacion_rnp :=F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, session__n_convoca,ag_f_contrato, lv_estado_rnp);


        IF NOT lb_validacion_rnp THEN
           f_msg_pantalla(lv_estado_rnp,'''doNewContrato''');
           reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' _error = 1; ');
           return;
        END IF;

    END IF;

    BEGIN
        SELECT nom_postor INTO lv_nom_contratista FROM reg_procesos.convocatoria_propuesta pro WHERE pro.ruc_postor = ag_ruc_contratista and pro.n_convoca = session__n_convoca;
    EXCEPTION
        when others then
             f_msg_error('Error: Al intentar hallar el nombre del Contratista','''doNewContrato''');
             return;
    END;


    -- Indicador de consorcio --
    BEGIN
        select ind_consorcio into ln_ind_consorcio from reg_procesos.convocatoria_propuesta where ruc_postor = ag_ruc_contratista and n_convoca = session__n_convoca;
    EXCEPTION
        when others then
             f_msg_error('Error al intentar hallar el indicador de Consorcio','''doNewContrato''');
             return;
    END;


   ------------------------- Obtiene el tipo de archivo -------------------------------------

   BEGIN
        --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
        select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
   EXCEPTION
        when others then
             f_msg_error('Error: Al intentar hallar el tipo de documento','''doNewContrato''');
             return;
   END;

   ------------------------- Fin de Obtiene el tipo de archivo ------------------------------

   select * into row_convocatoria_propuesta from reg_procesos.convocatoria_propuesta where n_convoca  = session__n_convoca and ruc_postor = ag_ruc_contratista;


   -- Cargamos la trama de Items
  -- usp_print( ag_trama_items);

   -- Verificamos que se hayan seleccionado al menos un item tambien se valida la fecha de BP por item
  
  
   v_xml              := ag_trama_items;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);

   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);
   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');
      
   cantidad:= xmldom.getLength(v_nl);

  if cantidad = 0 then
  usp_print('
  
  
      <script language=javascript>
                   
                  alert("Por favor ingrese Items");
                  goSubmit("doNewContrato",'''')
          
          
      </script>');
      end if;
      
      usp_print(' <script language=javascript>
       try{
          validaFechaContratoBp("xmlItems","'||ag_f_contrato||'")
              }catch(err){}
</script>
');

/*
usp_print('<br>ln_cod_contrato'||ln_cod_contrato);
usp_print('<br>session__n_convoca'||session__n_convoca);
usp_print('<br>ag_des_contrato'||ag_des_contrato);
usp_print('<br>ag_ciu_ccodigo'||ag_ciu_ccodigo);
usp_print('<br>ag_ciu_cespecial'||ag_ciu_cespecial);
usp_print('<br>TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24)'||TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24));
usp_print('<br>ag_codmoneda_contrato'||ag_codmoneda_contrato);
usp_print('<br> ag_m_contratado'||TO_NUMBER (replace(ag_m_contratado,',','.') ,'999999999999999.99'));
usp_print('<br>ag_cod_sist_adquisicion'||ag_cod_sist_adquisicion);
usp_print('<br>ag_cod_modalidad_finan'||ag_cod_modalidad_finan);
usp_print('<br>ag_cod_modalidad_alcance'||ag_cod_modalidad_alcance);
usp_print('<br>ag_codmoneda_contrato'||ag_codmoneda_contrato);
usp_print('<br>ag_costo_final'||TO_NUMBER (replace(ag_costo_final,',','.'),'999999999999999.99'));
usp_print('<br>ag_observaciones'||ag_observaciones);
usp_print('<br>ag_n_contrato'||ag_n_contrato);
usp_print('<br> TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24)'|| TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24));
usp_print('<br>TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24)'||TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24));
usp_print('<br>ag_n_propuesta'||ag_n_propuesta);
usp_print('<br>ln_ind_consorcio'||ln_ind_consorcio);
usp_print('<br>ag_cod_tipo_contrato'||ag_cod_tipo_contrato);
usp_print('<br>session__eue_codigo'||LPAD (session__eue_codigo, 6, '0'));
usp_print('<br>session__anhoentidad'||session__anhoentidad);
usp_print('<br>ag_cod_enti_pagadora'||ag_cod_enti_pagadora);
usp_print('<br>ag_anho_enti_pagadora'||ag_anho_enti_pagadora);
usp_print('<br>row_convocatoria_propuesta.cod_tipo_postor'||row_convocatoria_propuesta.cod_tipo_postor);
usp_print('<br>session__USERID'||session__USERID);
usp_print('<br>iisenv__remote_host'||iisenv__remote_host);
usp_print('<br>ag_ruc_destino_pago'||ag_ruc_destino_pago);
usp_print('<br>lv_nom_contratista'||lv_nom_contratista);
usp_print('<br>ag_ruc_destino_pago'||ag_ruc_destino_pago);
usp_print('<br>ag_nom_destino_pago'||ag_nom_destino_pago);
*/
                  
----inicio SM-189-2018-SGFS
--- IF TO_NUMBER(ag_m_contratado, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' ) > 0 THEN BEGIN
 IF TO_NUMBER(ag_m_contratado, '999999999999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' ) > 0 THEN BEGIN
----fin SM-189-2018-SGFS
      SELECT reg_procesos.s_contrato.NEXTVAL INTO ln_cod_contrato FROM DUAL;

      INSERT INTO reg_procesos.contrato
                  (n_cod_contrato,
                   n_convoca,
                   des_contrato,
                   ciu_ccodigo,
                   ciu_cespecial,
                   f_contrato,
                   codmoneda_contrato,
                   m_contratado,
                   cod_situacion,
                   cod_sist_adquisicion,
                   cod_modalidad_finan,
                   cod_modalidad_alcance,
                   mon_codigo,
                   costo_final,
                   observaciones,
                   n_contrato,
                   f_vigencia_ini,
                   f_vigencia_fin,
                   n_propuesta,
                   ind_consorcio,
                   cod_tipo_contrato,
                   codconsucode,
                   anhoentidad,
                   codconsucode_paga,
                   anhoentidad_paga,
                   cod_tipo_postor,
                   usu_Creacion,
                   ip_creacion,
                   IND_CONTRATO_PUB,
                   IND_VERSION,
                   ruc_contratista,
                   nom_contratista,
                   ruc_destino_pago,
                   nom_destino_pago
                  )
           VALUES (ln_cod_contrato,
                   session__n_convoca,
                   ag_des_contrato,
                   ag_ciu_ccodigo,
                   ag_ciu_cespecial,
                   TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   ag_codmoneda_contrato,
                 --  DECODE (ag_m_contratado,' ',NULL,TO_NUMBER (replace(ag_m_contratado,',','.') ,'999999999999999.99')),
                   --DECODE (ag_m_contratado,' ',NULL,TO_NUMBER(ag_m_contratado, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' )),
                   decode(ag_m_contratado, ' ', null, to_number(replace(ag_m_contratado, '.', ','))),
                   1,
                   ag_cod_sist_adquisicion,
                   ag_cod_modalidad_finan,
                   ag_cod_modalidad_alcance,
                   ag_codmoneda_contrato,
                --   DECODE (ag_costo_final,' ', NULL,TO_NUMBER (replace(ag_costo_final,',','.'),'999999999999999.99')),
              --     DECODE (ag_costo_final,' ',NULL,TO_NUMBER(ag_costo_final, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' )),
                decode(ag_costo_final, ' ', null, to_number(replace(ag_costo_final, '.', ','))),
                   ag_observaciones,
                   ag_n_contrato,
                   TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                   ag_n_propuesta,
                   ln_ind_consorcio,
                   ag_cod_tipo_contrato,
                   LPAD (session__eue_codigo, 6, '0'),
                   session__anhoentidad,
                   ag_cod_enti_pagadora,
                   ag_anho_enti_pagadora,
                   row_convocatoria_propuesta.cod_tipo_postor,
                   session__USERID,
                   iisenv__remote_host,
                   0,
                   1,
                   /*ag_ruc_contratista*/ag_ruc_destino_pago,
                   lv_nom_contratista,
                   ag_ruc_destino_pago,
                   ag_nom_destino_pago
                  );

   EXCEPTION
      WHEN OTHERS THEN
         f_msg_error('Error: Al intentar registrar el Contrato','''doNewContrato''');
         return;
   END;

   BEGIN
  
          
        PKU_GESTOR_CONT_UTILES_2.p_insUploadContrato(
              reg_procesos.f_get_min_n_convoca(session__N_CONVOCA),
              TO_DATE (ag_fec_aprob,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
              doc_obs,
              lv_codtipofile,
              pfiletoupload_file1,
              SizeFile,
              session__userid,
              iisenv__remote_host,
              WriteFileDirectoryDynamic                       ,
              ln_cod_contrato);


              
   EXCEPTION
      WHEN OTHERS THEN
           f_msg_error('Error: Al intentar registrar el Documento del Contrato','''doNewContrato''');
           return;

   END;


   BEGIN
      -- registro de items
      usp_registra_items(ag_trama_items,ln_cod_contrato,session__N_CONVOCA);


   EXCEPTION
      WHEN OTHERS THEN
           f_msg_error('Error: Al intentar registrar los Items del Contrato','''doNewContrato''');
           return;
   END;


   BEGIN
       --------- Actualiza Calendario --------
       if ag_trama_calendario is not null then
          usp_registra_calendario(ag_trama_calendario,PK_CONVOCATORIA.gn_id_operacion);
          
       end if;

   EXCEPTION
      WHEN OTHERS THEN
          f_msg_error('Error: Al intentar registrar el Calendario de Pagos','''doNewContrato''');
          return;
   END;


  BEGIN
     UPDATE reg_procesos.contrato  SET id_operacion = reg_procesos.pk_convocatoria.getidoperacion() WHERE n_cod_contrato = ln_cod_contrato;
     UPDATE CONTRATO_OPERACION SET CONTRATO_OPERACION.Usuario_Transfer = session__USERID WHERE CONTRATO_OPERACION.id_operacion = reg_procesos.pk_convocatoria.getidoperacion() ;
  EXCEPTION
      WHEN OTHERS THEN
         f_msg_error('Error: Al intentar registrar el Contrato','''doNewContrato''');
         return;
  END;

   usp_print('<input type=hidden value ='||ln_cod_contrato||' name=ag_cod_contrato id=ag_cod_contrato>');
   usp_print('<script language="javascript">');

   IF PKU_GESTOR_CONT_UTILES_2.f_get_tipo_validos(session__N_CONVOCA) > 0 AND PKU_SS_GARANTIAS.f_valida_inicio(session__N_CONVOCA) > 0  THEN
     usp_print('
      alert("Antes de publicar el contrato debe seleccionar \nel submenu Garantias para declarar la \naplicacion o no del requisito Garantias");
      ');
   END IF;

   usp_print('thisform.scriptdo.value = ''doEditContrato'';
                   if ( _error !=1 )
                         thisform.submit();

             </script>');

 ELSE

         usp_print('<input type=hidden value ='||ln_cod_contrato||' name=ag_cod_contrato id=ag_cod_contrato>');
         usp_print('<script language="javascript">
                            alert("El monto del contrato no puede ser 0");
                            goSubmit("doNewContrato",document.all(''scriptdo''))
                   </script>');

 END IF;

END;


 PROCEDURE uspmancontratosdoedit (
      session__n_convoca         VARCHAR2,
      session__eue_codigo        VARCHAR2,
      session__anhoentidad       VARCHAR2,
      session__cod_moneda        VARCHAR2,
      session__FileSingedHTTP    VARCHAR2,
      ag_des_contrato            VARCHAR2,
      ag_cod_contrato            VARCHAR2,
      ag_n_contrato              VARCHAR2,
      ag_cod_tipo_contrato       VARCHAR2,
      ag_n_propuesta             VARCHAR2,
      ag_cod_sist_adquisicion    VARCHAR2,
      ag_cod_modalidad_alcance   VARCHAR2,
      ag_observaciones           VARCHAR2,
      ag_trama_calendario        VARCHAR2
 )
 IS



      CURSOR C_contrato(p_cod_contrato varchar2) is
      SELECT c.n_cod_contrato,
             c.n_convoca,
             c.n_item,
             c.des_contrato,
             c.ciu_ccodigo,
             c.ciu_cespecial,
             c.ruc_contratista,
             c.ruc_destino_pago,
             c.nom_destino_pago,
             TO_CHAR (c.f_contrato, reg_procesos.pku_ss_constantes.gv_formato_fecha)     f_contrato,
             c.codmoneda_contrato,
             c.m_contratado ,
             c.cod_situacion,
             c.cod_causa_resoucion,
             TO_CHAR (c.f_liquidacion, reg_procesos.pku_ss_constantes.gv_formato_fecha) f_liquidacion,
             c.fec_intervencion,
             c.cod_sist_adquisicion,
             c.cod_modalidad_finan,
             c.cod_modalidad_alcance,
             c.plazo_real,
             c.mon_codigo,
             m.mon_desc,
             TO_CHAR (c.costo_final, reg_procesos.pku_ss_constantes.gv_formato_dinero) costo_final,
             c.cod_sancion,
             c.penalidad,
             c.cod_ejec_garantias,
             c.observaciones,
             c.n_contrato,
             c.codconsucode,
             TO_CHAR (c.f_vigencia_ini, reg_procesos.pku_ss_constantes.gv_formato_fecha) f_vigencia_ini,
             TO_CHAR (c.f_vigencia_fin, reg_procesos.pku_ss_constantes.gv_formato_fecha) f_vigencia_fin,
             LPAD (c.n_convoca, 8, '0') n_convoca_pad,
             LPAD (c.n_cod_contrato, 8, '0') n_cod_contrato_pad,
             TRIM (nom_contratista) nom_contratista,
             ind_consorcio,
             n_propuesta,
             cod_tipo_contrato,
             cod_tipo_postor,
             cod_pais_destino_pago,
             des_pais,
             conv.cod_tipo_modalidad,
             c.id_operacion,
             c.codconsucode_paga,
             c.anhoentidad_paga
     FROM
             reg_procesos.contrato c
             left outer join  reg_procesos.convocatorias conv on c.n_convoca = conv.n_convoca
             left outer join sease.moneda m on  c.mon_codigo = m.mon_codigo
        LEFT OUTER JOIN reg_procesos.t_pais tp  ON tp.cod_pais = c.cod_pais_destino_pago
         where c.n_cod_contrato = p_cod_contrato;


      -- datos del contrato por editar
      lv_des_contrato                reg_procesos.contrato.des_contrato%TYPE;
      lv_ruc_destino_pago            reg_procesos.contrato.ruc_destino_pago%TYPE;
      lv_nom_destino_pago            reg_procesos.contrato.nom_destino_pago%TYPE;
      lv_f_contrato                  VARCHAR2 (35);
      ln_codmoneda_contrato          reg_procesos.contrato.codmoneda_contrato%TYPE;
      lf_m_contratado                VARCHAR2 (35);
      lv_f_liquidacion               VARCHAR2 (35);
      lv_f_intervencion              VARCHAR2 (35);
      ln_cod_sist_adquisicion        reg_procesos.contrato.cod_sist_adquisicion%TYPE;
      ln_cod_modalidad_alcance_res   reg_procesos.contrato.cod_modalidad_alcance%TYPE;
      lv_observaciones               reg_procesos.contrato.observaciones%TYPE;
      ln_n_contrato                  reg_procesos.contrato.n_contrato%TYPE;
      lv_f_vigencia_ini              VARCHAR2 (35);
      lv_f_vigencia_fin              VARCHAR2 (35);
      ln_n_propuesta                 reg_procesos.contrato.n_propuesta%TYPE;
      lv_ruc_contratista             reg_procesos.convocatoria_propuesta.ruc_postor%TYPE;
      ln_id_operacion                reg_procesos.contrato_operacion.id_operacion%TYPE;
      ln_cod_tipo_contrato           reg_procesos.contrato.cod_tipo_contrato%TYPE;

      -- Garantias
      ln_v_garantias_declaradas      NUMBER;
      ln_v_declaracion               NUMBER;
      ln_v_tipos_validos             NUMBER;
      ln_v_rango                     NUMBER;

       -- Cursores
      crucscontrato                  ref_cursor;
      ctipocontrato                  ref_cursor;
      cmodalidadalcance              ref_cursor;
      csistemaadquisicion            ref_cursor;
      cmoneda                        ref_cursor;
      cmiembros_consorcio            ref_cursor;

       -- datos de la entidad pagadora
      lv_codconsucode_paga           reg_procesos.contrato_tipo_entidad.codconsucode_paga%TYPE;
      lv_anhoenidad_paga             reg_procesos.contrato_tipo_entidad.anhoentidad_paga%TYPE;
      lv_descentidad_paga            sease.entidades.descripcion%TYPE;
      ln_cont_paga                   NUMBER;

      --  Variables combos
      lv_combo_rucs                  VARCHAR2(20000);
      lv_combo_tipocontrato          VARCHAR2(4000);
      lv_combo_moneda                VARCHAR2(4000);
      lv_combo_modalidad_alcance     VARCHAR2(4000);
      lv_combo_sistemaadquisicion    VARCHAR2(4000);

      -- variables de los datos del upload
      ln_NCOD_DOC                    NUMBER;
      lv_DOC_URL                     VARCHAR2(250);
      lv_FEC_UPLOAD                  VARCHAR2(20);
      lv_USER_UPLOAD                 VARCHAR2(30);
      lv_FEC_APROB                   VARCHAR2(20);
      lv_EXT_TIPO_FILE               VARCHAR2(250);
      lv_ICON_TIPO_FILE              VARCHAR2(250);
      lv_DOC_OBS                     VARCHAR2(250);
      lv_cod_contrato                VARCHAR2(8);

      -- Datos de los items
      ln_items_resueltos             NUMBER;
      ln_items_en_ejecucion          NUMBER;

      -- Datos de fechas del contrato
      ld_fec_contrato                DATE;
      ld_fec_culimnacion             DATE;
      -- Varialbles
      lv_estado_contrato             VARCHAR2 (200);
      lv_trama_calendario            VARCHAR2(18000);
      LN_INDPUB_CONTRATO             NUMBER;
      lv_ruta_file                   VARCHAR2(1250);

      -- Garantias
      ln_proc_tipo                   NUMBER;
      ln_valida_inicio               NUMBER;
      ln_app                         number; 
      
      -- Consorcios
      ln_ind_consorcio               NUMBER;
      ls_ruc_miembro                 VARCHAR2(11);
      ls_nom_miembro                 VARCHAR2(150);
      temp                           varchar2(100);
       lv_anho_convocatoria           NUMBER;
        ln_tipo_modalidad              NUMBER;
      LN_NORMATIVA_P                 VARCHAR2 (30);--MANTENIMIENTO 84-2018
      LN_PROV_EXTRANJ_SRNP_P     	 VARCHAR2 (500);--MANTENIMIENTO 84-2018
----INICIO  SM-224-2018-SGFS-2018/SGFS
    lb_validacion_rnp               BOOLEAN;
    lv_estado_rnp                   VARCHAR2(500);
----FIN  SM-224-2018-SGFS-2018/SGFS

 BEGIN 

           SELECT nvl(anhoentidad, anho_convoca),nvl(COD_TIPO_MODALIDAD,0) INTO lv_anho_convocatoria,ln_tipo_modalidad FROM reg_procesos.convocatorias WHERE n_convoca = session__N_CONVOCA;
 
  
      pku_gestor_cont_funciones_js_2.fvalidacadenas_js; --SEGUN MEMORANDO N 312-2016/SGFS-SM 054-2016
      PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos; 
--      sp_javascript_contratos_ficha;
      PKU_GESTOR_CONT_FUNCIONES_JS_2.sp_javascript_contratos_update;
--      sp_javascript_valida_ruc;
      PKU_GESTOR_CONT_FUNCIONES_JS_2.fOperacionesPagina;

    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlGeneral;
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlContratos(session__anhoentidad,lpad(session__eue_codigo,6,'0'),session__N_CONVOCA );
    PKU_GESTOR_CONT_FUNCIONES_JS_2.fFechasGeneral;

    -- Vemos si esta publicado el contrato
    LN_INDPUB_CONTRATO         := PKU_GESTOR_CONT_UTILES_2.f_get_indPubContrato(ag_cod_contrato);


    -- Trama del Calendario
    lv_trama_calendario     := nvl(ag_trama_calendario,PKU_GESTOR_CONT_UTILES_2.f_getXmlCalContrato(ag_cod_contrato));
     --lv_trama_calendario := nvl(ag_trama_calendario,PKU_SS_UTILES3.f_getXmlCalAdionReduc(f_get_id_operacion(ag_cod_contrato)));

    ln_v_garantias_declaradas  := REG_PROCESOS.Pku_Ss_Garantias.f_valida_declaracion(ag_cod_contrato);
    ln_v_declaracion           := REG_PROCESOS.Pku_Ss_Garantias.f_existe_declaracion(ag_cod_contrato);
    ln_v_tipos_validos         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_tipo_validos(session__N_CONVOCA);
    ln_v_rango                 := reg_procesos.Pku_Ss_Garantias.f_valida_inicio(session__N_CONVOCA);

      -- inicializamos variables de sesion
    usp_print ('<SESSION_EXPORT>
                       <COD_CONTRATO>'||ag_cod_contrato||'</COD_CONTRATO>
                       <PUBLICADO>'||LN_INDPUB_CONTRATO||'</PUBLICADO>
                </SESSION_EXPORT>');

    -- datos del contrato
    For xrow in C_contrato(ag_cod_contrato) loop
        lv_des_contrato               := xrow.des_contrato;
        ln_n_contrato                 := xrow.n_contrato;
        ln_n_propuesta                := xrow.n_propuesta;
        lv_ruc_destino_pago           := xrow.ruc_destino_pago;
        lv_nom_destino_pago           := xrow.nom_destino_pago;
        lv_f_contrato                 := xrow.f_contrato;
        lv_f_vigencia_ini             := xrow.f_vigencia_ini;
        lv_f_vigencia_fin             := xrow.f_vigencia_fin;
        ln_codmoneda_contrato         := xrow.codmoneda_contrato;
        ln_cod_sist_adquisicion       := xrow.cod_sist_adquisicion;
        ln_cod_modalidad_alcance_res  := xrow.cod_modalidad_alcance;
        lv_f_liquidacion              := xrow.f_liquidacion;
        lv_f_intervencion             := xrow.fec_intervencion;
        lf_m_contratado               := xrow.m_contratado;
        ln_id_operacion               := xrow.id_operacion;
        lv_observaciones              := xrow.observaciones;
        ln_cod_tipo_contrato          := xrow.cod_tipo_contrato;
      --  lv_ruc_contratista            := xrow.ruc_contratista;
    End loop;

    -- Inicializacion de Cursores
    ctipocontrato                   := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_ctipo_contrato;
    crucscontrato                   := f_crucs_contrato (session__N_CONVOCA);
    cmodalidadalcance               := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_ctipo_mod_alcance;
    csistemaadquisicion             := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_csistema_finance;
    cmoneda                         := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cmonedas;
    cmiembros_consorcio             := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_cMiembros_postor(ln_n_propuesta);


    -- Inicializamos los combos
    lv_combo_tipocontrato       := f_retorna_combo(ctipocontrato, 'ag_cod_tipo_contrato', nvl(ag_cod_tipo_contrato,ln_cod_tipo_contrato),null,null);
    lv_combo_rucs               := f_retorna_combo(crucscontrato, 'ag_n_propuesta_', nvl(ag_n_propuesta,ln_n_propuesta),'--- Seleccionar ---','style="width:339px;" onchange="cargaRUC(''doEditContrato'');" disabled="disabled">');
    lv_combo_modalidad_alcance  := f_retorna_combo(cmodalidadalcance, 'ag_cod_modalidad_alcance', NVL (ag_cod_modalidad_alcance, ln_cod_modalidad_alcance_res),'--- Seleccionar ---','style="width:339px;"');
    lv_combo_sistemaadquisicion := f_retorna_combo(csistemaadquisicion, 'ag_cod_sist_adquisicion', NVL (ag_cod_sist_adquisicion, ln_cod_sist_adquisicion),'--- Seleccionar ---','style="width:339px;"');
    lv_combo_moneda             := f_retorna_combo(cmoneda, 'ag_codmoneda_contrato_sel', ln_codmoneda_contrato,null,'disabled="true" style="width:114px;"');

    -- datos del upload del contrato
    REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.P_last_upload_contrato( ag_cod_contrato, session__N_CONVOCA, ln_NCOD_DOC,lv_DOC_URL,lv_FEC_UPLOAD ,lv_USER_UPLOAD,lv_FEC_APROB ,lv_EXT_TIPO_FILE,lv_ICON_TIPO_FILE, lv_DOC_OBS );

    -- datos de la entidad q paga
    reg_procesos.PKU_GESTOR_CONT_UTILES_2.p_entidad_pagadora (session__eue_codigo, session__anhoentidad,1,ln_cont_paga,lv_codconsucode_paga,  lv_anhoenidad_paga, lv_descentidad_paga  );
    lv_ruta_file                := gpk_directorio_liquidacion||'\'||session__anhoentidad||'\'||session__eue_codigo||'\'||session__N_CONVOCA;

   -- Estado de los items del contrato
   ln_items_resueltos         := f_get_cantitemsresueltos (ag_cod_contrato);
   ln_items_en_ejecucion      := f_get_cantitemsenejecucion (ag_cod_contrato);
   usp_fechasprorroga (ag_cod_contrato,ld_fec_contrato,ld_fec_culimnacion);


   lv_estado_contrato :=
      f_get_estadocontrato (ld_fec_contrato,
                            ld_fec_culimnacion,
                            TO_DATE (lv_f_liquidacion,reg_procesos.pku_ss_constantes.gv_formato_fecha),
                            TO_DATE (lv_f_intervencion,reg_procesos.pku_ss_constantes.gv_formato_fecha),
                            ln_items_resueltos,
                            ln_items_en_ejecucion
                           );

--   select ind_consorcio into ln_ind_consorcio from reg_procesos.convocatoria_propuesta where ruc_postor = lv_ruc_contratista and n_convoca = session__n_convoca;

 
  

   select c.ruc_postor, c.ind_consorcio into lv_ruc_contratista ,ln_ind_consorcio from reg_procesos.convocatoria_propuesta c where c.n_propuesta = nvl(ag_n_propuesta,ln_n_propuesta);
   
 	LN_NORMATIVA_P:='SN';  --MANTENIMIENTO 84-2018
	LN_PROV_EXTRANJ_SRNP_P:='NO_EXTRANJERO_SNRP'; --MANTENIMIENTO 84-2018
 	USP_PRINT('<input type="hidden" name="V_LN_NORMATIVA_P"   value="'||LN_NORMATIVA_P||'"></input>');--MANTENIMIENTO 84-2018 
 	USP_PRINT('<input type="hidden" name="V_LN_PROV_EXTRANJ_SRNP_P"   value="'||LN_PROV_EXTRANJ_SRNP_P||'"></input>');--MANTENIMIENTO 84-2018
  ----INICIO  SM-224-2018-SGFS-2018/SGFS
	lb_validacion_rnp :=f_valida_inhab_contrato(lv_ruc_contratista, session__n_convoca,lv_f_contrato, lv_estado_rnp);

	USP_PRINT('<input type="hidden" name="V_LV_ESTADO_RNP"   value="'||TO_CHAR(lv_estado_rnp)||'"></input>');
  ----FIN  SM-224-2018-SGFS-2018/SGFS    
   usp_print('<input type="hidden" name="ag_item_publicar"           value="N"/>'); --SM 321-2019 tchacon
   usp_print('<input type="hidden" name="v_calendario_total"         value=""/>');
   usp_print('<input type="hidden" name="ag_trama_items"             value=""/>');
   usp_print('<input type="hidden" name="ag_trama_items_xml"         value=""/>');
   usp_print('<input type="hidden" name="ag_n_convoca"               value="'||session__n_convoca||'"/>');
   usp_print('<input type="hidden" name="WriteFileDirectory"         value="FileSinged">');
   usp_print('<input type="hidden" name="WriteFileDirectoryDynamic"  value="'||lv_ruta_file||'"></input>
   <input type="hidden" name="SizeFile"></input>
   ');

   -- Nombre de contratista
   usp_print('<input type="hidden" name="ag_ruc_contratista"         value="'||lv_ruc_contratista||'" >');
              usp_print('<input type="hidden" name="ag_nom_contratista"         value="'||reg_procesos.F_WS_RNP_GET_RAZON_SOCIAL(lv_ruc_contratista)||'">');
              --usp_print('<input type="hidden" name="ag_nom_contratista"         value="'||reg_procesos.F_WS_SUNAT_GET_RAZON_SOCIAL(lv_ruc_contratista)||'">');
   -- Moneda del contrato
   usp_print('<input type="hidden" name="ag_codmoneda_contrato"      value="'||ln_codmoneda_contrato||'"  >');
   usp_print('<input type="hidden" name="ag_cod_contrato"            value="'||ag_cod_contrato||'"  >');
   usp_print('<input type="hidden" name="ag_id_operacion"            value="'||ln_id_operacion||'"  >');
   usp_print('<input type="hidden" name="ag_n_propuesta"             value="'||ln_n_propuesta||'"  >');
   -- Garantias 
   usp_print('<input type="hidden" name="ag_v_garantias_decla"       value="'||ln_v_garantias_declaradas||'"  >');
   usp_print('<input type="hidden" name="ag_v_declaracion"           value="'||ln_v_declaracion||'"  >');
   usp_print('<input type="hidden" name="ag_v_tipos_validos"         value="'||ln_v_tipos_validos||'"  >');
   usp_print('<input type="hidden" name="ag_v_rango"                 value="'||ln_v_rango||'"  >');
   usp_print('<input type="hidden" name="ag_tipo_modalidad"           value="'||ln_tipo_modalidad||'"/>'); 

          
   usp_print ('
        <table border="0" cellpadding="0" cellspacing="0" width="100%" > 
        <tr>
            <td>'||REG_PROCESOS.PKU_PROCESOS_COMUN.f_get_titulo(session__N_CONVOCA, 'Modificar Contrato') ||'</td>
            <td align=right valign="top">
              <input type=button value="Volver" name="btnVolver" onclick="thisform.scriptdo.value=''doViewConsolaContratos'';thisform.submit();">');

               IF nvl(LN_INDPUB_CONTRATO,0) = 0 THEN 
                  --usp_print('<input type=button value="Eliminar" name="btnGuardar" onclick="thisform.scriptdo.value=''usp_eliminar_contrato'';thisform.submit();">');
                  --usp_print('<input type=button value="Guardar" onclick="Grabar('||PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__N_CONVOCA)||',''xmlItems'',''ag_trama_items'');">');

                  select proc_tipo into ln_proc_tipo from convocatorias where n_convoca = session__n_convoca;
                  ln_valida_inicio := pku_ss_garantias.f_valida_inicio(session__N_CONVOCA) ;

                  select count(1) into ln_app from GARANTIA_DECLARACION d INNER JOIN REG_PROCESOS.GARANTIA_CLASE cl on d.cod_clase = cl.cod_clase   left outer join reg_procesos.garantia_razon ra on d.cod_razon = ra.cod_razon     where d.n_cod_contrato  = ag_cod_contrato;

/* 13*09*2020 se desabilita la opcion pubicar contrato*/
                 -- if ( ln_proc_tipo in (11,23,40) or ln_valida_inicio = 0 or ( ln_app > 0 and ln_valida_inicio = 1 and PKU_SS_GARANTIAS.f_valida_declaracion(ag_cod_contrato) = 0 ) ) then
                 --     usp_print('<input type=button value="Publicar Contrato3" name="btnPublicar" onclick="Publicar();">');
                 -- end if;

               END IF;
               
               
               
   usp_print('</td>
        </tr>
        </table>');


         
   usp_print('<table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">
        <tr><td colspan="3"><h3>Datos del Contrato</h3></td></tr> 
         
       ');

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Entidad Contratante',
                '<b>'||lv_descentidad_paga||'</b>',
                'Entidad encargada de efectuar el pago.'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Descripci&oacute;n del contrato/Orden de Compra o Servicio',
                '<input type=text value="'|| NVL (TRIM (ag_des_contrato), lv_des_contrato) ||'" name="ag_des_contrato" size="54">',
                '&nbsp;Descripcin del contrato/Orden de Compra o Servicio'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('N&uacute;mero de Contrato u Orden de Compra o Servicio:',
                lv_combo_tipocontrato
                ||'&nbsp;<input size=30 maxlength="250" name="ag_n_contrato" value="'||NVL (ag_n_contrato, ln_n_contrato)|| '">',
                '&nbsp;N&uacute;mero de Contrato u Orden de Compra o Servicio'));


   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Ruc o Codigo de Proveedor Extranjero no Domiciliado del Contratista:',
                lv_combo_rucs,
                '&nbsp;Seleccione el Contratista'));

  IF ln_ind_consorcio = 1 THEN

       usp_print
         ('<tr>
              <td class=c1>&nbsp;</td>
              <td class=c2><b>Miembros del Consorcio:</b><BR>');

              usp_print('<table>');

      LOOP
      FETCH cmiembros_consorcio INTO ls_ruc_miembro, ls_nom_miembro;
      EXIT WHEN cmiembros_consorcio%NOTFOUND;
             usp_print
               ('<tr>
                    <td>'||ls_ruc_miembro||'&nbsp; - &nbsp;'||ls_nom_miembro||'</td>
                </tr>');
      END LOOP;
      CLOSE cmiembros_consorcio;
              usp_print('</table>');
      usp_print('</td>
              <td class=c3>&nbsp;</td>
          </tr>');

  END IF;

  --IF   lv_ruc_destino_pago  is null THEN  temp := lv_ruc_contratista ELSE  temp := lv_ruc_destino_pago  END IF
  


   usp_print('<tr>
            <td class=c1>RUC Destinatario de Pago</td>
            <td class=c2><input name="ag_ruc_destino_pago" id=ag_ruc_destino_pago size="54" readOnly="true" value="'|| lv_ruc_destino_pago  ||'" style="background:#e9f4fe"  ></td>
            <td class=c3>&nbsp;N&uacute;mero RUC del Destinatario de Pago</td>
        </tr>
        <tr>
            <td class=c1>Destinatario del pago: </td>
            <td class=c2><div id=divnombre style="border:0px solid #008000"></div></td>
            <td class=c3>&nbsp;Nombre del destinatario del Pago</td>
        </tr>
        <tr>
            <td class=c1>(*)Fecha de Suscripci&oacute;n del Contrato/notificaci&oacute;n de la Orden de Compra o Servicio:</td>
            <td class=c2><div class="input-group datepicker" id="idDivTxtFechaContrato">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
<input  type=text data-format="dd/MM/yyyy" class="form-control" name="ag_f_contrato" readOnly  value="'||lv_f_contrato||'">
           
        </div> 
            </td>
            <td class=c3>&nbsp;Fecha de Suscripcion del Contrato/notificaci&oacute;n de la Orden de Compra o Servicio</td>
      </tr>'
        );
        
        


   usp_print
     ('<tr>
           <td class=c1>(*)Vigencia del contrato:</td>
           <td class=c2>Inicio:
           <div class="input-group datepicker" id="idDivTxtFechaIni">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
           <input type=text size=16 readOnly="true" name="ag_f_vigencia_ini" data-format="dd/MM/yyyy" class="form-control" value="'||lv_f_vigencia_ini||'">
           </div>Fin:
          <div class="input-group datepicker" id="idDivTxtFechaFin">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div>
           <input  type=text size=17 readOnly="true" name="ag_f_vigencia_fin" data-format="dd/MM/yyyy" class="form-control" value="'||lv_f_vigencia_fin||'">
          </div>
           </td>
           <td class=c3>&nbsp;Vigencia del Contrato original</td>.
      </tr>');

   usp_print
       ('<tr>
           <td class=c1>(*)Monto Contratado:</td>
           <td class=c2>'||lv_combo_moneda||' <input value="" readOnly="true"  size="34" type="text"  name="ag_m_contratado" id="ag_m_contratado" onkeyup="validarInputNumDecimal(this)"></td>
           <td class=c3>&nbsp;Monto Contratado</td>
        </tr>
        <tr>
          <td class=c1>(*)Situaci&oacute;n: </td>
          <td class=c2><input value="'||lv_estado_contrato||'" class="InpReadOnly" size="54" type="text" readonly name="agdestpago"/></td>
          <td class=c3>&nbsp;Estado Actual del Contrato</td>
        </tr>');

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Sistema de Contrataci&oacute;n:',
                lv_combo_sistemaadquisicion,
                '&nbsp;Sistema de Contrataci&oacute;n'));

   -- Modalidad de financiamiento
   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Modalidad de ejecuci&oacute;n contractual:',
                lv_combo_modalidad_alcance,
                '&nbsp;Modalidad de ejecuci&oacute;n contractual'));

   usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
                '<input type=text name="ag_observaciones" id="ag_observaciones" value="'|| NVL (ag_observaciones, lv_observaciones)||'" size="54">',
                '&nbsp;Observaciones del Contrato'));

   usp_print('</table>');

 --  DATOS DEL UPLOAD
  usp_print
       ('<table border="0" cellpadding="3" cellspacing="0" width="100%" class="table table-striped">
            <tr><td colspan=3><h3>Registro de Contrato/Orden de Compra o Servicio</h3></td></tr>
            <tr><td colspan=3 class=c1b>&nbsp;</td></tr>');

  select count(n_cod_contrato) INTO lv_cod_contrato from REG_PROCESOS.CONVOCATORIA_DOC
  WHERE n_convoca=session__N_CONVOCA and cod_tipo_doc=600; 
      
usp_print( '<tr><td width=35%>(*)Adjuntar ArchivoOOO</td><td width=35%>    
<input type="file" id="pfiletoupload1"  name="pfiletoupload1" class="form-control" size="41"  value="">'
|| case when lv_cod_contrato > 0  then 
'<br><a target=_blank href="'||url_azure_app||replace(lv_DOC_URL,' ','%20')||'">
<img src="'||lv_ICON_TIPO_FILE||'" border="0" width="25" height="25"/></a>'  
else
'<br>          
<a target=_blank href="http://'||reg_procesos.f_get_conexiones(10)||replace(lv_DOC_URL,' ','%20')||'">
<img src="'||lv_ICON_TIPO_FILE||'" border="0" width="25" height="25"/></a>'     
end || case when lv_FEC_UPLOAD is not null then ' Registrado el '||lv_FEC_UPLOAD end 
||'<input type="hidden" name="pfiletoupload_file1" value=""/></td>
<td width=30%>Seleccione el archivo que contiene el Contrato/Orden de Compra o Servicio, solo se permiten archivos *.doc o *.pdf</td></tr>');
  
  usp_print(
          PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha del Documento de Contrato',
              '<div class="input-group datepicker" id="idDivTxtFechaDoc">
        <div class="input-group-addon add-on">
        <span class="glyphicon glyphicon-calendar"></span>
</div><input readonly name="ag_fec_aprob" data-format="dd/MM/yyyy" class="form-control" value="'||lv_FEC_APROB||'"></div>',
              'Seleccione la fecha de aprobacion del documento.'));

  usp_print(
          PKU_PROCESOS_COMUN.f_putRowForm('Observaciones:',
              '<input size="54" type="text" name="doc_obs" value="'||lv_DOC_OBS||'">',
              '&nbsp;Ingrese las Observaciones'));

  usp_print ('</table>');
  usp_print ('</td></tr>');

  
    usp_print('
         <script language="javascript" event=onchange for=ag_ruc_destino_pago>
                 divnombre.innerHTML = "";
                 callconsor(this.value,"'||session__n_convoca||'");
         </script>
 
        <script language="javascript">
               callconsor(thisform.ag_ruc_destino_pago.value,"'||session__n_convoca||'");
        </script>

     ');


 IF reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__n_convoca) = 1 THEN
 
   -----------------  Calendario de pagos ------------
      usp_print('
      <tr>
      <td></br>
      <table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">
      <tr><td colspan="3"><h3>Calendario de pagos</h3></td></tr>');
      usp_print('<tr><td width=33% ></td>
      <td width=33%>
      <table border=1 width=100%  align=center cellpadding=3 cellspacing=0>
      <thead> <tr style=''background-color: #BDBDBD;color:#111111''>
      <td width=20% >Nro. de pago</td>
      <td width=30% >Fecha de pago</td>
      <td width=30% > <div id=''dv_tot_val_item''></div></td>
      <td width=20% >Operación</td></tr>
      <tr><td width=10%><input type=hidden name=v_ind_modificar value=0 /><input type=hidden value="" name="v_item" /></td>
      <td align=center width=20%><div class="input-group datepicker" id="idDivTxtFechaPago"> <div class="input-group-addon add-on">
      <span class="glyphicon glyphicon-calendar"></span></div>
      <input   name="ag_cal_fec_pago" data-format="dd/MM/yyyy" class="form-control" align=center readOnly=true/></div></td>
      <td align=center width=20%><input name=ag_cal_monto_pago  type=text onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this)"  /></td>
      <td align=center width=10%><input type=button name=it_b_agregar  value=''Agregar''></td>
      </tr></thead>
      ');
      usp_print('<tr><td colspan=4><div id="divCalendario">&nbsp;</div></td></tr>');
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.fXmlCalendario(session__cod_moneda,replace(lv_trama_calendario, ',', '.'),'v_calendario_total');
      usp_print('</table></td><td width=34% ></td></tr>');

    
    usp_print('
           
        
        <script language="javascript" event="onclick" for="it_b_agregar">
        AdicionarCalendario(thisform.ag_cal_fec_pago.value, thisform.ag_cal_monto_pago.value);
      
    </script>
        ');

    
 END IF;
 
  

 


 usp_print('
         <table border="0" cellpadding="0" cellspacing="0" width="100%" class="table table-striped">
         <tr><td><h3>Items del Contrato</h3></td></tr>
         <tr>
            <td align="center">
                <input type="button" value="Agregar Nuevo Item al Contrato"  OnClick="AdicionarElemento(thisform.ag_proc_item.value,thisform.ag_f_bp_cons.value,thisform.ag_ubigeo.value,thisform.ag_descripcion.value,thisform.ag_monto.value,thisform.ag_unidad.value,thisform.ag_cantidad.value,thisform.ag_unidad_codigo.value,thisform.ag_itempaq_desc.value,thisform.ag_nivel5_cod.value,'||session__eue_codigo||','||session__anhoentidad||','||session__n_convoca||' );"></input>
            </td>
         </tr>
         <tr><td>&nbsp;</td></tr>
         <tr>
            <td>');
            
             usp_print('<div id="divLista">&nbsp;</div>');
  
  
    -- Trama de Items
    begin

     if ag_n_propuesta  = ln_n_propuesta or ag_n_propuesta is null then
        PKU_GESTOR_CONT_UTILES_2.usp_XmlItemsManContrato(ag_cod_contrato,session__N_CONVOCA, ln_n_propuesta);
     else
        PKU_GESTOR_CONT_UTILES_2.usp_XmlItemsNewContrato(ag_n_propuesta,session__n_convoca,session__EUE_CODIGO);
     end if;

      usp_print('<script language=javascript>thisform.ag_m_contratado.value =   sumaTotalesItems("xmlItems") </script>');


        EXCEPTION
        when others then

             f_msg_error('Error: Al intentar hallar los items del contrato','''doView''');
             return;
    end;



        usp_print ('</table>');

        usp_print ('</td></tr>');
        usp_print ('</table>');

        reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script('
         
           if(thisform.ag_tipo_modalidad.value == 1 || thisform.ag_tipo_modalidad.value == 3 ){
                  $("#ag_monto").removeAttr("readOnly", false); //colocar readonly
                  $("#ag_cantidad").removeAttr("readOnly", false);
            }

       ');




 END;


PROCEDURE uspprocesar_pub_contrato (
   session__cod_contrato            NUMBER,
   session__n_convoca               VARCHAR2,
   ag_id_operacion                  VARCHAR2,
   session__userid                  VARCHAR2,
   iisenv__remote_host              VARCHAR2

  )
  IS

  ln_indsiaf                       NUMBER;

  BEGIN


  -- Verifica el indicador del SIAF
  ln_indsiaf := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__n_convoca);

      UPDATE REG_PROCESOS.CONTRATO
         SET IND_CONTRATO_PUB = 1 ,
             f_publica = sysdate
       WHERE N_COD_CONTRATO = session__cod_contrato;

  IF ln_indsiaf = 1 THEN

    reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion(ag_id_operacion);

    UPDATE CONTRATO_OPERACION
       SET CONTRATO_OPERACION.Usuario_Transfer = session__userid,
           CONTRATO_OPERACION.IP_CREACION      = iisenv__remote_host
     WHERE CONTRATO_OPERACION.id_operacion     = ag_id_operacion; --reg_procesos.pk_convocatoria.getidoperacion;

  END IF;

  COMMIT;

  usp_print('<input type=hidden name=ag_n_convoca value ='||session__n_convoca||'>');

  usp_print('<script language="javascript">
                     thisform.scriptdo.value = "doViewConsolaContratos";
                     thisform.submit();
             </script>');



  END;



      PROCEDURE uspprocesarupdatecontrato(
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
    /*  ag_costo_final                  VARCHAR2,*/
      ag_observaciones                VARCHAR2,
      ag_n_contrato                   VARCHAR2,
      ag_f_vigencia_ini               VARCHAR2,
      ag_f_vigencia_fin               VARCHAR2,
      ag_n_propuesta                  VARCHAR2,
      ag_nom_contratista              VARCHAR2,
      ag_ruc_destino_pago             VARCHAR2,
      ag_cod_tipo_contrato            VARCHAR2,
      ag_id_operacion                 VARCHAR2,
      pfiletoupload1                   VARCHAR2,
      ag_fec_aprob                    VARCHAR2,
      doc_obs                         VARCHAR2,
      SizeFile             VARCHAR2,
      iisenv__remote_host             VARCHAR2,
      WriteFileDirectoryDynamic       VARCHAR2,
      ag_trama_items              VARCHAR2,
      ag_trama_calendario             VARCHAR2,
      ag_nom_destino_pago             VARCHAR2,
      pfiletoupload_file1              VARCHAR2
   )
   IS

    lb_validacion_rnp               BOOLEAN;
    lv_estado_rnp                   VARCHAR2(500);
   -- Upload
   lvtipodocumento                    VARCHAR2(50);
   lv_codtipofile                     VARCHAR2(20);
   ln_indsiaf                         NUMBER;
   row_convocatoria_propuesta         reg_procesos.convocatoria_propuesta%rowtype;
   ld_fecha_cons                   DATE;
   ln_proc_tipo                    number;

   BEGIN

    select proc_Tipo  into  ln_proc_tipo from convocatorias where n_convoca = session__n_convoca;

    reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' var _error = 0; ');

   -- Validamos la Fecha de consentimiento a nivel de Item --

    IF NOT f_valida_fconsentimiento(ag_trama_items,session__n_convoca,ag_f_contrato) THEN
             f_msg_pantalla('La Fecha del Contrato no puede ser anterior a la Fecha de Consentimiento','''doNewContrato''');
             reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' _error = 1; ');
             return;
    END IF;


        -- Correo q indica que no deberian validarse el RNp a los CE
    if  ( substr(ag_ruc_contratista,1,1) not in ('7','I')  )then

        lb_validacion_rnp :=F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, session__n_convoca,ag_f_contrato, lv_estado_rnp);


        IF NOT lb_validacion_rnp THEN
           f_msg_pantalla(lv_estado_rnp,'''doNewContrato''');
           reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' _error = 1; ');
           return;
        END IF;

    end if;



    usp_print('
    <CENTER>
        <TABLE border="0">
            <TR>
                <TD COLSPAN="3" class=c1>
                    <div id="divEsperar" style="border:0px solid #008000"><img src="img/circle_working.gif"></div>
                </TD>
            </TR>
        </TABLE>
    </CENTER> ');

    select *  into row_convocatoria_propuesta from reg_procesos.convocatoria_propuesta where ruc_postor = ag_ruc_contratista and n_convoca = session__n_convoca;





    BEGIN
          UPDATE reg_procesos.contrato
             SET des_contrato            = TRIM (ag_des_contrato),
                 ciu_ccodigo             = TRIM (ag_ciu_ccodigo),
                 ciu_cespecial           = ag_ciu_cespecial,
                 ruc_contratista         = ag_ruc_contratista,
                 f_contrato              = TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 codmoneda_contrato      = ag_codmoneda_contrato,
                 --m_contratado            =  DECODE (ag_m_contratado,' ',NULL,TO_NUMBER(ag_m_contratado, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' )),
                 m_contratado= decode(ag_m_contratado, ' ', null, to_number(replace(ag_m_contratado, '.', ','))),
                 --DECODE (ag_m_contratado,' ', NULL,TO_NUMBER (replace(ag_m_contratado,',','.'),'999999999999999.99')),
                 cod_sist_adquisicion    = ag_cod_sist_adquisicion,
                 cod_modalidad_finan     = ag_cod_modalidad_finan,
                 cod_modalidad_alcance   = ag_cod_modalidad_alcance,
                 mon_codigo              = ag_codmoneda_contrato,
              --   costo_final             = DECODE (ag_costo_final,' ', NULL,TO_NUMBER (ag_costo_final, '999999999999999.99')),
                 observaciones           = ag_observaciones,
                 n_contrato              = ag_n_contrato,
                 f_vigencia_ini          = TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 f_vigencia_fin          = TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 n_propuesta             = ag_n_propuesta,
                nom_contratista         = NVL(reg_procesos.F_WS_RNP_GET_RAZON_SOCIAL(ruc_contratista),ag_nom_destino_pago),
                 ind_consorcio           = row_convocatoria_propuesta.ind_consorcio,
                 cod_tipo_contrato       = ag_cod_tipo_contrato,
                 ruc_destino_pago        = ag_ruc_destino_pago,
                 nom_destino_pago        = NVL(reg_procesos.F_WS_GET_RAZSOC_ALL(ag_ruc_destino_pago),ag_nom_destino_pago),
                 cod_tipo_postor         = row_convocatoria_propuesta.cod_tipo_postor

             WHERE n_cod_contrato        = session__cod_contrato;

         EXCEPTION
            WHEN OTHERS THEN
               f_msg_error('Error al intentar Actualizar el Contrato','''doEditContrato''');
               RETURN;
    END;


    BEGIN

    IF pfiletoupload_file1 IS NOT NULL THEN

        lvtipodocumento:=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
        select cod_tipo_file into lv_codtipofile from Reg_procesos.tipo_archivo where ext_tipo_file=lvtipodocumento;

    END IF;

    EXCEPTION
            WHEN OTHERS THEN
               f_msg_error('Error al intentar hallar el tipo de Archivo','''doEditContrato''');
               RETURN;
    END;




    BEGIN
    
    usp_print('session__n_convoca: ' || reg_procesos.f_get_min_n_convoca(session__n_convoca) ||' ');
    usp_print('ag_fec_aprob: ' || TO_DATE (ag_fec_aprob,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24) ||' ');
    usp_print('doc_obs: ' || doc_obs ||' ');
    usp_print('lv_codtipofile: ' || lv_codtipofile ||' ');
    usp_print('pfiletoupload_file1: ' || pfiletoupload_file1 ||' ');
    
    IF pfiletoupload_file1 IS NOT NULL THEN
         PKU_GESTOR_CONT_UTILES_2.p_insUploadContrato(
                    reg_procesos.f_get_min_n_convoca(session__n_convoca),
                     TO_DATE (ag_fec_aprob,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                    doc_obs,
                    lv_codtipofile,
                    pfiletoupload_file1,
                    SizeFile,
                    session__userid,
                    iisenv__remote_host,
                    WriteFileDirectoryDynamic,
                    session__cod_contrato);
    END IF;

       EXCEPTION
          WHEN OTHERS THEN
             f_msg_error('Error al intentar Actualizar el Resumen del Contrato','''doEditContrato''');

    END;


    -- borramos los items anteriores

    DELETE  reg_procesos.item_contrato s  WHERE s.n_cod_contrato = session__cod_contrato;

    -- Insertamos los items del calendario y items del contrato

    usp_registra_items(ag_trama_items,session__cod_contrato,session__n_convoca);
    ln_indsiaf := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__n_convoca);

    -----------------Inserta Calendario---------------------
    IF ln_indsiaf = 1 THEN
         usp_registra_calendario(ag_trama_calendario,ag_id_operacion);
    END IF;

   -- Memo 245 2010 - Garantias
 IF PKU_GESTOR_CONT_UTILES_2.f_get_tipo_validos(session__N_CONVOCA) > 0 AND PKU_SS_GARANTIAS.f_valida_inicio(session__N_CONVOCA) > 0  THEN
     reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script('
      alert("Antes de publicar el contrato debe seleccionar \nel submenu Garantias para declarar la \naplicacion o no del requisito de Garantias");
      ');
   END IF;

   -- Fin Memo 245 2010 - Garantias

    usp_print('<input type=hidden value ='||session__cod_contrato||' name=ag_cod_contrato id=ag_cod_contrato>');
    usp_print('<script language="javascript">
                     thisform.scriptdo.value = "doEditContrato";
                     if ( _error !=1 ) thisform.submit();
               </script>');

   END;

PROCEDURE uspprocesarupdatecontrato_v3(
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
    /*  ag_costo_final                  VARCHAR2,*/
      ag_observaciones                VARCHAR2,
      ag_n_contrato                   VARCHAR2,
      ag_f_vigencia_ini               VARCHAR2,
      ag_f_vigencia_fin               VARCHAR2,
      ag_n_propuesta                  VARCHAR2,
      ag_nom_contratista              VARCHAR2,
      ag_ruc_destino_pago             VARCHAR2,
      ag_cod_tipo_contrato            VARCHAR2,
      ag_id_operacion                 VARCHAR2,
      pfiletoupload1                   VARCHAR2,
      ag_fec_aprob                    VARCHAR2,
      doc_obs                         VARCHAR2,
      SizeFile                         VARCHAR2,
      iisenv__remote_host             VARCHAR2,
      WriteFileDirectoryDynamic       VARCHAR2,
      ag_trama_items              VARCHAR2,
      ag_trama_calendario             VARCHAR2,
      ag_nom_destino_pago             VARCHAR2,
      pfiletoupload_file1              VARCHAR2,
       av_id_expede              VARCHAR2  DEFAULT NULL,
    av_id_proc                VARCHAR2  DEFAULT NULL,
    av_id_con_pub             VARCHAR2  DEFAULT NULL
   )
   IS

    lb_validacion_rnp               BOOLEAN;
    lv_estado_rnp                   VARCHAR2(500);
   -- Upload
   lvtipodocumento                    VARCHAR2(50);
   lv_codtipofile                     VARCHAR2(20);
   ln_indsiaf                         NUMBER;
   row_convocatoria_propuesta         reg_procesos.convocatoria_propuesta%rowtype;
   ld_fecha_cons                   DATE;
   ln_proc_tipo                    number;

   BEGIN

    select proc_Tipo  into  ln_proc_tipo from convocatorias where n_convoca = session__n_convoca;

    reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' var _error = 0; ');

   -- Validamos la Fecha de consentimiento a nivel de Item --

    IF NOT f_valida_fconsentimiento(ag_trama_items,session__n_convoca,ag_f_contrato) THEN
             f_msg_pantalla('La Fecha del Contrato no puede ser anterior a la Fecha de Consentimiento','''doNewContrato''');
             reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' _error = 1; ');
             return;
    END IF;


        -- Correo q indica que no deberian validarse el RNp a los CE
    if  ( substr(ag_ruc_contratista,1,1) not in ('7','I')  /*or ln_proc_tipo <> 23 */)then

        lb_validacion_rnp :=F_VALIDA_RNP_CONTRATO(ag_ruc_contratista, session__n_convoca,ag_f_contrato, lv_estado_rnp);


        IF NOT lb_validacion_rnp THEN
           f_msg_pantalla(lv_estado_rnp,'''doNewContrato''');
           reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script(' _error = 1; ');
           return;
        END IF;

    end if;





    usp_print('
    <CENTER>
        <TABLE border="0">
            <TR>
                <TD COLSPAN="3" class=c1>
                    <div id="divEsperar" style="border:0px solid #008000"><img src="img/circle_working.gif"></div>
                </TD>
            </TR>
        </TABLE>
    </CENTER> ');

    select *  into row_convocatoria_propuesta from reg_procesos.convocatoria_propuesta where ruc_postor = ag_ruc_contratista and n_convoca = session__n_convoca;


    BEGIN
    if av_id_proc is not null then
     usp_print('<input type="hidden" name="av_id_expede"           value="'||av_id_expede||'" id=av_id_expede/>');
 usp_print('<input type="hidden" name="av_id_proc"           value="'||av_id_proc||'" id=av_id_proc/>');
 usp_print('<input type="hidden" name="av_id_con_pub"           value="'||av_id_con_pub||'" id=av_id_con_pub/>');

          UPDATE reg_procesos.contrato
             SET des_contrato            = TRIM (ag_des_contrato),
                 --ciu_ccodigo             = TRIM (ag_ciu_ccodigo),
                 ciu_cespecial           = ag_ciu_cespecial,
                 ruc_contratista         = ag_ruc_contratista,
                 f_contrato              = TO_DATE (ag_f_contrato,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 codmoneda_contrato      = ag_codmoneda_contrato,
                 --m_contratado            =  DECODE (ag_m_contratado,' ',NULL,TO_NUMBER(ag_m_contratado, '999999999999.99',' NLS_NUMERIC_CHARACTERS = '',.''' )),
                    m_contratado= decode(ag_m_contratado, ' ', null, to_number(replace(ag_m_contratado, '.', ','))),
                 --DECODE (ag_m_contratado,' ', NULL,TO_NUMBER (replace(ag_m_contratado,',','.'),'999999999999999.99')),
                 cod_sist_adquisicion    = ag_cod_sist_adquisicion,
                 cod_modalidad_finan     = ag_cod_modalidad_finan,
                 cod_modalidad_alcance   = ag_cod_modalidad_alcance,
                 mon_codigo              = ag_codmoneda_contrato,
              --   costo_final             = DECODE (ag_costo_final,' ', NULL,TO_NUMBER (ag_costo_final, '999999999999999.99')),
                 observaciones           = ag_observaciones,
                 n_contrato              = ag_n_contrato,
                 f_vigencia_ini          = TO_DATE (ag_f_vigencia_ini,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 f_vigencia_fin          = TO_DATE (ag_f_vigencia_fin,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                 n_propuesta             = ag_n_propuesta,
                 nom_contratista         = NVL(reg_procesos.F_WS_RNP_GET_RAZON_SOCIAL(ruc_contratista),ag_nom_destino_pago),
                 ind_consorcio           = row_convocatoria_propuesta.ind_consorcio,
                 cod_tipo_contrato       = ag_cod_tipo_contrato,
                 ruc_destino_pago        = ag_ruc_destino_pago,
                 nom_destino_pago        = NVL(reg_procesos.F_WS_GET_RAZSOC_ALL(ag_ruc_destino_pago),ag_nom_destino_pago),
                 cod_tipo_postor         = row_convocatoria_propuesta.cod_tipo_postor,
                 n_indseacev3            = case when av_id_proc is null then n_indseacev3 else to_number(av_id_proc) end

             WHERE n_cod_contrato        = session__cod_contrato;
        else
        f_msg_error('Error al intentar Actualizar el Contrato','''doEditContrato''');
        return;
        end if;

         EXCEPTION
            WHEN OTHERS THEN
               f_msg_error('Error al intentar Actualizar el Contrato','''doEditContrato''');
               RETURN;
    END;

    BEGIN

    IF pfiletoupload_file1 IS NOT NULL THEN

        lvtipodocumento:=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
        select cod_tipo_file into lv_codtipofile from Reg_procesos.tipo_archivo where ext_tipo_file=lvtipodocumento;

    END IF;

    EXCEPTION
            WHEN OTHERS THEN
               f_msg_error('Error al intentar hallar el tipo de Archivo','''doEditContrato''');
               RETURN;
    END;


    BEGIN

    IF pfiletoupload_file1 IS NOT NULL THEN
         PKU_GESTOR_CONT_UTILES_2.p_insUploadContrato(
                    reg_procesos.f_get_min_n_convoca(session__n_convoca),
                    TO_DATE (ag_fec_aprob,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                    doc_obs,
                    lv_codtipofile,
                    pfiletoupload_file1,
                    SizeFile,
                    session__userid,
                    iisenv__remote_host,
                    WriteFileDirectoryDynamic,
                    session__cod_contrato);
    END IF;

       EXCEPTION
          WHEN OTHERS THEN
             f_msg_error('Error al intentar Actualizar el Resumen del Contrato','''doEditContrato''');

    END;


    -- borramos los items anteriores

    DELETE  reg_procesos.item_contrato s  WHERE s.n_cod_contrato = session__cod_contrato;

    -- Insertamos los items del calendario y items del contrato

    usp_registra_items_v3(ag_trama_items,session__cod_contrato,session__n_convoca);
    ln_indsiaf := reg_procesos.PKU_GESTOR_CONT_UTILES_2.f_get_indsiaf (session__n_convoca);

    -----------------Inserta Calendario---------------------
    IF ln_indsiaf = 1 THEN
         usp_registra_calendario(ag_trama_calendario,ag_id_operacion);
    END IF;

   -- Memo 245 2010 - Garantias
   IF PKU_GESTOR_CONT_UTILES_2.f_get_tipo_validos_v3(session__N_CONVOCA) > 0 AND PKU_SS_GARANTIAS.f_valida_inicio_v3(session__N_CONVOCA) > 0  THEN
     reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_2.js_script('
      alert("Antes de publicar el contrato debe seleccionar \nel submenu Garantias para declarar la \naplicacion o no del requisito de Garantias");
      ');
   END IF;

   -- Fin Memo 245 2010 - Garantias 

   
    usp_print('<input type=hidden value ='||session__cod_contrato||' name=ag_cod_contrato id=ag_cod_contrato>');
    
    usp_print('<script language="javascript">
                     thisform.scriptdo.value = "doEditContrato";
                     if ( _error !=1 ) 
                     thisform.submit();
               </script>');

   END;

END PKU_GESTOR_CONT_MOD_CONTRATOS;
/
