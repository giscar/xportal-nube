CREATE OR REPLACE PACKAGE "PKU_GESTOR_CONT_ADICIONALES"
  IS
--------------------------------------------------
  gv_PkName  varchar2(60) default 'PKU_SS_CONTRATOS_ADICIONAL';
  flag_actividad number:=0; 
  type ref_cursor is ref cursor;
  --------------------------------------------------
  gpk_eliminar       varchar2(200):='img/eliminar.gif';
  gpk_aceptar        varchar2(200):='img/iconprompttick.gif';
  gn_pagesize_contratos number:=20;
  gpk_directorio_adicred  varchar2(200):= 'mon\docs\contratos';--aramirez
   consucode  varchar2(30) :='';
  proveedor varchar2(30) :='';
  proceso varchar2(30) :='';
  nconvoca varchar2(30) :='';
  fcontra varchar2(30) :='';
  npropuesta number;
  session_cod_contrato number;
  lb_validacion_rnp2 boolean:=true;
  lb_estado_inha varchar2(500) :='';
  lb_error BOOLEAN:=false;
  
  
  FUNCTION f_valida_rnp_contrato(
         ag_ruc_contratista   IN VARCHAR2,
         ag_n_convoca         IN VARCHAR2,
         ag_f_contrato        IN VARCHAR2,
         ag_n_propuesta        IN NUMBER,
         ag_estado_rnp       OUT VARCHAR2
         ) return BOOLEAN;
  
  function f_get_emp_dets (vc_cod_contrato number )return emp_dets_nt;  
  FUNCTION f_cuenta_adired(ag_cod_contrato IN varchar2, ag_n_convoca IN varchar2) return number;
  
  FUNCTION f_get_desc_entidadAutoriza(ag_cod_entid_autoriza IN varchar2, p_anhoentidad IN varchar2 ) return varchar2;
  
  FUNCTION f_get_id_operacion(ag_cod_adicional IN number) return number;
  

  FUNCTION f_ind_uso_siaf(ag_cod_contrato IN varchar2) return number;
  
  FUNCTION f_ind_uso_siaf_modif(ag_cod_adicional IN varchar2) return number;
  
  FUNCTION f_maxitems(ag_cod_contrato IN varchar2) return number;
 
-----------------------------------------------------------------------------------------------------------------
----------- PROCEDURE USP_REGISTRA_ITEMS -----------
-----------------------------------------------------------------------------------------------------------------
 
   PROCEDURE usp_registra_items(
    ag_trama_items       VARCHAR2, 
    ag_cod_adicional     NUMBER, 
    ag_n_cod_contrato    NUMBER,
    ag_codmoneda         NUMBER);
     
   PROCEDURE uspLisAdicionalesDoView( 
      -- variables convenio marco
      ag_ncor_orden_pedido          VARCHAR2 DEFAULT '',
      ag_cm_opc                     VARCHAR2 DEFAULT '',
      ag_cm_oper_compra             VARCHAR2 DEFAULT '',
      --
      session__n_convoca            VARCHAR2,
      session__cod_contrato         VARCHAR2,
      session__PUBLICADO            varchar2
   );

   PROCEDURE uspnewadicionalitemdoedit (
      session__n_convoca      VARCHAR2 DEFAULT NULL,
      session__cod_contrato   VARCHAR2 DEFAULT NULL,
      ag_ind_adred               VARCHAR2, /* Tipo de operacion*/    
      ag_cant_items              VARCHAR2,        
      ag_cod_entid_autoriza      VARCHAR2,
      ag_trama_calendario        VARCHAR2,
      ag_nro_doc_cgr             VARCHAR2,
      ag_fec_doc_cgr             VARCHAR2,
      ag_nro_doc_adicional       VARCHAR2,
      ag_fec_doc_adicional       VARCHAR2,
      ag_descripcion             VARCHAR2,
      ag_tipo_doc_adicional      VARCHAR2,
      session__EUE_CODIGO        varchar2,          
      ag_proc_tipo               varchar2   

   );
      
   PROCEDURE uspadicionalreddoinsert (
      session__n_convoca           VARCHAR2 DEFAULT NULL,
      session__cod_contrato        VARCHAR2 DEFAULT NULL,
      ag_nro_doc_adicional            VARCHAR2,
      ag_tipo_doc_adicional           VARCHAR2,
      ag_cant_adicional               VARCHAR2,
      ag_unm_codigo_adicional         VARCHAR2,
      ag_monto_adicional              VARCHAR2,
      ag_codmoneda                    VARCHAR2,
      ag_fec_doc_adicional            VARCHAR2,
      ag_concepto_adicional           VARCHAR2,
      ag_nro_doc_cgr                  VARCHAR2,
      ag_fec_doc_cgr                  VARCHAR2,
      ag_ind_siaf                     VARCHAR2,
      -- de las valorizaciones objeto 3 y 4
      ag_num_comprobante_pago         VARCHAR2,
      ag_monto_bruto                  VARCHAR2,
      ag_monto_reajuste               VARCHAR2,
      ag_monto_amortizacion           VARCHAR2,
      ag_monto_deduccion              VARCHAR2,
      ag_monto_interes                VARCHAR2,
      ag_monto_otros                  VARCHAR2,
      ag_monto_neto                   VARCHAR2,
      ag_monto_igv                    VARCHAR2,
      ag_monto_total_pagado           VARCHAR2,
      ag_fec_valorizacion             VARCHAR2,
      ag_codmoneda_v                  VARCHAR2,
      ag_m_contratado                 VARCHAR2,
      -- indica que se modifico alguna fila para crear la reduccion
      ag_ncor_orden_pedido       IN   VARCHAR2 DEFAULT '',
      -- variables convenio marco
      ag_cm_opc                  IN   VARCHAR2 DEFAULT '',
      ag_cm_oper_compra          IN   VARCHAR2 DEFAULT '',
      -- variables para regresarlas al listado de Contratos
      ag_anhoentidad                  VARCHAR2 DEFAULT NULL,
      ag_proc_tipo                    VARCHAR2 DEFAULT NULL,
      ag_proc_desc                    VARCHAR2 DEFAULT NULL,
      ag_proc_sigla                   VARCHAR2 DEFAULT NULL,
      ag_currenpage                   VARCHAR2,
       --- para cargar archivo
       session__eue_codigo            VARCHAR2 DEFAULT NULL ,---JGARCIAF
       session__anhoentidad            VARCHAR2 DEFAULT NULL,---JGARCIAF
       pfiletoupload1             VARCHAR2,--jgarcia
      pfiletoupload_file1             VARCHAR2,--jgarcia
      SizeFile                        varchar2,--jgarcia
      session__USERID                 VARCHAR2,--jgarcia
      iisenv__remote_host             VARCHAR2,--jgarcia
      WriteFileDirectoryDynamic       VARCHAR2,--jgarcia
      ag_trama_items                  VARCHAR2 default null        
   );
   

     PROCEDURE uspadicionaladicdoinsert (
      ag_cod_contrato                VARCHAR2,
      ag_nro_doc_adicional           VARCHAR2,
      ag_tipo_doc_adicional          VARCHAR2,
      ag_monto_adicional             VARCHAR2,
      ag_codmoneda                   VARCHAR2,
      ag_fec_doc_adicional           VARCHAR2,
      ag_concepto_adicional          VARCHAR2,
      ag_nro_doc_cgr                 VARCHAR2,
      ag_fec_doc_cgr                 VARCHAR2,
      ag_ind_siaf                    VARCHAR2,
      -- argumentos de la valorizacion obj =3  o 4
      ag_num_comprobante_pago        VARCHAR2,
      ag_monto_bruto                 VARCHAR2,
      ag_monto_reajuste              VARCHAR2,
      ag_monto_amortizacion          VARCHAR2,
      ag_monto_deduccion             VARCHAR2,
      ag_monto_interes               VARCHAR2,
      ag_monto_otros                 VARCHAR2,
      ag_monto_neto                  VARCHAR2,
      ag_monto_igv                   VARCHAR2,
      ag_monto_total_pagado          VARCHAR2,
      ag_fec_valorizacion            VARCHAR2,
      ag_codmoneda_v                 VARCHAR2,
      ag_cod_entid_autoriza     IN   VARCHAR2 DEFAULT '',
      ag_descripcion                 VARCHAR2,
      ag_trama_calendario            VARCHAR2 default null,
      ag_trama_items                 VARCHAR2 default null,
      session__userid                varchar2,
      session__eue_codigo            VARCHAR2 DEFAULT NULL,
      ag_cod_objeto                  varchar2,
      ag_proc_tipo                   varchar2 ,
      ag_tipo_consultoria             number,
      --para cargar archivo
      session__n_convoca           VARCHAR2 DEFAULT NULL,---JGARCIAF
      session__anhoentidad            VARCHAR2 DEFAULT NULL,---JGARCIAF
      pfiletoupload1                  VARCHAR2,--jgarcia
      pfiletoupload_file1             VARCHAR2,--jgarcia
      SizeFile                        varchar2,--jgarcia
      iisenv__remote_host             VARCHAR2,--jgarcia
      WriteFileDirectoryDynamic       VARCHAR2--jgarcia
   );


  PROCEDURE uspAdicionalAdicDoUpdate
     ( 
       ag_n_convoca            varchar2,
       ag_cod_contrato         varchar2,
       ag_cod_adicional in varchar2 DEFAULT '', --vienen del editar
       ag_nro_doc_adicional    varchar2,
       ag_tipo_doc_adicional   varchar2,
       ag_cant_adicional       varchar2,
       ag_unm_codigo_adicional varchar2,
       ag_monto_adicional      varchar2,
       ag_codmoneda            varchar2,
       ag_fec_doc_adicional    varchar2,
       ag_concepto_adicional   varchar2,
       ag_nro_doc_cgr          varchar2,
       ag_fec_doc_cgr          varchar2,
       ag_ind_siaf             varchar2,
       -- argumentos de la valorizacion obj =3  o 4
       ag_cod_valorizacion varchar2,
        ag_num_comprobante_pago varchar2,
        ag_monto_bruto          varchar2,
        ag_monto_reajuste       varchar2,
        ag_monto_amortizacion   varchar2,
        ag_monto_deduccion      varchar2,
        ag_monto_interes       varchar2,
        ag_monto_otros varchar2,
        ag_monto_neto varchar2,
        ag_monto_igv varchar2,
        ag_monto_total_pagado varchar2,
        ag_fec_valorizacion varchar2,
        ag_codmoneda_v varchar2,
        ag_ncor_orden_pedido in varchar2 DEFAULT '', -- variables convenio marco
        ag_cm_opc in varchar2 DEFAULT '',
        ag_cm_oper_compra in varchar2 DEFAULT '',
        -- variables para regresarlas al listado de Contratos
        ag_anhoentidad            varchar2 DEFAULT Null,
        ag_descripcion            VARCHAR2,
        ag_trama_calendario            VARCHAR2 default null,
        ag_trama_items                 VARCHAR2 default null,
        session__userid                 VARCHAR2 default null,
        session__eue_codigo             VARCHAR2 default null,
        ag_cod_objeto                   VARCHAR2 default null);
        
   PROCEDURE uspmanadicionaldoedit (
      ag_n_convoca               IN   VARCHAR2 DEFAULT '',
      ag_cod_contrato            IN   VARCHAR2 DEFAULT '',
      ag_cod_adicional           IN   VARCHAR2 DEFAULT '', --vienen del editar
      ag_monto_adicional              VARCHAR2,
      ag_fec_doc_adicional            VARCHAR2,
      ag_nro_doc_adicional            VARCHAR2,
      ag_fec_doc_cgr                  VARCHAR2,                     -- del cgr
      ag_nro_doc_cgr                  VARCHAR2,                     -- del cgr
      ag_ncor_orden_pedido            VARCHAR2 DEFAULT '',
      ag_cm_opc                       VARCHAR2 DEFAULT '',
      ag_cm_oper_compra               VARCHAR2 DEFAULT '',
      session__cod_contrato           VARCHAR2,
      ag_trama_items                  VARCHAR2,
      ag_trama_calendario             VARCHAR2,
      session__n_convoca           VARCHAR2 DEFAULT NULL----jgarciaf
      );
  
 
    PROCEDURE usp_registra_calendario(ag_trama_calendario varchar2);
  
    PROCEDURE uspdonewadicionaledit (
      session__n_convoca           VARCHAR2 DEFAULT NULL,
      session__cod_contrato        VARCHAR2 DEFAULT NULL,
      ag_ind_adred               IN   VARCHAR2 DEFAULT '',
      ag_cgr                     IN   VARCHAR2 DEFAULT '',
      ag_muestra                      VARCHAR2 DEFAULT NULL,
      ag_ind_fecmod              IN   VARCHAR2 DEFAULT '',
      ag_ind_montomod            IN   VARCHAR2 DEFAULT '',
      ag_monto_adicional              VARCHAR2 DEFAULT NULL,
      monto_item                      VARCHAR2 DEFAULT NULL,
      ag_fec_doc_adicional            VARCHAR2 DEFAULT NULL,
      ag_tipo_doc_adicional           VARCHAR2 DEFAULT NULL,
      ag_nro_doc_adicional            VARCHAR2 DEFAULT NULL,
      ag_fec_doc_cgr                  VARCHAR2 DEFAULT NULL,        -- del cgr
      ag_nro_doc_cgr                  VARCHAR2 DEFAULT NULL,        -- del cgr
      ag_num_comprobante_pago         VARCHAR2 DEFAULT NULL,        -- valorizaciones
      ag_monto_bruto                  VARCHAR2 DEFAULT NULL,
      ag_monto_reajuste               VARCHAR2 DEFAULT NULL,
      ag_monto_amortizacion           VARCHAR2 DEFAULT NULL,
      ag_monto_deduccion              VARCHAR2 DEFAULT NULL,
      ag_monto_interes                VARCHAR2 DEFAULT NULL,
      ag_monto_otros                  VARCHAR2 DEFAULT NULL,
      ag_monto_neto                   VARCHAR2 DEFAULT NULL,
      ag_monto_igv                    VARCHAR2 DEFAULT NULL,
      ag_monto_total_pagado           VARCHAR2 DEFAULT NULL,
      ag_fec_valorizacion             VARCHAR2 DEFAULT NULL,
      ag_concepto_adicional           VARCHAR2 DEFAULT NULL,
      ag_ncor_orden_pedido       IN   VARCHAR2 DEFAULT '',
      -- variables convenio marco
      ag_cm_opc                  IN   VARCHAR2 DEFAULT '',
      ag_cm_oper_compra          IN   VARCHAR2 DEFAULT '',
      -- entidad que autoriza
      ag_cod_entid_autoriza      IN   VARCHAR2 DEFAULT '',
      -- variables para regresarlas al listado de Contratos
      ag_proc_tipo                    VARCHAR2 DEFAULT NULL,
      ln_total_adic                   NUMBER DEFAULT NULL,
      ag_trama_items                  VARCHAR2 DEFAULT NULL,
      session__eue_codigo             VARCHAR2 DEFAULT NULL,
      session__anhoentidad            VARCHAR2 DEFAULT NULL,
      ag_trama_calendario             VARCHAR2 DEFAULT NULL,
      ag_descripcion                  VARCHAR2 DEFAULT NULL,
         SizeFile                        varchar2--jgarcia
    
   );
   
  PROCEDURE uspadicionalreddoupdate (
      ag_n_convoca                   VARCHAR2,
      ag_cod_contrato                VARCHAR2,
      ag_cod_adicional          IN   VARCHAR2 DEFAULT '',  --vienen del editar
      ag_nro_doc_adicional           VARCHAR2,
      ag_tipo_doc_adicional          VARCHAR2,
      ag_cant_adicional              VARCHAR2,
      ag_ind_adred                   VARCHAR2,
      ag_unm_codigo_adicional        VARCHAR2,
      ag_monto_adicional             VARCHAR2,
      ag_codmoneda                   VARCHAR2,
      ag_fec_doc_adicional           VARCHAR2 DEFAULT null,
      ag_concepto_adicional          VARCHAR2,
      ag_nro_doc_cgr                 VARCHAR2,
      ag_fec_doc_cgr                 VARCHAR2,
      ag_cod_valorizacion            VARCHAR2,
      ag_ncor_orden_pedido      IN   VARCHAR2 DEFAULT '',
      -- variables convenio marco
      ag_cm_opc                 IN   VARCHAR2 DEFAULT '',
      ag_cm_oper_compra         IN   VARCHAR2 DEFAULT '',
      -- variables para regresarlas al listado de Contratos
      ag_anhoentidad                 VARCHAR2 DEFAULT NULL,
      ag_trama_items                 VARCHAR2
   );
   
   PROCEDURE uspmanreducciondoedit (
      session__n_convoca           VARCHAR2 DEFAULT NULL,
      session__cod_contrato        VARCHAR2 DEFAULT NULL,
      ag_cod_adicional           IN   VARCHAR2 DEFAULT '',
      ag_fec_doc_adicional            VARCHAR2 default null,
      ag_ncor_orden_pedido       IN   VARCHAR2 DEFAULT '',
      -- variables convenio marco
      ag_cm_opc                  IN   VARCHAR2 DEFAULT '',
      ag_cm_oper_compra          IN   VARCHAR2 DEFAULT '',
      -- variables para regresarlas al listado de Contratos
      ag_anhoentidad                  VARCHAR2 DEFAULT NULL,
      ag_trama_items                  VARCHAR2 DEFAULT NULL
   );
   
    procedure jscript_vigencia;
  procedure actualiza_vigencia(
v_codigo                VARCHAR2,
ag_f_vigencia_ini          VARCHAR2 DEFAULT NULL,
ag_f_vigencia_fin          VARCHAR2 DEFAULT NULL,
v_tipo                      NUMBER  
);
END;
/


CREATE OR REPLACE PACKAGE BODY                "PKU_GESTOR_CONT_ADICIONALES" 
IS


-- funcion para sacar el id_operacion cuando tengo el cod_adicional
   FUNCTION f_get_id_operacion (ag_cod_adicional IN NUMBER)
      RETURN NUMBER
   IS
      ln_id_operacion   NUMBER;
   BEGIN
      -- devuelve el objeto
      BEGIN
         SELECT DISTINCT a.id_operacion
                    INTO ln_id_operacion
                    FROM reg_procesos.contrato_operacion_calendario a,
                         reg_procesos.adicional_reduccion c
                   WHERE c.cod_adicional =  ag_cod_adicional
                     AND a.id_operacion = c.id_operacion;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ln_id_operacion := NULL;
      END;

      RETURN ln_id_operacion;
   END;

   --------------
  function f_get_emp_dets (vc_cod_contrato number )

    return emp_dets_nt
is
    return_value emp_dets_nt;
begin
    select  emp_dets(b.codconsucode,  a.ruc_contratista,t.tip_abrev, b.n_convoca,a.f_contrato,a.n_propuesta)
    bulk collect into return_value
       FROM REG_PROCESOS.contrato a
                join REG_PROCESOS.convocatorias b on a.n_convoca = b.n_convoca
                left outer join SEASE.tipo_proceso t on t.tip_codigo = b.proc_tipo
                left outer join REG_PROCESOS.t_tipo_subasta ts on b.cod_tipo_subasta = ts.cod_tipo_subasta
                left outer join REG_PROCESOS.objeto o on b.codobjeto = o.codobjeto
                left outer join REG_PROCESOS.monedas m on b.codmoneda = m.codmoneda
                left outer join REG_PROCESOS.monedas mo on a.mon_codigo = mo.codmoneda
              
            where a.n_cod_contrato = vc_cod_contrato;
    return return_value;
end;

------------ devuelve la descripcion de la entidad que autoriza el Adicional
   FUNCTION f_get_desc_entidadautoriza (
      ag_cod_entid_autoriza   IN   VARCHAR2,
      p_anhoentidad           IN   VARCHAR2
   )
      RETURN VARCHAR2
   IS
      ln_desc_ent_autoriza   VARCHAR2 (1000);
   BEGIN
      BEGIN
         SELECT DISTINCT (e.descripcion)
                    INTO ln_desc_ent_autoriza
                    FROM reg_procesos.entidades e
                   WHERE e.codconsucode = ag_cod_entid_autoriza
                     AND e.anhoentidad = p_anhoentidad;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ln_desc_ent_autoriza := UPPER ('La Entidad lo Autorizo');
      END;

      RETURN ln_desc_ent_autoriza;
   END;


   /*** nodename="maxitems" **********/
   FUNCTION f_maxitems (ag_cod_contrato IN VARCHAR2)
      RETURN NUMBER
   IS
      maxitems   NUMBER;
   BEGIN
      SELECT MAX (TRIM (TO_CHAR (c.proc_item, '99999999')))
        INTO maxitems
        FROM reg_procesos.item_contrato c
       WHERE c.n_cod_contrato = ag_cod_contrato;           -- {n_cod_contrato}

      RETURN maxitems;
   END;

-- para saber contar cuantos adicionales y reducciones se tiene en la lista
   FUNCTION f_cuenta_adired (
      ag_cod_contrato   IN   VARCHAR2,
      ag_n_convoca      IN   VARCHAR2
   )
      RETURN NUMBER
   IS
      total_lista_adred   NUMBER;
   BEGIN
      SELECT COUNT (1)
        INTO total_lista_adred
        FROM (SELECT DISTINCT co.n_convoca, a.ind_adicional_reduccion,
                              a.n_cod_contrato, a.cod_adicional,
                              a.nro_doc_adicional, ti.des_tipo_instrumento,
                              a.cant_adicional, u.unm_desc, a.monto_adicional,
                              m.descripcion,
                              TO_CHAR (a.fec_doc_adicional, 'dd/mm/yyyy' ) fec_doc_adicional,
                              a.concepto_adicional, a.cod_entid_autoriza
                         FROM reg_procesos.convocatorias co,
                              reg_procesos.contrato c,
                              sease.unidad_medida u,
                              reg_procesos.monedas m,
                              reg_procesos.adicional_reduccion a
                              LEFT OUTER JOIN reg_procesos.t_tipo_instrumento ti
                              ON (ti.cod_tipo_instrumento = a.tipo_doc_adicional  )
                        WHERE co.n_convoca = c.n_convoca
                          AND c.n_cod_contrato = a.n_cod_contrato
                          AND a.unm_codigo_adicional = u.unm_codigo
                          AND a.codmoneda = m.codmoneda
                          AND c.n_convoca = ag_n_convoca
                          AND a.n_cod_contrato = ag_cod_contrato);

      RETURN total_lista_adred;

   END;


         ------------------------------------------------------------------------------------------------
/* FUNCION QUE HACE LA VALIDADCION DEL CONTRATISTA O CONSORCIO ANTES DE  REGISTRAR EL ADICIONAL - REDUCCION INHABILITADO*/
------------------------------------------------------------------------------------------------
FUNCTION f_valida_rnp_contrato(
         ag_ruc_contratista   IN VARCHAR2,
         ag_n_convoca         IN VARCHAR2,
         ag_f_contrato        IN VARCHAR2,
         ag_n_propuesta       IN NUMBER,
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
      lv_ruc_postor          VARCHAR2(20);
      

BEGIN

   lv_n_convoca     := to_number(ag_n_convoca);
  select p.ruc_postor into lv_ruc_postor from reg_procesos.convocatoria_propuesta p where p.n_convoca = lv_n_convoca and  p.n_propuesta=ag_n_propuesta ;
  
  lv_ruc_consorcio := lv_ruc_postor;
  
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
        --cant :='ERROR'; comentario para inhabilitar la validacion del sistemas de rnp
              -- IF cant <> '1-OK' THEN
              IF substr(cant,1,1) = '2' THEN
                mensaje_inhabi := 'El Proveedor del Consorcio: '||' '||xrow.NOM_MIEMBRO||' '||' se encuentra inhabilitado, no es posible publicar el contrato.';
                LB_RETORNO := FALSE;
                lb_error:=false;
              END IF;

              IF UPPER(cant) LIKE '%ERROR%' THEN
                  mensaje_inhabi := 'Sistema externo no disponible, vuelva a intentar';
                  LB_RETORNO    := false;
                  lb_error :=true;
                    
              END IF;    
          END IF;

        END LOOP;

  ag_estado_rnp:=mensaje_inhabi;
      ELSE

          SELECT count(1) INTO ln_valida_rucentidad from reg_procesos.entidades e where e.n_ruc = lv_ruc_consorcio;

          IF ln_valida_rucentidad = 0 THEN
      cant := reg_procesos.F_WS_RNP_GET_ESTADO_ACTUAL_ESP(lv_ruc_consorcio,to_char(ld_f_contrato,'yyyymmdd'));
             --cant :='ERROR'; comentario para inhabilitar la validacion del sistemas de rnp
            ---caso de de cant= 2-SE ENCUENTRA INHABILITADO
      -- IF cant <> '1-OK' THEN
              IF substr(cant,1,1) = '2' THEN
                   mensaje_inhabi := 'El proveedor'||' '||lv_ruc_consorcio||' '||' se encuentra inhabilitado, no es posible publicar el contrato.';
                    LB_RETORNO := FALSE;
                    lb_error:=false;
              END IF;
           
           --- caso de de cant= 9-Error Llamada al Web Service - RNP
             IF UPPER(cant) LIKE '%ERROR%' THEN
                    mensaje_inhabi := 'Sistema externo no disponible, vuelva a intentar';
                    LB_RETORNO    := false;
                    lb_error :=true;
                    
                    
                                      
                END IF;                
           
            END IF;
  ag_estado_rnp:=mensaje_inhabi;
  END IF;  
RETURN LB_RETORNO;


END;

  
/*******************************************************************************/
/******************************************************************************/
-- segun el nodename del xml este este es para el nuevo adicional
   FUNCTION f_ind_uso_siaf (ag_cod_contrato IN VARCHAR2)
      RETURN NUMBER
   IS
      ind_uso_siaf   NUMBER;
   BEGIN
      SELECT ep.ind_uso_siaf
        INTO ind_uso_siaf
        FROM reg_procesos.entidadue_anho_tipo_proceso ep,
             reg_procesos.convocatorias c,
             reg_procesos.contrato cnt
       WHERE ep.eue_codigo = c.codconsucode
         AND ep.eue_anho = c.anhoentidad
         AND c.n_convoca = cnt.n_convoca
         AND cnt.n_cod_contrato = ag_cod_contrato -- 94130 -- {n_cod_contrato}
         AND c.proc_tipo = ep.tip_codigo;

      /*       exception
                     when no_data_found then
                     ind_uso_siaf:= 0;
      */
      RETURN ind_uso_siaf;
   END;

--- para el mantenimiento de adicional (es distinto al de nuevo adicional)
   FUNCTION f_ind_uso_siaf_modif (ag_cod_adicional IN VARCHAR2)
      RETURN NUMBER
   IS
      ind_uso_siaf   NUMBER;
   BEGIN
      SELECT ep.ind_uso_siaf
        INTO ind_uso_siaf
        FROM reg_procesos.entidadue_anho_tipo_proceso ep,
             reg_procesos.convocatorias c,
             reg_procesos.contrato cnt,
             reg_procesos.adicional_reduccion ar
       WHERE ep.eue_codigo = c.codconsucode
         AND ep.eue_anho = c.anhoentidad
         AND c.n_convoca = cnt.n_convoca
         AND cnt.n_cod_contrato = ar.n_cod_contrato
         AND ar.cod_adicional = ag_cod_adicional
         AND c.proc_tipo = ep.tip_codigo;

      /*    exception
                  when no_data_found then
                  ind_uso_siaf:= 0;
        */
      RETURN ind_uso_siaf;
   END;

--------------------------------------------------------------------------------------------------------------------------
-- Nuevo adicional -- uspdonewadicionaledit
--------------------------------------------------------------------------------------------------------------------------
   PROCEDURE uspdonewadicionaledit (
      session__n_convoca              VARCHAR2 DEFAULT NULL,
      session__cod_contrato           VARCHAR2 DEFAULT NULL,
      ag_ind_adred                    VARCHAR2 DEFAULT '',
      ag_cgr                          VARCHAR2 DEFAULT '',
      ag_muestra                      VARCHAR2 DEFAULT NULL,
      ag_ind_fecmod                   VARCHAR2 DEFAULT '',
      ag_ind_montomod                 VARCHAR2 DEFAULT '',
      ag_monto_adicional              VARCHAR2 DEFAULT NULL,
      monto_item                      VARCHAR2 DEFAULT NULL,
      ag_fec_doc_adicional            VARCHAR2 DEFAULT NULL,
      ag_tipo_doc_adicional           VARCHAR2 DEFAULT NULL,
      ag_nro_doc_adicional            VARCHAR2 DEFAULT NULL,
      ag_fec_doc_cgr                  VARCHAR2 DEFAULT NULL,
      ag_nro_doc_cgr                  VARCHAR2 DEFAULT NULL,
      ag_num_comprobante_pago         VARCHAR2 DEFAULT NULL,
      ag_monto_bruto                  VARCHAR2 DEFAULT NULL,
      ag_monto_reajuste               VARCHAR2 DEFAULT NULL,
      ag_monto_amortizacion           VARCHAR2 DEFAULT NULL,
      ag_monto_deduccion              VARCHAR2 DEFAULT NULL,
      ag_monto_interes                VARCHAR2 DEFAULT NULL,
      ag_monto_otros                  VARCHAR2 DEFAULT NULL,
      ag_monto_neto                   VARCHAR2 DEFAULT NULL,
      ag_monto_igv                    VARCHAR2 DEFAULT NULL,
      ag_monto_total_pagado           VARCHAR2 DEFAULT NULL,
      ag_fec_valorizacion             VARCHAR2 DEFAULT NULL,
      ag_concepto_adicional           VARCHAR2 DEFAULT NULL,
      ag_ncor_orden_pedido            VARCHAR2 DEFAULT '',
      -- variables convenio marco
      ag_cm_opc                       VARCHAR2 DEFAULT '',
      ag_cm_oper_compra               VARCHAR2 DEFAULT '',
      -- entidad que autoriza
      ag_cod_entid_autoriza           VARCHAR2 DEFAULT '',
      -- variables para regresarlas al listado de Contratos
      ag_proc_tipo                    VARCHAR2 DEFAULT NULL,
      ln_total_adic                   NUMBER   DEFAULT NULL,
      ag_trama_items                  VARCHAR2 DEFAULT NULL,
      session__eue_codigo             VARCHAR2 DEFAULT NULL,
      session__anhoentidad            VARCHAR2 DEFAULT NULL,
      ag_trama_calendario             VARCHAR2 DEFAULT NULL,
      ag_descripcion                  VARCHAR2 DEFAULT NULL,
        SizeFile                        varchar2--jgarcia
      
   )
   IS
      -------- declaracion de Variables -------
      ln_n_convoca                    NUMBER;
      ln_n_cod_contrato               NUMBER;
      ln_total_pago_cont              NUMBER;
      ln_ind_siaf                     NUMBER;
      ln_ind_modif                    NUMBER;

      lv_combo_moneda                 varchar2(4000);
      lv_combo_operacion              varchar2(4000);
      lv_combo_entidadautoriza        varchar2(4000);
      lv_combo_tipoinstrumento        varchar2(4000);

      cmoneda                         ref_cursor;
      ctipooperacion                  ref_cursor;
      centidadautoriza                ref_cursor;
      ctipoinstrumento                ref_cursor;
      ln_ley number;
      
      
       --JGARCIA
         lv_directorio            varchar2(50);  ---jgarciaf
         lv_ruta                  varchar2(50); ---jgarciaf
         lv_anhoentidad           varchar2(4); ---jgarciaf
         lv_eue_codigo            varchar2(50); ---jgarciaf

      -- cursor para llenar los arreglos mon y cambio que se usaran en js
      CURSOR c_cambio
      IS
         SELECT val_tipo_cambio cambio, codmoneda
           FROM reg_procesos.t_cat_tipo_cambio
          WHERE ind_vigente = 1;

      -- variables para adicional
      contr_n_cod_contrato          reg_procesos.contrato.n_cod_contrato%TYPE;
      contr_n_contrato              reg_procesos.contrato.n_contrato%TYPE;
      contr_m_contratado            reg_procesos.contrato.m_contratado%TYPE;
      contr_codmoneda_contrato      reg_procesos.contrato.codmoneda_contrato%TYPE;
      contr_descripcion             reg_procesos.monedas.descripcion%TYPE;
      -- variable para el codigo objeto
      objetoconvoca                 varchar2(1);
      -- guarda el 15&% del monto contratado
      ln_moneda                     number;
      ls_fec_inicio                 varchar2(10);
      ls_fec_final                  varchar2(10);
      ln_PROC_TIPO                  number;
      t_tipo_consultoria            number;
      

   BEGIN

    reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script('var _enviado = 0;');
    -------- Inicializa Variables -------
    ln_n_convoca         := TO_NUMBER (session__n_convoca);
    ln_n_cod_contrato    := TO_NUMBER (session__cod_contrato);
    ln_ind_siaf          := f_ind_uso_siaf (ln_n_cod_contrato);
 session_cod_contrato := ln_n_cod_contrato ;
    BEGIN
      SELECT CODOBJETO, codmoneda, PROC_TIPO,t_tipo_co_codigo INTO objetoconvoca, ln_moneda , ln_PROC_TIPO, t_tipo_consultoria
        FROM reg_procesos.convocatorias
       WHERE n_convoca=session__n_convoca ;
    END;

    BEGIN
       SELECT c.n_cod_contrato, c.n_contrato, c.m_contratado,c.codmoneda_contrato, m.descripcion,to_char(c.F_VIGENCIA_INI,'dd/mm/yyyy'), to_char(c.F_VIGENCIA_Fin,'dd/mm/yyyy')
         INTO contr_n_cod_contrato, contr_n_contrato, contr_m_contratado, contr_codmoneda_contrato, contr_descripcion,ls_fec_inicio, ls_fec_final
         FROM reg_procesos.contrato c, reg_procesos.monedas m
        WHERE c.n_convoca      = ln_n_convoca
          AND c.n_cod_contrato = ln_n_cod_contrato
          AND c.codmoneda_contrato = m.codmoneda;

    END;

          ln_ley :=  f_get_primer_publicado(session__n_convoca)  ;

    -- Carga de cursores
    cmoneda                   := pku_ss_utiles.f_cmonedas;
    ctipooperacion            := pku_ss_utiles.f_tipo_operacion_contrato('3,4');
    centidadautoriza          := pku_ss_utiles.f_entidad_autoriza_adicional(objetoconvoca,session__eue_codigo,session__anhoentidad,t_tipo_consultoria,ln_ley);
    ctipoinstrumento          := pku_ss_utiles.f_tipo_instrumento('1,5');

    -- Inicializamos los combos
    lv_combo_moneda           := PKU_SS_UTILES.f_retorna_combo(cmoneda, 'ag_codmoneda_v', null,null,' style="width:340px" ');
    lv_combo_operacion        := PKU_SS_UTILES.f_retorna_combo(ctipooperacion, 'ag_ind_adred', ag_ind_adred,'Seleccione...','onchange=" f_changetipo()" style="width:340px" ');
    lv_combo_entidadautoriza  := PKU_SS_UTILES.f_retorna_combo(centidadautoriza, 'ag_cod_entid_autoriza', ag_cod_entid_autoriza,'Seleccione...',' onchange="f_changeEntidadAutoriza(this)" style="width:99%" ');
    lv_combo_tipoinstrumento  := PKU_SS_UTILES.f_retorna_combo(ctipoinstrumento, 'ag_tipo_doc_adicional', ag_tipo_doc_adicional,'Seleccione...','style="width:55%"');

   -- JAVASCRIPT --

   reg_procesos.pku_procesos_comun.dojscript;
   reg_procesos.pku_procesos_comun.doJScriptFechas;

 ---- jgarciaf inicio
     
   lv_anhoentidad := session__anhoentidad;
   lv_eue_codigo := session__eue_codigo;    
   lv_directorio := gpk_directorio_adicred;
   ---lv_ruta       := WriteFileDirectoryDynamic||'/'||docname;
   
   lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||session__n_convoca; 
  
   usp_print('
     <input type ="hidden" name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=text>
     <input type ="hidden" name=WriteFileDirectory value="FileSinged" type=text>
     <input type="hidden" name="extension"/>
     <input type ="hidden" id=SizeFile name=SizeFile />
   ');
   
   ----- JGARCIAF FIN 
   
   usp_print('
    <script language="javascript">
               function f_changetipo()
            {
                thisform.ag_monto_adicional.value="";
                document.getElementById(''trDocAuto'').style.display          = ''none''
                document.getElementById(''trBotonAdicional'').style.display   = ''none''
                document.getElementById(''trBotonReduccion'').style.display   = ''none''
                try{
                document.getElementById(''trCalendarioTitle'').style.display  = ''none''
                document.getElementById(''trCalendarioBody'').style.display   = ''none''

                document.getElementById(''tblVal'').style.display             = ''none''
                } catch(e){}

                if(thisform.ag_ind_adred.value == "3"){
                   document.getElementById(''trDocAuto'').style.display          = ''''
                   document.getElementById(''trBotonAdicional'').style.display   = ''block''
                   document.getElementById(''trBotonReduccion'').style.display   = ''none''
                   document.getElementById(''titleMonto'').innerHTML             = "Ingrese el Monto del Adicional"

                   try{
                   document.getElementById(''trCalendarioTitle'').style.display  = ''block''
                   document.getElementById(''trCalendarioBody'').style.display   = ''block''
                   document.getElementById(''tblVal'').style.display             = ''block''
                   } catch(e){}

                   }
                if(thisform.ag_ind_adred.value == "4"){
                   document.getElementById(''trDocAuto'').style.display          = ''none''
                   document.getElementById(''trBotonReduccion'').style.display   = ''block''
                   document.getElementById(''trBotonAdicional'').style.display   = ''none''
                   document.getElementById(''titleMonto'').innerHTML             = "Ingrese el Monto de la Reduccion"

                   try{
                   document.getElementById(''trCalendarioTitle'').style.display  = ''none''
                   document.getElementById(''trCalendarioBody'').style.display   = ''none''
                   document.getElementById(''tblVal'').style.display             = ''none''
                   } catch(e) {}

                }

                f_changeEntidadAutoriza(thisform.ag_cod_entid_autoriza.value);

            }
    </script>');

  usp_print('
      <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');

  usp_print(PKU_SS_UTILES.f_get_titulo_contrato(session__cod_contrato,'Crear Adicionales/Reducciones'));

  
  
  usp_print('<td align="right" valign=top width="50%">
             <input type="button" value="Volver" onclick="thisform.scriptdo.value=''LisAdicionalesDoView'';thisform.submit();">');

  usp_print('<div id="trBotonAdicional" style="display:none">
                  <input type="button" value="Grabar Adicional" onclick="grabarAdd(''AdicionalAdicDoInsert'')">
                  <input type="button" value="Seleccionar Item" onclick="seleccionaritems();">
             </div>');

  usp_print('<div id="trBotonReduccion" style="display:none">
              <input type="button" value="Grabar Reduccion" onclick="grabarRed(''AdicionalRedDoInsert'')">
              <input type="button" value="Seleccionar Item" onclick="thisform.scriptdo.value=''NewAdicionalItemDoEdit'';thisform.submit();">
             </div>');

  usp_print ('
        </td>
    </tr>');
  
    
   /* select * into consucode,proveedor,proceso,nconvoca,fcontra,npropuesta from table(f_get_emp_dets(session_cod_contrato));
    
    
    
     usp_print('
    <table>
    <tr >
    <td><h3>'|| consucode ||'</h3></td>
    </tr>
    <tr >
    <td><h3>'|| proveedor ||'</h3></td>
    </tr>
    
    <tr >
    <td><h3>'|| proceso ||'</h3></td>
    </tr>
    
     <tr >
    <td><h3>'|| nconvoca ||'</h3></td>
    </tr>
    
      <tr >
    <td><h3>'|| fcontra ||'</h3></td>
    </tr>
    
    <tr >
    <td><h3>'|| npropuesta ||'</h3></td>
    </tr>
   
     </table>');*/
    
    
  IF (ag_muestra IS NULL) THEN
       usp_print('<input type="hidden" name="ag_cgr" value="'|| ag_cgr|| '"/>');
  ELSE
       usp_print('<input type="hidden" name="ag_cgr" value="'|| ag_nro_doc_cgr||'"/>');
  END IF;

  usp_print('
              <input type ="hidden" name="ag_n_convoca"             value="'|| ln_n_convoca|| '"/>
              <input type ="hidden" name="ag_cod_contrato"          value="'|| ln_n_cod_contrato||'"/>
              <input type ="hidden" name="ag_m_contratado"          value="'|| contr_m_contratado||'"/>
              <input type ="hidden" name="ag_cod_objeto"            value="'|| objetoconvoca||'"/>
              <input type ="hidden" name="ln_total_adic"            value="'|| TO_CHAR (ln_total_adic)||'"/>
              <input type ="hidden" name="ag_ind_siaf"              value="'|| ln_ind_siaf||'"/>
              <input type ="hidden" name="ag_reg_cal_modif"         value=""/>
              <input type ="hidden" name="ag_id_motivo" />
              <input type ="hidden" name="ag_id_operacion" />
              <input type ="hidden" name="ag_id_op" />
              <input type ="hidden" name="ag_num_pagoA" />
              <input type ="hidden" name="ag_fecha_pagoA" />
              <input type ="hidden" name="ag_monto_pagoA" />
              <input type ="hidden" name="monto_item"               value="'|| monto_item||'" />
              <input type ="hidden" name="ag_num_pago" />
              <input type ="hidden" name="ag_muestra"               value="'|| ag_muestra||'"/>
              <input type ="hidden" name="ag_ncor_orden_pedido"     value="'|| ag_ncor_orden_pedido||'"/>
              <input type ="hidden" name="ag_cm_opc"                value="'|| ag_cm_opc||'"/>
              <input type ="hidden" name="ag_cm_oper_compra"        value="'|| ag_cm_oper_compra|| '"/>
              <input type ="hidden" name="ag_proc_tipo"             value="'|| ln_PROC_TIPO||'" />

              <input type ="hidden" name="ag_tipo_consultoria"             value="'|| t_tipo_consultoria||'" />
');

    usp_print('<input type ="hidden" name="ag_trama_items"          value="'||ag_trama_items||'" />');
    -- para calcular si las cantidades son iguales
    usp_print('
              <input type ="hidden" name="an_total_items"           value=""/>
              <input type ="hidden" name="an_total_calendario"      value=""/>');
    -- Fin Zona Hidden --
    usp_print
         ('<table align="center" class="table" style="width: 100%">');

    usp_print('
    <tr>
       <td style="width: 33%">
         <h3>Datos Generales</h3>
       </td>
       <td style="width: 33%"></td>
       <td style="width: 34%"></td>       
    </tr>');







    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Nmero del Contrato (u Orden de Compra o Servicio) ',
                '<input readonly="" class="form-control InpReadOnly" name="ag_n_contrato" value="'|| contr_n_contrato||'"  style="width:98%"/>',
                'N&uacute;mero del Contrato'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('Moneda (del Contrato)',
                '<input name="ag_codmoneda" value="'|| contr_codmoneda_contrato|| '" type="hidden"/><b>'|| contr_descripcion||'</b>',
                'Moneda del Contrato'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Tipo Operacion',
                lv_combo_operacion,
                'Seleccione el Tipo de Operacin'));

    -- Opcion para un Adicional
   usp_print('<tr id=trDocAuto  style="display:none;">
        <td class=c1>(*)Entidad que autoriza el adicional</td>
        <td class=c2>'||lv_combo_entidadautoriza||'</td>
        <td class=c3>Seleccione la entidad que autoriza el adicional.</td>
    </tr>');

    -- Formulario que muestra el nro y fecha del Documento que es Autorizado por CGR en caso de Obras
   usp_print('<tr id=trDoc  style="display:none;">
        <td class=c1>(*)Documento autorizado por (CGR)</td>
        <td class=c2><input name ="ag_nro_doc_cgr" value ="'|| ag_nro_doc_cgr|| '" size=54 class="form-control" /></td>
        <td class=c3>.</td>
    </tr>');

   usp_print('<tr id="trFecha" style="display:none;">
        <td class=c1>(*)Fecha del Documento autorizado por (CGR)</td>
        <td class=c2>
        <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fec_doc_cgr" value="'||ag_fec_doc_cgr||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control" readOnly/>
          </div>
        </td>
        <td class=c3>Ingrese la Fecha del Documento</td>
    </tr>');

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Documento autorizado por la Entidad',
                lv_combo_tipoinstrumento
                ||'<input size=22 type="text" name="ag_nro_doc_adicional" value="'|| ag_nro_doc_adicional|| '" onblur="ValidarString(this, ''Nmero de Documento'');" />',
                'Seleccione el Tipo de Documento'));
                
                     
            ---- jgarciaf inicio
            
    
    usp_print('
        <script language="javascript">
            function obtenerTamano(){
                var x = document.getElementById(''pfiletoupload1'');
                var file_size_final;
                if (''files'' in x) {
                     if (x.files.length == 0) {
                     }else{
                        var file = x.files[0];
                        //alert(file.size);
                        file_size_final=file.size; 
                        var xfile = document.getElementById(''SizeFile'');
                        xfile.value=file_size_final;
                        //alert(file_size_final);
                     }                    
                }            
            }
        </script>');        
    
   usp_print(            
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Adjuntar Archivo',
                '<input type="file" id="pfiletoupload1"  name="pfiletoupload1" class="form-control" size="'|| SizeFile|| '" value="" onchange="obtenerTamano()">
                <input type="hidden" name="pfiletoupload_file1" value=""/>',
                  'Seleccione el archivo que contiene el Adccional o Reduccion del Servicio, solo se permiten archivos *.doc ,*.docx, *.pdf ,*.zip,*.rar'));
                
            ---- jgarciaf FIN
     

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Fecha del Documento autorizado por la Entidad',
              '<div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fec_doc_adicional" value="'||ag_fec_doc_adicional||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control" readOnly/>
          </div>',
              'Ingrese la Fecha del Documento'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Descripci&oacute;n',
                '<input name="ag_descripcion" class="form-control" size=54 value="'||ag_descripcion||'" maxlength="80" >',
                'Descripci&oacute;n del Adicional o Reducci&oacute;n'));

    usp_print(
            PKU_PROCESOS_COMUN.f_putRowForm('(*)Monto(En Moneda del Contrato)',
                '<input name="ag_monto_adicional" class="form-control" value="'|| ag_monto_adicional|| '" readOnly="true" maxlength="11" size=54 />',
                '<div id=titleMonto name=titleMonto></div>'));



 IF (ln_ind_siaf  = 1)  THEN
    -----------------  Calendario de pagos ------------
    usp_print('</table>
    <table>
    <tr id="trCalendarioTitle" style="display:none" >
    <td><h3>Calendario</h3></td>
    </tr>
    <tr align=center id="trCalendarioBody" style="display:none">');
    usp_print('<TD  align=center>');
    reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlCalendario(ln_moneda,ag_trama_calendario,'an_total_calendario');
    usp_print ('</td>
     </tr>
     </table><br/><br/>');
 END IF;

  ----------------- items --------------------------------

  IF ag_trama_items IS NOT NULL THEN

  usp_print('<table class="table" style="width:100%">
  <tr><td><h3>Items</h3></td></tr>');
  usp_print('<tr align=center>');
  usp_print('<TD colspan="4" align=center>');
  PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlItemsReader(ag_trama_items,'an_total_items');
  usp_print('</TD></TR>
  </table>');

 END IF;
 usp_print ('
    </table></br>');

-- usp_print('<b>Vigencia del Contrato :'|| ls_fec_inicio ||' al ' || ls_fec_final || '</b>');

 ----------------------- Valorizaciones -----------------
 IF (objetoconvoca = pku_ss_constantes.gn_objeto_obras OR objetoconvoca = pku_ss_constantes.gn_objeto_consultoria_obras )THEN

  usp_print
         ('
         <table class="table table-striped" id="tblVal" style="display:none;">
         <tr>
              <td colspan ="3">
              <h3>Valorizaciones</h3>
              </td>  
         </tr>
         ');
 
   --Nmero de Valorizacin
/*    usp_print('
        <tr>
          <td><b>Nmero de Valorizacin</b></td>
          <td colspan="2"><input name="ag_cod_valorizacion" value=""/></td>
        </tr>
    ');
*/

   --Comprobante de Pago N
  usp_print('
    <tr>
      <td class=c1><b>(*)Comprobante de Pago N</b></td>
      <td class=c2><input name="ag_num_comprobante_pago" class="form-control"  value="'|| ag_num_comprobante_pago|| '" size="54"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

   --Moneda de Valorizacin
   usp_print
      ('<tr>
            <td class=c1><b>(*)Moneda de Valorizacin</b></td>
            <td class=c2>'||lv_combo_moneda||'</td>
            <td class=c3>&nbsp;</td>
         </tr>');

   --Monto Valorizado Bruto
   usp_print('
    <tr>
      <td class=c1><b>(*)Monto Valorizado Bruto</b></td>
      <td class=c2><input name="ag_monto_bruto" class="form-control" value="'|| ag_monto_bruto|| '" maxlength="11" size="54" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

   --Monto de Reajuste
   usp_print('
    <tr>
      <td class=c1><b>(*)Monto de Reducci&oacute;n</b></td>
      <td class=c2><input name="ag_monto_reajuste" class="form-control" value="'|| ag_monto_reajuste|| '" maxlength="11" size="54" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

   --Amortizaciones
   usp_print('
    <tr>
      <td class=c1><b>(*)Amortizaciones</b></td>
      <td class=c2><input name="ag_monto_amortizacion" class="form-control" value="'|| ag_monto_amortizacion|| '" maxlength="11" size="54" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

         --Deducciones
   usp_print('
    <tr>
      <td class=c1><b>(*)Deducciones</b></td>
      <td class=c2><input name="ag_monto_deduccion" class="form-control" value="'|| ag_monto_deduccion|| '" maxlength="11" size="54" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

         --Intereses
   usp_print('
    <tr>
      <td class=c1><b>(*)Intereses</b></td>
      <td class=c2><input name="ag_monto_interes" class="form-control" value="'|| ag_monto_interes|| '" maxlength="11" size="54" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

         -- otros
   usp_print('
    <tr>
      <td class=c1><b>(*)Otros</b></td>
      <td class=c2><input name="ag_monto_otros" class="form-control" value="'|| ag_monto_otros|| '" maxlength="11" size="54" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)"/></td>
      <td class=c3>&nbsp;</td>
          </tr>');

         --Monto Valorizado Neto
   usp_print('
    <tr>
      <td class=c1><b>(*)Monto Valorizado Neto</b></td>
      <td class=c2><input name="ag_monto_neto" class="form-control" value="'|| ag_monto_neto|| '" maxlength="11" size="54" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

         --IGV
    usp_print('
    <tr>
      <td class=c1><b>(*)IGV</b></td>
      <td class=c2><input name="ag_monto_igv" class="form-control" value="'|| ag_monto_igv|| '" maxlength="11" size="54" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

         --Monto Total Pagado
   usp_print('
    <tr>
      <td class=c1><b>(*)Monto Total Pagado</b></td>
      <td class=c2><input name="ag_monto_total_pagado" class="form-control" value="'|| ag_monto_total_pagado|| '" maxlength="11" size="54" onkeyup="validarInputNumDecimal(this)" onblur="validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

         --Fecha de Valorizacion
   usp_print('
    <tr>
      <td class=c1><b>(*)Fecha de Valorizacion</b></td>
      <td class=c2>
      <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fec_valorizacion" value="'||ag_fec_valorizacion||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control" readOnly/>
          </div>
          </td>
      <td class=c3>&nbsp;</td>
    </tr>');

         --Concepto Adicional
   usp_print('
    <tr>
      <td class=c1><b>(*)Concepto Adicional</b></td>
      <td class=c2><input name="ag_concepto_adicional" class="form-control" value="'|| ag_concepto_adicional|| '" maxlength="11" size="54"/></td>
      <td class=c3>&nbsp;</td>
    </tr>');

   usp_print ('</table> ');

   END IF;


    usp_print('
    <input type="hidden" name="ln_total_pago_cont1"      value="'|| ln_total_pago_cont|| '"/>
    <input type="hidden" name="ln_ind_modif1"            value="'|| ln_ind_modif|| '"/>
    <input type="hidden" name="ag_ind_modif"             value="'|| ln_ind_modif|| '"/>
    <input type="hidden" name="ag_ind_fecmod"            value="'|| ag_ind_fecmod|| '"/>
    <input type="hidden" name="ag_ind_montomod"          value="'|| ag_ind_montomod|| '"/>
    <input type="hidden" name="cambio"                   value=""/>
    <input type="hidden" name="codobjeto"                value="'||objetoconvoca||'"/>
    ');

    -------- Java Script para Adicional y reduccion --------
      usp_print
         ('
        <script language="javascript">

       //para la validacion en valorizacion
          var cambio        = new Array();
          var mon           = new Array();
          i = 0;'
         );

      FOR c_camb IN c_cambio LOOP
        BEGIN
            usp_print (   '
                cambio[i] = '|| to_char(c_camb.cambio, '999,999,999,999.00') || '
                mon[i] =' || c_camb.codmoneda || '
                i++; ');
         END;
      END LOOP;

      usp_print
         (   '
            function ValidarString(ls_obj, ls_mensage)
            {
                var strCadena = ls_obj.value;
                var valido= "ABCDEFGHIJKLMNOPQRSTUVWYXZ0123456789abcdefghijklmnopqrstuvwxyz#$%()=*+}{[]-:,.!?&/ ";
                var flag=0;

                for (i = 0 ; i <= strCadena.length - 1; i++)
                    {
                       if(!vacio(trim(strCadena.substring(i,i+1)))){
                            if (valido.indexOf (strCadena.substring(i,i+1),0) == -1)
                            {
                                ls_obj.select();
                                //alert("Hay un caracter no permitido en el campo " + ls_mensage + "\nel caracter no permitido es ( "+strCadena.substring(i,i+1)+" )");
                                ls_obj.focus();
                                flag =1;

                            }
                       }
                    }

                if ( flag ==1 ){
                    alert("Hay un caracter no permitido en el Nro. de Documento que autoriza la Operacin");
                    ls_obj.value="";

                    return false;
                }else{
                    return true;
                }
            }

            function vacio(ls_cadena) {
                if (ls_cadena == " " || ls_cadena == null || ls_cadena.length == 0)
                    return true;
                else return false;
            }


     // =========  metodo para adicional_reduccion ==========

         //valida que el numero ingresado solo tenga 2 decimales como maximo
            function num_decimales( val, msge ) {

            // alert(" estoy en validacion de 2 decimales ");
            var DigitsAfterDecimal = 2;
               if(val.indexOf(".") > -1)
                {
                   if(val.length - (val.indexOf(".")+1) > DigitsAfterDecimal)
                     {
                       alert("Por Favor ingrese "+msge+ " con valor decimal valido. Solamente " +DigitsAfterDecimal + " digitos son permitidos despues del punto decimal.");
                       return false;
                      }
                    else
                     {
                      return true;
                      }
                 }
                 else
                 {
                    //valor sin decimales
                    if(parseInt(val) > 0)
                        {
                        return true;
                        }
                 }

            }// fin de la funcion valida num_decimales despues del punto



           function f_changeEntidadAutoriza(obj)
            {

                thisform.ag_monto_adicional.value="";

                if(thisform.ag_cod_entid_autoriza.value=="000008"){
                   document.getElementById(''trDoc'').style.display   = ''''
                   document.getElementById(''trFecha'').style.display = ''''
                   }
                else{
                   document.getElementById(''trDoc'').style.display   = ''none''
                   document.getElementById(''trFecha'').style.display = ''none''
                }
            }

           function ValidarCambio(obj){

                monto = parseFloat(thisform.ag_monto_adicional.value);
                for(i=0; i<cambio.length; i++){
                    if(thisform.ag_codmoneda.value == mon[i]){
                        monto = monto*cambio[i];
                    }
                }
                return monto;
            }

           function ValidarCGR(obj)
           {
            alert(" estoy en validar CGR de Nuevo Adicional ");

               if(thisform.ag_nro_doc_cgr != "" && thisform.ag_fec_doc_cgr !=  ""  && thisform.ag_fec_doc_cgr != "" )
               {
                    //alert("Encontro las cosas");
                    return true;
               }
               else
               {
                    //alert("No Encontro las cosas");
                    return false;
               }
            }


        // modificado
        function ValidarSuma(){
                //alert("Ingreso a Suma");
                var pago = parseFloat(thisform.ag_monto_adicional.value);
                var msg  = "";
                porcentaje  = parseFloat(thisform.ag_m_contratado.value)*0.15;
                msg = "Como el monto adicional ("+thisform.ag_monto_adicional.value+") es mayor al 15% del monto contractual ("+porcentaje+") en la Moneda del Contrato.\nDebe Selecccionar Entidad que Autoriza a la Contraloria e Ingresar el documento y la fecha de autorizacin \npor CGR Si ya lo hizo solo es una Aclaracion Continue... ";

                if(pago>porcentaje)
                {
                   alert(msg);
                   if (thisform.ag_cod_entid_autoriza.value== "000008" )
                   {
                       if(ValidarCGR)
                          return true;
                       else
                          return false;
                    }
                    else
                    {
                     // alert("Retorna False de Suma1");
                      return false;
                    }

                 }
                 else
                 {
                   // alert("Retorna True de Suma2");
                    return true;
                 }
          }


// ========= fin de metodo para adicional_reduccion ==========

  function seleccionaritems(){
     if (thisform.ag_cod_entid_autoriza.value == "" )
      {
          alert("Por Favor seleccione entidad Que autoriza el Adicional");
          thisform.ag_cod_entid_autoriza.focus();
          return false ;
      }

  try{
    xmlDelEliminar($("#xmlCalendario").html());
    thisform.ag_trama_calendario.value = $("#xmlCalendario").html();
   }catch(err){}

    thisform.scriptdo.value="NewAdicionalItemDoEdit";
    thisform.submit();

  }


var form_submitted = false;

function submit_form ( )
{
  if ( form_submitted )
  {
    alert ( "Se esta procesando la solicitud. Por favor espere un momento" );
    return false;
  }
  else
  {
    form_submitted = true;
    return true;
  }
}




    function ValidarCGR(){

    if(thisform.ag_cgr.value!="") {
       if(ValidarBlanco  (thisform.ag_nro_doc_cgr  ,"Documento autorizado por CGR")  &&
          ValidarBlanco  (thisform.ag_fec_doc_cgr  ,"Fecha del documento autorizado por CGR")  &&
          ValidarFecha   (thisform.ag_fec_doc_cgr  ,"Fecha del documento autorizado por CGR")
       ){
            return true;
       }else{
            return false;
       }
    }
    return true;
  }

  //funcion que luego de validar la adicion llama al procedimiento que hace la insercion
   function grabarAdd(pagina)
   {
   if( _enviado == 1 ){return;}

   if (thisform.ag_cod_entid_autoriza.value == "" )
   {
          alert("Por Favor seleccione entidad Que autoriza el Adicional");
          thisform.ag_cod_entid_autoriza.focus();
          return false ;
   }


   if ( !ValidarBlanco(thisform.ag_nro_doc_adicional,"Documento que autoriza la operacin" ) )
    {
          return false;
    }

   if (thisform.ag_monto_adicional.value == 0 )
   {
          alert("El monto del contrato no puede ser 0, debe agregar los adicionales a nivel de Item");
          thisform.ag_monto_adicional.focus();
          return false ;
   }
   
   /*jgarcia  INICIO*/

if (thisform.pfiletoupload1.value != "" )
  {

    var extension = thisform.pfiletoupload1.value.substring(thisform.pfiletoupload1.value.length-4);

    //extension = extension.replace(".","");

    if (extension == "docx")
                        {
                            extension = "." + extension;
                            
                        }
    if ( extension == ".doc" || extension == ".pdf" || extension == ".zip" || extension == ".rar" || extension == ".docx")
          {

   
            var namearchive = "'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'"+extension;
            thisform.pfiletoupload_file1.value = namearchive;
            thisform.extension.value = extension;
          }
      else
          {
            alert("Lo sentimos, el tipo de archivo que intenta grabar no esta permitido");
            return false ;
          }
  }
      
    else   {
          alert ("Registre el documento Adicional ");
        return false ;
        }    

/*jgarcia  FIN*/


   if('|| ln_ind_siaf || '==1 && redondear(thisform.an_total_calendario.value, 2) != eval(thisform.ag_monto_adicional.value))
   {    
        alert("El monto ingresado en el campo Monto no coincide con el monto ingresado en el Calendario de Pago, corrija e intente nuevamente")
        thisform.ag_monto_adicional.focus();
        return false;
   }

   if (thisform.ag_cod_entid_autoriza.value== "000008" )
   {
           if(!ValidarCGR())  return false;
   }

   try{
//           thisform.ag_trama_calendario.value = xmlCalendario.xml;
           generacionTramaCalendario();

   }catch(err){}

   thisform.scriptdo.value=pagina;

   if (_enviado == 0 ){thisform.submit();}

   _enviado = 1;

}

 function grabarRed(pagina)
  {
    if (thisform.ag_monto_adicional.value == 0 )
    {
    alert("El monto de la reduccion no puede ser 0");
    return;
    }


  if(!(ValidarBlanco(thisform.ag_nro_doc_adicional,"Documento de Autorización"))&& ValidarFecha(thisform.ag_fec_doc_adicional,"Fecha del Documento de Autorizacion") && ValidarBlanco  (thisform.ag_fec_doc_adicional,"Fecha del Documento de Autorizacion")  && ValidarBlanco  (thisform.ag_monto_adicional ,"Monto") && ValidarDecimal (thisform.ag_monto_adicional,"Monto")  )
    {

    return false;
    }

  if (thisform.ag_descripcion.value == "" )
  {
  alert("Debe ingresar la descripcion de la operacin");
  thisform.ag_descripcion.focus();
  return false;
  }
/*
  if(thisform.ag_cod_objeto.value==3 || thisform.ag_cod_objeto.value==4){

     if(!valorizacion()) return false;
    }*/

      
      
      /*jgarcia  INICIO*/

if (thisform.pfiletoupload1.value != "" )
  {

    var extension = thisform.pfiletoupload1.value.substring(thisform.pfiletoupload1.value.length-4);

    //extension = extension.replace(".","");

    if (extension == "docx")
                        {
                            extension = "." + extension;
                            
                        }
    if ( extension == ".doc" || extension == ".pdf" || extension == ".zip" || extension == ".rar" || extension == ".docx")
          {

   
            var namearchive = "'||to_char(sysdate, 'ddmmyyyyHH24MISS')||'"+extension;
            thisform.pfiletoupload_file1.value = namearchive;
            thisform.extension.value = extension;
          }
      else
          {
            alert("Lo sentimos, el tipo de archivo que intenta grabar no esta permitido");
            return false ;
          }
  }
      
    else   {
          alert ("Registre el documento Adicional ");
        return false ;
        }    

  
/*jgarcia  FIN*/

  thisform.scriptdo.value=pagina;
  thisform.submit();


  }



    function cancelar(pagina,scrobj)
    {
         thisform.scriptdo.value=pagina;
         thisform.submit();
    }

    function f_validaCampoNumerico()
    {
        escribe=1;
        var key=window.event.keyCode;            //codigo de tecla.
        if (key <46 || key > 57 || key==47){     //si no es numero o punto decimal "."
            window.event.keyCode=0;                  //anula la entrada de texto.
        }
    }



 </script>
 <!-- Para saber lo que se muestra la primera vez que se carga la pantalla -->
 <script>f_changetipo();</script>');

     usp_print('<script language="javascript">
     $(document).ready(function(){
        try{
         //thisform.ag_monto_adicional.value= redondear(parseFloat(sumaTotalesItems(xmlItems)),2);
         thisform.ag_monto_adicional.value= redondear(parseFloat(thisform.an_total_items.value),2);

      }catch(err){
      }                
     });
     

     </script>');

END;
/****************************************************************************************************/

   PROCEDURE uspnewadicionalitemdoedit (
      session__n_convoca         VARCHAR2 DEFAULT NULL,
      session__cod_contrato      VARCHAR2 DEFAULT NULL,
      ag_ind_adred               VARCHAR2, /* Tipo de operacion*/
      ag_cant_items              VARCHAR2,
      ag_cod_entid_autoriza      VARCHAR2,
      ag_trama_calendario        VARCHAR2,
      ag_nro_doc_cgr             VARCHAR2,
      ag_fec_doc_cgr             VARCHAR2,
      ag_nro_doc_adicional       VARCHAR2,
      ag_fec_doc_adicional       VARCHAR2,
      ag_descripcion             VARCHAR2,
      ag_tipo_doc_adicional      VARCHAR2,
      session__EUE_CODIGO        VARCHAR2,
      ag_proc_tipo               varchar2

   )
   IS

      lv_trama_items      LONG;
      ln_ind_adred        number;
      lv_subtitle         VARCHAR2(100);

      ln_cod_obj          number;
      ln_ley_29564        number;
      LN_PROC_TIPO        number;
      t_tipo_consultoria  number;
      ln_ley    number;
      cod_entidad_autoriza number;
   BEGIN


    select codobjeto, PROC_TIPO,t_tipo_co_codigo into ln_cod_obj,LN_PROC_TIPO, t_tipo_consultoria from  convocatorias where n_convoca =session__n_convoca;
    select count(1) into ln_ley_29564 from reg_procesos.contrato_validaciones where codconsucode = session__EUE_CODIGO;

    usp_print('
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform" >
    <tr>
      <td>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
            <tr>
               <td>'
          || PKU_SS_UTILES.f_get_titulo_contrato(session__cod_contrato,'Seleccionar Items')||
              '</td>
               <td valign=top align=right>
                    <input type=button value="Volver" onclick="thisform.scriptdo.value=''DoNewAdicionalEdit'';thisform.submit();">
                    <input type=button value="Continuar" onclick="generaTrama()">
               </td>
             </tr>
        </table>');

        if (ag_ind_adred = 3 and ag_cod_entid_autoriza = '000008') then
           usp_print('<p><b>Entidad que autoriza:</b> Contraloria General de la Republica' );
        end if;

        if (ag_ind_adred = 3 and ag_cod_entid_autoriza = 1952) then
           usp_print('<p><b>Entidad que autoriza:</b> Organismo Supervisor de las Contrataciones del Estado' );
        end if;

        usp_print('<br>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableform">
             <tr>
               <td colspan = 6 align="right">
               <div id="paginacion"></div>
              </td>
            </tr>
        </table>');



   ----------------- Muestra los Items -----------------

   usp_print('<xml id="xmlActual"><root></root></xml>');

   /* No se a quien se le ocurrio tener dos indicadores para saber si es un adicional o reduccion*/
   IF ag_ind_adred = 3 THEN
       lv_subtitle := 'Adicional';
       ln_ind_adred := 1;
   END IF;

   IF ag_ind_adred = 4 THEN
      lv_subtitle := 'Reduccion';
      ln_ind_adred := 2;
   END IF;

/*Adicion codigo
 Sustento: INC.2014.02.25.246_OP.No permite registrar adicional 
 Fecha: 02/05/2014
 Autor: Isaac Mendoza
*/
--inicio
   if(ag_cod_entid_autoriza = '000008') then 
    cod_entidad_autoriza := 1;
   else 
    cod_entidad_autoriza := 2;
   end if;

-- lv_trama_items := PKU_SS_UTILES.f_getXmlItemsAdionReducSel2(session__cod_contrato,ag_cod_entid_autoriza,ln_ind_adred,ln_cod_obj, t_tipo_consultoria,cod_entidad_autoriza);
-- comentado por INC.2014.02.25.246_OP.No permite registrar adicional
-- Se comenta f_getXmlItemsAdionReducSel2 y se descomenta f_getXmlItemsAdionReducSel en atención de la incidencia (2040_OP_SEACE2_CON)
   lv_trama_items := PKU_GESTOR_CONT_UTILES_3.f_getXmlItemsAdionReducSel(session__cod_contrato,ag_cod_entid_autoriza,ln_ind_adred,ln_cod_obj, t_tipo_consultoria);
--fin
usp_print('<script>');
   usp_print(lv_trama_items);
  
   usp_print('
   $(document).ready(function(){
          var myObject = eval(''('' + itemJSON + '')'');                    
                  for (i in myObject)
                  {   $(''#tablaItems tr:last'').
                          after("<tr class=TabFilMan>"+
                                   "<td width = 8% style=''text-align:center''>"+
                                       "<input type=checkbox name=chkObjs class=chkObjs ></input>"+
                                       "<input type=hidden  datafld=copiar name=hcopiar />"+
                                   "</td>"+
                                   
                                   "<td width = 3%>"+myObject[i][''fila'']+"</td>"+  
                                   "<td width = 3%>"+myObject[i][''procitem'']+"</td>"+
                                   "<td width = 30%>"+myObject[i][''descripcion'']+"</td>"+
                                   "<td width = 8%>"+myObject[i][''unidad'']+"</td>"+
                                   "<td width = 5%>"+myObject[i][''cantidad'']+"</td>"+
                                   "<td width = 10%>"+myObject[i][''mon'']+"</td>"+
                                   "<td width = 10%>"+myObject[i][''sum'']+"</td>"+');
                                   --mmautino: 15.05.2015 formato 1356_OP_SEACE2_CON                                    
                                   if not (ag_ind_adred = 3 and ag_cod_entid_autoriza = '000008' and ln_cod_obj = 4 and t_tipo_consultoria = 2  and ln_ley = 1  ) then
                                      if ag_proc_tipo not in (11,23) then
                                                 usp_print('"<td width = 12%>"+myObject[i][''top'']+"</td>"+');
                                      else
                                          usp_print('"<td  style=''display:none'' width=''12%''></td>"+');  
                                      end if;
                                   else
                                      usp_print('"<td  style=''display:none'' width=''12%''></td>"+'); 
                                   end if;
                                   
                                usp_print('"<td width = 11%>"+
                                                "<input type=text datafld=monto name=txtMontoxml size=15 style=''text-align:left'' onkeyup=''validarInputNumDecimal(this)'' onblur=''validarFormInputNumDecimal(this); this.value = redondear(this.value, 2)'' ></input>"+
                                           "</td>"+');
                                           
                                    usp_print('"<td style=''display:none''>"+myObject[i][''ley'']+"</td>"+');
                                --Fin  
                                    if ln_cod_obj in (1,2,4)  and ln_ley_29564 > 0 then
                                       usp_print('"<td width = 11%>"+
                                                       "<span datafld=chl dataformatas=html >"+
                                                 "</td>"+');
                                    end if;   
                                              
                                     usp_print('"</tr>");                         
                   }
   });
      
   ');

usp_print('</script>');   
   
   ---------- Cabecera de los Items ---------------
   usp_print('<!-- datapagesize="1" -->
<input type="hidden" name=chkObjs >
<input type="hidden" name=chkObjs >
     <table id="tablaItems" width="100%" class="table table-bordered">
     <thead>
          <tr align="center">
          <td class="th1"><b>Adicionar Items</b></td>
          <td class="th1"><b>Nº</b></td>
          <td class="th1"><b>Item</b></td>
          <td class="th1"><b>Descripción</b></td>
          <td class="th1"><b>Unidad de Medida</b></td>
          <td class="th1"><b>Cantidad</b></td>
          <td class="th1"><b>Monto Item Original</b></td>
          <td class="th1"><b>Monto '||lv_subtitle||' Actual</b></td>');
    -- Memorando N° 368-2011/SPLA-RAA


       ln_ley :=  f_get_primer_publicado(session__n_convoca)  ;


      if not (ag_ind_adred = 3 and ag_cod_entid_autoriza = '000008' and ln_cod_obj = 4 and t_tipo_consultoria = 2 and ln_ley = 1  ) then
          if ag_proc_tipo not in (11,23)  then
          usp_print('<td class="th1"><b>(*)Monto '||lv_subtitle||' Maximo</b></td>');
          end if;
     end if;


    usp_print('<td class="th1"><b>Monto '||lv_subtitle||' Item </b></td>');

          -- Memo 276-2010/spla-ecc
          if ln_cod_obj in (1,2,4) and ln_ley_29564 > 0 then
                    usp_print('<td class="th1">Art. 2 Ley 29564</td>');
          end if;

     usp_print('</tr>
      </thead>
       </table>');

    usp_print('
       </td>
     </tr>
     <tr>
        <td><div id="filas"></div></td>
     </tr>');

     usp_print('
     <tr>
        <td>');
        
     --Inicio KMerma SM-286-2019
     IF ag_ind_adred = 3 and ag_proc_tipo not in (11) THEN
         usp_print('<br><br>
              <b>(*)Porcentajes máximos para Adicionales:</b>
              <br><b>Bienes:</b> Hasta 25% (Art. 157.1 RLCE)
              <br><b>Servicios:</b> Hasta 25% (Art. 157.1 RLCE)
              <br><b>Obra:</b> Hasta 15% Entidad, mayor a 15% hasta 50% Contraloría (Art. 206.1 RLCE)
              <br><b>Consultoría de Obra:</b>
              <br><b>Elaboración de Expediente Técnico de Obra:</b> Hasta 25% (Art. 157.1 RLCE)
              <br><b>Supervisión de Obra:</b> Hasta 15% Entidad, mayor a 15% Contraloría (Art. 191)
              ');
     --Fin KMerma SM-286-2019
     ELSIf ag_ind_adred = 4 THEN

       usp_print('<br><br>
              <b>(*)Porcentajes máximos para Reducciones:</b>
              <br><b>Bienes:</b> Hasta 25 % (Art. 174)
              <br><b>Servicios:</b> Hasta 25 % (Art. 174)
              <br><b>Obra:</b> Hasta 25 % (Art. 41 - DL 1017)
              <br><b>Consultoria de Obra:</b>
              <br><b>Elaboración de Expediente Técnico de Obra:</b>Hasta 25% (Art. 174)
              <br><b>Supervisión de Obra:</b>Hasta 15% Entidad, mayor a 15% Contraloría(Art. 191)');
     END IF;
     usp_print(' </td>
     </tr>
     ');


    usp_print('</table>');
    usp_print('<input type="hidden"  name="ag_ind_adred"               value="'|| ag_ind_adred|| '" />');
    usp_print('<input type="hidden"  name="ag_trama_items"             value="" />');
    usp_print('<input type="hidden"  name="ag_cod_entid_autoriza"      value="'||ag_cod_entid_autoriza||'" />');
    usp_print('<input type="hidden"  name="ag_trama_calendario"        value="'||ag_trama_calendario||'" />');
    usp_print('<input type="hidden"  name="ag_nro_doc_cgr"             value="'||ag_nro_doc_cgr|| '" />');
    usp_print('<input type="hidden"  name="ag_fec_doc_cgr"             value="'||ag_fec_doc_cgr||'" />');
    usp_print('<input type="hidden"  name="ag_nro_doc_adicional"       value="'||ag_nro_doc_adicional||'" />');
    usp_print('<input type="hidden"  name="ag_fec_doc_adicional"       value="'||ag_fec_doc_adicional||'" />');
    usp_print('<input type="hidden"  name="ag_descripcion"             value="'||REG_PROCESOS.F_REPLACE_TILDES(ag_descripcion)||'" />');
    usp_print('<input type="hidden"  name="ag_tipo_doc_adicional"      value="'||ag_tipo_doc_adicional||'" />');
    usp_print('<input type="hidden"  name="ag_proc_tipo"               value="'||ag_proc_tipo||'" />');

        usp_print('<input type="hidden"  name="ag_cod_obj"               value="'||ln_cod_obj||'" />');
        usp_print('<input type="hidden"  name="ag_tipo_consultoria"               value="'||t_tipo_consultoria||'" />');

     usp_print('<input type="hidden"  name="ag_ley"               value="'||ln_ley||'" />');
    ----------------- Java Script --------------
    pku_procesos_comun.dojscript;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlAdicionalReduccion;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.fNumeros;
    PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlPaginacion;
    ----------------- Java Script --------------
    --PKU_SS_FUNCIONES_JS.js_script(' paginacion(xmlItems,10,1);');

 END;

/* FIN - NEW PROCEDURE uspnewadicionalitemdoedit */
/****************************************************************************************************/

procedure usplistadiconalesreducciones(
          session__n_convoca         VARCHAR2,
          session__cod_contrato      VARCHAR2,
          ag_tipo                       NUMBER
)
is

      CURSOR c_list_items
      IS
         SELECT DISTINCT ROWNUM num,
                         co.n_convoca,
                         a.ind_adicional_reduccion,
                         a.n_cod_contrato,
                         a.cod_adicional,
                         a.nro_doc_adicional,
                         ti.des_tipo_instrumento,
                         a.cant_adicional,
                         a.monto_adicional,
                         m.descripcion,
                         TO_CHAR (a.fec_doc_adicional,'dd/mm/yyyy') fec_doc_adicional,
                         a.concepto_adicional,
                         a.cod_entid_autoriza,
                         co.anhoentidad,
                         co.codconsucode
                    FROM reg_procesos.convocatorias co,
                         reg_procesos.contrato c,
                         reg_procesos.monedas m,
                         reg_procesos.adicional_reduccion a
         LEFT OUTER JOIN reg_procesos.t_tipo_instrumento ti  ON (ti.cod_tipo_instrumento = a.tipo_doc_adicional)
                   WHERE co.n_convoca               = c.n_convoca
                     AND c.n_cod_contrato           = a.n_cod_contrato
                     AND c.codmoneda_contrato       = m.codmoneda
                     AND c.n_convoca                = session__n_convoca
                     AND a.n_cod_contrato           = session__cod_contrato
                     AND a.ind_adicional_reduccion  = ag_tipo
                ORDER BY a.cod_adicional;


       ln_codobjeto                  NUMBER;
       lv_descripcion                VARCHAR2(50);
       lv_evento                     VARCHAR2(50);

  BEGIN


   IF ag_tipo = 1 THEN
      lv_descripcion :=  'Adicionales';
      lv_evento      :=  'ManAdicionalDoEdit';
   ELSIF ag_tipo = 2 THEN
      lv_descripcion :=  'Reducciones';
      lv_evento      :=  'ManReduccionDoEdit';
   END IF;



   ln_codobjeto :=  PKU_SS_UTILES.f_getcodobjeto (session__n_convoca);

   usp_print
     ('<table border="0" width=100% align=center class=table table-striped>
        <tr>
            <td colspan=8><h3>'||lv_descripcion||'</h3></td>
        </tr>

        <tr>
            <th class="th1">Nro</th>
            <th class="th1">Entidad que lo Autoriza</th>
            <th class="th1">Tipo de Documento <br> que lo Autoriza</th>
            <th class="th1">Documento <br>  que lo Autoriza</th>
            <th class="th1">Fecha del Documento <br> que lo Autoriza</th>
            <th class="th1">Moneda</th>
            <th style="text-align: right">Monto</th>
        ');

    IF (session__n_convoca IS NOT NULL and (ln_codobjeto = 3 OR ln_codobjeto = 4))  THEN
            usp_print ('<th class="th1">Concepto Adicional</th> ');
    END IF;

    usp_print ('</tr>');

   IF session__n_convoca IS NOT NULL THEN

        FOR ilist_adicional IN c_list_items LOOP

            usp_print('<td><b>'||makea('scriptdo='||lv_evento||'&ag_n_convoca='|| session__n_convoca || '&ag_cod_contrato='|| session__cod_contrato ||'&ag_cod_adicional='|| ilist_adicional.cod_adicional ||'&ag_fec_doc_adicional=' || ilist_adicional.fec_doc_adicional,ilist_adicional.cod_adicional)|| '</b></td>');


            IF (f_get_desc_entidadautoriza(ilist_adicional.cod_entid_autoriza,ilist_adicional.anhoentidad) = UPPER ('La Entidad lo Autorizo')) THEN
                 usp_print ('<td align="left">'|| f_get_desc_entidadautoriza (ilist_adicional.codconsucode ,ilist_adicional.anhoentidad)||'</td>');
            ELSE
                 usp_print('<td align="left">'|| f_get_desc_entidadautoriza(ilist_adicional.cod_entid_autoriza,ilist_adicional.anhoentidad)||'</td>');

            END IF;

            usp_print ('
                <td>'|| ilist_adicional.des_tipo_instrumento|| '</td>
                <td>'|| ilist_adicional.nro_doc_adicional||    '</td>
                <td>'|| ilist_adicional.fec_doc_adicional||    '</td>
                <td>'|| ilist_adicional.descripcion||          '</td>
                <td align="right">' || to_char(ilist_adicional.monto_adicional,pku_ss_constantes.gv_formato_dinero)||      '</td>');


            IF (session__n_convoca IS NOT NULL and (ln_codobjeto = 3 OR ln_codobjeto = 4) )THEN
                   usp_print('<td>'|| ilist_adicional.concepto_adicional|| '</td>');
            END IF;

            usp_print ('</tr>');

         END LOOP;

      END IF;

     usp_print ('</table>');

  END;

  PROCEDURE usplisadicionalesdoview (
      -- variables convenio marco
      ag_ncor_orden_pedido          VARCHAR2 DEFAULT '',
      ag_cm_opc                     VARCHAR2 DEFAULT '',
      ag_cm_oper_compra             VARCHAR2 DEFAULT '',
      --
      session__n_convoca            VARCHAR2,
      session__cod_contrato         VARCHAR2,
      session__PUBLICADO            varchar2
   )
   IS
      -------- declaracion de Variables -------
      ln_montoadicional             NUMBER;
      ln_montoreduccion             NUMBER;
      ln_n_convoca                  NUMBER;
      ln_n_cod_contrato             VARCHAR2(30);
      -- guarda monto total de los adicionales
      -- variable de convenio marco
      ln_ncor_orden_pedido          NUMBER;
      ln_cm_opc                     NUMBER;
      ln_cm_oper_compra             NUMBER;
      ln_monto_contratado           NUMBER;


      -- cursor para el listado Adicionales de procesos de Convenio Marco
      CURSOR c_list_adicionalcm
      IS
         SELECT DISTINCT '' n_convoca, a.ind_adicional_reduccion,
                         a.n_cod_contrato, a.cod_adicional,
                         a.nro_doc_adicional, ti.des_tipo_instrumento,
                         a.cant_adicional, a.monto_adicional,
                         m.descripcion,
                         TO_CHAR (a.fec_doc_adicional,'dd/mm/yyyy') fec_doc_adicional,
                         a.concepto_adicional
                    FROM reg_procesos.contrato c,
                         reg_procesos.monedas m,
                         reg_procesos.adicional_reduccion a LEFT OUTER JOIN reg_procesos.t_tipo_instrumento ti
                         ON (ti.cod_tipo_instrumento = a.tipo_doc_adicional)
                   WHERE c.n_cod_contrato     = a.n_cod_contrato
                     AND c.codmoneda_contrato = m.codmoneda
                     AND a.n_cod_contrato     = ln_n_cod_contrato
                ORDER BY a.cod_adicional;

      -- variables para listar los adicionales

      -------------------------------------------------------------
      vn_contrato            reg_procesos.contrato.n_contrato%TYPE;
      vcodconsucode          reg_procesos.convocatorias.codconsucode%TYPE;
      vanhoentidad           reg_procesos.convocatorias.anhoentidad%TYPE;
      v_cantidad             int;
      ag_f_vigencia_ini     varchar2(10);
      ag_f_vigencia_fin     varchar2(10);

  ln_modulo number;        -- (1/3) 12.09.2020 , permite verificar si las acciones sobre el contrato deben estas habilitados

   BEGIN
    v_cantidad:=0;
    jscript_vigencia;
      -------- Inicializa Variables -------

      IF (session__cod_contrato IS NOT NULL) THEN
         ln_n_convoca      := TO_NUMBER (session__n_convoca);
         ln_n_cod_contrato := TO_NUMBER (session__cod_contrato);
      ELSE
         usp_print
            (pku_procesos_comun.f_putmensaje
                ('Visualice el contrato antes de seleccionar la acci&oacute;n.<br>Retorne a la Consola de Contratos ...', ''));
         RETURN;
      END IF;

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


      ln_montoadicional    := 0;
      ln_montoreduccion    := 0;

      -- del convenio marco
      ln_ncor_orden_pedido := TO_NUMBER (ag_ncor_orden_pedido);
      ln_cm_opc            := TO_NUMBER (ag_cm_opc);
      ln_cm_oper_compra    := TO_NUMBER (ag_cm_oper_compra);


      --- SELECT PARA DATOS DE LA LISTA ADICIONAL

      BEGIN

         SELECT c.n_contrato INTO vn_contrato
           FROM reg_procesos.contrato c
          WHERE c.n_cod_contrato = ln_n_cod_contrato;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            vn_contrato := NULL;
      END;

      BEGIN

                select count(*) into v_cantidad
                from reg_procesos.contrato
                where n_cod_contrato = ln_n_cod_contrato
                and (f_vigencia_fin is null or f_vigencia_ini is null)
                and ind_version is null;

                if v_cantidad > 0 then
                select to_char(f_vigencia_ini, 'dd/mm/yyyy'), to_char(f_vigencia_fin, 'dd/mm/yyyy') into ag_f_vigencia_ini, ag_f_vigencia_fin
                from reg_procesos.contrato
                where n_cod_contrato = ln_n_cod_contrato
                and (f_vigencia_fin is null or f_vigencia_ini is null)
                and ind_version is null;
                end if;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
            vn_contrato := NULL;
        END;

      IF (ln_n_convoca IS NOT NULL) THEN
         BEGIN
            SELECT c.codconsucode,   c.anhoentidad INTO vcodconsucode,  vanhoentidad
              FROM reg_procesos.convocatorias c
             WHERE c.n_convoca = ln_n_convoca ;

         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               vn_contrato := NULL;
         END;

      END IF;

      -- hidden para retornar a la consola de contratos


      usp_print
         ('
  <script language="javascript">
    function Crear_Adicional()
    {
      thisform.scriptdo.value = "DoNewAdicionalEdit";
      thisform.submit();}

  </script>');


      -- Cabecera FORMULARIO adicionales
   usp_print('
     <div><input type="hidden" name="v_cantidad" value="'||v_cantidad||'" >
     <input type="hidden" name="v_codigo" value="'||session__cod_contrato||'" >
     <input type="hidden" name="v_tipo" value="1" >
     <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
        <tr>');

   usp_print(PKU_SS_UTILES.f_get_titulo_contrato (session__cod_contrato,'Adicionales / Reducciones'));

   usp_print
         ('<td align="right" valign=top width="50%">');
         if  v_cantidad > 0 then 
             usp_print('<input type="button" value="Guardar Vigencia" onclick=Grabar_Vigencia()>');
               else
                   -- (3/3) 12.09.2020, obtiene el indicador que verifica que las acciones esten habilitadas
                   if ln_modulo = 1 then 
                     usp_print('<input type="button" value="Crear Adicional / Reducci&oacute;n" onclick=Crear_Adicional()>');
                   end if;  
         end if;
         usp_print('
          </td>
        </tr>
      </table>
     </div>
    <br/>');


     usp_print
     ('<table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0 id="tbl_vigencia" style="display:none">
         <tr>
            <td colspan=8><h3>Indicar la vigencia del contrato</h3></td>
        </tr><tr>');

        usp_print('<tr><td class=c1 colspan=1>(*)Vigencia del contrato:</td><td class=c2 colspan=5>Inicio:<input class=CalSelect type="text" readonly name="ag_f_vigencia_ini" value="'
               || ag_f_vigencia_ini
               || '" size=16 '|| case when ag_f_vigencia_ini is not null then '' else ' onclick="calendario(this)" ' end ||'>&nbsp;&nbsp;Fin: <input class=CalSelect type="text" readonly name="ag_f_vigencia_fin" value="'
               || ag_f_vigencia_fin
               || '" size=16 '|| case when ag_f_vigencia_fin is not null then '' else ' onclick="calendario(this)" ' end ||'></td><td class=c3 colspan=2>&nbsp;Vigencia del contrato original</td></tr>');

        usp_print('        </tr>
       <br/>
        </table>
        ');





      -- Listado Adicionales no CONV MARCO
      IF ln_n_convoca IS NOT NULL THEN

         usplistadiconalesreducciones(session__n_convoca,session__cod_contrato,1);

         usp_print('<br><br>');

         usplistadiconalesreducciones(session__n_convoca,session__cod_contrato,2);

      END IF;

      -- Listado para convenio marco
      IF (ln_n_convoca IS NULL) THEN


         FOR ilist_adicionalcm IN c_list_adicionalcm LOOP
            -- para enlazarlo a la pantalla de mantenimiento Adicional
            IF (ilist_adicionalcm.ind_adicional_reduccion = 1)THEN

                  usp_print('<td align="center">'|| reg_procesos.pku_xportal_utils.ufutil_mkbtm(gv_pkname|| '.uspManAdicionalDoEdit','Editar','editarCM(this,'|| ln_n_convoca || ','|| ln_n_cod_contrato|| ','|| ilist_adicionalcm.cod_adicional|| ','|| ln_ncor_orden_pedido|| ','|| ln_cm_opc || ','|| ln_cm_oper_compra || ',')|| '</td>');

                  usp_print('<td align="center"><a href="?scriptdo='|| gv_pkname|| '.uspManAdicionalDoEdit&ag_n_convoca='|| ln_n_convoca || '&amp;ag_cod_contrato=' || ln_n_cod_contrato || '&amp;ag_cod_adicional='|| ilist_adicionalcm.cod_adicional|| '&amp;ag_ncor_orden_pedido='|| ln_ncor_orden_pedido|| '&amp;ag_cm_opc='|| ln_cm_opc|| '&amp;ag_cm_oper_compra='|| ln_cm_oper_compra|| '">'|| ilist_adicionalcm.cod_adicional|| '</a></td>');

                  usp_print ('<td>Adicional</td>');

                  ln_montoadicional := ln_montoadicional + TO_NUMBER (ilist_adicionalcm.monto_adicional);

            END IF;

            -- para enlazarlo a la pantalla de mantenimiento Reduccion
            IF (ilist_adicionalcm.ind_adicional_reduccion = 2)THEN

                  usp_print('<td align="center">'|| reg_procesos.pku_xportal_utils.ufutil_mkbtm( gv_pkname|| '.uspManReduccionDoEdit','Editar','editarCM(this,'|| ln_n_convoca || ','|| ln_n_cod_contrato || ','|| ilist_adicionalcm.cod_adicional || ','|| ln_ncor_orden_pedido || ','|| ln_cm_opc || ','|| ln_cm_oper_compra || ',')||'</td>');

                  usp_print('<td align="center"><a href="?scriptdo='|| gv_pkname|| '.uspManReduccionDoEdit&ag_n_convoca='|| ln_n_convoca||'&amp;ag_cod_contrato='|| ln_n_cod_contrato|| '&amp;ag_cod_adicional='|| ilist_adicionalcm.cod_adicional|| '&amp;ag_ncor_orden_pedido='|| ln_ncor_orden_pedido|| '&amp;ag_cm_opc='|| ln_cm_opc|| '&amp;ag_cm_oper_compra=' || ln_cm_oper_compra||'">'|| ilist_adicionalcm.cod_adicional||'</a></td>');

                  usp_print ('<td>Reduccion</td>');

                  ln_montoreduccion := ln_montoreduccion + TO_NUMBER (ilist_adicionalcm.monto_adicional);

            END IF;

            usp_print ('
                <td align="center">'|| ilist_adicionalcm.des_tipo_instrumento || '</td>
                <td align="center">'|| ilist_adicionalcm.nro_doc_adicional || '</td>
                <td align="center">'|| ilist_adicionalcm.fec_doc_adicional || '</td>
                <td align="center">'|| ilist_adicionalcm.cant_adicional    || '</td>
                <td align="center">'|| ilist_adicionalcm.descripcion       || '</td>
                <td align="right">' || ilist_adicionalcm.monto_adicional   || '</td>');
         END LOOP;

         usp_print ('</tr>');



      END IF;

      usp_print ('</table>
</td>
</tr>
</table>');


      SELECT m_contratado INTO ln_monto_contratado
        FROM reg_procesos.contrato
       WHERE n_cod_contrato = ln_n_cod_contrato AND n_convoca = ln_n_convoca;


      ---------- Java Script ---------------
      usp_print
         ('
       <script language="javascript">

              //editar la reduccion
              function editar(obj,nconvoca,ln_n_cod_contrato,ag_cod_adicional,objScrdo){
                thisform.ag_n_convoca.value=nconvoca;
                thisform.ag_cod_contrato.value=ln_n_cod_contrato;
                thisform.ag_cod_adicional.value=ag_cod_adicional;
                thisform.scriptdo.value=objScrdo;
                thisform.submit();
              }

            //editar el adicional
              function editarA(obj,nconvoca,ln_n_cod_contrato,ag_cod_adicional,ag_codconsucode,objScrdo){
                thisform.ag_n_convoca.value=nconvoca;
                thisform.ag_cod_contrato.value=ln_n_cod_contrato;
                thisform.ag_cod_adicional.value=ag_cod_adicional;
                thisform.ag_codconsucode.value=ag_codconsucode; //a pedido el lun_07-01-2008
                thisform.scriptdo.value=objScrdo;
                thisform.submit();

              }


            //para la parte de Convenio Marco (reduccion y adicional)
              function editarCM(obj,nconvoca,ln_n_cod_contrato,ag_cod_adicional,ag_ncor_orden_pedido,ag_cm_opc,ag_cm_oper_compra,objScrdo){
                thisform.ag_n_convoca.value=nconvoca;
                thisform.ag_cod_contrato.value=ln_n_cod_contrato;
                thisform.ag_cod_adicional.value=ag_cod_adicional;
                thisform.ag_cod_adicional.value=ag_cod_adicional;
                thisform.ag_ncor_orden_pedido.value=ag_ncor_orden_pedido;
                thisform.ag_cm_opc.value=ag_cm_opc;
                thisform.ag_cm_oper_compra.value=ag_cm_oper_compra;

                thisform.scriptdo.value=objScrdo;
                thisform.submit();
              }

              function crear(obj,ag_codconsucode,objScrdo){
                thisform.ag_codconsucode.value=ag_codconsucode;
                thisform.scriptdo.value=objScrdo;
                thisform.submit();
              }

            if (thisform.v_cantidad.value!= 0){
            alert("Complete las fechas de la vigencia del contrato.");
            }
             f_change_vigencia(thisform.v_cantidad.value);


       </script>
     ');


   END;


 PROCEDURE uspmanadicionaldoedit (
    ag_n_convoca               IN   VARCHAR2 DEFAULT '',
    ag_cod_contrato            IN   VARCHAR2 DEFAULT '',
    ag_cod_adicional           IN   VARCHAR2 DEFAULT '',
    ag_monto_adicional              VARCHAR2,
    ag_fec_doc_adicional            VARCHAR2,
    ag_nro_doc_adicional            VARCHAR2,
    ag_fec_doc_cgr                  VARCHAR2,                     -- del cgr
    ag_nro_doc_cgr                  VARCHAR2,                     -- del cgr
    ag_ncor_orden_pedido            VARCHAR2 DEFAULT '',
    ag_cm_opc                       VARCHAR2 DEFAULT '',
    ag_cm_oper_compra               VARCHAR2 DEFAULT '',
    session__cod_contrato           VARCHAR2,
    ag_trama_items                  VARCHAR2,
    ag_trama_calendario             VARCHAR2,
    --jgarciaf
    session__n_convoca           VARCHAR2 DEFAULT NULL----jgarciaf
    
 )
 IS
    -------- declaracion de Variables -------
    ln_n_convoca                  NUMBER;
    ln_n_cod_contrato             NUMBER;
    ln_ind_siaf                   NUMBER;
    ln_tot_cal_adicional          NUMBER;
    ln_id_operacion               NUMBER;

    ln_adic_reduc                 NUMBER;

    CURSOR c_cambio
    IS
       SELECT val_tipo_cambio cambio, codmoneda
         FROM reg_procesos.t_cat_tipo_cambio
        WHERE ind_vigente = 1;

    contr_n_cod_contrato          reg_procesos.contrato.n_cod_contrato%TYPE;
    contr_n_contrato              reg_procesos.contrato.n_contrato%TYPE;
    contr_m_contratado            reg_procesos.contrato.m_contratado%TYPE;
    contr_ruc_contratista         reg_procesos.contrato.ruc_contratista%TYPE;
    contr_nom_contratista         reg_procesos.contrato.nom_contratista%TYPE;
    --variables para la cabecera
    vn_contrato                   reg_procesos.contrato.n_contrato%TYPE;
    vf_contrato                   reg_procesos.contrato.f_contrato%TYPE;
    vn_convoca                    reg_procesos.convocatorias.n_convoca%TYPE;
    vn_proceso                    reg_procesos.convocatorias.n_proceso%TYPE;
    vanhoentidad                  reg_procesos.convocatorias.anhoentidad%TYPE;
    vproc_tipo                    reg_procesos.convocatorias.proc_tipo%TYPE;
    vproc_num                     reg_procesos.convocatorias.proc_num%TYPE;
    vproc_sigla                   reg_procesos.convocatorias.proc_sigla%TYPE;
    vproc_tipo_sigla              reg_procesos.tipo_procesos.proc_tipo_sigla%TYPE;
    vcodconsucode                 reg_procesos.convocatorias.codconsucode%TYPE;
    vdescripcion                  reg_procesos.adicional_reduccion.descripcion%Type;
    -- variable para el codigo objeto
    vn_codobjeto                  reg_procesos.convocatorias.codobjeto%TYPE;
    -- variables para el editar nodename "adicional"
    ad_cod_adicional              reg_procesos.adicional_reduccion.cod_adicional%TYPE;
    ad_cod_valorizacion           NUMBER;
    ad_ind_adicional_reduccion    VARCHAR2 (3);
    ad_n_cod_contrato             reg_procesos.adicional_reduccion.n_cod_contrato%TYPE;
    ad_tipo_doc_adicional         reg_procesos.adicional_reduccion.tipo_doc_adicional%TYPE;
    ad_nro_doc_adicional          reg_procesos.adicional_reduccion.nro_doc_adicional%TYPE;
    ad_cant_adicional             reg_procesos.adicional_reduccion.cant_adicional%TYPE;
    ad_unm_codigo_adicional       reg_procesos.adicional_reduccion.unm_codigo_adicional%TYPE;
    ad_monto_adicional            reg_procesos.adicional_reduccion.monto_adicional%TYPE;
    ad_codmoneda                  reg_procesos.adicional_reduccion.codmoneda%TYPE;
    ad_fec_doc_adicional          VARCHAR2 (10);
    ad_concepto_adicional         reg_procesos.adicional_reduccion.concepto_adicional%TYPE;
    ad_nro_doc_cgr                reg_procesos.adicional_reduccion.nro_doc_cgr%TYPE;
    ad_fec_doc_cgr                VARCHAR2 (10);
    ad_descripcion                reg_procesos.monedas.descripcion%TYPE;
    ad_desc_entidad_autoriza      reg_procesos.entidades.descripcion%TYPE;
    --nuevo requerimiento para adicional
    ad_cod_entid_autoriza         reg_procesos.adicional_reduccion.cod_entid_autoriza%TYPE;
    -- variables para el editar nodename "valorizacion"
    val_cod_valorizacion          reg_procesos.valorizacion.cod_valorizacion%TYPE;
    val_n_cod_contrato            reg_procesos.valorizacion.n_cod_contrato%TYPE;
    val_num_comprobante_pago      reg_procesos.valorizacion.num_comprobante_pago%TYPE;
    val_codmoneda                 reg_procesos.valorizacion.codmoneda%TYPE;
    val_monto_bruto               reg_procesos.valorizacion.monto_bruto%TYPE;
    val_monto_reajuste            reg_procesos.valorizacion.monto_reajuste%TYPE;
    val_monto_amortizacion        reg_procesos.valorizacion.monto_amortizacion%TYPE;
    val_monto_deduccion           reg_procesos.valorizacion.monto_deduccion%TYPE;
    val_monto_interes             reg_procesos.valorizacion.monto_interes%TYPE;
    val_monto_otros               reg_procesos.valorizacion.monto_otros%TYPE;
    val_monto_neto                reg_procesos.valorizacion.monto_neto%TYPE;
    val_monto_igv                 reg_procesos.valorizacion.monto_igv%TYPE;
    val_monto_total_pagado        reg_procesos.valorizacion.monto_total_pagado%TYPE;
    val_fec_valorizacion          VARCHAR2 (10);
    ag_ind_adred                  VARCHAR2 (1);
    -- Cursor
    ctipoinstrumento              ref_cursor;
    cmoneda                       ref_cursor;
    -- Combos
    lv_combo_tipoinstrumento      varchar2(4000);
    lv_combo_moneda               varchar2(4000);
    -- Items
    lv_trama_items                varchar2(32000);
    lv_trama_calendario           varchar2(18000);
    
    -- variables de los datos del upload--jgarciaf
      ln_NCOD_DOC                    NUMBER;-----jgarciaf
      lv_DOC_URL                     VARCHAR2(250);----jgarciaf
      lv_FEC_UPLOAD                  VARCHAR2(20);----jgarciaf
      lv_USER_UPLOAD                 VARCHAR2(30);----jgarciaf
      lv_FEC_APROB                   VARCHAR2(20);----jgarciaf
      lv_EXT_TIPO_FILE               VARCHAR2(250);----jgarciaf
      lv_ICON_TIPO_FILE              VARCHAR2(250);----jgarciaf
      lv_DOC_OBS                     VARCHAR2(250);----jgarciaf
      lv_id_adi                         NUMBER;----jgarciaf


 BEGIN

  -------- Funciones Script para Validaciones -------
  PKU_GESTOR_CONT_FUNCIONES_JS_3.fValidaCadenas_JS;

  -------- Inicializa Variables -------
  ln_n_convoca              := TO_NUMBER (ag_n_convoca);
  ln_n_cod_contrato         := TO_NUMBER (ag_cod_contrato);

  ln_ind_siaf               := f_ind_uso_siaf_modif (ag_cod_adicional);
  ln_id_operacion           := f_get_id_operacion (ag_cod_adicional);
  vn_codobjeto              := pku_ss_utiles.f_getcodobjeto(ln_n_convoca);

  -- select para obtener los datos del adicional a editar nodename ="adicional"
  BEGIN
     SELECT ar.cod_adicional,
            DECODE (ar.cod_valorizacion, NULL, NULL, ar.cod_valorizacion) cod_valorizacion,
            TRIM (TO_CHAR (ar.ind_adicional_reduccion, '999'))ind_adicional_reduccion,
            ar.n_cod_contrato, ar.tipo_doc_adicional,
            ar.nro_doc_adicional, ar.cant_adicional,
            ar.unm_codigo_adicional, ar.monto_adicional, ar.codmoneda,
            TO_CHAR (ar.fec_doc_adicional, 'dd/mm/yyyy')fec_doc_adicional,
            ar.concepto_adicional, ar.nro_doc_cgr,
            TO_CHAR (ar.fec_doc_cgr, 'dd/mm/yyyy') fec_doc_cgr,
            m.descripcion, ar.descripcion
       INTO ad_cod_adicional,
            ad_cod_valorizacion,
            ad_ind_adicional_reduccion,
            ad_n_cod_contrato, ad_tipo_doc_adicional,
            ad_nro_doc_adicional, ad_cant_adicional,
            ad_unm_codigo_adicional, ad_monto_adicional, ad_codmoneda,
            ad_fec_doc_adicional,
            ad_concepto_adicional, ad_nro_doc_cgr,
            ad_fec_doc_cgr,
            ad_descripcion,
            vdescripcion
       FROM reg_procesos.adicional_reduccion ar, reg_procesos.monedas m
      WHERE cod_adicional = TO_NUMBER (ag_cod_adicional)
        AND ar.codmoneda = m.codmoneda;

  END;


  ctipoinstrumento          := pku_ss_utiles.f_tipo_instrumento('1,5');
  cmoneda                   := reg_procesos.pku_ss_utiles.f_cmonedas;

  lv_combo_tipoinstrumento  := PKU_GESTOR_CONT_UTILES_3.f_retorna_combo(ctipoinstrumento, 'ag_tipo_doc_adicional', ad_tipo_doc_adicional,'Seleccione...','style="width:55%"');
  lv_combo_moneda           := PKU_GESTOR_CONT_UTILES_3.f_retorna_combo(cmoneda, 'ag_codmoneda_v', val_codmoneda,null,null);

  lv_trama_items            := nvl(ag_trama_items,PKU_GESTOR_CONT_UTILES_3.f_getXmlItemsAdionReduc(ln_n_cod_contrato,ag_cod_adicional));
  lv_trama_calendario       := nvl(ag_trama_calendario,PKU_GESTOR_CONT_UTILES_3.f_getXmlCalAdionReduc(ln_id_operacion));


  --select para obtener los datos de la valorizacion nodename "valorizacion"
  IF (ad_cod_valorizacion IS NOT NULL)THEN
     BEGIN
        SELECT cod_valorizacion, n_cod_contrato,
               num_comprobante_pago, codmoneda, monto_bruto,
               monto_reajuste, monto_amortizacion,
               monto_deduccion, monto_interes, monto_otros,
               monto_neto, monto_igv, monto_total_pagado,
               TO_CHAR (fec_valorizacion, 'dd/mm/yyyy') fec_valorizacion
          INTO val_cod_valorizacion, val_n_cod_contrato,
               val_num_comprobante_pago, val_codmoneda, val_monto_bruto,
               val_monto_reajuste, val_monto_amortizacion,
               val_monto_deduccion, val_monto_interes, val_monto_otros,
               val_monto_neto, val_monto_igv, val_monto_total_pagado,
               val_fec_valorizacion
          FROM reg_procesos.valorizacion
         WHERE cod_valorizacion = ad_cod_valorizacion;
                                 -- viene de arriba del select "adicional"
     END;
  END IF;

  -- select de  nodename ="contratos"
  BEGIN
     SELECT c.n_cod_contrato, c.n_contrato, c.m_contratado,
            c.ruc_contratista, c.nom_contratista
       INTO contr_n_cod_contrato, contr_n_contrato, contr_m_contratado,
            contr_ruc_contratista, contr_nom_contratista
       FROM reg_procesos.contrato c
      WHERE c.n_cod_contrato = ln_n_cod_contrato;
  END;

  ---- es para obtener datos del proceso  nodename="conv" -
  IF (ln_n_convoca IS NOT NULL)THEN
     BEGIN
        SELECT c.codconsucode, c.n_convoca, c.n_proceso, c.anhoentidad,
               c.proc_tipo, c.proc_num, c.proc_sigla, t.proc_tipo_sigla
          INTO vcodconsucode, vn_convoca, vn_proceso, vanhoentidad,
               vproc_tipo, vproc_num, vproc_sigla, vproc_tipo_sigla
          FROM reg_procesos.convocatorias c, reg_procesos.tipo_procesos t
         WHERE c.n_convoca = ln_n_convoca
           AND t.proc_tipo = c.proc_tipo;
     EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
           vn_contrato := NULL;
     END;

  END IF;

  -- descripcion de la entidad que autorizo el adelanto
  BEGIN


   usp_print( 'ag_cod_adicional:' || ag_cod_adicional);

     SELECT DISTINCT (e.codconsucode), e.descripcion
                INTO ad_cod_entid_autoriza, ad_desc_entidad_autoriza
                FROM reg_procesos.adicional_reduccion ad LEFT OUTER JOIN reg_procesos.entidades e
                     ON e.codconsucode = ad.cod_entid_autoriza
               WHERE ad.cod_adicional = TO_NUMBER (ag_cod_adicional)
                 AND e.anhoentidad = vanhoentidad;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
     ad_cod_entid_autoriza := 0;
     ad_desc_entidad_autoriza := UPPER('Cuando se Registro El Adicional No era Necesario una Entidad que lo Autorice');

  END;

  -- cabecera del formulario crear adicional--
  IF (ad_ind_adicional_reduccion = '1') THEN
     ag_ind_adred := '1';
  END IF;

  IF (ad_ind_adicional_reduccion = '2')THEN
     ag_ind_adred := '2';
  END IF;

  usp_print
     ('
  <div>
  <table border="0" width=100% align=center class=tableform cellpadding=3 cellspacing=0>
    <tr>');

  usp_print
      (PKU_SS_UTILES.f_get_titulo_contrato (session__cod_contrato,'Modificar Adicional'));

  SELECT COUNT(*)INTO ln_adic_reduc 
  FROM REG_PROCESOS.ADICIONAL_REDUCCION
  WHERE IND_ADICIONAL_REDUCCION IN (1,2) 
  AND N_COD_CONTRATO=session__cod_contrato; 
  
  if (ln_adic_reduc>0) then
  
          usp_print('
               </td>
               <td valign=top align=right>
               <input type="button" value="Volver" onclick="thisform.scriptdo.value=''LisAdicionalesDoView'';thisform.submit();">'
             );             
  else   
          usp_print('  
               </td>
               <td valign=top align=right>
               <input type="button" value="Volver" onclick="thisform.scriptdo.value=''LisAdicionalesDoView'';thisform.submit();">'
             );
          IF (ag_ind_adred = '1') THEN
             IF (f_ind_uso_siaf_modif (ad_cod_adicional) = 1)THEN
                usp_print
                   (   '<input type="button" value="Grabar" onclick="grabarAdd(''AdicionalAdicDoUpdate'','''
                    || ln_tot_cal_adicional|| ''')">');
             ELSE
                usp_print
                   ('<input type="button" value="Grabar" onclick="grabarAdd(''AdicionalAdicDoUpdate'',0)">' );
             END IF;
          END IF;
  end if;
    
  usp_print('</td>
       </tr>
     </table>
    </div>
  <br/>');

   -- los hidden de Adicional
   usp_print('<input type="hidden" name="ag_cgr" value="'|| nvl(ad_nro_doc_cgr,ag_nro_doc_cgr)|| '"/>');
   usp_print('
       <input type ="hidden" name="ag_n_convoca"             value="'|| ag_n_convoca|| '"/>
       <input type ="hidden" name="ag_cod_contrato"          value="'|| ag_cod_contrato|| '"/>
       <input type ="hidden" name="ag_concepto_adicional"    value=""/>
       <input type ="hidden" name="ag_m_contratado"          value="'|| contr_m_contratado|| '"/>
       <input type ="hidden" name="ag_cod_objeto"            value="'|| vn_codobjeto|| '"/>
       <input type ="hidden" name="ag_ind_siaf"              value="'|| ln_ind_siaf|| '"/>
       <input type ="hidden" name="ag_reg_cal_modif"         value=""/>
       <input type ="hidden" name="ag_id_motivo" />
       <input type ="hidden" name="ag_id_operacion"          value="'|| ln_id_operacion || '"/>
       <input type ="hidden" name="ag_id_op" />
       <input type ="hidden" name="ag_num_pago" />
       <input type ="hidden" name="ag_fec_pago" />
       <input type ="hidden" name="ag_monto_pago" />
       <input type ="hidden" name="ag_fecha_pago" />
       <input type ="hidden" name="ag_ncor_orden_pedido"     value="'|| ag_ncor_orden_pedido || '"/>
       <input type ="hidden" name="ag_cm_opc"                value="'|| ag_cm_opc|| '"/>
       <input type ="hidden" name="ag_cm_oper_compra"        value="'|| ag_cm_oper_compra|| '"/>
       <input type ="hidden" name="ag_cod_entid_autoriza"    value="'|| ad_cod_entid_autoriza|| '"/>
       <input type ="hidden" name="ag_cod_adicional"         value="'|| ag_cod_adicional||'" />
    ');

    usp_print('<input type ="hidden" name="ag_trama_items"          value="" />');

    -- para calcular si las cantidades son iguales
    usp_print('
              <input type ="hidden" name="an_total_items"           value=""/>
              <input type ="hidden" name="an_total_calendario"      value=""/>');

    usp_print('
    <table width=100% class="table table-striped">
    <tr>
        <td style="width:33%">Nmero del Contrato (u Orden de Compra o Servicio)</td>
        <td style="width:33%"><b>'|| contr_n_contrato||'</b></td>
        <td style="width:34%">Numero del Contrato</td>
    </tr>
    <tr>');

      IF (ad_ind_adicional_reduccion = '1') THEN
         usp_print('
        <td class=c1>Nmero de Adicional</td>
        <td class=c2><b>'|| ad_cod_adicional|| '</b></td>
        <td class=c3>Numero del Adicional Generado</td>
     </tr>
     <tr>
        <td class=c1>(*)Tipo</td>
        <td class=c2><b>ADICIONAL</b></td>
        <td class=c3>Tipo del Procedimiento</td>
     </tr>'
            );
      END IF;

   -- NUEVO REQUERIMIENTO (pinta la entidad que autorizo el adicional)
   usp_print('
    <tr>
        <td class=c1>(*)Autorizado por la Entidad</td>
        <td class=c2>'
         );

   IF (ad_ind_adicional_reduccion = '1') THEN

      IF (ad_cod_entid_autoriza = '0')  THEN
         usp_print
            ('<font color="green" face="arial, verdana, helvetica" size=1><b>'|| ad_desc_entidad_autoriza|| '</b></font>');
      ELSE
         usp_print ('<b>' || ad_desc_entidad_autoriza || '</b>');
      END IF;
   END IF;

   usp_print('
        </td>
        <td class=c3>Entidad que autoriza la operacion</td>
    </tr>');

   IF (ad_cod_entid_autoriza = '000008') THEN
     usp_print('
      <tr>
        <td class=c1>(*)Documento de autorizacion de (CGR)</td>
        <td class=c2><input name ="ag_nro_doc_cgr" value ="'|| nvl(ag_nro_doc_cgr,ad_nro_doc_cgr)|| '" size="54" class="form-control"/></td>
        <td class=c3>Numero de Documento de Autorizacion</td>
      </tr>');

      usp_print('<tr>
       <td class=c1>(*)Fecha del Documento autorizado por (CGR)</td>
       <td class=c2>
       
       <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fec_doc_cgr" value="'||nvl(ag_fec_doc_cgr,ad_fec_doc_cgr)||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control" readOnly/>
          </div>
          </td>
       <td class=c3>Fecha del Documento</td>
    </tr>');

    END IF;

    usp_print('
    <tr>
      <td class=c1>(*)Documento que autoriza la Operacion</td>
    <td class=c2>'||lv_combo_tipoinstrumento||'
        <input size=22 name="ag_nro_doc_adicional" class="form-control" maxlength="130" value="'|| nvl(ag_nro_doc_adicional,ad_nro_doc_adicional)|| '" onblur="ValidarString(this, ''Nmero de Documento'');" /></td>
    <td class=c3>Documento de Autorizacion</td>
    </tr>');
       
----jgarcia inicio
     
     
   
     
 -- datos del upload del contrato
   
   REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.P_last_upload_adicional( ag_cod_contrato, session__N_CONVOCA, ln_NCOD_DOC,lv_DOC_URL,lv_FEC_UPLOAD ,lv_USER_UPLOAD,lv_FEC_APROB ,lv_EXT_TIPO_FILE,lv_ICON_TIPO_FILE, lv_DOC_OBS,ag_cod_adicional);


 -----JGARCIAF----  DATOS DEL UPLOAD 
 
usp_print( '<tr align=center> <td colspan="4" align=center>' || case when lv_DOC_URL is not null then '<br><a target=_blank href="DownloadFileServlet?fileName='||lv_DOC_URL||'">
                <img src="'||lv_ICON_TIPO_FILE||'" border="0" width="25" height="25"/></a>' 
                end || case when lv_FEC_UPLOAD is not null then ' Registrado el '||lv_FEC_UPLOAD end||'<input type="hidden" name="pfiletoupload_file1" value=""/>
                       
          </td>
          </tr>');
    
 ---jgarcia fin




    usp_print('
    <tr>
    <td class=c1>(*)Fecha del Documento que autoriza la Operacion</td>
    <td class=c2>
    
    <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fec_doc_adicional" readonly value="'||nvl(ag_fec_doc_adicional,TO_CHAR (SYSDATE, 'dd/mm/yyyy'))||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control" readOnly/>
          </div>
    <td class=c3>Fecha del Documento</td>');
    usp_print('</tr>');

    usp_print(
        PKU_PROCESOS_COMUN.f_putRowForm('(*)Descripci&oacute;n',
            '<input class="form-control" name="ag_descripcion" size="54" value="'||vdescripcion||'" maxlength="80">',
            'Descripci&oacute;n del Adicional o Reducci&oacute;n'));

    --Moneda del contrato oculto y la descripcion
    usp_print(
        PKU_PROCESOS_COMUN.f_putRowForm('(*)Moneda',
            '<input class="form-control" size=54 name="ag_codmoneda" value="'|| ad_codmoneda|| '" type="hidden"/><b>'|| ad_descripcion|| '</b>',
            'Moneda del Contrato'));

    usp_print(
        PKU_PROCESOS_COMUN.f_putRowForm('(*)Monto (En la Moneda del Contrato)',
            '<input size=54 class="form-control" name="ag_monto_adicional" value="'|| nvl(ag_monto_adicional,ad_monto_adicional) || '"/>',
            'Monto del Item'));

    usp_print('</table>
     <br>');

 usp_print('<table style="width:40%" id=cal_idtablex align=left class="cTableCalendarioPago" >');

 IF (f_ind_uso_siaf_modif (ad_cod_adicional) = 1) THEN
     usp_print('<tr><td colspan=3><h3>Calendario</h3></td></tr>
      <tr><td align=center colspan=3>');
      usp_print(lv_trama_calendario);
   --   reg_procesos.pku_ss_funciones_js3.fXmlCalendario(ad_codmoneda,lv_trama_calendario,'an_total_calendario');
      usp_print ('</TD></tr>');
 END IF;
 usp_print ('</table>');



 IF lv_trama_items IS NOT NULL  THEN

   usp_print('<tr><td><h3>Items</h3></td></tr>');
   usp_print('<tr align=center>');
   usp_print('<TD colspan="4" align=center>');
   PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlItemsReader(lv_trama_items,'an_total_items');
   usp_print('</TD></TR>');

 END IF;

 
 
 usp_print('<script>
  function redondear( num, dec )
        {
            num = parseFloat(num);
            dec = parseFloat(dec);
            dec = (!dec ? 2 : dec);
            return Math.round(num * Math.pow(10, dec)) / Math.pow(10, dec);
        }
    
 
     var total = 0;
 $("#idBotonAgregarCalendario").on("click", function(){
 
      var mont = $(this).parent().parent().children().eq("2").children().val();
      var fec = $(this).parent().parent().children().eq("1").children().children(".fecCalendar").val();
     // total = total+ parseFloat(mont);  
     // thisform.an_total_calendario.value = total;
      if(mont !== "" && fec !==""){
              $(''.cTableCalendarioPago tr:last'').after("<tr class=''cFilaCalendario''>"+
                              "<td class=rowIndexCalendario></td>"+
                              "<td><div class=''input-group datepicker'' onclick=''calendarRow($(this))''  id=''idDivTxtFechaIni''><div class=''input-group-addon add-on''><span class=''glyphicon glyphicon-calendar''></span></div><input type=''text'' readonly name=''ag_cal_fec_pago'' value=''"+fec+"'' style=''width:98%'' data-format=''dd/MM/yyyy'' class=''form-control fecCalendar'' /></div></td>"+                              
                              "<td><input class=''cag_cal_monto_pago'' name=''ag_cal_monto_pago'' value=''"+mont+"'' type=text onKeyPress=''f_validaCampoNumerico();'' onBlur=''this.value = redondear(this.value,2); calculaTotalCalendario()'' /></td>"+ 
                              "<td align=center><img onclick=''deleteRowCalendario(this);'' alt=''Elimnar'' src=''http://172.16.2.12:87/img/eliminar.gif''/></td>"+                              
                              "</tr>");
                              $(this).parent().parent().children().eq("2").children().val('''');
                              $(this).parent().parent().children().eq("1").children().children(".fecCalendar").val('''');
                              enumeraItemCalendario();
                              calculaTotalCalendario();
   }});
                              
      function enumeraItemCalendario(){
       var i = 0;
       $(".rowIndexCalendario").each(function(){
           i++;
           $(this).text(i);
       })}
     
      function deleteRowCalendario(indice){
        tableId = document.getElementById("cal_idtablex");
        rest = indice.parentNode.parentNode.childNodes.item(2).childNodes.item(0).value;
        tableId.deleteRow(indice.parentNode.parentNode.rowIndex);
        enumeraItemCalendario();
        calculaTotalCalendario();
      }
     
     function calculaTotalCalendario(){
        var total = 0;
        $(".cag_cal_monto_pago").each(function(){
             total = total + parseFloat($(this).val());                                  
        });
        $("#idSumTotal").text(total);
        thisform.an_total_calendario.value = total;
      }
     
     function generacionTramaCalendario(){
        var xmlCalendario = "";
        xmlCalendario = xmlCalendario+"<root>";
        $(".cFilaCalendario").each(function(){
        xmlCalendario = xmlCalendario+"<calendario>"+
        "<fecha>"+$(this).children().eq(''1'').children().children(''.fecCalendar'').val()+"</fecha>"+
        "<monto>"+$(this).children().eq(''2'').children().val()+"</monto>"+         
        "<control></control>"+                  
        "<id></id>"+         
        "<moneda></moneda>"+
        "<numpago>"+$(this).children().eq(''0'').text()+"</numpago>"+
                      "</calendario>"    
       });
       xmlCalendario = xmlCalendario+"</root>";  
       thisform.ag_trama_calendario.value = xmlCalendario;
     }
   
   function f_validaCampoNumerico()
    {
        escribe=1;
        var key=window.event.keyCode;            //codigo de tecla.
        if (key <46 || key > 57 || key==47){     //si no es numero o punto decimal "."
            window.event.keyCode=0;                  //anula la entrada de texto.
        }
    }
     
     </script>');

 --------  Datos de Valorizaciones
 IF (vn_codobjeto = 3 OR vn_codobjeto = 4 ) THEN

    usp_print('
    <br/><br/>

<center>
    <table class="table table-striped" style="width:50%">
        <tr>
           <td><h3>Valorizaciones</h3></td>
           <td></td>
           <td></td>                      
        </tr>
        <tr>
          <td class=c1>Nmero de Valorizacin</td>
          <td class=c2><input size=54 readonly="" class="form-control" name="ag_cod_valorizacion" value="'
             || val_cod_valorizacion|| '"/></td>
          <td class=c3>Numero de Valorizacion</td>
        </tr>
        <tr>
          <td class=c1>Comprobante de Pago N</td>
          <td class=c2><input size=54 class="form-control" name="ag_num_comprobante_pago" value="'|| val_num_comprobante_pago|| '"/></td>
          <td class=c3>Comprobante de Pago</td>
        </tr>
        <tr>
          <td class=c1>Moneda de Valorizacin</td>
          <td class=c2>'||lv_combo_moneda||'</td>
          <td class=c3>Moneda de Valorizacin</td>
        </tr>
        <tr>
          <td class=c1>Monto Valorizado Bruto</td>
          <td class=c2><input size=54 name="ag_monto_bruto" class="form-control" value="'|| val_monto_bruto|| '"/></td>
          <td class=c3>Monto Valorizado Bruto</td>
        </tr>
        <tr>
          <td class=c1>Monto de Reducci&oacute;n</td>
          <td class=c2><input size=54 name="ag_monto_reajuste" class="form-control" value="'|| val_monto_reajuste || '"/></td>
          <td class=c3>Monto de Reducci&oacute;n</td>
        </tr>
        <tr>
          <td class=c1>Amortizaciones</td>
          <td class=c2><input size=54 name="ag_monto_amortizacion" class="form-control" value="'|| val_monto_amortizacion|| '"/></td>
          <td class=c3>Amortizaciones</td>
        </tr>
        <tr>
          <td class=c1>Deducciones</b></td>
          <td class=c2><input size=54 name="ag_monto_deduccion" class="form-control" value="'|| val_monto_deduccion|| '"/></td>
          <td class=c3>Deducciones</b></td>
        </tr>
        <tr>
          <td class=c1>Intereses</td>
          <td class=c2><input size=54 name="ag_monto_interes" class="form-control" value="'|| val_monto_interes|| '"/></td>
          <td class=c3>Intereses</td>
        </tr>
        <tr>
          <td class=c1>Otros</td>
          <td class=c2><input size=54 name="ag_monto_otros" class="form-control" value="'|| val_monto_otros|| '"/></td>
          <td class=c3>Otros</td>
        </tr>
        <tr>
          <td class=c1>Monto Valorizado Neto</td>
          <td class=c2><input size=54 name="ag_monto_neto" class="form-control" value="'|| val_monto_neto|| '"/></td>
          <td class=c3>Monto Valorizado Neto</td>
        </tr>
        <tr>
          <td  class=c1>IGV</td>
          <td  class=c2><input size=54 name="ag_monto_igv" class="form-control" value="'|| val_monto_igv|| '"/></td>
          <td  class=c3>IGV</td>
        </tr>
        <tr>
          <td class=c1>Monto Total Pagado</td>
          <td class=c2><input size=54 name="ag_monto_total_pagado" class="form-control" value="'|| val_monto_total_pagado|| '"/></td>
          <td class=c3>Monto Total Pagado</td>
        </tr>
        <tr>
          <td class=c1>Fecha de Valorizacin</td>
          <td class=c2>
          <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fec_valorizacion" value="'||val_fec_valorizacion||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control"/>
          </div>
          </td>
          <td class=c3>Fecha de Valorizacin</td>
        </tr>
        <tr>
          <td class=c1>Concepto Adicional</td>
          <td class=c2><input size=54 name="ag_concepto" class="form-control" value="'|| ad_concepto_adicional|| '"/></td>
          <td class=c3>Concepto Adicional</td>
        </tr>
   </table>
  </center> 
<br>'
            );
-- botones
      END IF;


      -- fin de la tabla de datos a completar --Adicional
  usp_print('
    <input type="hidden" name="ag_f_contrato" value="'|| vf_contrato|| '"/>
    <input type="hidden" name="ag_objeto"     value="'|| vn_codobjeto|| '"/>
    ' );


usp_print('<input type="hidden"  name="ag_trama_calendario" value="" />');

  -------- Java Script para Adicional y reduccion --------
  usp_print('
        <script language="javascript">

       //para la validacion en valorizacion
          var cambio        = new Array();
          var mon           = new Array();
          i = 0;'
         );

      FOR c_camb IN c_cambio LOOP
         BEGIN
            usp_print('
                cambio[i] ='|| to_char(c_camb.cambio, '999,999,999,999.00') || '
                   mon[i] ='|| c_camb.codmoneda || '
                   i++; ');
         END;
      END LOOP;

  usp_print('
  function ValidarString(ls_obj, ls_mensage)
  {
      var strCadena = ls_obj.value;
      var valido= "ABCDEFGHIJKLMNOPQRSTUVWYXZ0123456789abcdefghijklmnopqrstuvwxyz#$%()=*+}{[]-:,.!?&/ ";
      var flag=0;

      for (i = 0 ; i <= strCadena.length - 1; i++)
        {
           if(!vacio(trim(strCadena.substring(i,i+1)))){
              if (valido.indexOf (strCadena.substring(i,i+1),0) == -1)
              {
                ls_obj.select();
                //alert("Hay un caracter no permitido en el campo " + ls_mensage + "\nel caracter no permitido es ( "+strCadena.substring(i,i+1)+" )");
                ls_obj.focus();
                flag =1;

              }
           }
        }

      if ( flag ==1 ){
          alert("Hay un caracter no permitido en el Nro. de Documento que autoriza la Operacin");
          ls_obj.value="";

        return false;
      }else{
        return true;
      }
  }

  function vacio(ls_cadena) {
      if (ls_cadena == " " || ls_cadena == null || ls_cadena.length == 0)
          return true;
      else return false;
  }


 function f_changetipo(obj)
  {
      thisform.scriptdo.value="NewAdicionalDoEdit";
      thisform.submit();
  }


  function ValidarCambio(obj){
      var thisform=getForm(obj);

    //  alert(" estoy en validarCambio ");
      monto = parseFloat(thisform.ag_monto_adicional.value);
      for(i=0; i<cambio.length; i++){
          if(thisform.ag_codmoneda.value == mon[i]){
              monto = monto*cambio[i];
            //  alert("monto:"+monto)
          }
      }
      //  alert("monto:"+monto);
      return monto;
  }


  function ValidarCGR(){
    var resultado;
       if(ValidarBlanco  (thisform.ag_nro_doc_cgr  ,"Documento autorizado por CGR")  && ValidarBlanco  (thisform.ag_fec_doc_cgr  ,"Fecha del documento autorizado por CGR")  &&          ValidarFecha   (thisform.ag_fec_doc_cgr  ,"Fecha del documento autorizado por CGR")){
            resultado = true;
       }else{
            resultado = false;
       }
   return resultado;
  }

  function ValidarSuma(obj){
      // alert(" estoy en ValidarSuma ");
      var pago = ValidarCambio(obj);
      var msg  = "";
        // alert("pago:"+pago)
        // alert("m_contrato:"+thisform.ag_m_contratado.value)

      porcentaje  = parseFloat(thisform.ag_m_contratado.value)*0.15;
      msg = "Como el monto adicional ( "+pago +" ) es mayor al 15% del monto contractual ("+porcentaje+"). Debe Ingresar el documento y la fecha de autorizacin por CGR\nSi ya lo hizo solo es una Aclaracion Continue.. ";

      if(pago>porcentaje){

          alert(msg);

          if(thisform.ag_cod_entid_autoriza.value ==000008)
              {
                if(ValidarCGR(obj))
                 return true;
                else
                 return false;
              }

        }
        else
           return true;
  }

  function valorizacion(obj){
      if(
           /* ValidarSuma(obj) &&*/
            ValidarBlanco  (thisform.ag_num_comprobante_pago          ,"Comprobante de pago")                   &&
            ValidarBlanco  (thisform.ag_monto_bruto                   ,"Monto Valorizado Bruto")                &&
            ValidarDecimal (thisform.ag_monto_bruto                   ,"Monto Valorizado Bruto")                &&
            ValidarBlanco  (thisform.ag_monto_reajuste                ,"Monto de Reajuste")                     &&
            ValidarDecimal (thisform.ag_monto_reajuste                ,"Monto de Reajuste")                     &&
            ValidarBlanco  (thisform.ag_monto_amortizacion            ,"Amortizaciones")                        &&
            ValidarDecimal (thisform.ag_monto_amortizacion            ,"Amortizaciones")                        &&
            ValidarBlanco  (thisform.ag_monto_deduccion               ,"Deducciones")                           &&
            ValidarDecimal (thisform.ag_monto_deduccion               ,"Deducciones")                           &&
            ValidarBlanco  (thisform.ag_monto_interes                 ,"Intereses")                             &&
            ValidarDecimal (thisform.ag_monto_interes                 ,"Intereses")                             &&
            ValidarBlanco  (thisform.ag_monto_otros                   ,"Otros")                                 &&
            ValidarDecimal (thisform.ag_monto_otros                   ,"Otros")                                 &&
            ValidarBlanco  (thisform.ag_monto_neto                    ,"Monto Valorizado Neto")                 &&
            ValidarDecimal (thisform.ag_monto_neto                    ,"Monto Valorizado Neto")                 &&
            ValidarBlanco  (thisform.ag_monto_igv                     ,"IGV")                                   &&
            ValidarDecimal (thisform.ag_monto_igv                     ,"IGV")                                   &&
            ValidarBlanco  (thisform.ag_monto_total_pagado            ,"Monto Total Pagado")                    &&
            ValidarDecimal (thisform.ag_monto_total_pagado            ,"Monto Total Pagado")                    &&
            ValidarBlanco  (thisform.ag_fec_valorizacion              ,"Fecha de Valorizacin")                 &&
            ValidarFecha   (thisform.ag_fec_valorizacion              ,"Fecha de Valorizacin")  )
        {
            if(thisform.ag_cod_entid_autoriza.value==000008)
              { if(ValidarCGR(obj)) return true;
                else return false;
              }
            else
              return true; //osea no es contraloria
         }
    else return false;

  }// fin de la funcion que valida valorizacion

  function grabarAdd(pagina,valor)
   {
   if (thisform.ag_cod_entid_autoriza.value == "" )
   {
          alert("Por Favor seleccione entidad Que autoriza el Adicional");
          thisform.ag_cod_entid_autoriza.focus();
          return false ;
   }

  if ( !ValidarBlanco(thisform.ag_nro_doc_adicional,"Documento que autoriza la operacin" ) )
    {
          return false;
    }

  if (thisform.ag_monto_adicional.value == 0 )
   {
          alert("El monto del contrato no puede ser 0, debe agregar los adicionales a nivel de Item");
          thisform.ag_monto_adicional.focus();
          return false ;
   }





   //alert (thisform.an_total_calendario.value)
   //alert (eval(thisform.ag_monto_adicional.value))

/*
   if('|| ln_ind_siaf || '==1 && redondear(thisform.an_total_calendario.value,2) != eval(thisform.ag_monto_adicional.value))
   {
        alert("El monto ingresado en el campo Monto no coincide con el monto ingresado en el Calendario de Pago, corrija e intente nuevamente")
        thisform.ag_monto_adicional.focus();
        return false;
   }
*/

/*  if(!valorizacion())
   {
         return false;
   } */

   if (thisform.ag_cod_entid_autoriza.value== "000008" )
   {
           if(!ValidarCGR())  return false;
   }


   //thisform.ag_trama_items.value = xmlItems.xml;
  // thisform.ag_trama_calendario.value = xmlCalendario.xml;
  generacionTramaCalendario();
   thisform.scriptdo.value=pagina;
   thisform.submit();
   return;

 }
 </script>');

   END;

----------------------------------------------------------------------------------------------------
--  procedure para insertar la reduccion y actualiza otras tablas
----------------------------------------------------------------------------------------------------
   PROCEDURE uspadicionalreddoinsert (
      session__n_convoca           VARCHAR2 DEFAULT NULL,
      session__cod_contrato        VARCHAR2 DEFAULT NULL,
      ag_nro_doc_adicional            VARCHAR2,
      ag_tipo_doc_adicional           VARCHAR2,
      ag_cant_adicional               VARCHAR2,
      ag_unm_codigo_adicional         VARCHAR2,
      ag_monto_adicional              VARCHAR2,
      ag_codmoneda                    VARCHAR2,
      ag_fec_doc_adicional            VARCHAR2,
      ag_concepto_adicional           VARCHAR2,
      ag_nro_doc_cgr                  VARCHAR2,
      ag_fec_doc_cgr                  VARCHAR2,
      ag_ind_siaf                     VARCHAR2,
      -- de las valorizaciones objeto 3 y 4
      ag_num_comprobante_pago         VARCHAR2,
      ag_monto_bruto                  VARCHAR2,
      ag_monto_reajuste               VARCHAR2,
      ag_monto_amortizacion           VARCHAR2,
      ag_monto_deduccion              VARCHAR2,
      ag_monto_interes                VARCHAR2,
      ag_monto_otros                  VARCHAR2,
      ag_monto_neto                   VARCHAR2,
      ag_monto_igv                    VARCHAR2,
      ag_monto_total_pagado           VARCHAR2,
      ag_fec_valorizacion             VARCHAR2,
      ag_codmoneda_v                  VARCHAR2,
      ag_m_contratado                 VARCHAR2,
      -- indica que se modifico alguna fila para crear la reduccion
      ag_ncor_orden_pedido       IN   VARCHAR2 DEFAULT '',
      -- variables convenio marco
      ag_cm_opc                  IN   VARCHAR2 DEFAULT '',
      ag_cm_oper_compra          IN   VARCHAR2 DEFAULT '',
      -- variables para regresarlas al listado de Contratos
      ag_anhoentidad                  VARCHAR2 DEFAULT NULL,
      ag_proc_tipo                    VARCHAR2 DEFAULT NULL,
      ag_proc_desc                    VARCHAR2 DEFAULT NULL,
      ag_proc_sigla                   VARCHAR2 DEFAULT NULL,
      ag_currenpage                   VARCHAR2,
      --- para cargar archivo
      session__eue_codigo            VARCHAR2 DEFAULT NULL ,---JGARCIAF
       session__anhoentidad            VARCHAR2 DEFAULT NULL,---JGARCIAF
       pfiletoupload1             VARCHAR2,--jgarcia
      pfiletoupload_file1             VARCHAR2,--jgarcia
      SizeFile                        varchar2,--jgarcia
      session__USERID                 VARCHAR2,--jgarcia
      iisenv__remote_host             VARCHAR2,--jgarcia
      WriteFileDirectoryDynamic       VARCHAR2,--jgarcia
      ag_trama_items                  VARCHAR2 default null
   )
   IS

      ----------- Variables ---------
      ln_cod_contrato               NUMBER;
      ln_cod_moneda                 NUMBER;
      ln_tipo_doc_adicional         NUMBER;
      ln_cant_adicional             NUMBER;
      ln_ind_adred                  NUMBER;
      ln_unm_codigo_adicional       NUMBER;
      ag_n_convoca                  VARCHAR2 (50);
      ag_cod_contrato               VARCHAR2 (50);
      ln_codmoneda_v                NUMBER;
      ln_suma_restom                NUMBER;
      ln_ind_siaf                   NUMBER;

        --JGARCIA
        
         lv_directorio            varchar2(50);  ---jgarciaf
         lv_ruta                  varchar2(50); ---jgarciaf
         lv_anhoentidad           varchar2(4); ---jgarciaf
         lv_eue_codigo            varchar2(50); ---jgarciaf
         lv_codtipofile           VARCHAR2(20);---jgarciaf
         lv_id_redu                 NUMBER ;    ---jgarciaf
       
         

      ln_valida_rango               NUMBER;

   BEGIN

      ag_n_convoca             := session__n_convoca;
      ag_cod_contrato          := session__cod_contrato;
      ln_cod_contrato          := TO_NUMBER (session__cod_contrato);
      ln_tipo_doc_adicional    := TO_NUMBER (ag_tipo_doc_adicional);
      ln_cant_adicional        := TO_NUMBER (ag_cant_adicional);
      ln_ind_adred             := 2;
      ln_unm_codigo_adicional  := TO_NUMBER (ag_unm_codigo_adicional);
      ln_cod_moneda            := TO_NUMBER (ag_codmoneda);
      ln_codmoneda_v           := TO_NUMBER (ag_codmoneda_v);
      ln_ind_siaf              := f_ind_uso_siaf(ag_cod_contrato);

   /* 003-SM aramirez inicio*/
        
              select * into consucode,proveedor,proceso,nconvoca,fcontra,npropuesta from table(f_get_emp_dets(session_cod_contrato));
              
                
              
           if (consucode='002433' and proceso='SEL') or (consucode='002433' and proceso='ABR') or (consucode='002433' and proceso='COM') then
                  
                   lb_validacion_rnp2 := f_valida_rnp_contrato(proveedor,nconvoca,ag_fec_doc_adicional,npropuesta,lb_estado_inha);
                       
                      if  lb_validacion_rnp2 then
                                 
                                                             -- Verificamos que el adicional o reduccion se encuentre dentro de la vigencia del contrato
                              select count(1) into  ln_valida_rango
                                from reg_procesos.contrato x
                               where x.n_cod_contrato = ag_cod_contrato
                                 and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) >= trunc(x.f_vigencia_ini)
                              /*   and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) <= trunc(x.f_vigencia_fin);*/
                              and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) <= trunc(pku_ss_utiles.f_get_fecha_fin_amp(ag_cod_contrato));
                        
                              IF ln_valida_rango = 0  THEN
                        
                                    usp_print(
                                    pku_procesos_comun.f_putMensaje(
                                        'La fecha del Adicional o Reduccion se debe encontrar dentro de la vigencia del contrato.
                                        <br>Retorne a la Consola de Contratos',
                                        '')
                                );
                                RETURN;
                              END IF;
                        
                        
                        ------------------------- Obtiene el tipo de archivo JGARCIAF -------------------------------------
                        
                           BEGIN
                                --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
                                select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
                           EXCEPTION
                           WHEN OTHERS THEN
                                  usp_print(
                                        pku_procesos_comun.f_putMensaje(
                                            'Error: Al intentar registrar el archivo del Adicional/Reduccion',
                                            '')
                                    );
                                   return;
                           END;
                        
                           ------------------------- Fin de Obtiene el tipo de archivo  JGARCIAF------------------------------
                        
                        
                        
                              ---------- Ingresar la reduccion o Adicional ----------
                              INSERT INTO reg_procesos.adicional_reduccion
                                          (n_cod_contrato,
                                           nro_doc_adicional,
                                           tipo_doc_adicional,
                                           cant_adicional,
                                           ind_adicional_reduccion,
                                           unm_codigo_adicional,
                                           monto_adicional,
                                           codmoneda,
                                           fec_doc_adicional,
                                           concepto_adicional, nro_doc_cgr,
                                           fec_doc_cgr
                                          )
                                   VALUES (ln_cod_contrato,
                                           ag_nro_doc_adicional,
                                           ln_tipo_doc_adicional,
                                           ln_cant_adicional,
                                           ln_ind_adred,
                                           ln_unm_codigo_adicional,
                                           TO_NUMBER (replace(ag_monto_adicional, ',','.'), '99999999999.99'),
                                           ln_cod_moneda,
                                           TO_DATE (ag_fec_doc_adicional, 'dd/mm/yyyy'),
                                           ag_concepto_adicional, ag_nro_doc_cgr,
                                           TO_DATE (ag_fec_doc_cgr, 'dd/mm/yyyy'));
                        
                        
                        
                        ---- jgarciaf inicio
                             
                           lv_anhoentidad := ag_anhoentidad;
                           lv_eue_codigo := session__eue_codigo;    
                           lv_directorio := gpk_directorio_adicred;
                           lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||ag_n_convoca; 
                          
                           usp_print('
                             <input type ="hidden" name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=text>
                             <input type ="hidden" name=WriteFileDirectory value="FileSinged" type=text>
                           ');
                           
                           
                          
                             BEGIN
                          
                                    select max(Cod_Adicional) into lv_id_redu from REG_PROCESOS.Adicional_Reduccion where n_cod_contrato=ln_cod_contrato;
                                    
                                    
                                REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.p_insUploadReduccion(
                                      reg_procesos.f_get_min_n_convoca(session__N_CONVOCA),
                                      TO_DATE (ag_fec_doc_adicional,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                                      'NULL',--doc_obs,
                                      lv_codtipofile,
                                      pfiletoupload_file1,
                                      SizeFile,
                                      session__userid,
                                      iisenv__remote_host,
                                      WriteFileDirectoryDynamic,
                                      ln_cod_contrato,
                                      lv_id_redu);
                                      
                                      
                           EXCEPTION
                              WHEN OTHERS THEN
                                  usp_print(
                                        pku_procesos_comun.f_putMensaje(
                                            'Error: Al intentar registrar el Documento de la Reduccion',
                                            '')
                                    );
                                   return;
                        
                           END;
                           
                        ----- jgarciaf fin
                        
                        
                              ------------- Ingresar la valorizacion -----------------
                              IF (ag_monto_bruto IS NOT NULL) THEN
                                 BEGIN
                                    INSERT INTO reg_procesos.valorizacion
                                                (n_cod_contrato, num_comprobante_pago,
                                                 codmoneda,
                                                 monto_bruto,
                                                 monto_reajuste,
                                                 monto_amortizacion,
                                                 monto_deduccion,
                                                 monto_interes,
                                                 monto_otros,
                                                 monto_neto,
                                                 monto_igv,
                                                 monto_total_pagado,
                                                 fec_valorizacion
                                                )
                                         VALUES (ln_cod_contrato, ag_num_comprobante_pago,
                                                 ln_codmoneda_v,
                                                 --TO_NUMBER (ag_monto_bruto, '99999999.99'),
                                                 TO_NUMBER (replace(ag_monto_bruto, ',','.'), '99999999999.99'),
                                                 --TO_NUMBER (ag_monto_reajuste, '99999999.99'),
                                                 TO_NUMBER (replace(ag_monto_reajuste, ',','.'), '99999999999.99'),
                                                 --TO_NUMBER (ag_monto_amortizacion, '99999999.99'),
                                                 TO_NUMBER (replace(ag_monto_amortizacion, ',','.'), '99999999999.99'),
                                                 --TO_NUMBER (ag_monto_deduccion, '99999999.99'),
                                                 TO_NUMBER (replace(ag_monto_deduccion, ',','.'), '99999999999.99'),
                                                 --TO_NUMBER (ag_monto_interes, '99999999.99'),
                                                 TO_NUMBER (replace(ag_monto_interes, ',','.'), '99999999999.99'),
                                                 --TO_NUMBER (ag_monto_otros, '99999999.99'),
                                                 TO_NUMBER (replace(ag_monto_otros, ',','.'), '99999999999.99'),
                                                 --TO_NUMBER (ag_monto_neto, '99999999.99'),
                                                 TO_NUMBER (replace(ag_monto_neto, ',','.'), '99999999999.99'),
                                                 --TO_NUMBER (ag_monto_igv, '99999999.99'),
                                                 TO_NUMBER (replace(ag_monto_igv, ',','.'), '99999999999.99'),
                                                 --TO_NUMBER (ag_monto_total_pagado, '99999999.99'),
                                                 TO_NUMBER (replace(ag_monto_total_pagado, ',','.'), '99999999999.99'),
                                                 ag_fec_valorizacion
                                                );
                                 END;
                              END IF;
                        
                          ln_suma_restom := TO_NUMBER (ag_m_contratado) - TO_NUMBER (ag_monto_adicional);
                        
                          ------- Registro de Items del Adicional/Reduccion ------------------
                          usp_registra_items( ag_trama_items, reg_procesos.pk_convocatoria.getCodReduccion,ln_cod_contrato,ln_cod_moneda);
                        
                        /*  -- En las reducciones no se modifica el calendario , x lo tanto ya no se transferira al MEF
                          -- actualizar la suma en el monto contratado del CONTRATO
                         IF (ln_ind_siaf = 1) THEN
                        
                             UPDATE reg_procesos.contrato
                                SET m_contratado   = ln_suma_restom,
                                    id_operacion   = reg_procesos.pk_convocatoria.getidoperacion()
                               WHERE n_cod_contrato = ln_cod_contrato;
                        
                               reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion(reg_procesos.pk_convocatoria.getidoperacion());
                        
                          ELSE
                             UPDATE reg_procesos.contrato
                                SET m_contratado = ln_suma_restom
                              WHERE n_cod_contrato = ag_cod_contrato;
                          END IF;
                        
                          COMMIT;
                        */
                        /*    pku_ss_make_contrato.usp_calcula_costofinal (ag_cod_contrato);
                        */
                            usp_print('
                                <input type="hidden"  name ="ag_n_convoca"             value="'|| ag_n_convoca||'" />
                                <input type="hidden"  name ="ag_cod_contrato"          value="'|| ag_cod_contrato||'" />
                                <input type="hidden"  name ="ag_nro_doc_adicional"     value="'|| ag_nro_doc_adicional||'" />
                                <input type="hidden"  name ="ag_tipo_doc_adicional"    value="'|| ag_tipo_doc_adicional||'" />
                                <input type="hidden"  name ="ag_cant_adicional"        value="'|| ag_cant_adicional|| '" />
                                <input type="hidden"  name ="ag_unm_codigo_adicional"  value="'|| ag_unm_codigo_adicional|| '" />
                                <input type="hidden"  name ="ag_monto_adicional"       value="'|| ag_monto_adicional||'" />
                                <input type="hidden"  name ="ag_codmoneda"             value="'|| ag_codmoneda||'" />
                                <input type="hidden"  name ="ag_fec_doc_adicional"     value="'|| ag_fec_doc_adicional||'" />
                                <input type="hidden"  name ="ag_concepto_adicional"    value="'|| ag_concepto_adicional||'" />
                                <input type="hidden"  name ="ag_ncor_orden_pedido"     value="'|| ag_ncor_orden_pedido||'" />
                                <input type="hidden"  name ="ag_cm_oper_compra"        value="'|| ag_cm_oper_compra||'" />
                                <input type="hidden"  name ="ag_anhoentidad"           value="'|| ag_anhoentidad ||'" />
                                <input type="hidden"  name ="ag_proc_tipo"             value="'|| ag_proc_tipo ||'" />
                                <input type="hidden"  name ="ag_proc_desc"             value="'|| ag_proc_desc ||'" />
                                <input type="hidden"  name ="ag_proc_sigla"            value="'|| ag_proc_sigla ||'" />
                                <input type="hidden"  name ="ag_currenpage"            value="'|| ag_currenpage ||'" />
                                <input type="hidden" name="pfiletoupload_file1"                 value="'||pfiletoupload_file1||'"/>');
                        
                              usp_print
                                 ('
                                <script language="javascript">
                                    thisform.scriptdo.value=''LisAdicionalesDoView'';
                                    thisform.submit();
                                </script>');
                                    

                       else 
                           begin   
                           
                                   
                           
                                  if lb_error then
                                       
                                       
                                        usp_print('
                                   <script language=javascript>
                                     alert("Sistema externo no disponible, vuelva a intentar");
                                     thisform.scriptdo.value = "DoNewAdicionalEdit";
                                     thisform.submit();
                                   </script>
                                   ');
                                   return;
                                       
                                   else
                                   usp_print('
                                   <script language=javascript>
                                     alert("El proveedor'||' '|| proveedor ||' '||'se encuentra inhabilitado, no es posible publicar el adicional");
                                     thisform.scriptdo.value = "DoNewAdicionalEdit";
                                     thisform.submit();
                                   </script>
                                   ');
                                   return;
                                   
                                   end if;
                             end;
                             return;
                        end if;
              
             else 
                    
                                           -- Verificamos que el adicional o reduccion se encuentre dentro de la vigencia del contrato
                          select count(1) into  ln_valida_rango
                            from reg_procesos.contrato x
                           where x.n_cod_contrato = ag_cod_contrato
                             and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) >= trunc(x.f_vigencia_ini)
                          /*   and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) <= trunc(x.f_vigencia_fin);*/
                          and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) <= trunc(pku_ss_utiles.f_get_fecha_fin_amp(ag_cod_contrato));
                    
                          IF ln_valida_rango = 0  THEN
                    
                                usp_print(
                                pku_procesos_comun.f_putMensaje(
                                    'La fecha del Adicional o Reduccion se debe encontrar dentro de la vigencia del contrato.
                                    <br>Retorne a la Consola de Contratos',
                                    '')
                            );
                            RETURN;
                          END IF;
                    
                    
                    ------------------------- Obtiene el tipo de archivo JGARCIAF -------------------------------------
                    
                       BEGIN
                            --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
                            select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
                       EXCEPTION
                       WHEN OTHERS THEN
                              usp_print(
                                    pku_procesos_comun.f_putMensaje(
                                        'Error: Al intentar registrar el archivo del Adicional/Reduccion',
                                        '')
                                );
                               return;
                       END;
                    
                       ------------------------- Fin de Obtiene el tipo de archivo  JGARCIAF------------------------------
                    
                    
                    
                          ---------- Ingresar la reduccion o Adicional ----------
                          INSERT INTO reg_procesos.adicional_reduccion
                                      (n_cod_contrato,
                                       nro_doc_adicional,
                                       tipo_doc_adicional,
                                       cant_adicional,
                                       ind_adicional_reduccion,
                                       unm_codigo_adicional,
                                       monto_adicional,
                                       codmoneda,
                                       fec_doc_adicional,
                                       concepto_adicional, nro_doc_cgr,
                                       fec_doc_cgr
                                      )
                               VALUES (ln_cod_contrato,
                                       ag_nro_doc_adicional,
                                       ln_tipo_doc_adicional,
                                       ln_cant_adicional,
                                       ln_ind_adred,
                                       ln_unm_codigo_adicional,
                                       TO_NUMBER (replace(ag_monto_adicional, ',','.'), '99999999999.99'),
                                       ln_cod_moneda,
                                       TO_DATE (ag_fec_doc_adicional, 'dd/mm/yyyy'),
                                       ag_concepto_adicional, ag_nro_doc_cgr,
                                       TO_DATE (ag_fec_doc_cgr, 'dd/mm/yyyy'));
                    
                    
                    
                    ---- jgarciaf inicio
                         
                       lv_anhoentidad := ag_anhoentidad;
                       lv_eue_codigo := session__eue_codigo;    
                       lv_directorio := gpk_directorio_adicred;
                       lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||ag_n_convoca; 
                      
                       usp_print('
                         <input type ="hidden" name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=text>
                         <input type ="hidden" name=WriteFileDirectory value="FileSinged" type=text>
                       ');
                       
                       
                      
                         BEGIN
                      
                                select max(Cod_Adicional) into lv_id_redu from REG_PROCESOS.Adicional_Reduccion where n_cod_contrato=ln_cod_contrato;
                                
                                
                            REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.p_insUploadReduccion(
                                  reg_procesos.f_get_min_n_convoca(session__N_CONVOCA),
                                  TO_DATE (ag_fec_doc_adicional,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                                  'NULL',--doc_obs,
                                  lv_codtipofile,
                                  pfiletoupload_file1,
                                  SizeFile,
                                  session__userid,
                                  iisenv__remote_host,
                                  WriteFileDirectoryDynamic,
                                  ln_cod_contrato,
                                  lv_id_redu);
                                  
                                  
                       EXCEPTION
                          WHEN OTHERS THEN
                              usp_print(
                                    pku_procesos_comun.f_putMensaje(
                                        'Error: Al intentar registrar el Documento de la Reduccion',
                                        '')
                                );
                               return;
                    
                       END;
                       
                    ----- jgarciaf fin
                    
                    
                          ------------- Ingresar la valorizacion -----------------
                          IF (ag_monto_bruto IS NOT NULL) THEN
                             BEGIN
                                INSERT INTO reg_procesos.valorizacion
                                            (n_cod_contrato, num_comprobante_pago,
                                             codmoneda,
                                             monto_bruto,
                                             monto_reajuste,
                                             monto_amortizacion,
                                             monto_deduccion,
                                             monto_interes,
                                             monto_otros,
                                             monto_neto,
                                             monto_igv,
                                             monto_total_pagado,
                                             fec_valorizacion
                                            )
                                     VALUES (ln_cod_contrato, ag_num_comprobante_pago,
                                             ln_codmoneda_v,
                                             --TO_NUMBER (ag_monto_bruto, '99999999.99'),
                                             TO_NUMBER (replace(ag_monto_bruto, ',','.'), '99999999999.99'),
                                             --TO_NUMBER (ag_monto_reajuste, '99999999.99'),
                                             TO_NUMBER (replace(ag_monto_reajuste, ',','.'), '99999999999.99'),
                                             --TO_NUMBER (ag_monto_amortizacion, '99999999.99'),
                                             TO_NUMBER (replace(ag_monto_amortizacion, ',','.'), '99999999999.99'),
                                             --TO_NUMBER (ag_monto_deduccion, '99999999.99'),
                                             TO_NUMBER (replace(ag_monto_deduccion, ',','.'), '99999999999.99'),
                                             --TO_NUMBER (ag_monto_interes, '99999999.99'),
                                             TO_NUMBER (replace(ag_monto_interes, ',','.'), '99999999999.99'),
                                             --TO_NUMBER (ag_monto_otros, '99999999.99'),
                                             TO_NUMBER (replace(ag_monto_otros, ',','.'), '99999999999.99'),
                                             --TO_NUMBER (ag_monto_neto, '99999999.99'),
                                             TO_NUMBER (replace(ag_monto_neto, ',','.'), '99999999999.99'),
                                             --TO_NUMBER (ag_monto_igv, '99999999.99'),
                                             TO_NUMBER (replace(ag_monto_igv, ',','.'), '99999999999.99'),
                                             --TO_NUMBER (ag_monto_total_pagado, '99999999.99'),
                                             TO_NUMBER (replace(ag_monto_total_pagado, ',','.'), '99999999999.99'),
                                             ag_fec_valorizacion
                                            );
                             END;
                          END IF;
                    
                      ln_suma_restom := TO_NUMBER (ag_m_contratado) - TO_NUMBER (ag_monto_adicional);
                    
                      ------- Registro de Items del Adicional/Reduccion ------------------
                      usp_registra_items( ag_trama_items, reg_procesos.pk_convocatoria.getCodReduccion,ln_cod_contrato,ln_cod_moneda);
                    
                    /*  -- En las reducciones no se modifica el calendario , x lo tanto ya no se transferira al MEF
                      -- actualizar la suma en el monto contratado del CONTRATO
                     IF (ln_ind_siaf = 1) THEN
                    
                         UPDATE reg_procesos.contrato
                            SET m_contratado   = ln_suma_restom,
                                id_operacion   = reg_procesos.pk_convocatoria.getidoperacion()
                           WHERE n_cod_contrato = ln_cod_contrato;
                    
                           reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion(reg_procesos.pk_convocatoria.getidoperacion());
                    
                      ELSE
                         UPDATE reg_procesos.contrato
                            SET m_contratado = ln_suma_restom
                          WHERE n_cod_contrato = ag_cod_contrato;
                      END IF;
                    
                      COMMIT;
                    */
                    /*    pku_ss_make_contrato.usp_calcula_costofinal (ag_cod_contrato);
                    */
                        usp_print('
                            <input type="hidden"  name ="ag_n_convoca"             value="'|| ag_n_convoca||'" />
                            <input type="hidden"  name ="ag_cod_contrato"          value="'|| ag_cod_contrato||'" />
                            <input type="hidden"  name ="ag_nro_doc_adicional"     value="'|| ag_nro_doc_adicional||'" />
                            <input type="hidden"  name ="ag_tipo_doc_adicional"    value="'|| ag_tipo_doc_adicional||'" />
                            <input type="hidden"  name ="ag_cant_adicional"        value="'|| ag_cant_adicional|| '" />
                            <input type="hidden"  name ="ag_unm_codigo_adicional"  value="'|| ag_unm_codigo_adicional|| '" />
                            <input type="hidden"  name ="ag_monto_adicional"       value="'|| ag_monto_adicional||'" />
                            <input type="hidden"  name ="ag_codmoneda"             value="'|| ag_codmoneda||'" />
                            <input type="hidden"  name ="ag_fec_doc_adicional"     value="'|| ag_fec_doc_adicional||'" />
                            <input type="hidden"  name ="ag_concepto_adicional"    value="'|| ag_concepto_adicional||'" />
                            <input type="hidden"  name ="ag_ncor_orden_pedido"     value="'|| ag_ncor_orden_pedido||'" />
                            <input type="hidden"  name ="ag_cm_oper_compra"        value="'|| ag_cm_oper_compra||'" />
                            <input type="hidden"  name ="ag_anhoentidad"           value="'|| ag_anhoentidad ||'" />
                            <input type="hidden"  name ="ag_proc_tipo"             value="'|| ag_proc_tipo ||'" />
                            <input type="hidden"  name ="ag_proc_desc"             value="'|| ag_proc_desc ||'" />
                            <input type="hidden"  name ="ag_proc_sigla"            value="'|| ag_proc_sigla ||'" />
                            <input type="hidden"  name ="ag_currenpage"            value="'|| ag_currenpage ||'" />
                            <input type="hidden" name="pfiletoupload_file1"                 value="'||pfiletoupload_file1||'"/>');
                    
                          usp_print
                             ('
                            <script language="javascript">
                                thisform.scriptdo.value=''LisAdicionalesDoView'';
                                thisform.submit();
                            </script>');

            end if;
        
        
        
        
        /* 003-SM aramirez fin*/
        
        


     
   END;

-----------------------------------------------------------------------------------------------------------------
----------- PROCEDURE USP_REGISTRA_ITEMS -----------
-----------------------------------------------------------------------------------------------------------------

PROCEDURE usp_registra_items(
    ag_trama_items       VARCHAR2,
    ag_cod_adicional     NUMBER,
    ag_n_cod_contrato    NUMBER,
    ag_codmoneda         NUMBER)
   IS

   v_parser  xmlparser.Parser;
   v_doc     xmldom.DOMDocument;
   v_nl      xmldom.DOMNodeList;
   v_n       xmldom.DOMNode;
   v_xml     VARCHAR2(4000);

   ln_proc_item      number;
   ln_monto          number(15,2);
   contComas         number := 0;
   BEGIN

   v_xml                    := ag_trama_items;
   v_parser                 := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);
   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc                    := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);

   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/i');

  DELETE FROM  ADICIONAL_REDUCCION_ITEM  WHERE COD_ADICIONAL = ag_cod_adicional;

  FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
    v_n := xmldom.item(v_nl, cur_emp);

    ln_proc_item  :=  xslprocessor.valueOf(v_n,'item');
    contComas := instr(xslprocessor.valueOf(v_n,'mon'), ',');
    if contComas > 0 then
      ln_monto      :=  to_number(xslprocessor.valueOf(v_n,'mon')); 
    else
      ln_monto      :=  to_number(xslprocessor.valueOf(v_n,'mon'),'999999999990.00');
    end if;   

    BEGIN
      INSERT INTO ADICIONAL_REDUCCION_ITEM
         (COD_ADICIONAL, N_COD_CONTRATO,MONTO_ADICIONAL,PROC_ITEM,CODMONEDA,F_REGISTRO)
      VALUES
         (ag_cod_adicional,ag_n_cod_contrato,ln_monto,ln_proc_item,ag_codmoneda,sysdate);

        EXCEPTION
              WHEN OTHERS THEN
                  pku_ss_mod_contratos.f_msg_error('Error al intentar registrar la Informacion de los Items','''LisAdicionalesDoView''');
    END;
  END LOOP;

  xmldom.freeDocument(v_doc);

 END;

-----------------------------------------------------------------------------------------------------------------
----------- PROCEDURE USP_REGISTRA_CALENDARIO -----------
-----------------------------------------------------------------------------------------------------------------

PROCEDURE usp_registra_calendario(ag_trama_calendario varchar2)
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
   contComas      number := 0;
   BEGIN

   v_xml              := ag_trama_calendario;
   v_parser           := xmlparser.newParser;
   xmlparser.setValidationMode (v_parser, FALSE);
   xmlparser.parseBuffer(v_parser, v_xml);
   v_doc              := xmlparser.getDocument(v_parser);
   xmlparser.freeParser(v_parser);

   v_nl := xslprocessor.selectNodes(xmldom.makeNode(v_doc),'/root/calendario');

  FOR cur_emp IN 0 .. xmldom.getLength(v_nl) - 1 LOOP
   v_n := xmldom.item(v_nl, cur_emp);

   ln_num_pago := xslprocessor.valueOf(v_n,'numpago');
   ld_fec_pago := to_date(xslprocessor.valueOf(v_n,'fecha'),'dd/mm/yyyy');
   ln_codmoneda := xslprocessor.valueOf(v_n,'moneda');
   contComas := instr(xslprocessor.valueOf(v_n,'monto'), ',');
--   ln_montoPago := xslprocessor.valueOf(v_n,'monto');
--   ln_montoPago :=  to_number(xslprocessor.valueOf(v_n,'monto'),'999999999990.00');
   if contComas > 0 then
      ln_montoPago    :=  to_number(xslprocessor.valueOf(v_n,'monto')); 
    else
      ln_montoPago    :=  to_number(xslprocessor.valueOf(v_n,'monto'),'999999999990.00');
    end if;   


    INSERT INTO reg_procesos.contrato_operacion_calendario
                (num_pago,
                 fec_pago,
                 codmoneda,
                 monto_pago)
         VALUES (ln_num_pago,
                 ld_fec_pago,
                 ln_codmoneda,
                 ln_montoPago);
   --    dbms_output.put_line(xslprocessor.valueOf(v_n,'CODOBJETO') || '<-->'||xslprocessor.valueOf(v_n,'DESCRIPCION'));

  END LOOP;
  xmldom.freeDocument(v_doc);


 END;


-----------------------------------------------------------------------------------------------------------------
----------- PROCEDURE QUE INSERTA EL NUEVO ADICIONAL -----------
-----------------------------------------------------------------------------------------------------------------

   PROCEDURE uspadicionaladicdoinsert (
      ag_cod_contrato                VARCHAR2,
      ag_nro_doc_adicional           VARCHAR2,
      ag_tipo_doc_adicional          VARCHAR2,
      ag_monto_adicional             VARCHAR2,
      ag_codmoneda                   VARCHAR2,
      ag_fec_doc_adicional           VARCHAR2,
      ag_concepto_adicional          VARCHAR2,
      ag_nro_doc_cgr                 VARCHAR2,
      ag_fec_doc_cgr                 VARCHAR2,
      ag_ind_siaf                    VARCHAR2,
      -- argumentos de la valorizacion obj = 3  o 4
      ag_num_comprobante_pago        VARCHAR2,
      ag_monto_bruto                 VARCHAR2,
      ag_monto_reajuste              VARCHAR2,
      ag_monto_amortizacion          VARCHAR2,
      ag_monto_deduccion             VARCHAR2,
      ag_monto_interes               VARCHAR2,
      ag_monto_otros                 VARCHAR2,
      ag_monto_neto                  VARCHAR2,
      ag_monto_igv                   VARCHAR2,
      ag_monto_total_pagado          VARCHAR2,
      ag_fec_valorizacion            VARCHAR2,
      ag_codmoneda_v                 VARCHAR2,
      ag_cod_entid_autoriza     IN   VARCHAR2 DEFAULT '',
      ag_descripcion                 VARCHAR2,
      ag_trama_calendario            VARCHAR2 default null,
      ag_trama_items                 VARCHAR2 default null,
      session__userid                varchar2,
      session__eue_codigo            VARCHAR2 DEFAULT NULL ,
      ag_cod_objeto                  varchar2,
      ag_proc_tipo                   varchar2  ,
      ag_tipo_consultoria             number,
      
     --- para cargar archivo
      session__n_convoca           VARCHAR2 DEFAULT NULL,----JGARCIAF
      session__anhoentidad            VARCHAR2 DEFAULT NULL,---JGARCIAF
      pfiletoupload1                  VARCHAR2,--jgarcia
      pfiletoupload_file1             VARCHAR2,--jgarcia
      SizeFile                        varchar2,--jgarcia
      iisenv__remote_host             VARCHAR2,--jgarcia
      WriteFileDirectoryDynamic       VARCHAR2--jgarcia
   )
   IS

      ----------- Variables ---------
      ln_cod_contrato           NUMBER;
      ln_cod_moneda             NUMBER;
      ln_cod_adicional          NUMBER;
      ln_tipo_doc_adicional     NUMBER;
      ln_ind_siaf               NUMBER;
      ln_cod_valorizacion       NUMBER;
      ln_codmoneda_v            NUMBER;
      lv_codentidadautoriza     CHAR(6);
      ln_ind_adred              NUMBER;
      ln_valida_rango           int;
      ln_sum_adicional_actual   NUMBER;
      ln_sum_adicional_total    NUMBER;
      ln_sum_adicional_MAX      NUMBER;
      ln_porcentaje_total       NUMBER;
      ln_monto_contrato         NUMBER;

      ln_ley_29564              NUMBER;
    
        --JGARCIA
         lv_directorio            varchar2(50);  ---jgarciaf
         lv_ruta                  varchar2(50); ---jgarciaf
         lv_anhoentidad           varchar2(4); ---jgarciaf
         lv_eue_codigo            varchar2(50); ---jgarciaf
         lv_codtipofile           VARCHAR2(20);---jgarciaf
         lv_id_adi                  NUMBER ;----JGARCIAF
         men     VARCHAR2(20);

   BEGIN  
        /*validaciones */
       select * into consucode,proveedor,proceso,nconvoca,fcontra,npropuesta from table(f_get_emp_dets(session_cod_contrato));
           if (consucode='002433' and proceso='SEL') or (consucode='002433' and proceso='ABR') or (consucode='002433' and proceso='COM') then
                  
                   lb_validacion_rnp2 := f_valida_rnp_contrato(proveedor,nconvoca,ag_fec_doc_adicional,npropuesta,lb_estado_inha);
                   
                    /*      if lb_validacion_rnp2 then
                                men:='esta habilitado';
                                
                                else
                                 men:='esta inhabilitado';
                                
                            end if;
                        
                            begin
                                   usp_print('
                                   <script language=javascript>
                                     alert("El proveedor' || men ||ag_fec_doc_adicional||'se encuentra inhabilitado, no es posible publicar el adicional");
                                     thisform.scriptdo.value = "DoNewAdicionalEdit";
                                     thisform.submit();
                                   </script>
                                   ');
                                   return;
                             end;*/
                        
                      if  lb_validacion_rnp2 then
                              
                                                                       --aqui comienza el proceso para grabar
                       /* 003-2019*/
                -- Verificamos los montos maximos
                      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script(' var _error = 0; ');
                
                      ln_cod_contrato          := TO_NUMBER (ag_cod_contrato);
                
                      SELECT COUNT(1)INTO ln_ley_29564 FROM REG_PROCESOS.CONTRATO_VALIDACIONES WHERE CODCONSUCODE = session__eue_codigo;
                      SELECT M_CONTRATADO INTO ln_monto_contrato FROM CONTRATO WHERE N_COD_CONTRATO = ln_cod_contrato;
                
                      SELECT nvl(SUM(monto_adicional),0) INTO ln_sum_adicional_actual FROM reg_procesos.adicional_reduccion WHERE n_cod_Contrato = ln_cod_contrato  and IND_ADICIONAL_REDUCCION =1;
                
                      ln_sum_adicional_total   := ln_sum_adicional_actual + ag_monto_adicional;
                --- Hallamos el % que le corresponde
                
                      IF (to_number(ag_cod_entid_autoriza) = to_number(session__eue_codigo) and to_number(session__eue_codigo) <> 8 )THEN
                
                
                
                                    SELECT tope INTO ln_porcentaje_total FROM REG_PROCESOS.ADICIONAL_REDUCCION_TOPES WHERE ind_adicional_reduccion = 1 AND CODOBJETO = ag_cod_objeto AND CGR = 2;
                
                                    ln_sum_adicional_MAX := ln_monto_contrato * (ln_porcentaje_total/100);
                          ELSE
                
                                  if ag_cod_objeto = 4 and ag_tipo_consultoria = 2  then
                
                                           ln_sum_adicional_MAX := 9999999999 ;
                
                                  else
                
                
                                           SELECT tope INTO ln_porcentaje_total FROM REG_PROCESOS.ADICIONAL_REDUCCION_TOPES WHERE ind_adicional_reduccion = 1 AND CODOBJETO = ag_cod_objeto AND CGR = 1;
                
                
                                           ln_sum_adicional_MAX := ln_monto_contrato * (ln_porcentaje_total/100);
                
                                  end if ;
                
                
                
                      END IF;
                      --- Validar Tope Maximo
                    -- Memo 368-2011/spla-raa
                    if ag_proc_tipo not in (11,23)  then
                        IF ( ln_ley_29564 = 0 )  THEN
                          IF ln_sum_adicional_total > ln_sum_adicional_MAX  THEN
                             REG_PROCESOS.PKU_SS_MOD_CONTRATOS.f_msg_pantalla('El monto adicional supera el limite permitido ','''DoNewAdicionalEdit''');
                
                             return;
                          END IF;
                        END IF;
                    end if;
                
                
                
                  -- Verificamos que el adicional o reduccion se encuentre dentro de la vigencia del contrato
                      select count(1) into  ln_valida_rango
                        from reg_procesos.contrato x
                       where x.n_cod_contrato = ag_cod_contrato
                         and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) >= trunc(x.f_vigencia_ini)
                      /*   and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) <= trunc(x.f_vigencia_fin);*/
                      and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) <= trunc(pku_ss_utiles.f_get_fecha_fin_amp(ag_cod_contrato));
                
                
                
                
                      IF ln_valida_rango = 0  THEN
                
                            usp_print(
                            pku_procesos_comun.f_putMensaje(
                                'La fecha del Adicional o Reduccion se debe encontrar dentro de la vigencia del contrato.
                                <br>Retorne a la Consola de Contratos',
                                '')
                        );
                        RETURN;
                      END IF;
                
                      lv_codentidadautoriza    := TO_CHAR (ag_cod_entid_autoriza);
                      ln_ind_siaf              := TO_NUMBER (ag_ind_siaf);
                      -- variables para la insercion en la tabla adicion_reduccion
                
                      ln_tipo_doc_adicional    := TO_NUMBER (ag_tipo_doc_adicional);
                      ln_cod_moneda            := TO_NUMBER (ag_codmoneda);
                      ln_codmoneda_v           := TO_NUMBER (ag_codmoneda_v);
                      ln_ind_adred             := 1;
                
                
                ------------------------- Obtiene el tipo de archivo JGARCIAF -------------------------------------
                
                   BEGIN
                        --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
                        select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
                   EXCEPTION
                   WHEN OTHERS THEN
                          usp_print(
                                pku_procesos_comun.f_putMensaje(
                                    'Error: Al intentar registrar el archivo del Adicional/Reduccion',
                                    '')
                            );
                           return;
                   END;
                
                   ------------------------- Fin de Obtiene el tipo de archivo  JGARCIAF------------------------------
                
                
                
                
                      ---------- Ingresar el adicional o reduccion  ----------
                      INSERT INTO reg_procesos.adicional_reduccion
                                  (n_cod_contrato,
                                   nro_doc_adicional,
                                   tipo_doc_adicional,
                                   ind_adicional_reduccion,
                                   monto_adicional,
                                   codmoneda,
                                   fec_doc_adicional,
                                   concepto_adicional, nro_doc_cgr,
                                   fec_doc_cgr, cod_entid_autoriza,
                                   descripcion )
                           VALUES (ln_cod_contrato,
                                   ag_nro_doc_adicional,
                                   ln_tipo_doc_adicional,
                                   ln_ind_adred,
                                   TO_NUMBER (replace(ag_monto_adicional,',','.'), '99999999999.99'),
                                   ln_cod_moneda,
                                   TO_DATE (ag_fec_doc_adicional, 'dd/mm/yyyy'),
                                   ag_concepto_adicional, ag_nro_doc_cgr,
                                   TO_DATE (ag_fec_doc_cgr, 'dd/mm/yyyy'), lv_codentidadautoriza,
                                   ag_descripcion);
                
                
                ---- jgarciaf inicio
                     
                   lv_anhoentidad := session__anhoentidad;
                   lv_eue_codigo := session__eue_codigo;    
                   lv_directorio := gpk_directorio_adicred;
                   lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||session__n_convoca; 
                  
                   usp_print('
                     <input type="hidden" name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=text>
                     <input type="hidden" name=WriteFileDirectory value="FileSinged" type=text>
                   ');
                   
                     BEGIN
                  
                             
                     select max(Cod_Adicional) into lv_id_adi from Adicional_Reduccion where n_cod_contrato=ln_cod_contrato;
                            
                        REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.p_insUploadAdicional(
                              reg_procesos.f_get_min_n_convoca(session__N_CONVOCA),
                              TO_DATE (ag_fec_doc_adicional,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                              'NULL',--doc_obs,
                              lv_codtipofile,
                              pfiletoupload_file1,
                              SizeFile,
                              session__userid,
                              iisenv__remote_host,
                              WriteFileDirectoryDynamic,
                              ln_cod_contrato,
                              lv_id_adi);
                              
                   EXCEPTION
                      WHEN OTHERS THEN
                          usp_print(
                                pku_procesos_comun.f_putMensaje(
                                    'Error: Al intentar registrar el Documento del Adicional/Reduccion',
                                    '')
                            );
                           return;
                
                   END;
                   
                ----- jgarciaf fin
                
                
                      ------------- Ingresar la valorizacion ----------------
                      IF (ag_fec_valorizacion IS NOT NULL) THEN
                         BEGIN
                            INSERT INTO reg_procesos.valorizacion
                                        (n_cod_contrato,
                                         num_comprobante_pago,
                                         codmoneda, monto_bruto,
                                         monto_reajuste,
                                         monto_amortizacion,
                                         monto_deduccion,
                                         monto_interes,
                                         monto_otros,
                                         monto_neto,
                                         monto_igv,
                                         monto_total_pagado,
                                         fec_valorizacion )
                                 VALUES (ln_cod_contrato,
                                         ag_num_comprobante_pago,
                                         ln_codmoneda_v,
                                         --TO_NUMBER (ag_monto_bruto),
                                         TO_NUMBER (replace(ag_monto_bruto,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_reajuste),
                                         TO_NUMBER (replace(ag_monto_reajuste,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_amortizacion),
                                         TO_NUMBER (replace(ag_monto_amortizacion,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_deduccion),
                                         TO_NUMBER (replace(ag_monto_deduccion,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_interes),
                                         TO_NUMBER (replace(ag_monto_interes,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_otros),
                                         TO_NUMBER (replace(ag_monto_otros,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_neto),
                                         TO_NUMBER (replace(ag_monto_neto,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_igv),
                                         TO_NUMBER (replace(ag_monto_igv,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_total_pagado),
                                         TO_NUMBER (replace(ag_monto_total_pagado,',','.'), '99999999999.99'),
                                         ag_fec_valorizacion );
                         END;
                      END IF;
                
                
                    ------- Registro de Items del Adicional/Reduccion ------------------
                    usp_registra_items( ag_trama_items, reg_procesos.pk_convocatoria.getcodadicional,ln_cod_contrato,ln_cod_moneda);
                
                 ------- Actualizar Campos del Contrato: Transferencia al MEF -------
                    IF (ln_ind_siaf = 1)THEN
                
                    ------- Actualiza Contrato --------
                       BEGIN
                          UPDATE reg_procesos.adicional_reduccion
                             SET id_operacion  = reg_procesos.pk_convocatoria.getidoperacion
                           WHERE cod_adicional = reg_procesos.pk_convocatoria.getcodadicional;
                
                
                          reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion
                                                (reg_procesos.pk_convocatoria.getidoperacion);
                
                        update CONTRATO_OPERACION
                           set CONTRATO_OPERACION.Usuario_Transfer = session__userid
                        where CONTRATO_OPERACION.id_operacion = reg_procesos.pk_convocatoria.getidoperacion;
                
                    --------- Actualiza Calendario --------
                          usp_registra_calendario(ag_trama_calendario);
                       END;
                
                    END IF;
                
                    -- obtener codigo de la valorizacion
                    SELECT reg_procesos.pk_convocatoria.getcodadicional,
                           reg_procesos.pk_convocatoria.getcodvalorizacion
                      INTO ln_cod_adicional,
                           ln_cod_valorizacion
                      FROM DUAL;
                
                    --- actualizo el codigo de valorizacion
                    UPDATE reg_procesos.adicional_reduccion
                       SET cod_valorizacion = ln_cod_valorizacion
                     WHERE cod_adicional = ln_cod_adicional;
                
                    COMMIT;
                
                    pku_ss_make_contrato.usp_calcula_costofinal (ag_cod_contrato);
                
                
                    usp_print
                       ('
                     <script language="javascript">
                              thisform.scriptdo.value=''LisAdicionalesDoView'';
                               if ( _error !=1 )
                                  thisform.submit();
                     </script>'
                       );
                
               
                 
                 --aqui termina el registrar

                             
                        else 
                          begin  
                          
                                  
                          
                                  if lb_error  then
                                       
                                       
                                        usp_print('
                                   <script language=javascript>
                                     alert("Sistema externo no disponible, vuelva a intentar");
                                     thisform.scriptdo.value = "DoNewAdicionalEdit";
                                     thisform.submit();
                                   </script>
                                   ');
                                   return;
                                       
                                   else
                                   usp_print('
                                   <script language=javascript>
                                     alert("El proveedor'||' '|| proveedor ||' '||'se encuentra inhabilitado, no es posible publicar el adicional");
                                     thisform.scriptdo.value = "DoNewAdicionalEdit";
                                     thisform.submit();
                                   </script>
                                   ');
                                   return;
                                   
                                   end if;
                             end;
                             return;
                        end if;
              
             else 
                        
                                         --aqui comienza el proceso para grabar
                       /* 003-2019*/
                -- Verificamos los montos maximos
                      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script(' var _error = 0; ');
                
                      ln_cod_contrato          := TO_NUMBER (ag_cod_contrato);
                
                      SELECT COUNT(1)INTO ln_ley_29564 FROM REG_PROCESOS.CONTRATO_VALIDACIONES WHERE CODCONSUCODE = session__eue_codigo;
                      SELECT M_CONTRATADO INTO ln_monto_contrato FROM CONTRATO WHERE N_COD_CONTRATO = ln_cod_contrato;
                
                      SELECT nvl(SUM(monto_adicional),0) INTO ln_sum_adicional_actual FROM reg_procesos.adicional_reduccion WHERE n_cod_Contrato = ln_cod_contrato  and IND_ADICIONAL_REDUCCION =1;
                
                      ln_sum_adicional_total   := ln_sum_adicional_actual + to_number(ag_monto_adicional);
                --- Hallamos el % que le corresponde
                
                      IF (to_number(ag_cod_entid_autoriza) = to_number(session__eue_codigo) and to_number(session__eue_codigo) <> 8 )THEN
                
                
                
                                    SELECT tope INTO ln_porcentaje_total FROM REG_PROCESOS.ADICIONAL_REDUCCION_TOPES WHERE ind_adicional_reduccion = 1 AND CODOBJETO = ag_cod_objeto AND CGR = 2;
                
                                    ln_sum_adicional_MAX := ln_monto_contrato * (ln_porcentaje_total/100);
                          ELSE
                
                                  if ag_cod_objeto = 4 and ag_tipo_consultoria = 2  then
                
                                           ln_sum_adicional_MAX := 9999999999 ;
                
                                  else
                
                
                                           SELECT tope INTO ln_porcentaje_total FROM REG_PROCESOS.ADICIONAL_REDUCCION_TOPES WHERE ind_adicional_reduccion = 1 AND CODOBJETO = ag_cod_objeto AND CGR = 1;
                
                
                                           ln_sum_adicional_MAX := ln_monto_contrato * (ln_porcentaje_total/100);
                
                                  end if ;
                
                
                
                      END IF;
                      --- Validar Tope Maximo
                    -- Memo 368-2011/spla-raa
                    if ag_proc_tipo not in (11,23)  then
                        IF ( ln_ley_29564 = 0 )  THEN
                          IF ln_sum_adicional_total > ln_sum_adicional_MAX  THEN
                             REG_PROCESOS.PKU_SS_MOD_CONTRATOS.f_msg_pantalla('El monto adicional supera el limite permitido ','''DoNewAdicionalEdit''');
                
                             return;
                          END IF;
                        END IF;
                    end if;
                
                
                
                  -- Verificamos que el adicional o reduccion se encuentre dentro de la vigencia del contrato
                      select count(1) into  ln_valida_rango
                        from reg_procesos.contrato x
                       where x.n_cod_contrato = ag_cod_contrato
                         and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) >= trunc(x.f_vigencia_ini)
                      /*   and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) <= trunc(x.f_vigencia_fin);*/
                      and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) <= trunc(pku_ss_utiles.f_get_fecha_fin_amp(ag_cod_contrato));
                
                
                
                
                      IF ln_valida_rango = 0  THEN
                
                            usp_print(
                            pku_procesos_comun.f_putMensaje(
                                'La fecha del Adicional o Reduccion se debe encontrar dentro de la vigencia del contrato.
                                <br>Retorne a la Consola de Contratos',
                                '')
                        );
                        RETURN;
                      END IF;
                
                      lv_codentidadautoriza    := TO_CHAR (ag_cod_entid_autoriza);
                      ln_ind_siaf              := TO_NUMBER (ag_ind_siaf);
                      -- variables para la insercion en la tabla adicion_reduccion
                
                      ln_tipo_doc_adicional    := TO_NUMBER (ag_tipo_doc_adicional);
                      ln_cod_moneda            := TO_NUMBER (ag_codmoneda);
                      ln_codmoneda_v           := TO_NUMBER (ag_codmoneda_v);
                      ln_ind_adred             := 1;
                
                
                ------------------------- Obtiene el tipo de archivo JGARCIAF -------------------------------------
                
                   BEGIN
                        --select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,length(pfiletoupload_file1)-2,length(pfiletoupload_file1)));
                        select cod_tipo_file into lv_codtipofile From Reg_procesos.tipo_archivo Where ext_tipo_file=upper(substr(pfiletoupload_file1,(INSTR(pfiletoupload_file1,'.',1) + 1)));
                   EXCEPTION
                   WHEN OTHERS THEN
                          usp_print(
                                pku_procesos_comun.f_putMensaje(
                                    'Error: Al intentar registrar el archivo del Adicional/Reduccion',
                                    '')
                            );
                           return;
                   END;
                
                   ------------------------- Fin de Obtiene el tipo de archivo  JGARCIAF------------------------------
                
                
                
                
                      ---------- Ingresar el adicional o reduccion  ----------
                      INSERT INTO reg_procesos.adicional_reduccion
                                  (n_cod_contrato,
                                   nro_doc_adicional,
                                   tipo_doc_adicional,
                                   ind_adicional_reduccion,
                                   monto_adicional,
                                   codmoneda,
                                   fec_doc_adicional,
                                   concepto_adicional, nro_doc_cgr,
                                   fec_doc_cgr, cod_entid_autoriza,
                                   descripcion )
                           VALUES (ln_cod_contrato,
                                   ag_nro_doc_adicional,
                                   ln_tipo_doc_adicional,
                                   ln_ind_adred,
                                   TO_NUMBER (replace(ag_monto_adicional,',','.'), '99999999999.99'),
                                   ln_cod_moneda,
                                   TO_DATE (ag_fec_doc_adicional, 'dd/mm/yyyy'),
                                   ag_concepto_adicional, ag_nro_doc_cgr,
                                   TO_DATE (ag_fec_doc_cgr, 'dd/mm/yyyy'), lv_codentidadautoriza,
                                   ag_descripcion);
                
                
                ---- jgarciaf inicio
                     
                   lv_anhoentidad := session__anhoentidad;
                   lv_eue_codigo := session__eue_codigo;    
                   lv_directorio := gpk_directorio_adicred;
                   lv_ruta := lv_directorio||'\'||lv_anhoentidad||'\'||lpad(lv_eue_codigo,6,'0')||'\'||session__n_convoca; 
                  
                   usp_print('
                     <input type="hidden" name=WriteFileDirectoryDynamic value="'||lv_ruta||'" type=text>
                     <input type="hidden" name=WriteFileDirectory value="FileSinged" type=text>
                   ');
                   
                     BEGIN
                  
                             
                     select max(Cod_Adicional) into lv_id_adi from Adicional_Reduccion where n_cod_contrato=ln_cod_contrato;
                            
                        REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.p_insUploadAdicional(
                              reg_procesos.f_get_min_n_convoca(session__N_CONVOCA),
                              TO_DATE (ag_fec_doc_adicional,reg_procesos.pku_ss_constantes.gv_formato_fecha_hora24),
                              'NULL',--doc_obs,
                              lv_codtipofile,
                              pfiletoupload_file1,
                              SizeFile,
                              session__userid,
                              iisenv__remote_host,
                              WriteFileDirectoryDynamic,
                              ln_cod_contrato,
                              lv_id_adi);
                              
                   EXCEPTION
                      WHEN OTHERS THEN
                          usp_print(
                                pku_procesos_comun.f_putMensaje(
                                    'Error: Al intentar registrar el Documento del Adicional/Reduccion',
                                    '')
                            );
                           return;
                
                   END;
                   
                ----- jgarciaf fin
                
                
                      ------------- Ingresar la valorizacion ----------------
                      IF (ag_fec_valorizacion IS NOT NULL) THEN
                         BEGIN
                            INSERT INTO reg_procesos.valorizacion
                                        (n_cod_contrato,
                                         num_comprobante_pago,
                                         codmoneda, monto_bruto,
                                         monto_reajuste,
                                         monto_amortizacion,
                                         monto_deduccion,
                                         monto_interes,
                                         monto_otros,
                                         monto_neto,
                                         monto_igv,
                                         monto_total_pagado,
                                         fec_valorizacion )
                                 VALUES (ln_cod_contrato,
                                         ag_num_comprobante_pago,
                                         ln_codmoneda_v,
                                         --TO_NUMBER (ag_monto_bruto),
                                         TO_NUMBER (replace(ag_monto_bruto,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_reajuste),
                                         TO_NUMBER (replace(ag_monto_reajuste,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_amortizacion),
                                         TO_NUMBER (replace(ag_monto_amortizacion,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_deduccion),
                                         TO_NUMBER (replace(ag_monto_deduccion,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_interes),
                                         TO_NUMBER (replace(ag_monto_interes,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_otros),
                                         TO_NUMBER (replace(ag_monto_otros,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_neto),
                                         TO_NUMBER (replace(ag_monto_neto,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_igv),
                                         TO_NUMBER (replace(ag_monto_igv,',','.'), '99999999999.99'),
                                         --TO_NUMBER (ag_monto_total_pagado),
                                         TO_NUMBER (replace(ag_monto_total_pagado,',','.'), '99999999999.99'),
                                         ag_fec_valorizacion );
                         END;
                      END IF;
                
                
                    ------- Registro de Items del Adicional/Reduccion ------------------
                    usp_registra_items( ag_trama_items, reg_procesos.pk_convocatoria.getcodadicional,ln_cod_contrato,ln_cod_moneda);
                
                 ------- Actualizar Campos del Contrato: Transferencia al MEF -------
                    IF (ln_ind_siaf = 1)THEN
                
                    ------- Actualiza Contrato --------
                       BEGIN
                          UPDATE reg_procesos.adicional_reduccion
                             SET id_operacion  = reg_procesos.pk_convocatoria.getidoperacion
                           WHERE cod_adicional = reg_procesos.pk_convocatoria.getcodadicional;
                
                
                          reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion
                                                (reg_procesos.pk_convocatoria.getidoperacion);
                
                        update CONTRATO_OPERACION
                           set CONTRATO_OPERACION.Usuario_Transfer = session__userid
                        where CONTRATO_OPERACION.id_operacion = reg_procesos.pk_convocatoria.getidoperacion;
                
                    --------- Actualiza Calendario --------
                          usp_registra_calendario(ag_trama_calendario);
                       END;
                
                    END IF;
                
                    -- obtener codigo de la valorizacion
                    SELECT reg_procesos.pk_convocatoria.getcodadicional,
                           reg_procesos.pk_convocatoria.getcodvalorizacion
                      INTO ln_cod_adicional,
                           ln_cod_valorizacion
                      FROM DUAL;
                
                    --- actualizo el codigo de valorizacion
                    UPDATE reg_procesos.adicional_reduccion
                       SET cod_valorizacion = ln_cod_valorizacion
                     WHERE cod_adicional = ln_cod_adicional;
                
                    COMMIT;
                
                    pku_ss_make_contrato.usp_calcula_costofinal (ag_cod_contrato);
                
                
                    usp_print
                       ('
                     <script language="javascript">
                              thisform.scriptdo.value=''LisAdicionalesDoView'';
                               if ( _error !=1 )
                                  thisform.submit();
                     </script>'
                       );
                
               
                 
                 --aqui termina el registrar
              
           end if;
      

   end ;

  /*************PROCEDURE QUE HACE EL UPDATE (ACTUALIZA el adicional) ademas de ACTUALIZAR OTRAS TABLAS ***/
   PROCEDURE uspadicionaladicdoupdate (
      ag_n_convoca                   VARCHAR2,
      ag_cod_contrato                VARCHAR2,
      ag_cod_adicional          IN   VARCHAR2 DEFAULT '',  --vienen del editar
      ag_nro_doc_adicional           VARCHAR2,
      ag_tipo_doc_adicional          VARCHAR2,
      ag_cant_adicional              VARCHAR2,
      ag_unm_codigo_adicional        VARCHAR2,
      ag_monto_adicional             VARCHAR2,
      ag_codmoneda                   VARCHAR2,
      ag_fec_doc_adicional           VARCHAR2,
      ag_concepto_adicional          VARCHAR2,
      ag_nro_doc_cgr                 VARCHAR2,
      ag_fec_doc_cgr                 VARCHAR2,
      ag_ind_siaf                    VARCHAR2,
-- argumentos de la valorizacion obj =3  o 4
      ag_cod_valorizacion            VARCHAR2,
      ag_num_comprobante_pago        VARCHAR2,
      ag_monto_bruto                 VARCHAR2,
      ag_monto_reajuste              VARCHAR2,
      ag_monto_amortizacion          VARCHAR2,
      ag_monto_deduccion             VARCHAR2,
      ag_monto_interes               VARCHAR2,
      ag_monto_otros                 VARCHAR2,
      ag_monto_neto                  VARCHAR2,
      ag_monto_igv                   VARCHAR2,
      ag_monto_total_pagado          VARCHAR2,
      ag_fec_valorizacion            VARCHAR2,
      ag_codmoneda_v                 VARCHAR2,
      ag_ncor_orden_pedido      IN   VARCHAR2 DEFAULT '',
                                                   -- variables convenio marco
      ag_cm_opc                 IN   VARCHAR2 DEFAULT '',
      ag_cm_oper_compra         IN   VARCHAR2 DEFAULT '',
      -- variables para regresarlas al listado de Contratos
      ag_anhoentidad                 VARCHAR2 DEFAULT NULL,
      ag_descripcion                 VARCHAR2,
      ag_trama_calendario            VARCHAR2 default null,
      ag_trama_items                 VARCHAR2 default null,
      session__userid                 VARCHAR2 default null,
      session__eue_codigo             VARCHAR2 default null,
      ag_cod_objeto                   VARCHAR2 default null
   )
   IS
      ----------- Variables ---------
      ln_cod_contrato           NUMBER;
      ln_cod_moneda             NUMBER;
      ln_tipo_doc_adicional     NUMBER;
      ln_cant_adicional         NUMBER;
      ln_unm_codigo_adicional   NUMBER;
      ln_monto_adicional        NUMBER;
      ln_ind_siaf               NUMBER;
      ln_codmoneda_v            NUMBER;
      ln_valida_rango           int;
      lv_descripcion            varchar2(80);

      ln_sum_adicional_actual   NUMBER;
      ln_sum_adicional_total    NUMBER;
      ln_sum_adicional_MAX      NUMBER;
      ln_porcentaje_total       NUMBER;
      ln_monto_contrato         NUMBER;
      lv_ent_auto               varchar2(6);

   BEGIN

    -- Verificamos los montos maximos
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script(' var _error = 0; ');

    ln_cod_contrato          := TO_NUMBER (ag_cod_contrato);

      select x.cod_entid_autoriza Into lv_ent_auto From adicional_reduccion x where x.cod_adicional = ag_cod_adicional;

      SELECT M_CONTRATADO INTO ln_monto_contrato FROM CONTRATO WHERE N_COD_CONTRATO = ln_cod_contrato;

      SELECT nvl(SUM(monto_adicional),0) INTO ln_sum_adicional_actual FROM reg_procesos.adicional_reduccion WHERE n_cod_Contrato = ln_cod_contrato;

      ln_sum_adicional_total   := ln_sum_adicional_actual + ag_monto_adicional;

      --- Hallamos el % que le corresponde   
      IF to_char(lv_ent_auto, '000000') = to_char(session__eue_codigo, '000000') THEN
            SELECT tope INTO ln_porcentaje_total FROM REG_PROCESOS.ADICIONAL_REDUCCION_TOPES WHERE ind_adicional_reduccion = 1 AND CODOBJETO = ag_cod_objeto AND CGR = 2;
            ln_sum_adicional_MAX := ln_monto_contrato * (ln_porcentaje_total/100);
          ELSE
            SELECT tope INTO ln_porcentaje_total FROM REG_PROCESOS.ADICIONAL_REDUCCION_TOPES WHERE ind_adicional_reduccion = 1 AND CODOBJETO = ag_cod_objeto AND CGR = 1;
            ln_sum_adicional_MAX := ln_monto_contrato * (ln_porcentaje_total/100);
      END IF;

      --- Validar Tope Maximo
      IF ln_sum_adicional_total > ln_sum_adicional_MAX THEN
         REG_PROCESOS.PKU_SS_MOD_CONTRATOS.f_msg_pantalla('El monto adicional supera el limite permitido ','''DoNewAdicionalEdit''');
         return;
      END IF;



      -- Verificamos que el adicional o reduccion se encuentre dentro de la vigencia del contrato
      select count(1) into  ln_valida_rango
        from reg_procesos.contrato x
       where x.n_cod_contrato = ag_cod_contrato
         and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) >= trunc(x.f_vigencia_ini)
          and trunc(to_date(ag_fec_doc_adicional,'dd/mm/yyyy')) <= trunc(x.f_vigencia_fin);

      IF ln_valida_rango = 0  THEN

            usp_print(
            pku_procesos_comun.f_putMensaje(
                'La fecha del Adicional o Reduccion se debe encontrar dentro de la vigencia del contrato.<br>Retorne a la Consola de Contratos ...',
                '')
        );
        RETURN;
      END IF;

      ln_ind_siaf             := TO_NUMBER (ag_ind_siaf);
      ln_cod_contrato         := TO_NUMBER (ag_cod_contrato);
      ln_tipo_doc_adicional   := TO_NUMBER (ag_tipo_doc_adicional);
      ln_cant_adicional       := TO_NUMBER (ag_cant_adicional);
      ln_monto_adicional      := TO_NUMBER (ag_monto_adicional);
      ln_unm_codigo_adicional := TO_NUMBER (ag_unm_codigo_adicional);
      ln_cod_moneda           := TO_NUMBER (ag_codmoneda);
      ln_codmoneda_v          := TO_NUMBER (ag_codmoneda_v);
      lv_descripcion          := ag_descripcion;

      ---------- Hago la actualizacion del Adicional en la tabla adicion_reduccion ----------
      UPDATE reg_procesos.adicional_reduccion
         SET  nro_doc_adicional = ag_nro_doc_adicional,
              fec_doc_adicional = TO_DATE (ag_fec_doc_adicional, 'dd/mm/yyyy'),
                 cant_adicional = ln_cant_adicional,
                monto_adicional = ln_monto_adicional,
             concepto_adicional = ag_concepto_adicional,
                      codmoneda = ln_cod_moneda,
           unm_codigo_adicional = ln_unm_codigo_adicional,
               cod_valorizacion = DECODE (ag_cod_valorizacion,'', '',TO_NUMBER (ag_cod_valorizacion, 9999999)),
                    nro_doc_cgr = ag_nro_doc_cgr,
                    fec_doc_cgr = TO_DATE (ag_fec_doc_cgr, 'dd/mm/yyyy'),
             tipo_doc_adicional = ln_tipo_doc_adicional,
                    descripcion = lv_descripcion
            WHERE cod_adicional = TO_NUMBER (ag_cod_adicional);


   ------- Registro de Items del Adicional/Reduccion ------------------
   usp_registra_items( ag_trama_items, ag_cod_adicional,ln_cod_contrato,ln_cod_moneda);

   IF (ln_ind_siaf = 1) THEN
   BEGIN
   --------- Actualiza Calendario --------
   usp_registra_calendario(ag_trama_calendario);

   UPDATE reg_procesos.adicional_reduccion
      SET id_operacion = reg_procesos.pk_convocatoria.getidoperacion
    WHERE cod_adicional = TO_NUMBER (ag_cod_adicional);

   reg_procesos.pk_trans_mef.sp_ws_mef_send_operacion(reg_procesos.pk_convocatoria.getidoperacion);


      update CONTRATO_OPERACION
           set CONTRATO_OPERACION.Usuario_Transfer = session__userid
        where CONTRATO_OPERACION.id_operacion = reg_procesos.pk_convocatoria.getidoperacion;

   END;
   END IF;

      ------------- Ingresar la valorizacion -----------------
      UPDATE reg_procesos.valorizacion
         SET n_cod_contrato        = ln_cod_contrato,
             num_comprobante_pago  = ag_num_comprobante_pago,
             codmoneda             = ln_codmoneda_v,
             monto_bruto           = ag_monto_bruto,
             monto_reajuste        = ag_monto_reajuste,
             monto_amortizacion    = ag_monto_amortizacion,
             monto_deduccion       = ag_monto_deduccion,
             monto_interes         = ag_monto_interes,
             monto_otros           = ag_monto_otros,
             monto_neto            = ag_monto_neto,
             monto_igv             = ag_monto_igv,
             monto_total_pagado    = ag_monto_total_pagado,
             fec_valorizacion      = TO_DATE (ag_fec_valorizacion, 'dd/mm/yyyy')
       WHERE cod_valorizacion      = TO_NUMBER (ag_cod_valorizacion);

      UPDATE reg_procesos.adicional_reduccion
         SET cod_valorizacion = TO_NUMBER (ag_cod_valorizacion)
       WHERE cod_adicional = TO_NUMBER (ag_cod_adicional);

      COMMIT;

      pku_ss_make_contrato.usp_calcula_costofinal (ag_cod_contrato);


      usp_print('
       <input type ="hidden" name ="ag_ncor_orden_pedido" value="'|| ag_ncor_orden_pedido|| '" />
       <input type ="hidden" name ="ag_cm_opc"            value="'|| ag_cm_opc|| '" />
       <input type ="hidden" name ="ag_cm_oper_compra"    value="'|| ag_cm_oper_compra|| '" />
       <input type ="hidden" name="ag_anhoentidad"        value="'|| ag_anhoentidad|| '" />
');

      usp_print
         ('<script language="javascript">
                thisform.scriptdo.value=''LisAdicionalesDoView'';
                thisform.submit();
           </script>');


   END;
/************************************************************************************************/
   PROCEDURE uspmanreducciondoedit (
      session__n_convoca           VARCHAR2 DEFAULT NULL,
      session__cod_contrato        VARCHAR2 DEFAULT NULL,
      ag_cod_adicional           IN   VARCHAR2 DEFAULT '', --vienen del editar
      ag_fec_doc_adicional            VARCHAR2 default null,
      ag_ncor_orden_pedido       IN   VARCHAR2 DEFAULT '',
      -- variables convenio marco
      ag_cm_opc                  IN   VARCHAR2 DEFAULT '',
      ag_cm_oper_compra          IN   VARCHAR2 DEFAULT '',
      -- variables para regresarlas al listado de Contratos
      ag_anhoentidad                  VARCHAR2 DEFAULT NULL,
      ag_trama_items                  VARCHAR2 DEFAULT NULL
   )
   IS
      -------- declaracion de Variables -------
      ag_n_convoca                 VARCHAR2 (50);
      ln_n_convoca                 NUMBER;
      ln_n_cod_contrato            NUMBER;
      ln_total_pago_cont           NUMBER;
      ln_total_pago_cont_scr       NUMBER;
      ln_ind_siaf                  NUMBER;
      ln_ind_modif                 NUMBER;
      -- guarda el monto total de pago en el cal adicional al hacer uno nuevo
      ln_id_operacion              NUMBER;

      lv_trama_items                varchar2(32000);
      -- cursor para llenar los arreglos mon y cambio que se usaran en js
      CURSOR c_cambio
      IS
         SELECT val_tipo_cambio cambio, codmoneda
           FROM reg_procesos.t_cat_tipo_cambio
          WHERE ind_vigente = 1;

      -- variables para adicional nodename ="contratos"
      contr_n_cod_contrato         reg_procesos.contrato.n_cod_contrato%TYPE;
      contr_n_contrato             reg_procesos.contrato.n_contrato%TYPE;
      contr_m_contratado           reg_procesos.contrato.m_contratado%TYPE;
      contr_ruc_contratista        reg_procesos.contrato.ruc_contratista%TYPE;
      contr_nom_contratista        reg_procesos.contrato.nom_contratista%TYPE;
      --variables para la cabecera
      vf_contrato                  reg_procesos.contrato.f_contrato%TYPE;
      vn_convoca                   reg_procesos.convocatorias.n_convoca%TYPE;
      vn_proceso                   reg_procesos.convocatorias.n_proceso%TYPE;
      vanhoentidad                 reg_procesos.convocatorias.anhoentidad%TYPE;
      vproc_tipo                   reg_procesos.convocatorias.proc_tipo%TYPE;
      vproc_num                    reg_procesos.convocatorias.proc_num%TYPE;
      vproc_sigla                  reg_procesos.convocatorias.proc_sigla%TYPE;
      vproc_tipo_sigla             reg_procesos.tipo_procesos.proc_tipo_sigla%TYPE;
      vcodconsucode                reg_procesos.convocatorias.codconsucode%TYPE;
      -- variable para el codigo objeto
      vn_codobjeto                 reg_procesos.convocatorias.codobjeto%TYPE;
      -- variables para el editar nodename "adicional"
      ad_cod_adicional             reg_procesos.adicional_reduccion.cod_adicional%TYPE;
      ad_cod_valorizacion          NUMBER;
      ad_ind_adicional_reduccion   VARCHAR2 (3);
      ad_n_cod_contrato            reg_procesos.adicional_reduccion.n_cod_contrato%TYPE;
      ad_tipo_doc_adicional        reg_procesos.adicional_reduccion.tipo_doc_adicional%TYPE;
      ad_nro_doc_adicional         reg_procesos.adicional_reduccion.nro_doc_adicional%TYPE;
      ad_cant_adicional            reg_procesos.adicional_reduccion.cant_adicional%TYPE;
      ad_unm_codigo_adicional      reg_procesos.adicional_reduccion.unm_codigo_adicional%TYPE;
      ad_monto_adicional           reg_procesos.adicional_reduccion.monto_adicional%TYPE;
      ad_codmoneda                 reg_procesos.adicional_reduccion.codmoneda%TYPE;
      ad_fec_doc_adicional         VARCHAR2 (10);
      ad_concepto_adicional        reg_procesos.adicional_reduccion.concepto_adicional%TYPE;
      ad_nro_doc_cgr               reg_procesos.adicional_reduccion.nro_doc_cgr%TYPE;
      ad_fec_doc_cgr               VARCHAR2 (10);
      ad_descripcion               reg_procesos.monedas.descripcion%TYPE;
      -- Cursor
      ctipoinstrumento              ref_cursor;
      -- Combos
      lv_combo_tipoinstrumento      varchar2(4000);
      
      -- variables de los datos del upload--jgarciaf
      ln_NCOD_DOC                    NUMBER;-----jgarciaf
      lv_DOC_URL                     VARCHAR2(250);----jgarciaf
      lv_FEC_UPLOAD                  VARCHAR2(20);----jgarciaf
      lv_USER_UPLOAD                 VARCHAR2(30);----jgarciaf
      lv_FEC_APROB                   VARCHAR2(20);----jgarciaf
      lv_EXT_TIPO_FILE               VARCHAR2(250);----jgarciaf
      lv_ICON_TIPO_FILE              VARCHAR2(250);----jgarciaf
      lv_DOC_OBS                     VARCHAR2(250);----jgarciaf


   BEGIN

     -------- Funciones Script para Validaciones -------
      reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.fvalidacadenas_js;
      pku_procesos_comun.dojscript;

      -------- Inicializa Variables -------
      ln_n_convoca      := TO_NUMBER (session__n_convoca);
      ln_n_cod_contrato := TO_NUMBER (session__cod_contrato);

      ln_ind_siaf       := f_ind_uso_siaf_modif (ag_cod_adicional);
      ln_ind_modif      := ln_total_pago_cont_scr - ln_total_pago_cont;
      lv_trama_items    := nvl(ag_trama_items,PKU_GESTOR_CONT_UTILES_3.f_getXmlItemsAdionReduc(ln_n_cod_contrato,ag_cod_adicional));

      -- select para obtener los datos del adicional a editar nodename ="adicional"
      BEGIN
         SELECT ar.cod_adicional,
                DECODE (ar.cod_valorizacion, NULL, NULL, ar.cod_valorizacion)  cod_valorizacion,
                TRIM (TO_CHAR (ar.ind_adicional_reduccion, '999')) ind_adicional_reduccion,
                ar.n_cod_contrato,
                ar.tipo_doc_adicional,
                ar.nro_doc_adicional,
                ar.cant_adicional,
                ar.unm_codigo_adicional,
                ar.monto_adicional,
                ar.codmoneda,
                TO_CHAR (ar.fec_doc_adicional, 'dd/mm/yyyy')fec_doc_adicional,
                ar.concepto_adicional,
                ar.nro_doc_cgr,
                TO_CHAR (ar.fec_doc_cgr, 'dd/mm/yyyy') fec_doc_cgr,
                m.descripcion
           INTO ad_cod_adicional,
                ad_cod_valorizacion,
                ad_ind_adicional_reduccion,
                ad_n_cod_contrato,
                ad_tipo_doc_adicional,
                ad_nro_doc_adicional,
                ad_cant_adicional,
                ad_unm_codigo_adicional,
                ad_monto_adicional,
                ad_codmoneda,
                ad_fec_doc_adicional,
                ad_concepto_adicional,
                ad_nro_doc_cgr,
                ad_fec_doc_cgr,
                ad_descripcion
           FROM reg_procesos.adicional_reduccion ar, reg_procesos.monedas m
          WHERE cod_adicional = TO_NUMBER (ag_cod_adicional)
            AND ar.codmoneda = m.codmoneda;
     EXCEPTION
            WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar halalar los datos del Adicional/Reduccion','''LisAdicionalesDoView''');

      END;

    ctipoinstrumento          := pku_ss_utiles.f_tipo_instrumento('1,5');

    lv_combo_tipoinstrumento  := PKU_SS_UTILES.f_retorna_combo(ctipoinstrumento, 'ag_tipo_doc_adicional', ad_tipo_doc_adicional,'Seleccione...','style="width:250px"');

    BEGIN
         SELECT c.n_cod_contrato, c.n_contrato, c.m_contratado,c.ruc_contratista, c.nom_contratista
           INTO contr_n_cod_contrato, contr_n_contrato, contr_m_contratado,contr_ruc_contratista, contr_nom_contratista
           FROM reg_procesos.contrato c
          WHERE c.n_cod_contrato = ln_n_cod_contrato;
       EXCEPTION
            WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar halalar los datos del Contrato','''LisAdicionalesDoView''');
                RETURN;

   END;

   IF (ln_n_convoca IS NOT NULL) THEN
        BEGIN
            SELECT c.codconsucode, c.n_convoca, c.n_proceso, c.anhoentidad,c.proc_tipo, c.proc_num, c.proc_sigla, t.proc_tipo_sigla,c.codobjeto
              INTO vcodconsucode, vn_convoca, vn_proceso, vanhoentidad,vproc_tipo, vproc_num, vproc_sigla, vproc_tipo_sigla,vn_codobjeto
              FROM reg_procesos.convocatorias c, reg_procesos.tipo_procesos t
             WHERE c.n_convoca = ln_n_convoca
               AND t.proc_tipo = c.proc_tipo;
        EXCEPTION
            WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar halalar los datos de la convocatoria','''LisAdicionalesDoView''');

        END;
   END IF;


  -- obtengo el id_operacion
  ln_id_operacion := f_get_id_operacion (ag_cod_adicional);


  usp_print('
      <table border="0" width=100% class=tableform cellpadding=0 cellspacing=0>
        <tr>');

  usp_print
          (PKU_SS_UTILES.f_get_titulo_contrato (session__cod_contrato,'Modificar Reducci&oacute;n'));

  usp_print('
         </td>
         <td valign=top align=right>
              <input type="button" value="Volver" onclick="thisform.scriptdo.value=''LisAdicionalesDoView'';thisform.submit();">
              <input type="button" value="Grabar" onclick="grabarRed(''AdicionalRedDoUpdate'')">
         </td>
        </tr>
     </table>
  <br/>');

    -- los hidden de Adicional
    usp_print('
    <input type="hidden" name="ag_n_convoca"             value="'|| ag_n_convoca|| '"/>
    <input type="hidden" name="ag_cod_contrato"          value="'|| session__cod_contrato|| '" />
    <input type="hidden" name="ag_concepto_adicional"    value=""/>
    <input type="hidden" name="ag_m_contratado"          value="'|| contr_m_contratado|| '"/>
    <input type="hidden" name="ag_cod_objeto"            value="'|| vn_codobjeto|| '"/>
    <input type="hidden" name="ag_ind_siaf"              value="'|| ln_ind_siaf|| '"/>
    <input type="hidden" name="ag_ind_modif"             value="'|| ln_ind_modif|| '"/>
    <input type="hidden" name="ag_reg_cal_modif"         value=""/>
    <input type="hidden" name="ag_id_motivo" />
    <input type="hidden" name="ag_id_operacion"          value="'|| ln_id_operacion|| '"/>
    <input type="hidden" name="ag_id_op" />
    <input type="hidden" name="ag_num_pago" />
    <input type="hidden" name="ag_fec_pago" />
    <input type="hidden" name="ag_monto_pago" />
    <input type="hidden" name="ag_fecha_pago" />
    <input type="hidden" name="ag_ncor_orden_pedido"     value="'|| ag_ncor_orden_pedido|| '"/>
    <input type="hidden" name="ag_cm_opc"                value="'|| ag_cm_opc|| '"/>
    <input type="hidden" name="ag_cm_oper_compra"        value="'|| ag_cm_oper_compra|| '"/>
    <input type="hidden" name="ag_anhoentidad"           value="'|| ag_anhoentidad|| '" />
    <input type="hidden" name="ag_trama_items"           value="" />
    <input type="hidden" name="ag_trama_calendario"           value="" /> 
    <input type ="hidden" name="an_total_items"           value=""/>
    ');

----jgarcia inicio


 -- datos del upload del contrato
   
   REG_PROCESOS.PKU_GESTOR_CONT_UTILES_2.P_last_upload_reduccion( session__cod_contrato, session__N_CONVOCA, ln_NCOD_DOC,lv_DOC_URL,lv_FEC_UPLOAD ,lv_USER_UPLOAD,lv_FEC_APROB ,lv_EXT_TIPO_FILE,lv_ICON_TIPO_FILE, lv_DOC_OBS,ag_cod_adicional);

---jgarciaf

    usp_print('
     <table width=100% class="table table-striped">
        <tr>
            <td class=c1>Nmero del Contrato (u Orden de Compra o Servicio)</td>
            <td class=c2><b>'|| contr_n_contrato || '</b><input type="hidden" name="contr_n_contrato" value="'|| contr_n_contrato || '"/></td>
            <td class=c3>Nmero del Contrato (u Orden de Compra o Servicio)</td>
        </tr>
        <tr>');

      usp_print('<td class=c1>Nmero de Reduccin</td>
                 <td class=c2><b>'|| ad_cod_adicional|| '</b><input type="hidden" name="ag_cod_adicional" value="'|| ad_cod_adicional|| '"/></td>
                 <td class=c3>Nmero de Reduccin</td>
        </tr>
        <tr>
             <td class=c1>Tipo</td>
           <td class=c2><b>REDUCCIN</b></td>
           <td class=c3>Tipo Operacion</td>
        </tr>
        <tr>
             <td class=c1>Documento autorizado por la Entidad</td>
           <td class=c2>'||lv_combo_tipoinstrumento||'<input size=12 class="form-control" name="ag_nro_doc_adicional" value="'|| ad_nro_doc_adicional|| '" onblur="ValidarString(this, ''Nmero de Documento'');" /></td>
           <td class=c3>Documento autorizado por la Entidad</td>
        </tr>
        
        
        <tr align=center> <td colspan="4" align=center>'|| case when lv_DOC_URL is not null then '<br><a target=_blank href="DownloadFileServlet?fileName='||lv_DOC_URL||'">
                    <img src="'||lv_ICON_TIPO_FILE||'" border="0" width="25" height="25"/></a>'end || case when lv_FEC_UPLOAD is not null then ' Registrado el '||lv_FEC_UPLOAD end||
                    '<input type="hidden" name="pfiletoupload_file1" value=""/>
        </td>
        </tr>
      
       
        
        <tr>
           <td class=c1>Fecha del Documento autorizado por la Entidad</td>
           <td class=c2>
           <div class="input-group datepicker" id="idDivTxtFechaIni">
                <div class="input-group-addon  add-on">
                     <span class="glyphicon glyphicon-calendar"></span>
                </div>
               <input type="text" name="ag_fec_doc_adicional" value="'||ad_fec_doc_adicional||'" style="width:98%" data-format="dd/MM/yyyy" class="form-control"/>
          </div>
           <td class=c3>Fecha del Documento autorizado por la Entidad</td>
         </tr>

         <tr>
             <td class=c1>Moneda</td>
           <td class=c2><input name="ag_codmoneda" value="'|| ad_codmoneda || '" type="hidden"/>
                   <b>'|| ad_descripcion|| '</b>
           </td>
           <td class=c3>Moneda</td>
         </tr>

         <tr>
            <td class=c1>Monto</td>
            <td class=c2><input name="ag_monto_adicional" type="hidden" value="'|| ad_monto_adicional|| '"/>
                  <b>'|| ad_monto_adicional|| '</b>
            </td>
            <td class=c3>Monto</td>
         </tr>
      </table>');

  ----------------- items --------------------------------

  IF lv_trama_items IS NOT NULL THEN

  usp_print('<tr><td><h3>Items</h3></td></tr>');
  usp_print('<tr align=center>');
  usp_print('<TD colspan="4" align=center>');
  PKU_GESTOR_CONT_FUNCIONES_JS_3.fXmlItemsReader(lv_trama_items,'an_total_items');
  usp_print('</TD></TR>');

  END IF;

  usp_print ('</table>');

  usp_print('
    <input type="hidden" name="ag_f_contrato" value="'|| vf_contrato|| '"/>
    <input type="hidden" name="ag_objeto"     value="'|| PKU_SS_UTILES.f_getcodobjeto (ln_n_convoca)|| '"/>
    <input type="hidden" name="cambio"        value=""/>');

  -------- Java Script para Adicional y reduccion --------
      usp_print
         ('
        <script language="javascript">

       //para la validacion en valorizacion
          var cambio        = new Array();
          var mon           = new Array();
          i = 0;'
         );

      FOR c_camb IN c_cambio LOOP
         BEGIN
            usp_print (   '
                cambio[i] = ' || to_char(c_camb.cambio, '999,999,999,999.00') || '
                mon[i] ='|| c_camb.codmoneda || '
                i++; ');
         END;
      END LOOP;

      usp_print
         (   '
            function ValidarString(ls_obj, ls_mensage)
            {
                var strCadena = ls_obj.value;
                var valido= "ABCDEFGHIJKLMNOPQRSTUVWYXZ0123456789abcdefghijklmnopqrstuvwxyz#$%()=*+}{[]-:,.!?&/ ";
                var flag=0;

                for (i = 0 ; i <= strCadena.length - 1; i++)
                    {
                       if(!vacio(trim(strCadena.substring(i,i+1)))){
                            if (valido.indexOf (strCadena.substring(i,i+1),0) == -1)
                            {
                                ls_obj.select();
                                //alert("Hay un caracter no permitido en el campo " + ls_mensage + "\nel caracter no permitido es ( "+strCadena.substring(i,i+1)+" )");
                                ls_obj.focus();
                                flag =1;

                            }
                       }
                    }

                if ( flag ==1 ){
                    alert("Hay un caracter no permitido en el Nro. de Documento que autoriza la Operacin");
                    ls_obj.value="";

                    return false;
                }else{
                    return true;
                }
            }

            function vacio(ls_cadena) {
                if (ls_cadena == " " || ls_cadena == null || ls_cadena.length == 0)
                    return true;
                else return false;
            }

             function ValidarCambio(obj){
                var thisform=getForm(obj);

                monto = parseFloat(thisform.ag_monto_adicional.value);
                for(i=0; i<cambio.length; i++){
                    if(thisform.ag_codmoneda.value == mon[i]){
                        monto = monto*cambio[i];
                    }
                }
                return monto;
            }


   // graba las modificaciones realizadas a la Reduccion
   
   function grabarRed(pagina){
   if(thisform.ag_concepto==null){
          thisform.ag_concepto_adicional.value=""
      }
      else{
          thisform.ag_concepto_adicional.value = thisform.ag_concepto.value
      }

     //thisform.ag_trama_items.value = xmlItems.xml;
     thisform.scriptdo.value=pagina;
     thisform.submit();

   }

   function cancelar(obj,scrobj){
        var thisform=getForm(obj);
           thisform.scriptdo.value=scrobj;
           thisform.submit();
   }

  </script>');

  END;

-- procedimiento para actualizar los datos de la Reduccion ----
   PROCEDURE uspadicionalreddoupdate (
      ag_n_convoca                   VARCHAR2,
      ag_cod_contrato                VARCHAR2,
      ag_cod_adicional          IN   VARCHAR2 DEFAULT '',
      ag_nro_doc_adicional           VARCHAR2,
      ag_tipo_doc_adicional          VARCHAR2,
      ag_cant_adicional              VARCHAR2,
      ag_ind_adred                   VARCHAR2,
      ag_unm_codigo_adicional        VARCHAR2,
      ag_monto_adicional             VARCHAR2,
      ag_codmoneda                   VARCHAR2,
      ag_fec_doc_adicional           VARCHAR2 DEFAULT null,
      ag_concepto_adicional          VARCHAR2,
      ag_nro_doc_cgr                 VARCHAR2,
      ag_fec_doc_cgr                 VARCHAR2,
      ag_cod_valorizacion            VARCHAR2,
      ag_ncor_orden_pedido      IN   VARCHAR2 DEFAULT '',
      -- variables convenio marco
      ag_cm_opc                 IN   VARCHAR2 DEFAULT '',
      ag_cm_oper_compra         IN   VARCHAR2 DEFAULT '',
      -- variables para regresarlas al listado de Contratos
      ag_anhoentidad                 VARCHAR2 DEFAULT NULL,
      ag_trama_items                 VARCHAR2
   )
   IS
      ----------- Variables ---------
      ln_cod_contrato           NUMBER;
      ln_cod_moneda             NUMBER;
      ln_tipo_doc_adicional     NUMBER;
      ln_cant_adicional         NUMBER;
      ln_unm_codigo_adicional   NUMBER;
      ln_monto_adicional        NUMBER;

   BEGIN

      ln_cod_contrato           := TO_NUMBER (ag_cod_contrato);
      ln_tipo_doc_adicional     := TO_NUMBER (ag_tipo_doc_adicional);
      ln_cant_adicional         := TO_NUMBER (ag_cant_adicional);
      ln_unm_codigo_adicional   := TO_NUMBER (ag_unm_codigo_adicional);
      ln_cod_moneda             := TO_NUMBER (ag_codmoneda);
      ln_monto_adicional        := TO_NUMBER (ag_monto_adicional);

/*    usp_print('ln_cod_contrato: '||ln_cod_contrato||'<br>');
    usp_print('ln_tipo_doc_adicional: '||ln_tipo_doc_adicional||'<br>');
    usp_print('ag_nro_doc_adicional: '||ag_nro_doc_adicional||'<br>');
    usp_print('ln_cant_adicional: '||ln_cant_adicional||'<br>');
    usp_print('ln_unm_codigo_adicional: '||ln_unm_codigo_adicional||'<br>');
    usp_print('ln_cod_moneda: '||ln_cod_moneda||'<br>');
    usp_print('ag_fec_doc_adicional: '||ag_fec_doc_adicional||'<br>');
    usp_print('ag_cod_valorizacion: '||ag_cod_valorizacion||'<br>');
    usp_print('ag_cod_adicional: '||ag_cod_adicional||'<br>');

    return;*/

      ---------- Hago la actualizacion del Adicional en la tabla adicion_reduccion ----------
      UPDATE reg_procesos.adicional_reduccion
         SET n_cod_contrato            = ln_cod_contrato,
             tipo_doc_adicional        = ln_tipo_doc_adicional,
             nro_doc_adicional         = ag_nro_doc_adicional,
             cant_adicional            = ln_cant_adicional,
             unm_codigo_adicional      = ln_unm_codigo_adicional,
             monto_adicional           = ln_monto_adicional,
             codmoneda                 = ln_cod_moneda,
             fec_doc_adicional         = to_date(ag_fec_doc_adicional,'dd/mm/yy'),
             concepto_adicional        = ag_concepto_adicional,
             nro_doc_cgr               = ag_nro_doc_cgr,
             fec_doc_cgr               = to_date(ag_fec_doc_cgr,'dd/mm/yy'),
             cod_valorizacion          = DECODE (ag_cod_valorizacion,'', '', TO_NUMBER (ag_cod_valorizacion, 9999999))
       WHERE cod_adicional             = TO_NUMBER (ag_cod_adicional);

      ------- Registro de Items del Adicional/Reduccion ------------------
      usp_registra_items( ag_trama_items, ag_cod_adicional,ln_cod_contrato,ln_cod_moneda);


      COMMIT;

/*      pku_ss_make_contrato.usp_calcula_costofinal (ag_cod_contrato);
*/
      -------------- type="hidden" --------------
      usp_print
         (   '
      <input type="hidden" name ="ag_n_convoca"            value="'|| ag_n_convoca ||'" />
      <input type="hidden" name ="ag_cod_contrato"         value="'|| ag_cod_contrato ||'" />
      <input type="hidden" name ="ag_ind_adred"            value="'|| ag_ind_adred || '" />
      <input type="hidden" name ="ag_ncor_orden_pedido"    value="'|| ag_ncor_orden_pedido || '" />
      <input type="hidden" name ="ag_cm_opc"               value="'|| ag_cm_opc || '" />
      <input type="hidden" name ="ag_cm_oper_compra"       value="'|| ag_cm_oper_compra || '" />
      <input type="hidden" name="ag_anhoentidad"           value="'|| ag_anhoentidad || '" />'

         );

      usp_print
         ('
       <script language="javascript">
                thisform.scriptdo.value=''LisAdicionalesDoView'';
                thisform.submit();
       </script>');


   END;
procedure actualiza_vigencia(
v_codigo                VARCHAR2,
ag_f_vigencia_ini          VARCHAR2 DEFAULT NULL,
ag_f_vigencia_fin          VARCHAR2 DEFAULT NULL,
v_tipo                      NUMBER
)
is begin
 reg_procesos.PKU_GESTOR_CONT_FUNCIONES_JS_3.js_script(' var _error = 0; ');
 USP_PRINT('<input type="hidden" name="v_tipo" value="'||v_tipo||'" >');
IF (v_codigo is not null)THEN
     -- usp_print('lalalala');
    ------- Actualiza Contrato --------
       BEGIN
          UPDATE reg_procesos.contrato
             SET f_vigencia_ini  = ag_f_vigencia_ini,
             f_vigencia_fin = ag_f_vigencia_fin
           WHERE n_cod_contrato = v_codigo;

           usp_print('<center><font color="blue"><b>Se actualiz&oacute; la vigencia del contrato</b></font></center>');

        EXCEPTION
            WHEN OTHERS THEN
                pku_ss_mod_contratos.f_msg_error('Error al intentar actualizar la vigencia del contrato','''LisAdicionalesDoView''');

       END;
    commit;
END IF;
      usp_print
       ('
     <script language="javascript">
            if (thisform.v_tipo.value==1)
              thisform.scriptdo.value=''LisAdicionalesDoView'';
              if (thisform.v_tipo.value==2)
              thisform.scriptdo.value=''LisProrrogasDoView'';
              if (thisform.v_tipo.value==3)
              thisform.scriptdo.value=''Lisaampliacionplazodoview'';

               if ( _error !=1 )
              thisform.submit();
     </script>'
       );
end;


procedure jscript_vigencia is
begin
usp_print('<script language="javascript">
function comparaFF(fec1, fec2)
        {
            var Anio1 = (fec1).substr(6,4)
            var Mes1 = ((fec1).substr(3,2))*1 - 1
            var Dia1 = (fec1).substr(0,2)
            var Anio2 = (fec2).substr(6,4)
            var Mes2 = ((fec2).substr(3,2))*1 - 1
            var Dia2 = (fec2).substr(0,2)
            var Fecha_Inicio = new Date(Anio1,Mes1,Dia1)
            var Fecha_Fin = new Date(Anio2,Mes2,Dia2)
            if(Fecha_Inicio > Fecha_Fin)
                return 1;
            else
            {
                if(Fecha_Inicio < Fecha_Fin)
                    return 2;
                else
                    return 0;
            }
        }

function f_validar()
    {

        if (thisform.ag_f_vigencia_ini.value==""){
        alert("Ingrese la Fecha de Inicio de Vigencia")
                thisform.ag_f_vigencia_ini.focus();
                return false;
        }
        if (thisform.ag_f_vigencia_fin.value==""){
        alert("Ingrese la Fecha de Fin de Vigencia")
                thisform.ag_f_vigencia_fin.focus();
                return false;
        }
        if (comparaFF(thisform.ag_f_vigencia_ini.value, thisform.ag_f_vigencia_fin.value)== 1 ){
        alert("La Fecha de Inicio no puede mayor a la Fecha Fin de Vigencia")
                thisform.ag_f_vigencia_ini.focus();
                return false;
        }

    return true;
    }
    function Grabar_Vigencia()
    {
      if (f_validar()){
      thisform.scriptdo.value = "doVigencia";
      thisform.submit();
      }
    }

function DivOcultar(accion, div)
            { var capa=document.getElementById(div);
                        if ( accion == 1 )
                        {
                        capa.style.display="none";
                        capa.style.visibility="hidden";
                        }
                        if ( accion ==0 )
                        {
                        capa.style.display="";
                        capa.style.visibility="visible";
                        }
            }

             function f_change_vigencia(val, obj)
            {

              // alert("val: "+val);
                if( val== 0)
                DivOcultar(1,"tbl_vigencia")
                else
                DivOcultar(0,"tbl_vigencia")

            }
</script>
');
end;


END;
/
