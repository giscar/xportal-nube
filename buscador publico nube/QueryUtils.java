package pe.gob.osce.seace.publico.ejb.utils;

import pe.gob.osce.seace.buscadores.bus.type.GenericoETOType; //nocturno

/***********
 * 	ModificaciOn
 *  ======================================================
 *  Id		autor		fecha		DescripciÃ³n
 *  ======================================================
 *  001     jmatos		15/10/2014	Se adiciona filtros para la atenciÃ³n de incidencia 2749_OP_SEACE3_PUB
 *  002     rramos		22/10/2014	Se modifica por incidencia de archivos en seace2
 *  003     rramos		23/10/2014	Se modifica por incidencia 24 del 11/09/2014
 *  004     rramos		27/10/2014	Se modifica por incidencia 24 del 11/09/2014
 *  005     rramos		30/10/2014	Se modifica por incidencia 16 del 25/09/2014
 *  006     rramos		04/11/2014	Visualizar acciones SUSPENSION SUPERVISION OSCE y DOCUMENTO LEVANTA SUSPENSION SUPERVISION OSCE
 *  007     rramos		14/11/2014	Visualizar acciones Postergacion y Fe de Errata
 *  008     rramos		10/12/2014  Buscador por proveedor adjudicado
 *  009     gtintaya	22/12/2014  Listar items del seaceV2
 *  010		tchacon		09/01/2015  Para que se visualize correctamente el Numero del Item Incidencia 3410_OP_SEACE3_PUB
 *  011     gtintaya	12/01/2015  Mostrar Componentes de un Item Paquete.
 *  012 	tchacon     12/01/2015   Visualizar campo "Reinicado desde" En la Ficha del proceso
 *  013     tchacon		20/01/2015	Se Agrega historial de documentos
 *  014     gtintaya    30/06/2015  Se Visualiza documentos en la opcion "Ver documentos del Procedimiento".
 *  015 	tchacon     15/10/2015  Incidencia buscador por expediente de tribunal (el tomarazon link del tomarazon estaba mal)
 *  016		jmatos		02/11/2015	AtenciÃ³n al Correo Web 'DirecciÃ³n del SEACE: En el registro de participantes hay informaciÃ³n que no se ve en lo publico'
 *  017 	ddrodriguez 07/10/2015  Req 28 Nueva Ley - Requerimiento 28 respecto al Modulo de Notificaciones
 *  018		jcarrillo	13/01/2016	Requerimientos 02-B
 *  019	    asanchezz	13/01/2016  Requerimiento 57 - Nueva Ley
 *  020		cinonan		01/02/2016	Proceso de selecciÃ³n NÂ° MC-46-2015-DIRSAL PNP - dos recursos de apelaciÃ³n NÂ° 3282-2015-TCE y NÂ° 3285-2015-TCE. En ambos muestran el mismo TMR  
 *  021	    dllantoy	03/03/2016  Requerimiento 038
 *	022		cinonan		29/02/2016	Requerimento 08 - Ley 30225 - Fernando Quiroz (Efectos de Resolucion)   
  *	023		cinonan		29/02/2016	Requerimento 50 - Ley 30225 - Pierina Guerrero (Para nuevas acciones)
 * 024		ddrodriguez 05/05/2016  Req 14-2016	Crear modulo calendarizacion para procesos SIE creados bajo la nueva ley 30225
 * 025		mlaura 		18/05/2016	Memorando 036-2016 - VisualizaciÃ³n de documentos Buscador Publico de los procesos de selecciÃ³n convocados en el SEACE V2.0
  *	028		tchacon		13/07/2016	Inc 2426_OP_SEACE3_SEL no se visualiza correctamente el nombre del consorcio
  * 029     vbaldeon    01/08/2016  SOL. MANT. NÂ°024-2016      Agregar un documento de actos
  * 031 	cinonan		06/03/2017	M-011-2017: Reactivar el valor referencial (DL1341 que modifica la Ley 30225)  
  * 032    Dante Artica 04/07/2017 Consultoria de Pronunciamiento
  * 034		ddrodriguez 20/10/2017  SM 104-2017 Modificacion de los datos de una entidad (Razon Social y Direccion Fiscal)
  * 035		cinonan		07/03/2019	SM-031-2019 --> AdecuaciOn del valor referencial (2da. modificación del reglamento de la ley 30225)
  * 036		lfloresr	03/04/2019	SM-131-2019 --> En la ficha de selecciOn del Portal PUblico se debe de ver el icono del listado de consultas y observaciones en todos los casos que los hubiese
  * 037		apoyosgfs6	26/04/2019	SM-179-2019 --> No estA mostrando informaciOn del cronograma, archivos e Items de los procedimientos de Convenios y RegImenes Especiales
  * 038    	ddrodriguez	24/06/2019	SR-181-2019		Implementación de la Elevación de Cuestionamientos con modo de ejecución electrónica – Vista Pública de Acciones del procedimiento relacionadas
  * 039		ndiaz		20/07/2019	SM-268-2019		Implementación de la visualización de propuestas (electrónicas) en el buscador público
  * 040		ndiaz		16/11/2019	SM-341-2019		SM-341-2019 Revision y correccion del: Buscador de proveedores adjudicados para todos los procedimientos de seleccion incluyendo el Procedimientos Especial de Contratacion - PEC
  * 041		ndiaz		19/11/2019	SM-262-2019		Mostrar un historial de versiones de la etapa de Absolución de consultas y observaciones e integración de bases en el buscador público.
  * 042	 	cinonan		02/01/2020 	SM-386-2019 	Corrección de los datos de registro de la presentación de ofertas
  * 043     ddrodriguez	25/02/2020	SM-015-2020	   	Implementar campo Tipo de Proceso en la ficha de seleccion del Buscador Publico, segun el lineamiento del DU 018-2019
  * 044		ddrodriguez	19/05/2020	SM-084-2020     En el Portal Web publico, se debe visualizar a nivel de item el indicador Nulo (por reactivacion)
  * bse01	lfloresr	02/07/2020	SR-079-2020		Desarrollo e implementaciOn de interface web 01: Autenticación CODI - SEACE para la integraciOn con el Cuaderno de Obra Digital
 * ********/
public class QueryUtils {

	public static final Long TIPO_SEACE_3 = new Long(3);
	public static final Long TIPO_SEACE_2 = new Long(2);
	
	/**	Convocatoria	*/
	public static StringBuilder getQueryFichaConvocatoria(Long tipoSeace){
		StringBuilder sbQuery =new StringBuilder();
		
		if(tipoSeace.equals(TIPO_SEACE_2)){
			/*sbQuery.append("SELECT c.N_CONVOCA N_ID_EXPEDE, (tp.proc_tipo_sigla || ' ' || ts.des_tipo_subasta || ' .' || c.PROC_NUM || '-'|| c.ANHOENTIDAD || '/' ||c.PROC_SIGLA ) C_NOMETS,  c.NUM_CONVOCA C_NUMCNV, ");
			sbQuery.append(" tm.DES_TIPO_MODALIDAD TIP_COMPRA, tp.DESCRIPCION NORM_APLICA, o.DESCRIPCION DESCR_OBJETO, c.DES_OBJETO, c.V_REFERENCIAL, c.COSTO_VENTA, C.codmoneda, TO_CHAR(c.F_PUBLICA, 'DD/MM/YYYY HH24:MI') F_PUBLICA, ");
			sbQuery.append(" '' C_LUGPAG, '' C_NROCTA,  c.CODCONSUCODE,  e.DESCRIPCION,  e.DIRECCION,  e.URL_WEB,  e.TELEFONO "); 
			sbQuery.append(" from reg_procesos.convocatorias@AIXREGPRODES.SEACE.GOB.PE c,  reg_procesos.tipo_procesos@AIXREGPRODES.SEACE.GOB.PE tp,  reg_procesos.t_tipo_subasta@AIXREGPRODES.SEACE.GOB.PE ts, ");
			sbQuery.append(" reg_procesos.entidades@AIXREGPRODES.SEACE.GOB.PE e, reg_procesos.objeto@AIXREGPRODES.SEACE.GOB.PE o, reg_procesos.TIPO_MODALIDAD_CONV@AIXREGPRODES.SEACE.GOB.PE tm where N_CONVOCA = :idConvoca");
			sbQuery.append(" AND C.proc_tipo = tp.proc_tipo AND C.cod_tipo_subasta = ts.cod_tipo_subasta AND C.CODCONSUCODE = e.CODCONSUCODE AND C.ANHOENTIDAD = e.ANHOENTIDAD AND C.CODOBJETO = o.CODOBJETO ");
            sbQuery.append(" AND C.COD_TIPO_MODALIDAD = tm.COD_TIPO_MODALIDAD ");*/
			sbQuery.append("SELECT SEACE2.N_ID_EXPEDE, SEACE2.C_NOMETS, SEACE2.C_NUMCNV, SEACE2.TIP_COMPRA, SEACE2.NORM_APLICA, SEACE2.DESCR_OBJETO, SEACE2.DES_OBJETO, "
					+ " SEACE2.V_REFERENCIAL, SEACE2.COSTO_VENTA, SEACE2.CODMONEDA, SEACE2.F_PUBLICA, SEACE2.C_LUGPAG, SEACE2.C_NROCTA, SEACE2.CODCONSUCODE,  SEACE2.DESCRIPCION, ");
		//	sbQuery.append(" SEACE2.DIRECCION, SEACE2.URL_WEB, SEACE2.TELEFONO, SEACE2.N_ID_EXPEDE as N_ID_EXPEDE_2, SEACE2.TIP_COMPRA_ACT,cod_tipo_subasta FROM BUS.VW_BUS_CONVOCATORIA SEACE2 WHERE SEACE2.N_ID_EXPEDE = :idConvoca ");
			/*Inicio #018 - jcarrillo: Req. 02.B */
			/*** 012 INICIO  */
			sbQuery.append(" SEACE2.DIRECCION, SEACE2.URL_WEB, SEACE2.TELEFONO, SEACE2.N_ID_EXPEDE as N_ID_EXPEDE_2, SEACE2.TIP_COMPRA_ACT,cod_tipo_subasta,SEACE2.C_REIDES, 34 as ID_NORAPL,1 as I_VALEST, 0 as N_TIPLEY_30225  FROM BUS.VW_BUS_CONVOCATORIA SEACE2 WHERE SEACE2.N_ID_EXPEDE = :idConvoca ");//Id.031:cinonan
			/*** 012 FIN  */
			/*Fin #018 - jcarrillo: Req. 02.B */
			
			
		}else if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT  ");
			sbQuery.append(" T1.N_ID_EXPEDE ");
			sbQuery.append(" ,T1.C_NOMETS ");
			sbQuery.append(" ,T1.C_NUMCNV ");
			sbQuery.append(" ,(SELECT C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE P1 WHERE P1.N_ID_VARIABLE = 6 AND P1.N_ID_VALVARIABLE = T1.C_TIPCOM ) TIP_COMPRA ");
			sbQuery.append(" ,(SELECT C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE P1 WHERE P1.N_ID_VARIABLE = 4 AND P1.N_ID_VALVARIABLE = T1.C_NORAPL ) C_NORAPL ");
			sbQuery.append(" ,(SELECT C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE P1 WHERE P1.N_ID_VARIABLE = 8 AND P1.N_ID_VALVARIABLE = T1.C_TIPOBJ ) C_TIPOBJ ");
			sbQuery.append(" ,T1.C_DESOBJ ");
			sbQuery.append(" ,T1.C_VALRET_ORIG ");
			sbQuery.append(" ,B1.C_MONTO ");
			sbQuery.append(" ,T1.N_CODMON_ORIG ");
			sbQuery.append(" ,TO_CHAR(NVL(p1.d_fecpubrei, P1.D_FECCRE), 'DD/MM/YYYY HH24:MI') AS d_fecpub ");
			sbQuery.append(" ,LP.C_LUGPAG ");
			sbQuery.append(" ,LP.C_NROCTA ");
			sbQuery.append(" ,T1.N_ID_ORGAN ");
			sbQuery.append(" ,O1.C_NOMORG ");
			sbQuery.append(" ,O1.C_DIRFIS ");
			sbQuery.append(" ,O1.C_PAGWEB ");
			sbQuery.append(" ,O1.C_NROTLF ");
			sbQuery.append(" ,P.N_ID_PROCED ");//Id.031:cinonan
			sbQuery.append(" ,(SELECT P1.N_COD_ACTOS FROM pro.tbl_cnf_valor_variable p1 WHERE P1.N_ID_VARIABLE = 6 AND P1.N_ID_VALVARIABLE = T1.C_TIPCOM ) TIP_COMPRA_ACT ");
			sbQuery.append(" ,T1.C_MODSEL ");
			sbQuery.append(" ,B1.N_ID_BASES ");
			/**012 INICIO  */
			sbQuery.append(" ,P1.C_REIDES "); 
			/**012 FIN  */
			
			/*Inicio #018 - jcarrillo: Req. 02.B */
			sbQuery.append(" ,T1.C_NORAPL AS ID_NORAPL ");
			sbQuery.append(" , case when (SELECT Count(*) from PRO.TBL_ACT_ITEM x where x.n_id_expede=T1.n_id_expede and (x.n_indpaq in (1) or x.n_indpaq is null))=0  then ");
				sbQuery.append(" case when (SELECT Count(*) from PRO.TBL_ACT_ITEM I where I.n_id_expede=T1.n_id_expede and I.n_estpro in (5,7,17,18,23,24,26,27,32,34,35))>0  then '0'  else '1' end ");
			sbQuery.append(" else ");
				sbQuery.append(" case when (SELECT Count(*) from PRO.TBL_ACT_ITEM I where I.n_id_expede=T1.n_id_expede and (I.n_indpaq in (1) or I.n_indpaq is null) and I.n_estpro in (5,7,17,18,23,24,26,27,32,34,35))>0  then '0'  else '1' end ");
			sbQuery.append(" end  AS I_VALEST ");
			sbQuery.append(" ,T1.C_VALRET AS C_VALRET ");
			/*Fin #018 - jcarrillo: Req. 02.B */
			
			sbQuery.append(", T1.C_TIPSEL "); //019
			sbQuery.append(", P.N_TIPLEY_30225 ");//Id.031:cinonan
			// 034 -  Inicio
			sbQuery.append(", O1.C_NOMVIA||' '||O1.C_NUMVIA ||' '||O1.C_URBANI ||' ('||(SELECT DEP.C_DESUBI||'-'||PRO.C_DESUBI||'-'||DIS.C_DESUBI AS UBIGEO ");   
																		sbQuery.append(" FROM ADM.TBL_ADM_UBIGEO DIS ");
																		sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO PRO ON DIS.N_ID_UBIGPA = PRO.N_ID_UBIGEO ");  
																		sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO DEP ON PRO.N_ID_UBIGPA = DEP.N_ID_UBIGEO ");
																		sbQuery.append(" WHERE DIS.N_ID_UBIGEO = O1.N_ID_UBIGEO)||')' AS C_DIRLEGAL ");
			// 034 -  Fin
			sbQuery.append(" ,(SELECT C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO L1 WHERE L1.N_ID_LISTADO = 131 AND L1.N_ID_VALLISTADO = T1.N_IND_TIPPROC ) C_TIPPROC "); // SM-015-2020
			sbQuery.append(" FROM PRO.TBL_ACT_EXPEDIENTE T1 ");
			sbQuery.append(" ,PRO.TBL_ACT_PROCEDIMIENTO P ");//Id.031:cinonan
			sbQuery.append(" ,PRO.TBL_ACT_BASES B1 ");
			sbQuery.append(" ,PRO.TBL_SEL_PUB_CON P1 ");
			sbQuery.append(" ,PRO.DET_ACT_BASES_LUG_PAG LP ");
			sbQuery.append(" ,ADM.TBL_ADM_ORG O1 ");
			sbQuery.append(" WHERE T1.N_ID_EXPEDE = :idConvoca ");
			sbQuery.append(" AND P.N_ID_PROCED = T1.N_ID_PROCED ");//Id.031:cinonan			
			sbQuery.append(" AND P1.N_ID_BASES = B1.N_ID_BASES ");
			sbQuery.append(" AND T1.N_ID_EXPEDE = B1.N_ID_EXPEDE ");
			sbQuery.append(" AND P1.N_ID_BASES = LP.N_ID_BASES(+) ");
			sbQuery.append(" AND T1.N_ID_ORGAN = O1.N_ID_ORGAN ");								
		}
		
		return sbQuery;
	}
	
	// Inicio  021 Req 38-2 dllantoy
	public static StringBuilder getQueryFichaConvocatoriaExpediente(Long tipoSeace){
		StringBuilder sbQuery =new StringBuilder();		
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT  ");
			sbQuery.append(" T1.N_ID_EXPEDE ");
			sbQuery.append(" ,T1.C_NOMETS ");
			sbQuery.append(" ,T1.C_NUMCNV ");
			sbQuery.append(" ,(SELECT C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE P1 WHERE P1.N_ID_VARIABLE = 6 AND P1.N_ID_VALVARIABLE = T1.C_TIPCOM ) TIP_COMPRA ");
			sbQuery.append(" ,(SELECT C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE P1 WHERE P1.N_ID_VARIABLE = 4 AND P1.N_ID_VALVARIABLE = T1.C_NORAPL ) C_NORAPL ");
			sbQuery.append(" ,(SELECT C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE P1 WHERE P1.N_ID_VARIABLE = 8 AND P1.N_ID_VALVARIABLE = T1.C_TIPOBJ ) C_TIPOBJ ");
			sbQuery.append(" ,T1.C_DESOBJ ");
			sbQuery.append(" ,T1.C_VALRET_ORIG ");		
			sbQuery.append(" ,T1.N_CODMON_ORIG ");	
			sbQuery.append(" ,T1.N_ID_ORGAN ");
			sbQuery.append(" ,O1.C_NOMORG ");
			sbQuery.append(" ,O1.C_DIRFIS ");
			sbQuery.append(" ,O1.C_PAGWEB ");
			sbQuery.append(" ,O1.C_NROTLF ");
			sbQuery.append(" ,P.N_ID_PROCED ");//Id.031:cinonan
			sbQuery.append(" ,(SELECT P1.N_COD_ACTOS FROM pro.tbl_cnf_valor_variable p1 WHERE P1.N_ID_VARIABLE = 6 AND P1.N_ID_VALVARIABLE = T1.C_TIPCOM ) TIP_COMPRA_ACT ");
			sbQuery.append(" ,T1.C_MODSEL ");	
			sbQuery.append(" ,T1.C_NORAPL AS ID_NORAPL ");
			sbQuery.append(" , case when (SELECT Count(*) from PRO.TBL_ACT_ITEM x where x.n_id_expede=T1.n_id_expede and (x.n_indpaq in (1) or x.n_indpaq is null))=0  then ");
			    sbQuery.append(" case when (SELECT Count(*) from PRO.TBL_ACT_ITEM I where I.n_id_expede=T1.n_id_expede and I.n_estpro in (5,7,17,18,23,24,26,27,32,34,35))>0  then '0'  else '1' end ");
			sbQuery.append(" else ");
				sbQuery.append(" case when (SELECT Count(*) from PRO.TBL_ACT_ITEM I where I.n_id_expede=T1.n_id_expede and (I.n_indpaq in (1) or I.n_indpaq is null) and I.n_estpro in (5,7,17,18,23,24,26,27,32,34,35))>0  then '0'  else '1' end ");
			sbQuery.append(" end  AS I_VALEST ");
			sbQuery.append(" ,T1.C_VALRET AS C_VALRET ");
			sbQuery.append(", T1.C_TIPSEL ");
			sbQuery.append(", P.N_TIPLEY_30225 ");//Id.031:cinonan
			// 034 -  Inicio
			sbQuery.append(", O1.C_NOMVIA||' '||O1.C_NUMVIA ||' '||O1.C_URBANI ||' ('||(SELECT DEP.C_DESUBI||'-'||PRO.C_DESUBI||'-'||DIS.C_DESUBI AS UBIGEO ");   
																		sbQuery.append(" FROM ADM.TBL_ADM_UBIGEO DIS ");
																		sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO PRO ON DIS.N_ID_UBIGPA = PRO.N_ID_UBIGEO ");  
																		sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO DEP ON PRO.N_ID_UBIGPA = DEP.N_ID_UBIGEO ");
																		sbQuery.append(" WHERE DIS.N_ID_UBIGEO = O1.N_ID_UBIGEO)||')' AS C_DIRLEGAL ");
			// 034 -  Fin
			sbQuery.append(" FROM PRO.TBL_ACT_EXPEDIENTE T1 ");
			sbQuery.append(" ,PRO.TBL_ACT_PROCEDIMIENTO P ");//Id.031:cinonan
			sbQuery.append(" ,ADM.TBL_ADM_ORG O1 ");			
			sbQuery.append(" WHERE T1.N_ID_EXPEDE = :idConvoca ");			
			sbQuery.append(" AND T1.N_ID_ORGAN = O1.N_ID_ORGAN ");
			sbQuery.append(" AND P.N_ID_PROCED = T1.N_ID_PROCED ");//Id.031:cinonan
		}
		
		return sbQuery;
	}
	//Fin 021 Req 38-2 dllantoy
	
	/** Cronograma */
	public static StringBuilder getQueryFichaCronograma(Long tipoSeace){
		StringBuilder sbQuery =new StringBuilder();
		if( tipoSeace.equals(TIPO_SEACE_2) ){
			sbQuery.append(" SELECT cal.codetapa ");
			sbQuery.append(" ,cal.codetapa n_alias ");
			sbQuery.append(" ,etp.descripcion ");
			sbQuery.append(" ,etp.ORDEN ");
			sbQuery.append(" ,to_char(cal.FEC_INICIO, 'dd/mm/yyyy') ");
			sbQuery.append(" ,to_char(cal.FEC_FIN, 'dd/mm/yyyy') ");
			sbQuery.append(" ,to_char(cal.FEC_INICIO, 'HH24:MI') ");
			sbQuery.append(" ,to_char(cal.FEC_FIN, 'HH24:MI') ");
			sbQuery.append(" ,'' C_LUGAR ");
			sbQuery.append(" ,'' ");
			sbQuery.append(" FROM reg_procesos.calendario@AIXREGPRODES.SEACE.GOB.PE cal ");
			sbQuery.append(" ,reg_procesos.etapas@AIXREGPRODES.SEACE.GOB.PE etp ");
			sbQuery.append(" WHERE etp.CODETAPA = cal.CODETAPA ");
			sbQuery.append(" AND cal.N_CONVOCA = :nidExped ");
			sbQuery.append(" ORDER BY etp.ORDEN ");
			
		}else if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT DISTINCT (CRO.N_ID_CRONO) ");
			sbQuery.append(" ,CRO.N_ALIAS ");
			sbQuery.append(" ,ACT.C_DESETAPA ");
			sbQuery.append(" ,ACT.N_ORDETA ");
			sbQuery.append(" ,to_char(CRO.D_FECINI, 'dd/mm/yyyy') D_FECINI ");
			sbQuery.append(" ,to_char(CRO.D_FECFIN, 'dd/mm/yyyy') D_FECFIN ");
			sbQuery.append(" ,to_char(CRO.D_HORINI, 'HH24:MI') D_HORINI ");
			sbQuery.append(" ,to_char(CRO.D_HORFIN, 'HH24:MI') D_HORFIN ");
			sbQuery.append(" ,CRO.C_LUGAR ");
			sbQuery.append(" ,CRO.N_TIPO_SEL ");			
			sbQuery.append(" ,dep.C_DESUBI as departamento ");
			sbQuery.append(" ,pro.C_DESUBI as provincia ");
			sbQuery.append(" ,dis.C_DESUBI as distrito ");
			sbQuery.append(" ,act.C_REGISTRO as registro "); //Atencion Correo Web - ddrodriguez		
			sbQuery.append(" ,act.N_FOREJE as formaEjecucion "); //#036
			sbQuery.append(" FROM PRO.TBL_ACT_CRONOGRAMA CRO ");
			sbQuery.append(" INNER JOIN PRO.TBL_SEL_ACTIVIDAD act ON act.n_id_crono = cro.n_id_crono ");			
			sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO dis ON cro.C_UBIGEO = dis.N_ID_UBIGEO ");
			sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO pro ON dis.N_ID_UBIGPA = pro.N_ID_UBIGEO ");
			sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO dep ON pro.N_ID_UBIGPA = dep.N_ID_UBIGEO ");			
			sbQuery.append(" WHERE act.n_id_pub_con = :nidExped ");
			sbQuery.append(" AND act.N_ORDACT = 1  ");//Atencion Correo Web - jcarrillo
			sbQuery.append(" AND CRO.D_FECFIN IS NOT NULL ");//#037
			sbQuery.append(" ORDER BY cro.n_id_crono ");
			
		}
		return sbQuery;
	}
	
	// Inicio Req 14-2016 Nueva Ley 30225 (ddrodriguez)
	/** Calendarizacion */
	public static StringBuilder getQueryFichaCalendarizacion(){
		StringBuilder sbQuery =new StringBuilder();
			sbQuery.append(" SELECT CAL.N_ID_CALENDARIO ");
			sbQuery.append(" ,CAL.N_ID_CRONO ");
			sbQuery.append(" ,CAL.C_ITEM_GRUPO ");
			sbQuery.append(" ,to_char(CAL.D_FECINI, 'dd/mm/yyyy') D_FECINI ");
			sbQuery.append(" ,to_char(CAL.D_FECFIN, 'dd/mm/yyyy') D_FECFIN ");
			sbQuery.append(" ,to_char(CAL.D_HORINI, 'HH24:MI') D_HORINI ");
			sbQuery.append(" ,to_char(CAL.D_HORFIN, 'HH24:MI') D_HORFIN ");
			sbQuery.append(" FROM PRO.TBL_ACT_CALENDARIZACION CAL ");
			sbQuery.append(" WHERE CAL.N_ID_CRONO = :nidCrono ");
			sbQuery.append(" AND CAL.N_ESTADO = 1  ");
			sbQuery.append(" ORDER BY CAL.D_FECINI ");
			
		return sbQuery;
	}
	// Fin Req 14-2016 Nueva Ley 30225 (ddrodriguez)
	
	public static StringBuilder getQueryFichaCronogramaHistorico(Long tipoSeace){
		StringBuilder sbQuery =new StringBuilder();
		if( tipoSeace.equals(TIPO_SEACE_2) ){
			sbQuery.append(" SELECT cal.codetapa ");
			sbQuery.append(" ,cal.codetapa n_alias ");
			sbQuery.append(" ,etp.descripcion ");
			sbQuery.append(" ,etp.ORDEN ");
			sbQuery.append(" ,to_char(cal.FEC_INICIO, 'dd/mm/yyyy') ");
			sbQuery.append(" ,to_char(cal.FEC_FIN, 'dd/mm/yyyy') ");
			sbQuery.append(" ,to_char(cal.FEC_INICIO, 'HH24:MI') ");
			sbQuery.append(" ,to_char(cal.FEC_FIN, 'HH24:MI') ");
			sbQuery.append(" ,'' C_LUGAR ");
			sbQuery.append(" ,'' ");
			sbQuery.append(" FROM reg_procesos.calendario@AIXREGPRODES.SEACE.GOB.PE cal ");
			sbQuery.append(" ,reg_procesos.etapas@AIXREGPRODES.SEACE.GOB.PE etp ");
			sbQuery.append(" WHERE etp.CODETAPA = cal.CODETAPA ");
			sbQuery.append(" AND cal.N_CONVOCA = :nidExped ");
			sbQuery.append(" ORDER BY etp.ORDEN ");
			
		}else if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT DISTINCT (CRO.N_ID_CRONO) ");
			sbQuery.append(" ,CRO.N_ALIAS ");
			sbQuery.append(" ,to_char(CRO.D_FECINI, 'dd/mm/yyyy') D_FECINI ");
			sbQuery.append(" ,to_char(CRO.D_FECFIN, 'dd/mm/yyyy') D_FECFIN ");
			sbQuery.append(" ,to_char(CRO.D_HORINI, 'HH24:MI') D_HORINI ");
			sbQuery.append(" ,to_char(CRO.D_HORFIN, 'HH24:MI') D_HORFIN ");
			sbQuery.append(" ,CRO.C_LUGAR ");
			sbQuery.append(" ,CRO.N_TIPO_SEL	 ");		
			sbQuery.append(" ,dep.C_DESUBI as departamento ");
			sbQuery.append(" ,pro.C_DESUBI as provincia ");
			sbQuery.append(" ,dis.C_DESUBI as distrito ");
			sbQuery.append(" ,CRO.N_ETAPA ");
			sbQuery.append(" FROM PRO.TBL_ACT_CRONOGRAMA CRO ");
			sbQuery.append(" INNER JOIN pro.TBL_ACT_BASES b on  cro.N_ID_BASES = b.N_ID_BASES ");
			sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO dis ON cro.C_UBIGEO = dis.N_ID_UBIGEO ");
			sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO pro ON dis.N_ID_UBIGPA = pro.N_ID_UBIGEO ");
			sbQuery.append(" LEFT JOIN ADM.TBL_ADM_UBIGEO dep ON pro.N_ID_UBIGPA = dep.N_ID_UBIGEO ");		
			sbQuery.append(" WHERE b.N_ID_BASES = :idBase ");
			sbQuery.append(" AND cro.N_VERSION = :version ");
			sbQuery.append(" ORDER BY cro.n_id_crono ");			
		}
		return sbQuery;
	}
	
	/** Documentos */
	public static StringBuilder getQueryDocumentosProceso(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		
		if(tipoSeace.equals(TIPO_SEACE_3)){
			//sbQuery.append("SELECT DISTINCT(ACT.N_ID_CRONO), ACT.C_DESETAPA, DOC.C_NOMARC, DOC.N_TAMARC, C_ALFARC, TO_CHAR(D_FECPUB, 'DD/MM/YYYY HH24:MI' ) D_FECPUB, C_TIPDOC, DOC.C_EXTARC  FROM PRO.DET_SEL_DOC_CON DOC, PRO.TBL_SEL_ACTIVIDAD ACT ");
			//sbQuery.append(" WHERE DOC.N_ID_CRONO = ACT.N_ID_CRONO AND DOC.N_ID_PUB_CON = ACT.N_ID_PUB_CON AND DOC.N_ID_PUB_CON = :nidProceso ORDER BY D_FECPUB ASC");
			sbQuery.append("SELECT CRO.N_ID_CRONO, CRO.N_ALIAS, DOC.C_NOMARC, (round(DOC.N_TAMARC/1024,0)+1) AS N_TAMARC, DOC.C_ALFARC, TO_CHAR(DOC.D_FECPUB, 'DD/MM/YYYY HH24:MI' ) D_FECPUB, C_TIPDOC, DOC.C_EXTARC ");
/**
  * Inicio Dante Artica
  */
			sbQuery.append(", (select PS.C_DESCIRP_INSTAN_PRONUN from PRO.TBL_SEL_REG_OFI PS WHERE PS.N_ID_PUB_CON= DOC.N_ID_PUB_CON AND ROWNUM = 1) AS C_INSTANCIA_DESCRIP ");
/**
  * Fin Dante Artica
  */
			sbQuery.append(" FROM PRO.DET_SEL_DOC_CON DOC, PRO.TBL_ACT_CRONOGRAMA CRO WHERE DOC.N_ID_CRONO      =CRO.N_ID_CRONO (+) AND DOC.N_ID_PUB_CON= :nidProceso AND DOC.C_ESTADO      IN('A' , 'rFvqaxfeTvY=') ");
			//sbQuery.append(" ORDER BY CRO.N_ID_CRONO, DOC.D_FECPUB ASC ");
			sbQuery.append(" ORDER BY DOC.D_FECPUB ASC, N_ID_CRONO ");
			
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			//sbQuery.append("select doc.cod_doc, '' C_DESETAPA, (case when pro.reg_codigo is null and pro.ley_codigo is null then 'http://docs.seace.gob.pe' || doc.doc_url  else  'http://zonasegura.seace.gob.pe' || doc.doc_url  end) doc_url, (doc.tamano_bytes) tamano, '' C_ALFARC, TO_CHAR(doc.fec_upload, 'DD/MM/YYYY HH24:MI' ) fec_upload, decode(cod_tipo_doc  , 100, 1 , 150, 2, 2200, 8, 200, 4, 300, 6 ");
			sbQuery.append("select doc.cod_doc, '' C_DESETAPA, (case when pro.reg_codigo is null and pro.ley_codigo is null then 'http://docs.seace.gob.pe' || doc.doc_url  else  'https://zonasegura2.seace.gob.pe/documentos/' || doc.doc_url  end) doc_url, (doc.tamano_bytes) tamano, '' C_ALFARC, TO_CHAR(doc.fec_upload, 'DD/MM/YYYY HH24:MI' ) fec_upload, decode(cod_tipo_doc  , 100, 1 , 150, 2, 2200, 8, 200, 4, 300, 6 ");
			sbQuery.append(", 320, 9, 325, 9, 350, 11, 375, 13, 1800, 12, 400, 29, 450, 21, 2600, 26, 500, 18, 575 , 19, 0) C_TIPDOC, LOWER(ta.EXT_TIPO_FILE) C_EXTARC, ta.icon_tipo_file, doc.doc_nombre, doc.nro_doc from reg_procesos.convocatoria_doc@AIXREGPRODES.SEACE.GOB.PE doc, reg_procesos.tipo_archivo@AIXREGPRODES.SEACE.GOB.PE ta, reg_procesos.convocatorias@AIXREGPRODES.SEACE.GOB.PE con, reg_procesos.procesos@AIXREGPRODES.SEACE.GOB.PE pro ");// #003 
			sbQuery.append(" where doc.n_convoca=:nidProceso and doc.cod_tipo_file=ta.cod_tipo_file and doc.cod_tipo_doc IN (100, 150, 2200, 200, 300, 320, 325, 350, 375, 1800, 400, 450, 2600, 500, 575)"); // #002
			sbQuery.append(" and con.n_convoca = doc.n_convoca and con.n_proceso = pro.n_proceso "); //#025 mlaura Memorando 036-2016
			//sbQuery.append(" and con.n_convoca = doc.n_convoca and con.ind_conv_ultimo = 1 and con.n_proceso = pro.n_proceso "); 
			sbQuery.append(" ORDER BY doc.fec_upload ASC, doc.cod_doc ");
		}
		return sbQuery;
	}
	
	/** Item's*/
	public static StringBuilder getQueryItemsProcesos(Long tipoSeace){
		StringBuilder sbQuery  = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append("SELECT I.C_CCUBSO, I.C_DSITEM, I.N_RMYPE, (CASE N_RMYPE WHEN 1 THEN 'SI' WHEN 0 THEN 'NO' ELSE 'S/N' END) AS C_RMYPE, I.N_INDPAQ, (CASE I.N_INDPAQ  WHEN 1 THEN 'SI' ELSE 'NO' END) AS C_INDPAQ1, I.C_CANTID, I.C_UNIMED, (SELECT L.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO L WHERE L.N_ID_LISTADO = 1 AND L.N_ID_VALLISTADO = I.C_UNIMED) S_UNIMED, ");
			sbQuery.append(" I.C_VRETOT, I.N_ESTPRO, I.N_CANADJ, I.N_MONADJ, I.N_ID_ITEM, '' n_buenapro,  I.C_DCUBSO, I.N_SUBTIPOBJ, (SELECT VV.C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE VV WHERE VV.N_ID_VARIABLE = 11 AND VV.N_ID_VALVARIABLE= I.N_SUBTIPOBJ) C_SUBTIPOBJ, ");
			sbQuery.append(" I.C_FOREJE, I.C_SISCON,I.C_MODECO, I.C_TIPCAM, I.N_CODMON, (SELECT L.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO L WHERE L.N_ID_LISTADO = '31' AND L.N_ID_VALLISTADO = I.N_CODMON) C_CODMON, ");
			sbQuery.append(" I.C_DECREM, (CASE I.N_REAPRE WHEN 0 THEN 'NO' WHEN 1 THEN 'SI' WHEN 2 THEN 'NINGUNO' END) C_REAPRE, I.C_UBIEJE, ");
			sbQuery.append(" (SELECT DISTRITO FROM ADM.VW_UBIGEO_ADM WHERE N_ID_UBIGEO = I.C_UBIEJE) DISTRITO, ");
			sbQuery.append(" (SELECT PROVINCIA FROM ADM.VW_UBIGEO_ADM WHERE N_ID_UBIGEO = I.C_UBIEJE) PROVINCIA, ");
			sbQuery.append(" (SELECT DEPARTAMENTO FROM ADM.VW_UBIGEO_ADM WHERE N_ID_UBIGEO = I.C_UBIEJE) DEPARTAMENTO, ");
			sbQuery.append(" (SELECT VV.C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE VV  WHERE VV.N_ID_VARIABLE = 5  AND VV.N_ID_VALVARIABLE= I.C_SISCON) DES_SISCON, ");
			sbQuery.append(" (SELECT VV.C_NOMBRE  FROM PRO.TBL_CNF_VALOR_VARIABLE VV  WHERE VV.N_ID_VARIABLE = 2  AND VV.N_ID_VALVARIABLE= I.C_MODECO   ) DES_MODECO, ");
			sbQuery.append(" (CASE N_DISBPR WHEN 1 THEN 'SI' WHEN 0 THEN 'NO' ELSE '' END) C_DISBPR, C_DBIECOM ");
			/** 010 INICIO */
			sbQuery.append(" ,C_NROITEM ");
			/** 010 FIN */
			sbQuery.append(" ,N_CHECK_REACTIV ");//SM 084-2020
			//sbQuery.append(" from PRO.TBL_ACT_ITEM I where I.N_ID_EXPEDE = :idConvoca ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQuery.append("SELECT (SUBSTR(n.GRUPO_BIEN,1,2) || SUBSTR(n.CLASE_BIEN,1,2) || SUBSTR(n.FAMILIA_BIEN,1,2) || SUBSTR(n.ITEM_BIEN,1,2) || SUBSTR(n.NIVEL5,1,8)) AS  C_ID_ELE, i.descripcion, 0 N_RMYPE, ");
			sbQuery.append(" '' C_RMYPE, cod_tipo_detalle_bien N_INDPAQ, CASE cod_tipo_detalle_bien WHEN 1 THEN 'NO'  WHEN 5 THEN 'SI'  ELSE '' END C_INDPAQ, CANTIDAD, i.UNM_CODIGO, "); 
			sbQuery.append(" (select um.UNM_DESC from sease.unidad_medida@AIXREGPRODES.SEACE.GOB.PE um where um.unm_codigo = i.UNM_CODIGO) S_UNIMED, i.v_referencial, REG_PROCESOS.f_get_item_estado_resumen@AIXREGPRODES.SEACE.GOB.PE(i.n_convoca, i.proc_item) des_estado, " ); /** #005 */
			sbQuery.append(" 0 N_CANADJ, 0 N_MONADJ,  i.proc_item,  REG_PROCESOS.F_GET_N_BUENAPRO_ULTIMO@AIXREGPRODES.SEACE.GOB.PE(i.n_convoca) n_buenapro,  ");
			sbQuery.append(" n.descripcion C_DCUBSO, n.CODOBJETO, (SELECT O.DESCRIPCION FROM OBJETO@AIXREGPRODES.SEACE.GOB.PE O WHERE O.CODOBJETO = n.CODOBJETO) C_SUBTIPOBJ, ");
			sbQuery.append(" null C_FOREJE, null C_SISCON, null C_MODECO, null C_TIPCAM, null N_CODMON, null C_CODMON, null C_DECREM, null C_REAPRE, null C_UBIEJE, null DISTRITO, null PROVINCIA, null DEPARTAMENTO, null DES_SISCON, null DES_MODECO, null C_DISBPR, n.descripcion C_DBIECOM ");
			/** 010 INICIO */
			sbQuery.append(" ,PROC_ITEM AS C_NROITEM ");
			/** 010 FIN */
			sbQuery.append(" ,null N_CHECK_REACTIV ");//SM 084-2020
			/*  009 Inicio - Incidencia 2912  */
			sbQuery.append(" FROM reg_procesos.item_convoca@AIXREGPRODES.SEACE.GOB.PE i, t_cat_nivel5@AIXREGPRODES.SEACE.GOB.PE n where i.nivel5 = n.nivel5 (+) and i.n_convoca = reg_procesos.f_get_max_n_convoca@AIXREGPRODES.SEACE.GOB.PE(:idConvoca) ORDER BY PROC_ITEM ");     	
			//sbQuery.append(" FROM reg_procesos.item_convoca@AIXREGPRODES.SEACE.GOB.PE i, t_cat_nivel5@AIXREGPRODES.SEACE.GOB.PE n where i.nivel5 = n.nivel5 (+) and i.n_convoca = :idConvoca ORDER BY PROC_ITEM ");
			/*  009 Fin    */
		}
		return sbQuery;
	}
	
	/*Inicio Id.035:cinonan*/
	public static StringBuilder getQueryItemsPorProcesos(Long tipoSeace){
		StringBuilder sbQuery  = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append("SELECT I.C_CCUBSO, I.C_DSITEM, I.N_RMYPE, I.N_INDPAQ, (CASE I.N_INDPAQ  WHEN 1 THEN 'SI' ELSE 'NO' END) AS C_INDPAQ1, I.C_CANTID, I.C_UNIMED, I.C_VRETOT, I.N_ESTPRO, ");
			//sbQuery.append(" I.N_CANADJ, I.N_MONADJ, I.N_ID_ITEM, '' n_buenapro,  I.C_DCUBSO, I.N_SUBTIPOBJ, I.C_FOREJE, I.C_SISCON,I.C_MODECO, I.C_TIPCAM, I.N_CODMON, I.C_DECREM, C_NROITEM  "); // SM 084-2020
			sbQuery.append(" I.N_CANADJ, I.N_MONADJ, I.N_ID_ITEM, '' n_buenapro,  I.C_DCUBSO, I.N_SUBTIPOBJ, I.C_FOREJE, I.C_SISCON,I.C_MODECO, I.C_TIPCAM, I.N_CODMON, I.C_DECREM, C_NROITEM, N_CHECK_REACTIV  "); // SM 084-2020
		}
		return sbQuery;
	}
	/*Fin Id.035:cinonan*/
	
	//Inicio bse01
	public static StringBuilder getQueryItemsPorProcesosIncluyePaquetes(Long tipoSeace){
		StringBuilder sbQuery  = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append("SELECT I.C_CCUBSO, I.C_DSITEM, I.N_RMYPE, I.N_INDPAQ, (CASE I.N_INDPAQ  WHEN 1 THEN 'SI' ELSE 'NO' END) AS C_INDPAQ1, I.C_CANTID, I.C_UNIMED, I.C_VRETOT, I.N_ESTPRO, ");
			sbQuery.append(" I.N_CANADJ, I.N_MONADJ, I.N_ID_ITEM, '' n_buenapro,  I.C_DCUBSO, I.N_SUBTIPOBJ, I.C_FOREJE, I.C_SISCON,I.C_MODECO, I.C_TIPCAM, I.N_CODMON, I.C_DECREM, C_NROITEM, N_ID_PADRE  ");
		}
		return sbQuery;
	}
	//Fin bse01
	
	// Inicio  021 Req 38-2 dllantoy
	public static StringBuilder getQueryItemsProcesosActos(Long tipoSeace){
		StringBuilder sbQuery  = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append("SELECT I.C_CCUBSO, I.C_DSITEM, I.N_RMYPE, (CASE N_RMYPE WHEN 1 THEN 'SI' WHEN 0 THEN 'NO' ELSE 'S/N' END) AS C_RMYPE, I.N_INDPAQ, (CASE I.N_INDPAQ  WHEN 1 THEN 'SI' ELSE 'NO' END) AS C_INDPAQ1, I.C_CANTID, I.C_UNIMED, (SELECT L.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO L WHERE L.N_ID_LISTADO = 1 AND L.N_ID_VALLISTADO = I.C_UNIMED) S_UNIMED, ");
			sbQuery.append(" I.C_VRETOT, I.N_ESTPRO, I.N_ID_ITEM, I.C_DCUBSO, I.N_SUBTIPOBJ, (SELECT VV.C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE VV WHERE VV.N_ID_VARIABLE = 11 AND VV.N_ID_VALVARIABLE= I.N_SUBTIPOBJ) C_SUBTIPOBJ, ");
			sbQuery.append(" I.C_FOREJE, I.C_SISCON,I.C_MODECO, I.C_TIPCAM, I.N_CODMON, (SELECT L.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO L WHERE L.N_ID_LISTADO = '31' AND L.N_ID_VALLISTADO = I.N_CODMON) C_CODMON, ");
			sbQuery.append(" I.C_DECREM, (CASE I.N_REAPRE WHEN 0 THEN 'NO' WHEN 1 THEN 'SI' WHEN 2 THEN 'NINGUNO' END) C_REAPRE, I.C_UBIEJE, ");
			sbQuery.append(" (SELECT DISTRITO FROM ADM.VW_UBIGEO_ADM WHERE N_ID_UBIGEO = I.C_UBIEJE) DISTRITO, ");
			sbQuery.append(" (SELECT PROVINCIA FROM ADM.VW_UBIGEO_ADM WHERE N_ID_UBIGEO = I.C_UBIEJE) PROVINCIA, ");
			sbQuery.append(" (SELECT DEPARTAMENTO FROM ADM.VW_UBIGEO_ADM WHERE N_ID_UBIGEO = I.C_UBIEJE) DEPARTAMENTO, ");
			sbQuery.append(" (SELECT VV.C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE VV  WHERE VV.N_ID_VARIABLE = 5  AND VV.N_ID_VALVARIABLE= I.C_SISCON) DES_SISCON, ");
			sbQuery.append(" (SELECT VV.C_NOMBRE  FROM PRO.TBL_CNF_VALOR_VARIABLE VV  WHERE VV.N_ID_VARIABLE = 2  AND VV.N_ID_VALVARIABLE= I.C_MODECO   ) DES_MODECO, ");
			sbQuery.append(" (CASE N_DISBPR WHEN 1 THEN 'SI' WHEN 0 THEN 'NO' ELSE '' END) C_DISBPR, C_DBIECOM ");			
			sbQuery.append(" ,C_NROITEM ");		
		}
		return sbQuery;
	}
	// Fin  021 Req 38-2 dllantoy
		
	/** Items Coorporativa **/
	/*public static StringBuilder getQueryItemsProcesosCoorporativos(){
		StringBuilder sbQuery  = new StringBuilder();
		sbQuery.append("SELECT I.C_CCUBSO, I.C_DSITEM, I.N_RMYPE, (CASE N_RMYPE WHEN 1 THEN 'SI' WHEN 0 THEN 'NO' ELSE 'S/N' END) AS C_RMYPE, I.N_INDPAQ, (CASE I.N_INDPAQ  WHEN 1 THEN 'SI' WHEN 0 THEN 'NO' END) AS C_INDPAQ1, I.C_CANTID, I.C_UNIMED, (SELECT L.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO L WHERE L.N_ID_LISTADO = 1 AND L.N_ID_VALLISTADO = I.C_UNIMED) S_UNIMED, ");
		sbQuery.append(" I.C_VRETOT, I.N_ESTPRO, I.N_CANADJ, I.N_MONADJ, I.N_ID_ITEM, '' n_buenapro,  I.C_DCUBSO, I.N_SUBTIPOBJ, (SELECT VV.C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE VV WHERE VV.N_ID_VARIABLE = 11 AND VV.N_ID_VALVARIABLE= I.N_SUBTIPOBJ) C_SUBTIPOBJ, ");
		sbQuery.append(" I.C_FOREJE, I.C_SISCON,I.C_MODECO, I.C_TIPCAM, I.N_CODMON, (SELECT L.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO L WHERE L.N_ID_LISTADO = '31' AND L.N_ID_VALLISTADO = I.N_CODMON) C_CODMON, ");
		sbQuery.append(" I.C_DECREM, (CASE I.N_REAPRE WHEN 0 THEN 'NO' WHEN 1 THEN 'SI' WHEN 2 THEN 'NINGUNO' END) C_REAPRE, I.C_UBIEJE, ");
		sbQuery.append(" (SELECT DISTRITO FROM ADM.VW_UBIGEO_ADM WHERE N_ID_UBIGEO = I.C_UBIEJE) DISTRITO, ");
		sbQuery.append(" (SELECT PROVINCIA FROM ADM.VW_UBIGEO_ADM WHERE N_ID_UBIGEO = I.C_UBIEJE) PROVINCIA, ");
		sbQuery.append(" (SELECT DEPARTAMENTO FROM ADM.VW_UBIGEO_ADM WHERE N_ID_UBIGEO = I.C_UBIEJE) DEPARTAMENTO, ");
		sbQuery.append(" (SELECT VV.C_NOMBRE FROM PRO.TBL_CNF_VALOR_VARIABLE VV  WHERE VV.N_ID_VARIABLE = 5  AND VV.N_ID_VALVARIABLE= I.C_SISCON) DES_SISCON, ");
		sbQuery.append(" (SELECT VV.C_NOMBRE  FROM PRO.TBL_CNF_VALOR_VARIABLE VV  WHERE VV.N_ID_VARIABLE = 2  AND VV.N_ID_VALVARIABLE= I.C_MODECO   ) DES_MODECO, ");
		sbQuery.append(" (CASE N_DISBPR WHEN 1 THEN 'SI' WHEN 0 THEN 'NO' ELSE '' END) C_DISBPR, C_DBIECOM ");
		sbQuery.append(" from PRO.TBL_ACT_ITEM I, PRO.tbl_sel_tra_fic_ite t where I.N_ID_EXPEDE = :idConvoca and t.n_id_item   =i.n_id_item AND (t.c_estado      = 'E' ) order by C_NROITEM");
		return sbQuery;
	}*/
	
	
	/**Participantes */
	public static StringBuilder getQueryParticipantesItemps(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append("SELECT reg.C_RUC, reg.C_RAZSOC, oi.C_CANADJ, oi.C_MONADJ, prop.c_mype, depro.c_prosel, depro.c_bonific, prop.C_INDCON, prop.n_id_propuesta FROM PRO.tbl_sel_otor_item oi, PRO.det_sel_propuesta depro, pro.tbl_sel_propuesta prop, pro.tbl_sel_reg_par reg ");
			sbQuery.append(" where oi.N_ID_DET_PROP = depro.N_ID_DET_PROP  AND depro.N_ID_PROPUESTA = prop.N_ID_PROPUESTA  AND prop.N_ID_REG_PAR = reg.N_ID_REG_PAR  AND depro.N_ID_ITEM = :nidItem AND oi.C_ESTPOSTOR IS NOT NULL ");
			/** Inicio #001 */
			sbQuery.append(" AND (oi.c_estpostor    = :pestadoPostorAdjudicado or oi.c_estpostor      = :pestadoPostorConsentido ) AND oi.c_estado        = :estadoRegistroValido   ");
			/** Fin #001 */
			sbQuery.append(" UNION ALL ");
			sbQuery.append(" SELECT reg.C_RUC, reg.C_RAZSOC, item.n_CANADJ, item.n_monadj, prop.c_mype, depro.c_prosel, depro.c_bonific, prop.C_INDCON, prop.n_id_propuesta FROM PRO.det_sel_si_bpro bpro, PRO.det_sel_propuesta depro, pro.tbl_sel_propuesta prop, pro.tbl_sel_reg_par reg, ");
			sbQuery.append(" pro.tbl_act_item item  where bpro.N_ID_DET_PROP = depro.N_ID_DET_PROP  AND depro.N_ID_PROPUESTA = prop.N_ID_PROPUESTA  AND prop.N_ID_REG_PAR = reg.N_ID_REG_PAR ");
			sbQuery.append(" AND depro.n_id_item = item.n_id_item  AND bpro.C_BUENAPRO = 'S'  AND depro.N_ID_ITEM = :nidItem AND bpro.C_ESTITE IS NOT NULL ");
			sbQuery.append(" UNION ALL ");
			sbQuery.append(" SELECT DISTINCT par.C_RUC, par.c_razsoc, '' n_CANADJ, '' n_monadj, '' c_mype, '' c_prosel, '' c_bonific, 'N', null FROM PRO.tbl_sel_oto_con oto , PRO.det_sel_oto_con det, PRO.tbl_sel_reg_par par ");
			sbQuery.append(" WHERE oto.n_id_oto_con = det.n_id_oto_con AND par.n_id_reg_par   = det.n_id_reg_par AND det.n_id_item     = :nidItem AND (det.c_estpostor   =1 OR det.c_estpostor     =2) AND det.c_estreg       ='V'");
			
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQuery.append("Select CAST(cp.ruc_postor AS VARCHAR2(15))  ruc_postor, replace(replace(replace( replace(replace(cp.nom_postor ,'Â¿',''),'',''),'''',''),chr(10),' '),chr(13),' ') nom_postor, ibp.cant_adjudicada, ibp.monto_adjudicado, (case when ibp.ind_mype = '1' then 'SI' ELSE 'NO' END) C_mype, '' c_prosel, '' c_bonific, decode(cp.IND_CONSORCIO, '1', 'S', 'N') C_INDCON, cp.cod_consorcio ");
			sbQuery.append(" from REG_PROCESOS.convocatoria_propuesta@AIXREGPRODES.SEACE.GOB.PE cp ");
			sbQuery.append(" inner join REG_PROCESOS.convocatoria_propuesta_item@AIXREGPRODES.SEACE.GOB.PE cpi on cpi.n_propuesta = cp.n_propuesta ");
			sbQuery.append(" inner join REG_PROCESOS.items_bp@AIXREGPRODES.SEACE.GOB.PE ibp on ibp.n_propuesta = cpi.n_propuesta and ibp.proc_item   = cpi.proc_item ");
			sbQuery.append(" left outer join ( select postor.n_convoca, postor.proc_item, postor.n_propuesta, doc.cod_doc cod_doc, to_char(doc.fec_upload,'dd/mm/yyyy') fec_upload, to_char(doc.fec_upload,'hh24:mi:ss') hora_upload, ");
			sbQuery.append(" doc.doc_url doc_url, ta.icon_tipo_file icon_tipo_file, doc.user_upload user_upload, doc.cod_tipo_file, doc.doc_nombre, doc.tamano_bytes ");
			sbQuery.append(" from reg_procesos.convocatoria_doc_postor@AIXREGPRODES.SEACE.GOB.PE postor ");
			sbQuery.append(" left outer join reg_procesos.convocatoria_doc@AIXREGPRODES.SEACE.GOB.PE doc on postor.n_convoca = doc.n_convoca and postor.cod_doc = doc.cod_doc and doc.cod_tipo_doc = 2400 ");
			sbQuery.append(" left outer join reg_procesos.tipo_archivo@AIXREGPRODES.SEACE.GOB.PE ta on ta.cod_tipo_file = doc.cod_tipo_file ");
			sbQuery.append(" where doc.n_convoca     = reg_procesos.f_get_max_n_convoca@AIXREGPRODES.SEACE.GOB.PE( :idConvoca) ");
			sbQuery.append(" ) documento on documento.n_convoca    = reg_procesos.f_get_max_n_convoca@AIXREGPRODES.SEACE.GOB.PE( cpi.n_convoca) and documento.proc_item    = cpi.proc_item and documento.n_propuesta  = cpi.N_PROPUESTA ");
			sbQuery.append(" where cp.n_convoca    = :idConvoca and cpi.proc_item = :nidItem and ibp.n_buenapro  = :idBuenaPro and (ibp.monto_adjudicado > 0 ) ");
		}
		return sbQuery;
	}
	
	/** Obtener Integrantes Consorcio **/
	public static StringBuilder getQueryParticipantesConsorcio(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			//sbQuery.append(" SELECT CON.C_TIPCON, (SELECT VL.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO VL WHERE VL.N_ID_LISTADO = 8 AND VL.N_ID_VALLISTADO = CON.C_TIPCON) DES_TIPINT, ");
			sbQuery.append(" select con.C_NOMCONS, reg.C_RUC, reg.C_RAZSOC from pro.tbl_sel_consorcio con, pro.det_sel_consorcio detcon, pro.tbl_sel_reg_par reg ");
			sbQuery.append(" where con.n_id_consorcio = detcon.n_id_consorcio AND detcon.N_ID_REG_PAR = reg.N_ID_REG_PAR and n_id_propuesta = :codConsorciado ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQuery.append(" select '', ruc_miembro,nom_miembro from  reg_procesos.consorcio_miembro@aixregprodes.seace.gob.pe where cod_consorcio = :codConsorciado ");
		}
		return sbQuery;
	}
	
	
	/** Cabecera Condutor  Integrantes */
	public static StringBuilder getQueryHeaderConductorIntegrante(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			//sbQuery.append(" SELECT CON.C_TIPCON, (SELECT VL.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO VL WHERE VL.N_ID_LISTADO = 8 AND VL.N_ID_VALLISTADO = CON.C_TIPCON) DES_TIPINT, ");
			sbQuery.append(" SELECT (SELECT VL.N_FLAG FROM PRO.TBL_CNF_VALOR_LISTADO VL WHERE VL.N_ID_LISTADO = 8 AND VL.N_ID_VALLISTADO = CON.C_TIPCON) FLAG_TIPC, (SELECT VL.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO VL WHERE VL.N_ID_LISTADO = 8 AND VL.N_ID_VALLISTADO = CON.C_TIPCON) DES_TIPINT, ");
			sbQuery.append(" CON.C_DESCRI, CON.C_DOCDES, TO_CHAR(CON.D_FECDES, 'DD/MM/YYYY') D_FECDES FROM PRO.TBL_ACT_CONDUCTOR CON WHERE CON.N_ID_EXPEDE = :idExpediente ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQuery.append(" SELECT NULL C_TIPCON, NULL DES_TIPINT, COM.DESCRIPCION C_DESCRI, COM.NU_RESOLUCION C_DOCDES, TO_CHAR(COM.FE_RESOLUCION, 'DD/MM/YYYY')  D_FECDES ");
			sbQuery.append(" FROM REG_PROCESOS.COMITE@AIXREGPRODES.SEACE.GOB.PE COM, REG_PROCESOS.PROCESOSCOMITE@AIXREGPRODES.SEACE.GOB.PE PRO, REG_PROCESOS.CONVOCATORIAS@AIXREGPRODES.SEACE.GOB.PE CON WHERE COM.N_COMITE = PRO.N_COMITE AND PRO.IND_ULTIMO = 1 ");
			sbQuery.append(" AND PRO.N_PROCESO = CON.N_PROCESO AND CON.N_CONVOCA = :idExpediente ");
		}
		return sbQuery;
	}
	
	/** Condutor  Integrantes */
	public static StringBuilder getQueryConductorIntegrantes(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append("SELECT rownum, I.C_APEPAT, I.C_APEMAT, I.C_NOMBRE, I.C_EMAIL, I.N_NRODOC, CI.C_TIPINT, ");
			sbQuery.append(" (SELECT VL.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO VL WHERE VL.N_ID_LISTADO = 9 AND VL.N_ID_VALLISTADO = CI.C_TIPINT) DES_TIPINT ");
			sbQuery.append(" FROM PRO.TBL_ACT_CONDUCTOR CON, PRO.DET_ACT_CON_INT CI, PRO.TBL_ACT_INTEGRANTE I WHERE CON.N_ID_COND = CI.N_ID_COND  AND  CON.N_ESTADO=1 AND   CI.N_ID_INTE = I.N_ID_INTE AND CON.N_ID_EXPEDE = :idConvoca  ");
			sbQuery.append(" ORDER BY CI.C_TIPINT");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQuery.append(" SELECT rownum, INT.AP_PATERNO, INT.AP_MATERNO, INT.NO_NOMBRE, INT.EMAIL, INT.NU_DOCIDENTIDAD, INT.CODTIPOINTEGRANTE, ");
			sbQuery.append(" (SELECT TP.DESCRIPCION FROM TIPOINTEGRANTE@AIXREGPRODES.SEACE.GOB.PE TP WHERE TP.CODTIPOINTEGRANTE = INT.CODTIPOINTEGRANTE) DES_TIPINT ");
			sbQuery.append(" FROM REG_PROCESOS.PROCESOSCOMITE@AIXREGPRODES.SEACE.GOB.PE PRO, REG_PROCESOS.COMITE@AIXREGPRODES.SEACE.GOB.PE COM, REG_PROCESOS.INTEGRANTECOMITE@AIXREGPRODES.SEACE.GOB.PE INT, REG_PROCESOS.CONVOCATORIAS@AIXREGPRODES.SEACE.GOB.PE CON ");
			sbQuery.append(" WHERE PRO.N_COMITE = COM.N_COMITE AND INT.N_COMITE = COM.N_COMITE AND PRO.N_PROCESO = CON.N_PROCESO AND CON.N_CONVOCA = :idConvoca AND IND_ULTIMO = 1 ");
		}
		return sbQuery;
	}
	
	/** Lista Participantes */
	public static StringBuilder getQueryListaParticipantes(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT C_TIPDOC, C_RUC, C_RAZSOC, to_char(D_FECREG,'DD/MM/YYYY'), (CASE C_ESTPAR WHEN 'V' THEN 'VALIDO' WHEN 'N' THEN 'NO VALIDO' WHEN 'D' THEN 'DESCALIFICADO' END) C_ESTPAR, ");
			sbQuery.append(" C_MOTOBS, to_char(D_FECCRE,'DD/MM/YYYY'), C_USUCRE FROM PRO.TBL_SEL_REG_PAR WHERE N_ID_PUB_CON = :nidProceso and C_INTCON = 'N' ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			/*sbQuery.append(" SELECT (case WHEN  (PROP.CODTIPODOC = 1 OR PROP.CODTIPODOC = 5) AND PROP.COD_CONDICION = 1 THEN 1 WHEN  PROP.CODTIPODOC = 6 AND PROP.COD_CONDICION = 1 THEN 2 WHEN  PROP.CODTIPODOC = 6 AND PROP.COD_CONDICION = 5 THEN 3 ");
			sbQuery.append(" WHEN  PROP.IND_CONSORCIO = 1 THEN 4 end) C_TIPDOC, CAST(PROP.RUC_POSTOR AS VARCHAR2(11)) RUC_POSTOR, replace(replace(replace( replace(replace(PROP.NOM_POSTOR ,'Â¿',''),'',''),'''',''),chr(10),' '),chr(13),' ') NOM_POSTOR, TO_CHAR(PROP.F_REGISTRO, 'DD/MM/YYYY HH24:MI' )  F_REGISTRO,  ");
			sbQuery.append(" (CASE PROP.ESTADO_PROPUESTA WHEN 1 THEN 'Valido' WHEN 0 THEN 'Borrador' END) C_ESTPAR, PROP.ESTADO_RNP C_MOTOBS, TO_CHAR(PROP.F_REGISTRO, 'DD/MM/YYYY HH24:MI' ) D_FECCRE, PROP.USU_CREACION ");
			sbQuery.append(" FROM convocatoria_propuesta@AIXREGPRODES.SEACE.GOB.PE PROP, REG_PROCESOS.CONVOCATORIAS@AIXREGPRODES.SEACE.GOB.PE CON where PROP.N_CONVOCA = CON.N_CONVOCA AND CON.N_PROCESO = :nidProceso ");*/
			sbQuery.append(" SELECT (CASE WHEN (PROP.CODTIPODOC  = 1 OR PROP.CODTIPODOC     = 5) THEN 1 WHEN PROP.CODTIPODOC   = 6 THEN 2 WHEN PROP.CODTIPODOC   = 6 then 3 WHEN PROP.ID_CONSORCIO <> null THEN 4 end) c_tipdoc, ");
			sbQuery.append(" cast(prop.nrodocumento as varchar2(11)) ruc_postor, replace(replace(replace( replace(replace(prop.postornombre ,'Â¿',''),'',''),'''',''),chr(10),' '),chr(13),' ') nom_postor, ");
		    sbQuery.append(" to_char(prop.fec_compra, 'DD/MM/YYYY HH24:MI' ) f_registro, (case prop.ind_inscripcion when 2 then 'No Valido' else 'Valido'  end) c_estpar, prop.des_observacion c_motobs, ");
		    sbQuery.append(" to_char(prop.f_registro, 'DD/MM/YYYY HH24:MI' ) d_feccre, prop.usu_creacion from convocatoria_adquiriente_base@aixregprodes.seace.gob.pe prop, reg_procesos.convocatorias@aixregprodes.seace.gob.pe con ");
		    sbQuery.append(" where prop.n_convoca = con.n_convoca AND CON.n_convoca    = :nidProceso order by fec_compra");
		}
		return sbQuery;
	}
	
	/** Lista de Acciones de Procedimiento */
	public static StringBuilder getQueryListaAccionesProcedimiento(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT N_ID_ACC_PUB, C_TIPACC, D_FECPUB, C_MOTIVO, N_ID_PUB_CON, N_IDNOMTAB "); /** #006 */
			sbQuery.append(" from pro.tbl_sel_acc_pub where n_id_pub_con = :idPublicacion and (c_motivo is not null or c_motivo!='') order by D_FECPUB ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			// No disponible
			sbQuery = null;
		}
		return sbQuery;
	}
	
	/** Lista Oficio SupervisiÃ³n */
	public static StringBuilder getQueryListaOficioSupervision(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			/** Inicio #001: AtenciÃ³n a Mejora jmatos*/
			sbQuery.append(" SELECT dtofi.N_ID_OFI_PRO, to_char(dtofi.D_FECCRE,  'DD/MM/YYYY HH24:MI'), dtofi.D_FECUMO, dtofi.N_ID_OFI_SUP, dtofi.C_USUCRE, dtofi.C_USUUMO, ");
			sbQuery.append(" ofi.N_TIPDOC, (SELECT VL.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO VL WHERE VL.N_ID_LISTADO = 104 AND VL.N_ID_VALLISTADO = ofi.N_TIPDOC) C_TIPDOC, ");
			sbQuery.append(" ofi.C_NRODOC, to_char(ofi.D_FECDOC,  'DD/MM/YYYY'), ofi.C_EXTARCHIVO, ofi.N_TAMARCHIVO, ofi.C_NOMARCALF ");
			sbQuery.append(" FROM PRO.DET_SEL_OFI_PRO dtofi, PRO.TBL_SEL_OFI_SUP ofi WHERE ((dtofi.N_ID_PUB_CON= :idPublicacion ) OR (dtofi.N_ID_EXPEDE      = :idConvoca )) AND(ofi.C_VISTA ='P' AND dtofi.N_ID_OFI_SUP =ofi.N_ID_OFI_SUP) ");
			/**  Fin #001: AtenciÃ³n a Mejora jmatos */
			
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			// No disponible 
			return null;
		}
		return sbQuery;
	}
	
	/** Historial Procedimiento */
	public static StringBuilder getQueryListaHistorialProcedimiento(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" SELECT E.N_CARSEC AS caracterSecreto, E.C_NOMETS AS nomenclatura, B.N_ID_BASES AS idBase, C.C_ESTCON AS estado, K.N_ETAPA AS idElementoModeloFlujo,  C.N_ID_PUB_CON  AS idConv,P.N_ID_PROCED AS idProc ");
			sbQueryBuilder.append(" FROM PRO.TBL_ACT_PROCEDIMIENTO P INNER JOIN PRO.TBL_ACT_EXPEDIENTE E ON E.N_ID_PROCED=P.N_ID_PROCED AND E.N_ESTADO  = '1' INNER JOIN PRO.TBL_ACT_BASES B ON B.N_ID_EXPEDE=E.N_ID_EXPEDE AND B.N_ESTADO  = '1' ");
			sbQueryBuilder.append(" AND B.n_estbas  = '1' LEFT JOIN PRO.TBL_SEL_PUB_CON C ON C.N_ID_BASES      = B.N_ID_BASES LEFT JOIN PRO.TBL_ACT_CRONOGRAMA K ON C.N_ID_BASES = K.N_ID_BASES AND K.N_ESTCRO      ='1' ");
			sbQueryBuilder.append(" AND TO_CHAR(SYSDATE, 'YYYYMMDD HH24MISS') BETWEEN TO_CHAR(K.D_FECINI, 'YYYYMMDD HH24MISS')  AND TO_CHAR(K.D_FECFIN, 'YYYYMMDD HH24MISS')  ");
			/* SM-103 by ndiaz */
			sbQueryBuilder.append(" INNER JOIN (  ");
			sbQueryBuilder.append(" SELECT N_ID_PROCED, LEVEL as nivel,N_ESTADO FROM PRO.TBL_ACT_PROCEDIMIENTO  ");
			sbQueryBuilder.append(" WHERE N_ID_PADRE is null START WITH N_ID_PROCED in (select N_ID_PROCED from pro.tbl_act_expediente where n_id_expede=:nidExpediente  AND N_ESTADO!= 2) CONNECT BY PRIOR N_ID_PADRE = N_ID_PROCED ");
			sbQueryBuilder.append(" union ");
			sbQueryBuilder.append(" SELECT N_ID_PROCED,LEVEL  as nivel,N_ESTADO FROM PRO.TBL_ACT_PROCEDIMIENTO  ");
			sbQueryBuilder.append(" START WITH N_ID_PADRE = (SELECT N_ID_PROCED FROM PRO.TBL_ACT_PROCEDIMIENTO   ");
			sbQueryBuilder.append(" WHERE N_ID_PADRE is null START WITH N_ID_PROCED in (select N_ID_PROCED from pro.tbl_act_expediente where n_id_expede=:nidExpediente  AND N_ESTADO!= 2) CONNECT BY PRIOR N_ID_PADRE = N_ID_PROCED) CONNECT BY PRIOR N_ID_PROCED = N_ID_PADRE  ");
			sbQueryBuilder.append(" )PSEL ON P.N_ID_PROCED = PSEL.N_ID_PROCED AND PSEL.N_ESTADO != 2 ");
			
			/*sbQueryBuilder.append(" WHERE P.N_ID_PROCED IN ((SELECT P.N_ID_PROCED FROM PRO.TBL_ACT_EXPEDIENTE E, PRO.TBL_ACT_PROCEDIMIENTO P WHERE E.N_ID_PROCED = P.N_ID_PROCED ");
			sbQueryBuilder.append(" AND E.N_ID_EXPEDE   = :nidExpediente  AND P.N_ESTADO!     = 2 ) union all (SELECT P.N_ID_PADRE FROM PRO.TBL_ACT_EXPEDIENTE E, PRO.TBL_ACT_PROCEDIMIENTO P WHERE E.N_ID_PROCED = P.N_ID_PROCED AND E.N_ID_EXPEDE   = :nidExpediente AND P.N_ESTADO!= 2 ");
			sbQueryBuilder.append(" AND P.N_ID_PADRE   IS NOT NULL ) union all ((SELECT P.N_ID_PROCED FROM PRO.TBL_ACT_PROCEDIMIENTO P WHERE P.N_ESTADO! = 2 AND P.N_ID_PADRE  =(SELECT E.N_ID_PROCED FROM PRO.TBL_ACT_EXPEDIENTE E WHERE E.N_ID_EXPEDE = :nidExpediente )))) ");*/
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQueryBuilder.append(" SELECT null caracterSecreto,(tp.proc_tipo_sigla || ' ' || ts.des_tipo_subasta || ' .' || c.PROC_NUM || '-'|| c.ANHOENTIDAD || '/' ||c.PROC_SIGLA ) C_NOM_PROC,  ");
			sbQueryBuilder.append(" null idBase, (CASE (PKU_PROCESOS_COMUN.getEstadoPublicacion@AIXREGPRODES.SEACE.GOB.PE(c.N_CONVOCA)) WHEN 7 THEN 'P' ELSE '-1' END) estado, NULL idElementoModeloFlujo, c.N_CONVOCA idConv, ");
			sbQueryBuilder.append(" c.n_proceso FROM reg_procesos.tipo_procesos@AIXREGPRODES.SEACE.GOB.PE tp, reg_procesos.t_tipo_subasta@AIXREGPRODES.SEACE.GOB.PE ts, reg_procesos.convocatorias@AIXREGPRODES.SEACE.GOB.PE c LEFT OUTER JOIN SEASE.tipo_proceso@AIXREGPRODES.SEACE.GOB.PE t ON ( t.tip_codigo = c.proc_tipo) ");
			sbQueryBuilder.append(" WHERE c.n_proceso = :nidExpediente AND c.ind_conv_ultimo      = 1 AND c.proc_tipo = tp.proc_tipo AND c.cod_tipo_subasta = ts.cod_tipo_subasta AND c.ind_conv_ultimo_pub IS NOT NULL ");
			sbQueryBuilder.append(" ORDER BY c.n_convoca DESC ");
		}
		return sbQueryBuilder;
	}
	
	/** Lista de Accion de supervision */
	public static StringBuilder getQueryListaAccionesSupervision(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" SELECT asp.N_ID_IMP_CONST , asp.N_ID_PUB_CON, asp.C_ESTREG, asp.C_EXTARCHIVO, TO_CHAR(asp.D_FECCRE, 'DD/MM/YYYY'), TO_CHAR(asp.D_FECDOC, 'DD/MM/YYYY'), TO_CHAR(asp.D_FECUMO,'DD/MM/YYYY'), asp.C_NOMARCHIVO, asp.C_NUMDOCU, asp.C_OBSSUP, ");
			sbQueryBuilder.append(" (SELECT VL.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO VL WHERE VL.N_ID_LISTADO = '122' AND VL.N_ID_VALLISTADO = asp.C_ORISUPER ) DES_C_OBSSUP, ");
			sbQueryBuilder.append(" asp.C_ORISUPER,  asp.N_TAMARCHIVO, asp.C_NOMARCALF  ");
			sbQueryBuilder.append(" FROM PRO.TBL_SEL_IMP_CONST asp WHERE (asp.N_ID_PUB_CON= :idPublicacion ) ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQueryBuilder.append(" SELECT IAS.ID_ACCION_SUPERVISION, IAS.N_CONVOCA, IAS.ESTADO, IAS.COD_TIPO_FILE, (SELECT TA.EXT_TIPO_FILE  FROM REG_PROCESOS.TIPO_ARCHIVO@AIXREGPRODES.SEACE.GOB.PE TA WHERE TA.COD_TIPO_FILE = IAS.COD_TIPO_FILE) EXT_TIPO_FILE, ");
			sbQueryBuilder.append(" TO_CHAR(IAS.FEC_REGISTRO, 'DD/MM/YYYY'), TO_CHAR(IAS.FECHA_DOCUMENTO, 'DD/MM/YYYY'), TO_CHAR(IAS.FEC_MODIFICA, 'DD/MM/YYYY'), IAS.NOMBRE_DOCUMENTO, NULL C_NUMDOCU, IAS.NOTA_LEVANTA,  ");
			sbQueryBuilder.append(" (CASE IAS.ID_ORIGEN WHEN 1 THEN 'DTN' WHEN 2 THEN 'DSFE' END )DES_C_OBSSUP, IAS.USU_REGISTRO, IAS.TAMANO_BYTES, IAS.RUTA_DOCUMENTO  ");
			sbQueryBuilder.append(" FROM REG_PROCESOS.INH_ACCION_SUPERVISION@AIXREGPRODES.SEACE.GOB.PE IAS, REG_PROCESOS.CONVOCATORIAS@AIXREGPRODES.SEACE.GOB.PE CON WHERE CON.N_CONVOCA = IAS.N_CONVOCA AND CON.N_PROCESO = :idPublicacion ");
		}
		return sbQueryBuilder;
	}
	
	/** Lista Items por Accion de supervision */
	
	public static StringBuilder getQueryListaItemsAccionSupervision(){
		StringBuilder sbQueryBuilder = new StringBuilder();
		sbQueryBuilder.append(" SELECT C.C_NROITEM, C.C_DSITEM, C.C_CCUBSO, C.C_DCUBSO, C.C_CANTID, C.C_VRETOT, C.N_ID_ITEM  ");//Id.035:cinonan
		sbQueryBuilder.append(" FROM PRO.TBL_SEL_IMP_ITE A, PRO.TBL_SEL_IMP_CONST B, PRO.TBL_ACT_ITEM C ");
		sbQueryBuilder.append(" WHERE A.N_ID_IMP_CONST = B.N_ID_IMP_CONST AND C.N_ID_ITEM = A.N_ID_ITEM AND B.N_ID_PUB_CON = :idPublicacion ");
		
		// NO disponible Seace 2
		
		return sbQueryBuilder;
	}
	
	/** Inicio 017 Req 28 ley 30225 - ddrodriguez */
	/** Lista de Notifcacion de supervision */
	public static StringBuilder getQueryListaNotificacionesSupervision(){
		StringBuilder sbQueryBuilder = new StringBuilder();
			sbQueryBuilder.append(" select n.n_id_notifica, n.n_aniopac, to_char(n.d_feccre, 'YYYY') anio_notifica, m.c_descrip, ");
			sbQueryBuilder.append(" case m.c_tipref ");
			sbQueryBuilder.append(" when '1' then 'PAC' ");
			sbQueryBuilder.append(" when '2' then 'Proceso de selecciÃ³n' ");
			sbQueryBuilder.append(" when '3' then 'Contrato' else '' end tip_referencia, ");
			sbQueryBuilder.append(" case when r.n_id_noti_res is not null then ");
			sbQueryBuilder.append(" (select case n_estado ");
			sbQueryBuilder.append(" when 1 then 'Pendiente' ");
			sbQueryBuilder.append(" when 2 then 'Atendido parcial' ");
			sbQueryBuilder.append(" when 3 then 'Reiterativo' ");
			sbQueryBuilder.append(" when 4 then 'Atendido total' else '' end from pro.det_sel_noti_res ");
			sbQueryBuilder.append(" where n_id_noti_res = r.n_id_noti_res ");
			sbQueryBuilder.append(" ) else 'Pendiente' end desc_estado, ");
			sbQueryBuilder.append(" to_char(n.c_mensaje), to_char(n.c_solsug), n.n_id_contrato, n.c_extarchivo, n.n_tamarchivo, n.c_nomarcalf, to_char(n.d_feccre,'DD/MM/YYYY HH24:MI') fecha_creacion,to_char(nvl(r.d_feccre,n.d_feccre),'DD/MM/YYYY HH24:MI') fecha_estado ");
			sbQueryBuilder.append(" from pro.tbl_sel_notifica n ");
			sbQueryBuilder.append(" inner join pro.tbl_sel_mot_not m on m.n_id_mot_not = n.n_id_mot_not ");
			sbQueryBuilder.append(" left join (select max(dt.n_id_noti_res) n_id_noti_res, dt.n_id_notifica,max(dt.d_feccre) d_feccre ");
			sbQueryBuilder.append(" from pro.det_sel_noti_res dt where dt.c_accion='C' group by dt.n_id_notifica) r on r.n_id_notifica=n.n_id_notifica ");
			sbQueryBuilder.append(" where n.n_id_pub_con = :idPublicacion and n.c_publicacion='P' order by n.n_id_notifica desc ");
						
		return sbQueryBuilder;
	}	
	/** Lista Items por Notifcacion de supervision */
	/** Fin 017 Req 28 ley 30225 - ddrodriguez */
	
	/** Contratos */
	public static StringBuilder getQueryListaContratos(Long tipoSeace){
		//Aplica Igual para Seace 2 y 3
		StringBuilder sbQueryBuilder = new StringBuilder();
		sbQueryBuilder.append(" SELECT con.N_ID_CONTRATO , con.C_CONTRATISTA, con.C_DESCON, con.C_DESCTIPDOC, con.C_DESENTCON, con.C_DESTPAGO, REPLACE(con.C_ENLACE, '\\', '/'), TO_CHAR(con.D_FECFINVIG, 'DD/MM/YYYY'), ");
		sbQueryBuilder.append(" TO_CHAR(con.D_FECINIVIG, 'DD/MM/YYYY'), TO_CHAR(con.D_FECPERFEC, 'DD/MM/YYYY'), TO_CHAR(con.D_FECPUB, 'DD/MM/YYYY'), TO_CHAR(con.D_FECREGARC, 'DD/MM/YYYY'), con.N_ID_CONVOCA, con.N_MONTO, con.C_NUMCONTRA, con.C_NRODOCUMENTO, con.C_RUCONTRA, ");
		sbQueryBuilder.append(" con.C_RUCENTCON, con.C_SITUACION, con.N_TAMARC, con.C_ID_TIPDOC, con.C_TIPMON FROM BUS.VW_BUS_CONTRATOS con WHERE  ");
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" con.N_ID_CONVOCA= :nidConvocatoria ");
			sbQueryBuilder.append(" and con.IND_PUBLICADO = '1' "); //SI-124
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQueryBuilder.append(" con.N_CONVOCA= :nidConvocatoria ");
			sbQueryBuilder.append(" and con.IND_PUBLICADO = '1' "); //SI-124
		}else{
			return null;
		}
		
		return sbQueryBuilder;
	}
	
	/** Lista de Acciones sobre el ITEM **/
	public static StringBuilder getQueryListaAccionItem(){
		StringBuilder sbQueryBuilder = new StringBuilder();
		sbQueryBuilder.append(" SELECT N_ID_EST_ITEM, N_ID_PUB_CON, N_ESTPRO, C_ESTITEM, TO_CHAR(D_FECCRE, 'DD/MM/YYYY HH24:MI:SS') D_FECCRE, TO_CHAR(D_FECPUBITE , 'DD/MM/YYYY HH24:MI:SS') D_FECPUBITE , N_IDNOMTAB, N_ID_ITEM, C_MOTEST, C_NOMTAB, C_USUCRE FROM PRO.TBL_SEL_EST_ITEM ");
		sbQueryBuilder.append(" WHERE N_ID_PUB_CON= :idPublicacion AND N_ID_ITEM = :idItem order by to_date(d_fecpubite , 'DD/MM/YYYY HH24:MI:SS') asc ");
		return sbQueryBuilder;
	}
	
	/*** Items Resumen Cantidad **/
	public static StringBuilder getQueryListaResumenCantidad(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" SELECT  COUNT(N_ESTPRO),N_ESTPRO  from  PRO.TBL_ACT_item R  WHERE R.N_ID_EXPEDE = :pidExpe "); 
			sbQueryBuilder.append(" AND R.N_ID_PADRE IS NULL  AND R.N_ID_GRUPO IS NULL group by N_ESTPRO ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			/** #005 inicio */
			sbQueryBuilder.append(" SELECT count(REG_PROCESOS.f_get_item_estado_id@AIXREGPRODES.SEACE.GOB.PE(i.n_convoca, i.proc_item)) cantidad ");
			sbQueryBuilder.append(" , REG_PROCESOS.f_get_item_estado_id@AIXREGPRODES.SEACE.GOB.PE(i.n_convoca, i.proc_item) cod_estado ");
			sbQueryBuilder.append(" , REG_PROCESOS.f_get_item_estado_resumen@AIXREGPRODES.SEACE.GOB.PE(i.n_convoca, i.proc_item) des_estado ");
			sbQueryBuilder.append("  FROM reg_procesos.item_convoca@AIXREGPRODES.SEACE.GOB.PE i, t_cat_nivel5@AIXREGPRODES.SEACE.GOB.PE n where i.nivel5 = n.nivel5 (+) ");
			sbQueryBuilder.append("  and i.n_convoca = :pidExpe and REG_PROCESOS.f_get_item_estado_id@AIXREGPRODES.SEACE.GOB.PE(i.n_convoca, i.proc_item) is not null ");
			sbQueryBuilder.append("  group by REG_PROCESOS.f_get_item_estado_id@AIXREGPRODES.SEACE.GOB.PE(i.n_convoca, i.proc_item), REG_PROCESOS.f_get_item_estado_resumen@AIXREGPRODES.SEACE.GOB.PE(i.n_convoca, i.proc_item) ");
			/** #005 fin */
		}
		return sbQueryBuilder;
	}
	
	public static StringBuilder getQueryEnlaceTomaRazon(Long tipoSeace){
		/** En seace 3, la busqueda es a nivel de ITEM, en la versiÃ³n 2.0 la busqueda es a nivel de Convocatoria **/
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			/** #019 Inicio */
		//  sbQueryBuilder.append(" select i_ap.C_ENLTOMARAZON BB from pro.tbl_sel_rec_ape i_ap, pro.det_sel_re_ap_item di_ap where i_ap.n_id_rec_ape = di_ap.n_id_rec_ape  and di_ap.n_id_item= :identificador and TO_CHAR(i_ap.d_fecpub, 'DD/MM/YYYY HH24:MI:SS') = :fechapublicacion ");
			/*Inicio Id.020:cinonan*/			
//			sbQueryBuilder.append(" select i_ap.C_ENLTOMARAZON BB from pro.tbl_sel_rec_ape i_ap, pro.det_sel_re_ap_item di_ap where i_ap.n_id_rec_ape = di_ap.n_id_rec_ape  and di_ap.n_id_item= :identificador and TO_CHAR(i_ap.d_fecpub, 'DD/MM/YYYY HH24') = SUBSTR(:fechapublicacion, 1, 13) ");
			sbQueryBuilder.append(" select i_ap.C_ENLTOMARAZON BB from PRO.TBL_SEL_REC_APE i_ap ");			
			sbQueryBuilder.append(" inner join PRO.DET_SEL_RE_AP_ITEM di_ap on i_ap.N_ID_REC_APE=di_ap.N_ID_REC_APE ");
			sbQueryBuilder.append(" inner join PRO.TBL_SEL_EST_ITEM ei on i_ap.N_ID_REC_APE=ei.n_idnomtab AND di_ap.n_id_item=ei.n_id_item and i_ap.C_REGANTE='T' ");//Id.023:cinonan
			sbQueryBuilder.append(" where ei.N_ID_EST_ITEM= :identificador ");
			/*Fin Id.020:cinonan*/			
			/** #019 Fin */			
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQueryBuilder.append(" select doc_url bb from reg_procesos.convocatoria_doc@aixregprodes.seace.gob.pe  a inner join reg_procesos.tipo_documento@aixregprodes.seace.gob.pe b on a.cod_tipo_doc = b.cod_tipo_doc ");
			sbQueryBuilder.append(" where a.cod_tipo_doc = 550 and a.n_convoca = :identificador order by a.fec_upload ");
		}
		return sbQueryBuilder;
	}
	
	
	
	
	/**		Lista Id's Convocatorias	**/
	public static StringBuilder getQueryIdConvocatoriasExpedTribunal(){
		StringBuilder sbQueryBuilder = new StringBuilder();
		sbQueryBuilder.append("SELECT TO_CHAR(BS.N_ID_EXPEDE), '3' from PRO.TBL_SEL_REG_PAR RP, PRO.TBL_SEL_REC_APE RA, PRO.TBL_SEL_PUB_CON PC, PRO.TBL_ACT_BASES BS ");
		sbQueryBuilder.append(" WHERE RP.N_ID_REG_PAR = RA.N_ID_REG_PAR  AND PC.N_ID_BASES = BS.N_ID_BASES AND PC.N_ID_PUB_CON = RP.N_ID_PUB_CON AND RA.C_NROTRAMITE like :numeroTramite AND RA.C_ANIOEXP = :anio ");
		sbQueryBuilder.append(" UNION ALL ");
		sbQueryBuilder.append(" SELECT TO_CHAR(reg_procesos.F_GET_MIN_N_CONVOCA@AIXREGPRODES.SEACE.GOB.PE(DOC.N_CONVOCA)) N_CONVOCA, '2' FROM ");
		//sbQueryBuilder.append(" reg_procesos.CONVOCATORIA_DOC@AIXREGPRODES.SEACE.GOB.PE DOC WHERE DOC.COD_TIPO_DOC = 550 AND DOC.DOC_URL like :numeroTramiteSeace2 AND DOC.DOC_URL LIKE :anioSeace2 ");
		/** Inicio AtenciÃ³n Incidencia 8.4 / jmatos */
		sbQueryBuilder.append(" reg_procesos.CONVOCATORIA_DOC@AIXREGPRODES.SEACE.GOB.PE DOC WHERE DOC.COD_TIPO_DOC = 550 AND DOC.DOC_URL like :docURLTramite ");
		/** Fin AtenciÃ³n Incidencia 8.4 / jmatos*/
		return sbQueryBuilder;
	}
	
	/** Entidad Contratante */
	public static StringBuilder getEntidadContratante(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" select DISTINCT pac.c_rucent, pac.c_noment from PRO.det_act_exp_pac pac WHERE pac.N_ID_EXPEDE = :idExpediente ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			// No disponible 
			return null;
		}
		return sbQueryBuilder;
	}
	
	/** Obtener Nombre Moneda */
	public static StringBuilder getQueryNombreMoneda(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" SELECT C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO WHERE N_ID_LISTADO = 31 AND N_ID_VALLISTADO = :idMoneda ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQueryBuilder.append(" SELECT C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO WHERE N_ID_LISTADO = 31 AND N_COD_REFERENCIA = :idMoneda ");
		}
		return sbQueryBuilder;
	}
	
	/** Obtener Lugares de Pago **/
	public static StringBuilder getQueryLugaresPago(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append("select n_id_bases, n_id_lug_pag, c_entfin, c_lugpag, C_NROCTA from pro.det_act_bases_lug_pag where n_id_bases = :idBases ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			return null;
		}
		return sbQueryBuilder;
	}
	
	/** Obtener Acuerdos Comerciales **/
	public static StringBuilder getQueryAcuerdosComerciales(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" select N_ID_EXPEDE, C_DESTLC from pro.DET_ACT_EXP_TLC where n_id_expede = :idExpede ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			return null; // Pendiente de Implementar
		}
		return sbQueryBuilder;		
		
		
	}

	/** inicio #003 */
	/** Obtener Enlaces Resolucion Tribunal **/
	public static StringBuilder getQueryEnlacesResolucionTribunal(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			return null;
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQuery.append(" select convocatoria_doc.cod_doc,'' C_DESETAPA, convocatoria_doc.doc_url,  "); 
			sbQuery.append(" (convocatoria_doc.tamano_bytes) tamano,'' C_ALFARC, TO_CHAR(convocatoria_doc.fec_upload, 'DD/MM/YYYY HH24:MI' ) fec_upload, 19 C_TIPDOC, "); 
			sbQuery.append(" null C_EXTARC, null icon_tipo_file, convocatoria_doc.doc_nombre, convocatoria_doc.nro_doc ");
			sbQuery.append(" from reg_procesos.convocatoria_doc@AIXREGPRODES.SEACE.GOB.PE "); 
			sbQuery.append(" where translate( nvl(trim(convocatoria_doc.doc_nombre),'*') ,' 0123456789','*') is null "); 
			sbQuery.append(" and translate( nvl(trim(convocatoria_doc.nro_doc),'*') ,' 0123456789','*') is null "); 
			sbQuery.append(" and convocatoria_doc.cod_tipo_doc=575 and convocatoria_doc.cod_tipo_file is null "); 
			sbQuery.append(" and convocatoria_doc.n_convoca = reg_procesos.f_Get_min_n_convoca@AIXREGPRODES.SEACE.GOB.PE( :nidProceso ) ");
		}
		return sbQuery;
	}
	/** fin #003 */
	
	/** inicio #004 */
	/** Obtener Documentos Acciones **/
	public static StringBuilder getQueryDocumentosAcciones(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			return null;
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
	/* Inicio #015 tchacon:  se descomento el codigo anterior - Incidencia buscador por expediente de tribunal (el tomarazon link del tomarazon estaba mal) */
			
			sbQuery.append(" select doc_nombre ||', '||nvl(doc_obs,'')||', ' doc_nombre_obs, ");
			sbQuery.append(" ( case b.cod_tipo_doc when 500 then 'RESOLUCION DEL RECURSO DE APELACION DE LA ENTIDAD QUE AGOTA LA VIA ADMINISTRATIVA' ");
			sbQuery.append(" when 575 then 'RESOLUCION DEL RECURSO DE REVISION/APELACION DEL TRIBUNAL QUE AGOTA LA VIA ADMINISTRATIVA' ");
			sbQuery.append(" ELSE B.DES_TIPO_DOC END) des_tipo_doc, ");
			sbQuery.append(" to_char(fec_upload,'dd/mm/yyyy hh24:mi') fec_upload, doc_url, a.cod_tipo_doc,  c.icon_tipo_file, "); 
			//sbQuery.append(" to_char(fec_upload,'dd/mm/yyyy hh24:mi') fec_upload, (case when TO_NUMBER (TO_CHAR (a.fec_upload, 'yyyymmdd')) > 20100819 then 'http://zonasegura.seace.gob.pe' || doc_url  else 'http://docs.seace.gob.pe' || doc_url end) doc_url, a.cod_tipo_doc,  c.icon_tipo_file, ");
			sbQuery.append(" doc_nombre as nombredoc, c.cod_tipo_File, a.doc_obs observacion ");
			sbQuery.append(" FROM REG_PROCESOS.CONVOCATORIA_DOC@AIXREGPRODES.SEACE.GOB.PE A ");
			sbQuery.append(" inner join REG_PROCESOS.TIPO_DOCUMENTO@AIXREGPRODES.SEACE.GOB.PE B on A.cod_tipo_doc = B.cod_tipo_doc ");
			sbQuery.append(" left join reg_procesos.tipo_archivo@AIXREGPRODES.SEACE.GOB.PE c on a.cod_tipo_file = c.cod_tipo_file ");
			sbQuery.append(" WHERE A.cod_tipo_doc = B.cod_tipo_doc ");
			sbQuery.append(" and A.n_convoca = reg_procesos.f_get_min_n_convoca@AIXREGPRODES.SEACE.GOB.PE(:nidProceso) ");
			sbQuery.append(" and A.cod_tipo_doc not in (200,300,325,350,400,2400,3300,3400)      ");
			//sbQuery.append(" ORDER BY A.fec_upload ");
	/* Fin #015 tchacon:  se comento el codigo anterior - Incidencia buscador por expediente de tribunal (el tomarazon link del tomarazon estaba mal) */
	
	/* Inicio #015 tchacon:  se comento el codigo anterior - Incidencia buscador por expediente de tribunal (el tomarazon link del tomarazon estaba mal) */	
			/*
			sbQuery.append("	select doc_nombre ||', '||nvl(doc_obs,'')||', ' doc_nombre_obs, 	");
			sbQuery.append("	( case b.cod_tipo_doc when 500 then 'RESOLUCION DEL RECURSO DE APELACION DE LA ENTIDAD QUE AGOTA LA VIA ADMINISTRATIVA' 	");
			sbQuery.append("	when 575 then 'RESOLUCION DEL RECURSO DE REVISION/APELACION DEL TRIBUNAL QUE AGOTA LA VIA ADMINISTRATIVA' ELSE B.DES_TIPO_DOC END) des_tipo_doc, 	");
			sbQuery.append("	to_char(a.fec_upload,'dd/mm/yyyy hh24:mi') fec_upload,	");
			sbQuery.append("	(case when p.reg_codigo is null and p.ley_codigo is null then 'http://docs.seace.gob.pe' || a.doc_url  else  'http://zonasegura.seace.gob.pe' || a.doc_url  end) doc_url,	");
			sbQuery.append("	a.cod_tipo_doc,  c.icon_tipo_file, doc_nombre as nombredoc, c.cod_tipo_File, a.doc_obs observacion  FROM REG_PROCESOS.CONVOCATORIA_DOC@AIXREGPRODES.SEACE.GOB.PE A, REG_PROCESOS.TIPO_DOCUMENTO@AIXREGPRODES.SEACE.GOB.PE B,	");
			sbQuery.append("	reg_procesos.tipo_archivo@AIXREGPRODES.SEACE.GOB.PE c, reg_procesos.convocatorias@AIXREGPRODES.SEACE.GOB.PE convoca, reg_procesos.procesos@AIXREGPRODES.SEACE.GOB.PE p	");
			sbQuery.append("	WHERE A.cod_tipo_doc = B.cod_tipo_doc and A.cod_tipo_doc = B.cod_tipo_doc and a.cod_tipo_file  = c.cod_tipo_file  (+) and A.n_convoca = reg_procesos.f_get_min_n_convoca@AIXREGPRODES.SEACE.GOB.PE(:nidProceso) 	");
			sbQuery.append("	and A.cod_tipo_doc not in (200,300,325,350,400,2400,3300,3400) and convoca.n_convoca = a.n_convoca and p.n_proceso = convoca.n_proceso and convoca.ind_conv_ultimo = 1	");
			sbQuery.append("	ORDER BY A.fec_upload 	");
			*/
	 /* Fin #015 tchacon:  se comento el codigo anterior - Incidencia buscador por expediente de tribunal (el tomarazon link del tomarazon estaba mal) */
		}
		return sbQuery;
	}
	
	
	/** Obtener Notificaciones Acciones **/
	public static StringBuilder getQueryNotificacionesAcciones(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			return null;
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQuery.append(" Select nt.i_numero_notificacion n_notif, nt.i_anho_notificacion a_notif ");
			/*sbQuery.append(", nt.i_numero_notificacion||'-'||nt.i_anho_notificacion num_anho_notif, ");
			sbQuery.append(" to_char(nt.d_fecha_envio,'DD/MM/YYYY HH24:MI:SS') d_fecha_envio, ");
			sbQuery.append(" nt.s_referencia, mt.s_descripcion  desc_motivo, ");
			sbQuery.append(" to_char(nt.i_cant_veces,'999') i_cant_veces, ");
			sbQuery.append(" et.s_descripcion desc_etapa, es.s_descripcion desc_estado, ");
			sbQuery.append(" reg_procesos.pku_notificaciones_02.f_Get_Nombre_Usuario@AIXREGPRODES.SEACE.GOB.PE(nt.s_idusuario_envia,1) nom_usu_envia, ");
			sbQuery.append(" nt.i_numero_notificacion  num_notifica, ");
			sbQuery.append(" nt.i_anho_notificacion  anho_notifica, ");
			sbQuery.append(" nt.i_idestado, nt.i_idetapa_notificacion i_idetapa, ");
			sbQuery.append(" nt.n_proceso, a.id_area, a.nombre supervision, ");
			sbQuery.append(" nt.i_idmotivo, nt.n_convoca ");*/
			sbQuery.append(" from reg_procesos.snt_motivo_notificacion@AIXREGPRODES.SEACE.GOB.PE mt, ");
			sbQuery.append(" reg_procesos.snt_etapa_notificacion@AIXREGPRODES.SEACE.GOB.PE  et, ");
			sbQuery.append(" reg_procesos.snt_estado_notificacion@AIXREGPRODES.SEACE.GOB.PE es, ");
			sbQuery.append(" reg_procesos.snt_notificacion@AIXREGPRODES.SEACE.GOB.PE nt ");
			sbQuery.append(" left outer join reg_procesos.snt_area_notificacion@AIXREGPRODES.SEACE.GOB.PE a on a.id_area = nt.id_area ");
			sbQuery.append(" where nt.i_idmotivo = mt.i_idmotivo and nt.i_idetapa_notificacion = et.i_idetapa_notificacion ");
			sbQuery.append(" and nt.i_idestado = es.i_idestado and nt.i_idestado<>4 ");
			sbQuery.append(" and nt.i_idetapa_notificacion<>4 and nt.s_publica=2 ");
			sbQuery.append(" and (nt.n_convoca in ( select n_convoca from reg_procesos.convocatorias@AIXREGPRODES.SEACE.GOB.PE "); 
			sbQuery.append(" where n_proceso in(select n_proceso from reg_procesos.convocatorias@AIXREGPRODES.SEACE.GOB.PE where n_convoca = :nidProceso))) ");                            
			sbQuery.append(" order by nt.i_anho_notificacion asc, nt.i_numero_notificacion asc ");	
		}
		return sbQuery;
	}
	/** fin #004 */

	/** #006 inicio */
	/** Obtener Suspension por Id **/
	public static StringBuilder getQuerySuspensionByID(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" select sus.N_ID_SUS_SUP ID_SUSPENSION,  sus.N_MOTIVO,  val2.c_nombre motivoSuspencion, ");
			sbQueryBuilder.append(" sus.N_TIPDOC, val3.c_nombre tipoDocumento,sus.C_NRODOC nroDocumento, ");
			sbQueryBuilder.append(" sus.D_FECDOC fechaDocumento,sus.N_CARAPRO,  val4.c_nombre cargoAprobador, ");
			sbQueryBuilder.append(" sus.C_DATAPRO datosAprobador,sus.C_DESCRIP descripcionSuspencion, ");
			sbQueryBuilder.append(" sus.C_NOMARCALF nombreAlfresco, sus.C_EXTARCHIVO extensionArchivo,  ");
			sbQueryBuilder.append(" sus.N_TAMARCHIVO tamanoArchivo, sus.N_ESTADO estado, ");
			sbQueryBuilder.append(" val.c_nombre ds_tipoDocSuspension, susDoc.C_NRODOC ds_numeroDocumento, susDoc.D_FECDOC ds_fechaDocumento, "); 
			sbQueryBuilder.append(" susDoc.C_DATAPRO ds_datosAprobador, susDoc.C_DESCRIP ds_descripcion, susDoc.C_NOMARCALF ds_codigoAlfresco,  ");
			sbQueryBuilder.append(" susDoc.C_EXTARCHIVO ds_extensionArchivo, susDoc.N_TAMARCHIVO ds_tamanoArchivo ");
			sbQueryBuilder.append(" from pro.TBL_SEL_SUS_SUP sus ");
			sbQueryBuilder.append(" left join pro.DET_SEL_SUS_DOC susDoc  on susdoc.n_id_sus_sup = sus.n_id_sus_sup "); 
			sbQueryBuilder.append(" left join pro.TBL_CNF_VALOR_LISTADO val on susDoc.N_TIPDOC = val.N_ID_VALLISTADO  ");
			sbQueryBuilder.append(" left join pro.TBL_CNF_VALOR_LISTADO val2 on sus.N_MOTIVO = val2.N_ID_VALLISTADO  ");
			sbQueryBuilder.append(" left join pro.TBL_CNF_VALOR_LISTADO val3 on sus.N_TIPDOC = val3.N_ID_VALLISTADO  ");
			sbQueryBuilder.append(" left join pro.TBL_CNF_VALOR_LISTADO val4 on sus.N_CARAPRO = val4.N_ID_VALLISTADO  ");
			sbQueryBuilder.append(" where sus.n_id_sus_sup = :nidSuspension and rownum <=1 ");			
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			return null; 
		}
		return sbQueryBuilder;
	}
	
	/*Inicio Id.022:cinonan*/
	/** Obtener Suspension por Id **/
	public static StringBuilder getQueryEfectoResolucionByID(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" select efecto.n_id_efecto_res, efecto.c_tipocont, efecto.n_id_etapa, efecto.n_id_actividad, efecto.n_id_res_ape, efecto.c_estreg, to_char(efecto.d_fecpub,'dd/mm/yyyy HH24:MI:SS'), efecto.c_usupub, to_char(efecto.d_feccre,'dd/mm/yyyy HH24:MI:SS'), efecto.c_usucre, to_char(efecto.d_fecumo,'dd/mm/yyyy HH24:MI:SS'), efecto.c_usuumo,");
			sbQueryBuilder.append(" efecto.n_id_etapro, efecto.n_id_actpro, efecto.c_tipefe, efecto.c_jusmod, resol.c_nro_doc, resol.n_id_tipdoc, resol.d_fecdoc ");
			sbQueryBuilder.append(" from pro.tbl_sel_efecto_res efecto, pro.tbl_sel_res_ape resol ");
			sbQueryBuilder.append(" where resol.n_id_res_ape=efecto.n_id_res_ape and  n_id_efecto_res = :nidEfectoResolucion and rownum <=1 ");			
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			return null; 
		}
		return sbQueryBuilder;
	}	
	/*Fin Id.022:cinonan*/
	
	/** Obtener Items por Id de Suspension**/
	public static StringBuilder getQueryItemsByIdSuspension(Long tipoSeace){
		StringBuilder sbQueryBuilder = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQueryBuilder.append(" select i.C_DSITEM, i.C_VRETOT, i.N_ID_ITEM from pro.TBL_ACT_ITEM i where i.n_id_item in  ");//Id.035:cinonan
			sbQueryBuilder.append(" (select susItem.n_id_item from pro.DET_SEL_SUS_ITEM susItem where susItem.n_id_sus_sup = :nidSuspension) ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			return null; 
		}
		return sbQueryBuilder;
	}	
	
	/** #006 fin */
	
	/** #007 inicio */
	/** Obtener Acciones **/
	public static StringBuilder getQueryAcciones(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			return null;
		}else if(tipoSeace.equals(TIPO_SEACE_2)){ //
			sbQuery.append(" select decode(b.n_tipo,6,'Postergacion',7,'Fe de Errata') des_tipo_doc, ");
			sbQuery.append(" to_char(b.fec_creacion,'dd/mm/yyyy hh24:mi') fec_upload, ");
			sbQuery.append(" nvl(b.observaciones,'SIN JUSTIFICACION')  observacion ");
			sbQuery.append(" from (select * from reg_procesos.convocatorias@AIXREGPRODES.SEACE.GOB.PE where n_convoca = reg_procesos.f_get_min_n_convoca@AIXREGPRODES.SEACE.GOB.PE(:nidProceso) ) c, ");
			sbQuery.append(" reg_procesos.convocatorias@AIXREGPRODES.SEACE.GOB.PE a ,reg_procesos.fe_errata@AIXREGPRODES.SEACE.GOB.PE b, ");
			sbQuery.append(" reg_procesos.convocatoria_pub@AIXREGPRODES.SEACE.GOB.PE d ");
			sbQuery.append(" where c.n_proceso=a.n_proceso and c.proc_tipo=a.proc_tipo ");
			sbQuery.append(" and c.proc_sigla=a.proc_sigla and c.proc_num=a.proc_num ");
			sbQuery.append(" and c.anhoentidad=a.anhoentidad and c.num_convoca=a.num_convoca ");
			sbQuery.append(" and a.n_feerrata=b.n_feerrata and a.n_convoca=d.n_convoca ");
			sbQuery.append(" order by b.fec_creacion ");
		}
		return sbQuery;
	}	
	
	/** #007 fin */
	
	public static StringBuilder getQueryDocumentosConvocatoria(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" select doc.N_ID_DOC_CON, doc.C_TIPDOC, doc.C_NOMARC, (round(doc.N_TAMARC/1024,0)+1), doc.C_EXTARC, doc.C_ALFARC, TO_CHAR(doc.D_FECPUB,'DD/MM/YYYY HH24:MI'), "); 
			sbQuery.append(" doc.C_USUPUB, doc.C_USUCRE, TO_CHAR(doc.D_FECCRE,'DD/MM/YYYY HH24:MI'), doc.C_USUUMO, TO_CHAR(doc.D_FECUMO,'DD/MM/YYYY HH24:MI'),  ");
			sbQuery.append(" doc.N_ID_PUB_CON, doc.C_ESTADO, doc.C_OBSERV, doc.C_DOCUMENTO, doc.N_ID_CRONO, cron.N_ALIAS  ");
			sbQuery.append(" from DET_SEL_DOC_CON doc left join  TBL_ACT_CRONOGRAMA cron on cron.N_ID_CRONO = doc.N_ID_CRONO ");
			sbQuery.append(" where doc.C_ESTADO = 'A' and doc.N_ID_PUB_CON = :idConvocatoria ");
			sbQuery.append(" order by  cron.N_ID_CRONO, doc.D_FECPUB asc ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			return null;
		}
		return sbQuery;
	}	
	
	
	public static StringBuilder getQueryListaDatosProceso(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){	
			sbQuery.append(" select proc.N_ID_DAPROC idDocumento, ");
			sbQuery.append(" proc.N_EDOCU estado, ");
			sbQuery.append(" proc.C_T_ID_DOC idDocumentoAlfrescoTecnico, ");
			sbQuery.append(" proc.C_T_TIPDOC tipoDocumentoTecnico, ");
			sbQuery.append(" proc.C_NDOCU nroDocumentoTecnico, ");
		/**  014 --> Inicio - MEMORANDO 428-2015/SDP  **/
			//sbQuery.append(" TO_CHAR(proc.D_T_FECHA,'DD/MM/YYYY HH24:MI') fechaTecnico, ");
			sbQuery.append(" TO_CHAR(proc.D_T_FECHA,'DD/MM/YYYY') fechaTecnico, ");
		/**  Fin - MEMORANDO 428-2015/SDP  **/
			sbQuery.append(" proc.C_T_CARGO cargoTecnico, ");
			sbQuery.append(" proc.C_T_NOMBR nombreTecnico, ");
			sbQuery.append(" proc.C_T_APATE aPaternoTecnico, ");
			sbQuery.append(" proc.C_T_AMATE aMaternoTecnico, ");
			sbQuery.append(" proc.C_L_CARGO cargoLegal, ");
			sbQuery.append(" proc.C_L_ID_DOC idDocumentoAlfrescoLegal, ");
			sbQuery.append(" proc.C_L_TIPDOC tipoDocumentoLegal, ");
			sbQuery.append(" proc.C_L_NINFO nroDocumentoLegal, ");
		/**  014 --> Inicio - MEMORANDO 428-2015/SDP  **/
			//sbQuery.append(" TO_CHAR(proc.D_L_FECHA,'DD/MM/YYYY HH24:MI')  fechaLegal, ");
			sbQuery.append(" TO_CHAR(proc.D_L_FECHA,'DD/MM/YYYY')  fechaLegal, ");
		/**  Fin - MEMORANDO 428-2015/SDP  **/
			sbQuery.append(" proc.C_L_NOMBR nombreLegal, ");
			sbQuery.append(" proc.C_L_APATE aPaternoLegal, ");
			sbQuery.append(" proc.C_L_AMATE aMaternoLegal, ");
			sbQuery.append(" proc.C_TDISP tipoDispositivo, ");
			sbQuery.append(" proc.C_NUMSIG numeroSigla, ");
			sbQuery.append(" proc.C_NOMORGAN nombreOrganismo ");
			sbQuery.append(" from pro.TBL_ACT_DATOS_PROCESO proc where n_id_expede = :nidConvoca "); 
			sbQuery.append(" and N_EDOCU in (0,1,2,3,4,5) ");	
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			return null;
		}
		return sbQuery;
	}	
	
	public static StringBuilder getQueryListaDocumentoProcedimiento(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){	
			return null;
		}else if(tipoSeace.equals(TIPO_SEACE_2)){
			//sbQuery.append(" Select tpds.DES_TIPO_DOC_SUB_TIPO SubTitulo, (case when pro.reg_codigo is null and pro.ley_codigo is null then 'http://docs.seace.gob.pe' || pd.doc_url  else  'http://zonasegura.seace.gob.pe' || pd.doc_url  end) idAlfresco, icon_tipo_file extensionArchivo, ");
			sbQuery.append(" Select tpds.DES_TIPO_DOC_SUB_TIPO SubTitulo, (case when pro.reg_codigo is null and pro.ley_codigo is null then 'http://docs.seace.gob.pe' || pd.doc_url  else  'https://zonasegura2.seace.gob.pe/documentos/' || pd.doc_url  end) idAlfresco, icon_tipo_file extensionArchivo, ");
			
			sbQuery.append(" to_char(fec_upload,'dd/mm/yyyy hh24:mi') fechaHoraPublicacion, tpd.des_tipo_doc Titulo, doc_nombre nombreArchivo, ");
			sbQuery.append(" to_char(fec_aprob,'dd/mm/yyyy hh24:mi') fecha, nom_aprobador nombre, ape_pat_aprobador paterno, ");
			sbQuery.append(" ape_mat_aprobador materno, cargo_aprobador cargo, desc_causal_exo causal ");
			sbQuery.append("    from reg_procesos.proceso_doc@AIXREGPRODES.SEACE.GOB.PE pd ");
			sbQuery.append("           LEFT OUTER JOIN reg_procesos.TIPO_CAUSAL_EXO@AIXREGPRODES.SEACE.GOB.PE ON ");
			sbQuery.append("             pd.COD_CAUSAL_EXO = TIPO_CAUSAL_EXO.COD_CAUSAL_EXO ");
			sbQuery.append("           LEFT OUTER JOIN reg_procesos.tipo_archivo@AIXREGPRODES.SEACE.GOB.PE on ");
			sbQuery.append("             pd.cod_tipo_file = tipo_archivo.cod_tipo_file ");
			sbQuery.append("             inner join reg_procesos.tipo_documento@AIXREGPRODES.SEACE.GOB.PE tpd ");
			sbQuery.append("                 on pd.cod_tipo_doc=tpd.cod_tipo_doc ");
			sbQuery.append("             left join reg_procesos.TIPO_DOCUMENTO_SUB_TIPO@AIXREGPRODES.SEACE.GOB.PE tpds ");
			sbQuery.append("                 on  pd.cod_tipo_doc=tpds.cod_tipo_doc ");
			sbQuery.append("                     and pd.cod_tipo_doc_sub_tipo = tpds.cod_tipo_doc_sub_tipo 	");
			sbQuery.append("			 inner join reg_procesos.procesos@AIXREGPRODES.SEACE.GOB.PE pro 	"); 
			sbQuery.append("				 on pro.n_proceso  = pd.n_proceso		");
			sbQuery.append("         where pd.n_proceso = :nidProceso ");
			sbQuery.append("           and pd.cod_tipo_doc in (1100,1300,1350,1400)");
			sbQuery.append("           order by 1  ");			
		}
		return sbQuery;
	}	
	
	/** #008 inicio **/
	public static StringBuilder getQueryProveedores(boolean isConsorcio, boolean isRuc){
		StringBuilder sbQuery = new StringBuilder();
		if(isConsorcio){
			/*sbQuery.append(" select  distinct c_nomcons, '' from BUS.TBL_BUS_PROV_ADJ adj  ");
			sbQuery.append(" where adj.c_nomcons like :nombreConsorcio and rownum <=500 ");*/
			/*#040 - Inicio*/
			sbQuery.append(" select distinct c_nomcons, ''  from pro.TBL_ACT_ITEM item ");
			sbQuery.append(" left join PRO.det_sel_propuesta depro on item.n_id_item=depro.n_id_item and item.n_estpro in(4,19,22) ");
			sbQuery.append(" left join pro.tbl_sel_consorcio consor on depro.n_id_propuesta=consor.n_id_propuesta ");
			sbQuery.append(" where c_nomcons like :nombreConsorcio and rownum <=500");
			/*#040 - Fin*/
		}else if (isRuc) {			
			/*sbQuery.append(" select distinct c_ruc, c_razsoc from BUS.TBL_BUS_PROV_ADJ adj ");
			sbQuery.append(" where C_RUC = :ruc  and rownum <=500 ");*/
			/*#040 - Inicio*/
			sbQuery.append(" select distinct c_ruc, c_razsoc  from pro.TBL_ACT_ITEM item ");
			sbQuery.append(" left join PRO.det_sel_propuesta depro on item.n_id_item=depro.n_id_item and item.n_estpro in(4,19,22) ");
			sbQuery.append(" left join pro.tbl_sel_propuesta prop on prop.n_id_propuesta=depro.n_id_propuesta ");
			sbQuery.append(" left join pro.tbl_sel_consorcio consor on depro.n_id_propuesta=consor.n_id_propuesta ");
			sbQuery.append(" left join pro.tbl_sel_reg_par reg on prop.N_ID_REG_PAR = reg.N_ID_REG_PAR ");
			sbQuery.append(" where C_RUC = :ruc  and rownum <=500 ");
			/*#040 - Fin*/
		}else{
			/*sbQuery.append(" select distinct c_ruc, c_razsoc from BUS.TBL_BUS_PROV_ADJ adj ");
			sbQuery.append(" where adj.c_razsoc like :nombreProveedor  and rownum <=500 ");*/
			/*#040 - Inicio*/
			sbQuery.append(" select distinct c_ruc, c_razsoc from pro.TBL_ACT_ITEM item ");
			sbQuery.append(" left join PRO.det_sel_propuesta depro on item.n_id_item=depro.n_id_item and item.n_estpro in(4,19,22) ");
			sbQuery.append(" left join pro.tbl_sel_propuesta prop on prop.n_id_propuesta=depro.n_id_propuesta ");
			sbQuery.append(" left join pro.tbl_sel_consorcio consor on depro.n_id_propuesta=consor.n_id_propuesta ");
			sbQuery.append(" left join pro.tbl_sel_reg_par reg on prop.N_ID_REG_PAR = reg.N_ID_REG_PAR ");
			sbQuery.append(" where c_razsoc like :nombreProveedor  and rownum <=500  ");
			/*#040 - Fin*/
		}
		return sbQuery;
	}
	/** #008 fin **/
	
	/*
	 * 011  Inicio inci 004
	 */
	
	public static StringBuilder getQueryListaComponentesPaquete(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT r.n_id_item, r.n_id_padre, r.c_nroitem, r.c_ccubso, r.c_dcubso, r.c_dsitem, r.c_unimed, (SELECT l.C_NOMBRE FROM PRO.TBL_CNF_VALOR_LISTADO l WHERE l.n_id_vallistado = r.c_unimed) as des_unimed,r.c_cantid FROM PRO.TBL_ACT_ITEM R WHERE R.N_ID_PADRE in (:nidItem) ");
		}else if(tipoSeace.equals(TIPO_SEACE_2)){			
		}
		return sbQuery;
	}
		
	//***  011  Fin inci 004  ****//
/***
	 * 
	 * 
	 * 
	 * 
	 * SEACE 3.0
select * from bus.tbl_bus_proceso p, pro.tbl_act_bases b, PRO.TBL_ACT_CRONOGRAMA CRO, PRO.TBL_SEL_PUB_CON C
where p.n_id_convoca = b.n_id_expede and n_id_sistema = 3
and cro.n_id_bases = b.n_id_bases
AND C.n_id_bases = B.n_id_bases
--and p.n_id_convoca = 36523
and b.n_estado = 1
and b.n_estbas = 1
and sysdate between cro.d_fecini and cro.d_fecfin
and (cro.n_alias=2 or cro.n_alias= 25 or cro.n_alias=28)
and c.c_estcon= 'P'
and cro.n_estcro = 1 and cro.n_estado = 1;

 
 seace v2.0 
select * from bus.tbl_bus_proceso p, reg_procesos.calendario@aixregprodes.seace.gob.pe cal, 
              reg_procesos.etapas@AIXREGPRODES.SEACE.GOB.PE etp
where 
p.n_id_convoca = cal.n_convoca 
and etp.codetapa = cal.codetapa
and etp.codetapa in (215, 64)
and p.n_id_sistema = 2
and sysdate between TO_DATE(cal.FEC_INICIO) and TO_DATE(cal.FEC_FIN)

*/
	
	/** 013 INICIO*/
	/** Documentos Inactivos */
	public static StringBuilder getQueryDocumentosInactivos(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		/* #041 SM-262-2019 - INICIO*/
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT O.C_TIPDOC,O.C_NOMARC ");
			sbQuery.append(" FROM PRO.DET_SEL_DOC_CON O WHERE O.N_ID_PUB_CON=:nidProceso AND O.C_ESTADO = 'I' ");

		}
		/* #041 SM-262-2019 - FIN*/
		return sbQuery;
	}
	
	
	/** Documentos */
	public static StringBuilder getQueryHistorialDocumentosProceso(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT distinct(O.N_ID_DOC_CON) AS N_ID_DOC_CON, O.C_TIPDOC AS C_TIPDOC, O.C_NOMARC AS C_NOMARC, O.C_ALFARC AS C_ALFARC, (round(O.N_TAMARC/1024,0)+1) AS N_TAMARC  ");
			sbQuery.append(" ,to_char(O.D_FECPUB, 'dd/mm/yyyy HH24:MI:SS') AS fecha ");
			sbQuery.append(" ,O.C_EXTARC AS C_EXTARC , O.C_USUPUB AS C_USUPUB,  CRO.N_ALIAS AS C_DESETAPA, ACT.N_ORDETA AS N_ORDETA ");
			sbQuery.append(" FROM PRO.DET_SEL_DOC_CON O LEFT JOIN PRO.TBL_SEL_ACTIVIDAD ACT ON ACT.N_ID_CRONO = O.N_ID_CRONO  LEFT JOIN PRO.TBL_ACT_CRONOGRAMA CRO ON O.N_ID_CRONO =CRO.N_ID_CRONO WHERE O.N_ID_PUB_CON=:nidProceso AND O.C_TIPDOC =:tipoDoc ");
			sbQuery.append(" ORDER BY fecha DESC ");
			
			/*
			sbQuery.append(" SELECT distinct(O.N_ID_CRONO) AS N_ID_CRONO, O.C_TIPDOC AS C_TIPDOC, O.C_NOMARC AS C_NOMARC, O.C_ALFARC AS C_ALFARC, round(O.N_TAMARC/1024,0) AS N_TAMARC  ");
			sbQuery.append(" ,to_char(O.D_FECPUB, 'dd/mm/yyyy HH24:MI:SS') AS fecha ");
			sbQuery.append(" ,O.C_EXTARC AS C_EXTARC , O.C_USUPUB AS C_USUPUB, ACT.C_DESETAPA AS C_DESETAPA, ACT.N_ORDETA AS N_ORDETA ");
			sbQuery.append(" FROM PRO.DET_SEL_DOC_CON O INNER JOIN PRO.TBL_SEL_ACTIVIDAD ACT ON ACT.N_ID_CRONO = O.N_ID_CRONO WHERE O.N_ID_PUB_CON=:nidProceso AND O.C_TIPDOC =:tipoDoc ");
			sbQuery.append(" ORDER BY fecha DESC ");
			*/

		}
		/*else if(tipoSeace.equals(TIPO_SEACE_2)){
			sbQuery.append("select doc.cod_doc, '' C_DESETAPA, doc.doc_url, (doc.tamano_bytes) tamano, '' C_ALFARC, TO_CHAR(doc.fec_upload, 'DD/MM/YYYY HH24:MI' ) fec_upload, decode(cod_tipo_doc  , 100, 1 , 150, 2, 2200, 8, 200, 4, 300, 6 ");
			sbQuery.append(", 320, 9, 325, 9, 350, 11, 375, 13, 1800, 12, 400, 29, 450, 21, 2600, 26, 500, 18, 575 , 19, 0) C_TIPDOC, LOWER(ta.EXT_TIPO_FILE) C_EXTARC, ta.icon_tipo_file, doc.doc_nombre, doc.nro_doc from reg_procesos.convocatoria_doc@AIXREGPRODES.SEACE.GOB.PE doc, reg_procesos.tipo_archivo@AIXREGPRODES.SEACE.GOB.PE ta ");// #003 
			sbQuery.append(" where doc.n_convoca=:nidProceso and doc.cod_tipo_file=ta.cod_tipo_file and doc.cod_tipo_doc IN (100, 150, 2200, 200, 300, 320, 325, 350, 375, 1800, 400, 450, 2600, 500, 575)"); // #002
		}
				
		
		*/
		return sbQuery;
	}
 
	
	/*** Inicio 015 - jmatos */
		public static StringBuilder getQueryListaConsultaObservaciones(Long tipoSeace){
			StringBuilder sbQuery = new StringBuilder();
			if(tipoSeace.equals(TIPO_SEACE_3)){
				sbQuery.append("	SELECT formulacio0_.N_ID_FORM , formulacio0_.C_ESTADO, formulacio0_.C_ESTPAR, formulacio0_.C_EXTARCHIVO, TO_CHAR(formulacio0_.D_FECCRE,'DD/MM/YYYY'),	");
				sbQuery.append("	formulacio0_.D_FECMOD, TO_CHAR(formulacio0_.D_FECPRE,'DD/MM/YYYY'), formulacio0_.C_FORMA, formulacio0_.C_HORPRE, formulacio0_.C_JUSMOD, formulacio0_.C_MOTOBS,	");
				sbQuery.append("	formulacio0_.C_NOMARCHIVO, formulacio0_.C_NOMARCALF, formulacio0_.N_NROARCH, formulacio0_.N_ID_REG_PAR, formulacio0_.N_TAMARCHIVO,	");
				sbQuery.append("	formulacio0_.C_TIPFOR, formulacio0_.C_USUCRE, formulacio0_.C_USUMOD, participan1_.C_RUC,participan1_.C_RAZSOC,TO_CHAR(formulacio0_.D_FECCRE,'HH24:MI:SS')   ");
				sbQuery.append("	FROM PRO.TBL_SEL_FORM formulacio0_, PRO.TBL_SEL_REG_PAR participan1_	");
				sbQuery.append("	WHERE (formulacio0_.C_TIPFOR = :tipoFormulacion ) AND(participan1_.N_ID_PUB_CON=:idPublicacion AND formulacio0_.N_ID_REG_PAR=participan1_.N_ID_REG_PAR) AND(formulacio0_.C_ESTPAR LIKE '%%%' ) AND (formulacio0_.C_ESTADO= 'E')	");//Atencion Correo Web - jcarrillo
				sbQuery.append("	ORDER BY formulacio0_.D_FECCRE, formulacio0_.C_HORPRE	");
			}
			return sbQuery;
		}
		
		/*Inicio #036*/		
		public static StringBuilder getQueryListaConsultaObservacionesFE(){
			StringBuilder sbQuery = new StringBuilder();
			
			sbQuery.append(" select fe.N_ID_DET_FORM_FE, par.C_RUC, par.C_RAZSOC, fe.N_NRO, fe.C_TIPFOR, fe.N_ID_SECCION, fe.C_NUMERAL, ");
			sbQuery.append(" fe.C_LITERAL, fe.C_PAGINA, fe.D_FEC_ENVIO, fe.D_FECCRE, fe.C_DESCRIPCION, fe.C_ARTICULO "); 
			sbQuery.append(" from pro.DET_SEL_FORM_FE fe "); 
			sbQuery.append(" JOIN PRO.TBL_SEL_REG_PAR par ON (fe.N_ID_REG_PAR = par.N_ID_REG_PAR) ");
			sbQuery.append(" WHERE fe.C_ESTADO = 'E' ");
			sbQuery.append(" AND par.N_ID_PUB_CON = :idPublicacion ");
			sbQuery.append(" ORDER BY fe.D_FECCRE  ");

			return sbQuery;
		}
		/*Fin #036*/
		
		// Inicio SR-181-2019
		public static StringBuilder getQueryListaConsultaObservacionesCuestionamientoFE(){
			StringBuilder sbQuery = new StringBuilder();
			
			sbQuery.append(" select fe.N_ID_DET_FORM_FE, par.C_RUC, par.C_RAZSOC, fe.N_NRO, fe.C_TIPFOR, fe.N_ID_SECCION, fe.C_NUMERAL, ");
			sbQuery.append(" fe.C_LITERAL, fe.C_PAGINA, fe.D_FEC_ENVIO, fe.D_FECCRE, fe.C_DESCRIPCION, fe.C_ARTICULO "); 
			sbQuery.append(" from pro.DET_SEL_FORM_FE fe "); 
			sbQuery.append(" JOIN PRO.TBL_SEL_REG_PAR par ON (fe.N_ID_REG_PAR = par.N_ID_REG_PAR) ");
			sbQuery.append(" WHERE fe.C_ESTADO = 'E' ");
			sbQuery.append(" AND par.N_ID_PUB_CON = :idPublicacion ");
			sbQuery.append(" AND EXISTS (select * FROM  PRO.TBL_SEL_CUESTIONAMIENTO_FE CU WHERE CU.N_ID_DET_FORM_FE = fe.N_ID_DET_FORM_FE AND CU.C_ESTADO='E') ");
			sbQuery.append(" ORDER BY fe.D_FECCRE  ");

			return sbQuery;
		}
		
		public static StringBuilder getQueryListaCuestionamientosFE(){
			StringBuilder sbQuery = new StringBuilder();
			
			sbQuery.append(" SELECT FE.N_ID_CUEST_FE, PAR.C_RUC, PAR.C_RAZSOC, FE.D_FECENVIO, FE.C_SUSTENTO_ELEV, FE.C_TRANS_LEGAL ");
			sbQuery.append(" FROM PRO.TBL_SEL_CUESTIONAMIENTO_FE FE "); 
			sbQuery.append(" JOIN PRO.TBL_SEL_REG_PAR PAR ON (FE.N_ID_REG_PAR = PAR.N_ID_REG_PAR) "); 
			sbQuery.append(" WHERE FE.C_ESTADO = 'E' ");
			sbQuery.append(" AND FE.N_ID_DET_FORM_FE = :idDetalleFormElec ");
			sbQuery.append(" ORDER BY fe.D_FECCRE ");

			return sbQuery;
		}
		// Fin SR-181-2019
		// Inicio Inc 15-07-19
		public static StringBuilder getQueryListaActividades(){
			StringBuilder sbQuery = new StringBuilder();
			
			sbQuery.append(" SELECT C_REGISTRO FROM PRO.TBL_SEL_ACTIVIDAD ");
			sbQuery.append(" WHERE N_ID_PUB_CON= :idPublicacion AND N_ALIAS=7 AND N_FOREJE=1 "); 
			return sbQuery;
		}
		// Fin Inc 15-07-19
		
	/** Fin 015 - jmatos*/
               /**  014 --> Inicio - MEMORANDO 428-2015/SDP  **/
public static StringBuilder getQueryListaHistorialDatosDelProceso(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			sbQuery.append(" SELECT historiald0_.N_ID_DAPROC_HIS, ");
			sbQuery.append("   historiald0_.C_L_AMATE, ");
			sbQuery.append("   historiald0_.C_T_AMATE, ");
			sbQuery.append("   historiald0_.C_L_APATE, ");
			sbQuery.append("   historiald0_.C_T_APATE, ");
			sbQuery.append("   historiald0_.C_L_CARGO, ");
			sbQuery.append("   historiald0_.C_T_CARGO, ");
			sbQuery.append("   historiald0_.N_ID_DAPROC, ");
			sbQuery.append("   historiald0_.N_L_ESTADO, ");
			sbQuery.append("   historiald0_.N_EDOCU, ");
			sbQuery.append("   historiald0_.N_T_ESTADO, ");
			sbQuery.append("   historiald0_.D_L_FECHA, ");
			sbQuery.append("   historiald0_.D_T_FECHA, ");
			sbQuery.append("   historiald0_.C_L_ID_DOC, ");
			sbQuery.append("   historiald0_.C_T_ID_DOC, ");
			sbQuery.append("   historiald0_.N_IND, ");
			sbQuery.append("   historiald0_.N_CODMON, ");
			sbQuery.append("   historiald0_.C_MONTO, ");
			sbQuery.append("   historiald0_.C_L_NOMBR, ");
			sbQuery.append("   historiald0_.C_NOMORGAN, ");
			sbQuery.append("   historiald0_.C_T_NOMBR, ");
			sbQuery.append("   historiald0_.C_L_NINFO, ");
			sbQuery.append("   historiald0_.C_NDOCU, ");
			sbQuery.append("   historiald0_.C_NUMSIG, ");
			sbQuery.append("   historiald0_.C_OBSER, ");
			sbQuery.append("   historiald0_.C_PERIO, ");
			sbQuery.append("   historiald0_.C_TIPCAM, ");
			sbQuery.append("   historiald0_.C_TDISP, ");
			sbQuery.append("   historiald0_.C_L_TIPDOC, ");
			sbQuery.append("   historiald0_.C_T_TIPDOC ");
			sbQuery.append(" FROM PRO.TBL_ACT_DATOS_PROCESO_HIS historiald0_ ");
			sbQuery.append(" WHERE (historiald0_.N_ID_DAPROC = :idDatosProceso ) ");
		}
		return sbQuery;
        	}
                /**  Fin - MEMORANDO 428-2015/SDP  **/
				
				
	// Inicio  #028 tchacon			
	/** Obtener Nombre Consorcio **/
	public static StringBuilder getQueryConsorcio(Long tipoSeace){
	StringBuilder sbQuery = new StringBuilder();
	if(tipoSeace.equals(TIPO_SEACE_3)){
	sbQuery.append(" select con.N_ID_CONSORCIO,con.C_NOMCONS, con.N_ID_PROPUESTA from pro.tbl_sel_consorcio con  WHERE  con.n_id_propuesta= :identificador ");
	}else if(tipoSeace.equals(TIPO_SEACE_2)){
	sbQuery.append("  select COD_CONSORCIO,DES_CONSORCIO,N_PROPUESTA from reg_procesos.consorcio@aixregprodes.seace.gob.pe WHERE COD_CONSORCIO=:identificador ");
	}
	return sbQuery;
	}
	// Inicio  #028 tchacon
	
	
	 /**Inicio 029*/
	public static StringBuilder getDocumentosPorExpediente(Long tipoSeace){
		StringBuilder sbQuery = new StringBuilder();
		if(tipoSeace.equals(TIPO_SEACE_3)){
			 sbQuery.append(" SELECT o.C_EXTARC,o.C_ID_DOC_EXP,o.C_NOMARC,o.N_TAMARC FROM PRO.TBL_ACT_EXP_DOC o ");
		     sbQuery.append(" WHERE o.N_ID_EXPEDE = :idExpediente and o.C_ID_DATCAT= 'TDE17' ");
		}
		
			return sbQuery;
	}

	/**Fin 029*/
	/*#039 - Inicio - SM-268-2019*/
	public static StringBuilder getQueryListaPropuesta(String tipoObjeto) {
		StringBuilder sbQuery = new StringBuilder();
		/*CORECCION SM -268-2019 -*/
		sbQuery.append(" SELECT DISTINCT ");
		sbQuery.append(" n_id_propuesta,n_id_reg_par, fec_prop, usu_prop, fecmo_prop, usumo_prop, c_fecing, c_mype, c_empdisc, c_estadoreg, ");
		sbQuery.append(" c_estadopre, c_motobs, c_justificacion, c_calpre, c_tippro, d_fecenv, c_indcon, c_forma, c_horing, n_id_rep_legal, fec_repr, ");
		sbQuery.append(" usu_repr, fecmo_repr, usumo_repr, tipdoc_repr, c_numdoc, c_nombre, c_apepat, c_apemat, idprop_repr, c_estreg, c_ruc, c_razsoc, ");
		//sbQuery.append(" tipdoc_par ,c_nomcons,orden FROM ( ");
		sbQuery.append(" tipdoc_par ,c_nomcons FROM ( ");
		sbQuery.append(" select   ");
		sbQuery.append(" prop.n_id_propuesta, prop.n_id_reg_par,prop.d_feccre AS fec_prop,prop.c_usucre AS usu_prop,prop.d_fecmod AS fecmo_prop, ");
		sbQuery.append("  prop.c_usumod AS usumo_prop,prop.c_fecing,prop.c_mype,prop.c_empdisc,prop.c_estadoreg,prop.c_estadopre,prop.c_motobs, ");
		sbQuery.append(" prop.c_justificacion,prop.c_calpre,prop.c_tippro,prop.d_fecenv,prop.c_indcon,prop.c_forma,prop.c_horing, ");
		sbQuery.append(" re.n_id_rep_legal, re.d_feccre AS fec_repr,re.c_usucre AS usu_repr,re.d_fecmod AS fecmo_repr,re.c_usumod AS usumo_repr,re.c_tipdoc AS tipdoc_repr, ");
		sbQuery.append(" re.c_numdoc,re.c_nombre,re.c_apepat,re.c_apemat,re.n_id_propuesta AS idprop_repr,re.c_estreg,par.c_ruc,par.c_razsoc, ");
		sbQuery.append(" par.c_tipdoc AS tipdoc_par,oto.c_ordpreinicial,item.n_estpro,  CONSOR.c_nomcons,");
		//sbQuery.append(" ROW_NUMBER() OVER (PARTITION BY item.N_ID_ITEM ORDER BY nvl(oto.oto.C_ORDPREFINAL,oto.C_ORDPREINICIAL) asc ) AS orden,par.C_INTCON ");
		sbQuery.append("  nvl(oto.C_ORDPREFINAL,oto.C_ORDPREINICIAL) AS orden,par.C_INTCON ");
		sbQuery.append(" from pro.TBL_SEL_PROPUESTA  PROP ");
		sbQuery.append(" LEFT JOIN pro.TBL_SEL_CONSORCIO CONSOR ON CONSOR.N_ID_PROPUESTA=prop.n_id_propuesta");
		sbQuery.append(" LEFT JOIN pro.TBL_SEL_REG_PAR par ON prop.N_ID_REG_PAR =par.N_ID_REG_PAR  ");
		sbQuery.append(" LEFT JOIN pro.TBL_SEL_PUB_CON PUB ON PUB.N_ID_PUB_CON=Par.N_ID_PUB_CON ");
		sbQuery.append(" LEFT JOIN pro.det_sel_propuesta det ON det.n_id_propuesta = prop.n_id_propuesta  ");
		sbQuery.append(" LEFT JOIN pro.tbl_act_item item ON item.n_id_item = det.n_id_item AND (item.n_estpro = '4' OR ITEM.N_ESTPRO='19' OR ITEM.N_ESTPRO='22') ");
		sbQuery.append(" LEFT JOIN pro.tbl_sel_otor_item oto ON oto.n_id_det_prop = det.n_id_det_prop ");
		sbQuery.append(" LEFT JOIN pro.tbl_sel_rep_legal re ON re.n_id_propuesta = prop.n_id_propuesta ");
		sbQuery.append(" WHERE PUB.N_ID_PUB_CON=:idPublicacion and C_TIPPRO='PP' AND c_ordpreinicial IS NOT NULL and PAR.C_ESTPAR='V' and item.n_estpro is not null ) WHERE orden >0 ");

		if (tipoObjeto.equals("Bien") || tipoObjeto.equals("Servicio")) {// BIEN y SERVICIOS
			sbQuery.append(" AND orden<=2 ");
		} else {
			if (tipoObjeto.equals("Obra")) {// OBRA
				sbQuery.append(" AND orden<=4");
			} else {
				if (tipoObjeto.equals("Consultoría de Obra")) {//CONSULTORIA

				}
			}
		}
		//sbQuery.append(" order by orden asc ");
		return sbQuery;
	}
	
	public static StringBuilder getQueryListaPropuestaDetalle() {
		StringBuilder sbQuery = new StringBuilder();
		sbQuery.append("select PROP.N_ID_PROPUESTA,PROP.N_ID_REG_PAR,PROP.D_FECCRE as FEC_PROP,PROP.C_USUCRE as USU_PROP,PROP.D_FECMOD as FECMO_PROP,PROP.C_USUMOD as USUMO_PROP,PROP.C_FECING,PROP.C_MYPE,PROP.C_EMPDISC, ");
		sbQuery.append("PROP.C_ESTADOREG,PROP.C_ESTADOPRE,PROP.C_MOTOBS, ");
		sbQuery.append("PROP.C_JUSTIFICACION,PROP.C_CALPRE,PROP.C_TIPPRO,PROP.D_FECENV,PROP.C_INDCON,PROP.C_FORMA,PROP.C_HORING, "); 
		sbQuery.append("RE.N_ID_REP_LEGAL, RE.D_FECCRE as FEC_REPR, RE.C_USUCRE as USU_REPR, RE.D_FECMOD as FECMO_REPR, RE.C_USUMOD as USUMO_REPR, RE.C_TIPDOC as TIPDOC_REPR, RE.C_NUMDOC, RE.C_NOMBRE, ");
		sbQuery.append("RE.C_APEPAT, RE.C_APEMAT, RE.N_ID_PROPUESTA as IDPROP_REPR, RE.C_ESTREG, ");
		sbQuery.append("par.c_ruc,par.c_razsoc, par.C_TIPDOC as TIPDOC_PAR ");
		sbQuery.append("from pro.tbl_sel_propuesta PROP ");
		sbQuery.append("inner join pro.TBL_SEL_REG_PAR PAR on prop.n_id_reg_par=par.n_id_reg_par "); 
		sbQuery.append("inner join pro.TBL_SEL_REP_LEGAL RE on re.n_id_propuesta =prop.n_id_propuesta "); 
		sbQuery.append("where prop.n_id_propuesta=:idPropuesta ");
		
		return sbQuery;
	}
	public static StringBuilder getQueryValorListado() {
		StringBuilder sbQuery = new StringBuilder();
		sbQuery.append("select c_nombre from pro.TBL_CNF_VALOR_LISTADO where n_id_vallistado=:idvallistado and n_estado=1 ");
		
		return sbQuery;
	}
	
	public static StringBuilder getQueryListaArchivosPropuesta() {
		StringBuilder sbQuery = new StringBuilder();
		sbQuery.append("select * from pro.DET_SEL_ARCH_GENE where n_id_propuesta=:idPropuesta and C_ESTREG='V' ");

		return sbQuery;
	}
	
	public static StringBuilder getQueryListaItemOferta(String tipoObjeto) {
		StringBuilder sbQuery = new StringBuilder();
		sbQuery.append(" SELECT item.n_id_item, item.C_DSITEM, item.C_CANTID, item.C_VRETOT,det.C_CANTOFER, det.C_MONTOFER, ");
		sbQuery.append(" ARCH1.C_NOMARCHIVO,ARCH1.C_EXTARCHIVO,ARCH1.C_NOMARCALF,ARCH1.N_TAMARCHIVO,det.C_PROSEL, ");
		sbQuery.append(" ARCH2.C_NOMARCHIVO AS C_NOMARCHIVO_2,ARCH2.C_EXTARCHIVO AS C_EXTARCHIVO_2,ARCH2.C_NOMARCALF AS C_NOMARCALF_2,ARCH2.N_TAMARCHIVO AS N_TAMARCHIVO_2, item.c_nroitem ");//Id.042:cinonan
		sbQuery.append(" from pro.det_sel_propuesta DET ");
		sbQuery.append(" LEFT JOIN pro.tbl_act_item item ON item.n_id_item = det.n_id_item ");
		sbQuery.append(" LEFT JOIN( ");
		sbQuery.append("   SELECT  AR.N_ID_DET_PROP,AR.C_NOMARCHIVO,AR.C_EXTARCHIVO,AR.C_NOMARCALF,AR.N_TAMARCHIVO ");
		sbQuery.append("   from pro.det_sel_propuesta DET1 ");
		sbQuery.append("   left join pro.DET_SEL_ARCH_PROP AR on det1.N_ID_DET_PROP=AR.N_ID_DET_PROP AND AR.C_ESTREG='V' ");
		sbQuery.append("   where DET1.n_id_propuesta IN (:idPropuesta) AND AR.C_TIPARC='E' ");
		sbQuery.append(" ) ARCH1 on det.N_ID_DET_PROP=ARCH1.N_ID_DET_PROP ");
		sbQuery.append(" LEFT JOIN( ");
		sbQuery.append("   SELECT  AR.N_ID_DET_PROP,AR.C_NOMARCHIVO,AR.C_EXTARCHIVO,AR.C_NOMARCALF,AR.N_TAMARCHIVO ");
		sbQuery.append("   from pro.det_sel_propuesta DET2 ");
		sbQuery.append("   left join pro.DET_SEL_ARCH_PROP AR on det2.N_ID_DET_PROP=AR.N_ID_DET_PROP AND AR.C_ESTREG='V' ");
		sbQuery.append("   where DET2.n_id_propuesta IN (:idPropuesta) AND AR.C_TIPARC='P' ");
		sbQuery.append(" ) ARCH2 on det.N_ID_DET_PROP=ARCH2.N_ID_DET_PROP ");
		sbQuery.append(" where DET.n_id_propuesta IN (:idPropuesta) and item.n_id_item in( ");
		sbQuery.append("     select n_id_item from( select prop.n_id_propuesta, item2.n_id_item,nvl(oto.C_ORDPREFINAL,oto.C_ORDPREINICIAL) AS orden ");
		sbQuery.append("     from pro.TBL_SEL_PROPUESTA  PROP LEFT JOIN pro.det_sel_propuesta det3 ON det3.n_id_propuesta = prop.n_id_propuesta ");
		sbQuery.append("     LEFT JOIN pro.tbl_act_item item2 ON item2.n_id_item = det3.n_id_item AND (item2.n_estpro = '4' OR ITEM2.N_ESTPRO='19' OR ITEM2.N_ESTPRO='22') ");
		sbQuery.append("     LEFT JOIN pro.tbl_sel_otor_item oto ON oto.n_id_det_prop = det3.n_id_det_prop  " );
		sbQuery.append("     WHERE  C_TIPPRO='PP' AND c_ordpreinicial IS NOT NULL and item2.n_estpro is not null and prop.n_id_propuesta=:idPropuesta) ");
		sbQuery.append("WHERE orden >0  ");
		if (tipoObjeto.equals("Bien") || tipoObjeto.equals("Servicio")) {// BIEN y SERVICIOS
			sbQuery.append(" AND orden<=2 ");
		} else {
			if (tipoObjeto.equals("Obra")) {// OBRA
				sbQuery.append(" AND orden<=4");
			} else {
				if (tipoObjeto.equals("Consultoría de Obra")) {//CONSULTORIA

				}
			}
		}
		sbQuery.append(")  ");
		return sbQuery;
	}

	public static StringBuilder getQueryListaConsorcioOferta() {
		StringBuilder sbQuery = new StringBuilder();
		sbQuery.append(" SELECT con.C_USUCRE,par.C_RAZSOC,Val.C_NOMBRE, DETCON.C_PORCENTAJE,UBI.C_DESUBI,DETCON.C_MYPE,DETCON.C_EMPDISC, par.C_RUC FROM pro.TBL_SEL_CONSORCIO CON ");//Id.042:cinonan
		sbQuery.append(" LEFT JOIN pro.DET_SEL_CONSORCIO DETCON ON CON.N_ID_CONSORCIO=DETCON.N_ID_CONSORCIO  ");
		sbQuery.append(" LEFT JOIN pro.TBL_SEL_REG_PAR PAR ON PAR.N_ID_REG_PAR =DETCON.N_ID_REG_PAR ");
		sbQuery.append(" LEFT JOIN adm.TBL_ADM_UBIGEO UBI ON TO_CHAR(UBI.C_CODUBI) = TO_CHAR(DETCON.N_ID_PAIS) ");
		sbQuery.append(" LEFT JOIN pro.TBL_CNF_VALOR_LISTADO VAL ON VAL.N_ID_VALLISTADO=DETCON.C_REGRNP ");
		sbQuery.append(" WHERE N_ID_PROPUESTA=:idPropuesta ");
		return sbQuery;
	}
	/*#039 - Fin - SM-268-2019*/
	
	/* Inicio bse01 */
	public static StringBuilder getQueryListaGenericoETO(GenericoETOType genericoETOType) {
		StringBuilder sbQuery = new StringBuilder();
		sbQuery.append("select ");
		sbQuery.append(genericoETOType.getValue() + ", "); 
		sbQuery.append("C_NOMARCHIVO, C_EXTARCHIVO, N_TAMARCHIVO, C_NOMARCALF, D_FECCRE "); 
		sbQuery.append("from ");
		sbQuery.append(genericoETOType.getKey() + " ");
		sbQuery.append("where N_ID_ITEM = :idItem ");
		sbQuery.append("and C_ESTADO = :estado ");
		sbQuery.append("order by ");
		sbQuery.append(genericoETOType.getValue() + " ");
		sbQuery.append("asc ");
		return sbQuery;
	}
	
	public static StringBuilder getQueryListaParticularActualizacionETO() {
		StringBuilder sbQuery = new StringBuilder();		
		sbQuery.append("select N_ID_EXP_ACTU_ETO, N_TIP_DOC_APROB, C_NUM_DOC_APROB, ");
		sbQuery.append("D_FEC_APROB, D_FECCRE, C_NOM_ARCH_APROB, C_UUID_ARCH_APROB, N_TAM_ARCH_APROB ");
		sbQuery.append("from pro.DET_ACT_EXP_ETO_ACTU ");
		sbQuery.append("where n_id_exp_eto = :idExpEto ");
		sbQuery.append("order by n_id_exp_actu_eto ASC ");			
		return sbQuery;
	}
	
	public static StringBuilder getQueryListaParticularArchivoOS() {
		StringBuilder sbQuery = new StringBuilder();
		sbQuery.append("select N_ID_ETO_ARCH, C_NOMBRE, '' AS EXTENSION, N_TAMANIO, C_UUID, D_FECCRE "); 
		sbQuery.append("from PRO.DET_ACT_ETO_ARCH ");
		sbQuery.append("where n_id_exp_eto = :idExpEto "); 
		sbQuery.append("order by N_ID_ETO_ARCH ASC ");		
			
		return sbQuery;
	}
	
	
	public static StringBuilder getQueryListaParticularPresupuestoETO() {
		StringBuilder sbQuery = new StringBuilder();		
		sbQuery.append("select N_ID_ETO_PRESUPUESTO, C_NOMARCHIVO, C_EXTARCHIVO, N_TAMARCHIVO, C_NOMARCALF, D_FECCRE, D_FECPRESUESTO ");
		sbQuery.append("from pro.DET_SEL_ARCH_ETO_PRESUPUESTO ");
		sbQuery.append("where N_ID_ITEM = :idItem ");
		sbQuery.append("and C_ESTADO = :estado ");
		sbQuery.append("order by N_ID_ETO_PRESUPUESTO asc ");		
		return sbQuery;
	}
	
	public static StringBuilder getQueryListaParticularEstudiosETO() {
		StringBuilder sbQuery = new StringBuilder();		
		sbQuery.append("select N_ID_ETO_ESTTEC, C_NOMARCHIVO, C_EXTARCHIVO, N_TAMARCHIVO, C_NOMARCALF, D_FECCRE, C_NOMESTUDIO ");
		sbQuery.append("from pro.DET_SEL_ARCH_ETO_ESTTEC ");
		sbQuery.append("where N_ID_ITEM = :idItem ");
		sbQuery.append("and C_ESTADO = :estado ");
		sbQuery.append("order by N_ID_ETO_ESTTEC asc ");

		return sbQuery;
	}
	
	
	public static StringBuilder getQueryListaParticularLicenciasETO() {
		StringBuilder sbQuery = new StringBuilder();		
		sbQuery.append("select N_ID_ETO_LICEN, C_NOMARCHIVO, C_EXTARCHIVO, N_TAMARCHIVO, C_NOMARCALF, D_FECCRE, D_NOMDOCUMENTO ");
		sbQuery.append("from pro.DET_SEL_ARCH_ETO_LICEN ");
		sbQuery.append("where N_ID_ITEM = :idItem ");
		sbQuery.append("and C_ESTADO = :estado ");
		sbQuery.append("order by N_ID_ETO_LICEN asc ");
		return sbQuery;
	}
	
	public static StringBuilder getQueryListaParticularOtrosDocsETO() {
		StringBuilder sbQuery = new StringBuilder();		
		sbQuery.append("select N_ID_ETO_ODOCUM, C_NOMARCHIVO, C_EXTARCHIVO, N_TAMARCHIVO, C_NOMARCALF, D_FECCRE, D_NOMDOCUMENTO ");
		sbQuery.append("from pro.DET_SEL_ARCH_ETO_ODOCUM ");
		sbQuery.append("where N_ID_ITEM = :idItem ");
		sbQuery.append("and C_ESTADO = :estado ");
		sbQuery.append("order by N_ID_ETO_ODOCUM asc ");

		return sbQuery;
	}
	
	/* Fin bse01 */
}


