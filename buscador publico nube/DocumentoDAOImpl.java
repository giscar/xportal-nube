package pe.gob.osce.seace.publico.ejb.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.rmi.CORBA.Util;

import pe.gob.osce.seace.buscadores.adm.vo.ConvocatoriaVO;
import pe.gob.osce.seace.buscadores.adm.vo.CronogramaVO;
import pe.gob.osce.seace.buscadores.adm.vo.DatosDelProcesoVO;
import pe.gob.osce.seace.buscadores.adm.vo.DocumentoAccionVO;
import pe.gob.osce.seace.buscadores.adm.vo.DocumentoProcedimientoVO;
import pe.gob.osce.seace.buscadores.adm.vo.DocumentoVO;
import pe.gob.osce.seace.buscadores.adm.vo.DocumentosConvocatoriaVO;
/** 005 --> Inicio - MEMORANDO 428-2015/SDP **/ 
import pe.gob.osce.seace.buscadores.adm.vo.HistorialDatosDelProceso;
/**  Fin - MEMORANDO 428-2015/SDP **/
import pe.gob.osce.seace.buscadores.adm.vo.NotificacionAccionVO;
import pe.gob.osce.seace.buscadores.bus.state.EstadoDocumentoProcedimientoState;
import pe.gob.osce.seace.buscadores.bus.type.EtapaConfiguradorType;
import pe.gob.osce.seace.buscadores.bus.type.EtapaCronogramaType;
import pe.gob.osce.seace.buscadores.bus.type.TipoDocumentoConvocatoriaType;
import pe.gob.osce.seace.publico.ejb.dao.DocumentoDAOLocal;
import pe.gob.osce.seace.publico.ejb.utils.QueryUtils;
import pe.gob.osce.seace.publico.ejb.utils.Utils;

/**
 * Session Bean implementation class DocumentoDAOImpl
 */
/***********
 * 	Modificación
 *  ======================================================
 *  Id		autor		fecha		Descripción
 *  ======================================================
 *  001     rramos		23/10/2014	Se modifica por incidencia 24 del 11/09/2014
 *  002     rramos		27/10/2014	Se modifica por incidencia 24 del 11/09/2014
 *  003     rramos		14/11/2014	Visualizar acciones Postergacion y Fe de Errata
 *  004     tchacon		20/01/2015	Se Agrega historial de documentos
 *  005     gtintaya    30/06/2015  Se Visualiza documentos en la opcion "Ver documentos del Procedimiento".
 *  006     vbaldeon    01/08/2016  SOL. MANT. N°024-2016      Agregar un documento de actos   
 *  007 	Dante Artica 04/07/2017 Consultoria de Pronunciamiento*
 *  008		ndiaz		19/11/2019	Mostrar un historial de versiones de la etapa de Absolución de consultas y observaciones e integración de bases en el buscador público.
 * ********/
@Stateless
public class DocumentoDAOImpl implements DocumentoDAOLocal{

	@PersistenceContext(unitName = "pe.gob.osce.seace.buscadores.bus.model")
	private EntityManager em;
	 /**  004  INICIO */
	private List<Object[]> listaObjeto3=null;
	 /**  004  FIN */
    /**
     * Default constructor. 
     */
    public DocumentoDAOImpl() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public List<DocumentoVO> obtenerListaDocumentosProceso(Long nidProceso,
			Long nidSistema) throws Exception {
		// TODO Auto-generated method stub
		List<DocumentoVO> listaDocumento = new ArrayList();
		StringBuilder sbQuery = new StringBuilder();
		sbQuery = QueryUtils.getQueryDocumentosProceso(nidSistema);
		
		Query consulta = em.createNativeQuery(sbQuery.toString());
		consulta.setParameter("nidProceso", nidProceso);
		List<Object[]> listaObjeto = consulta.getResultList();
		
		/** inicio #001*/
		if(nidSistema.equals(QueryUtils.TIPO_SEACE_2)){
			sbQuery = QueryUtils.getQueryEnlacesResolucionTribunal(nidSistema);
			consulta = em.createNativeQuery(sbQuery.toString());
			consulta.setParameter("nidProceso", nidProceso);
			List<Object[]> listaObjeto2 = consulta.getResultList();
			if(listaObjeto!=null && listaObjeto2!=null){
				listaObjeto.addAll(listaObjeto2);
			} else if (listaObjeto==null && listaObjeto2!=null){
				listaObjeto=listaObjeto2;
			}
		}
		/** fin #001*/
		
		 /**  004  INICIO */	
			
		if(nidSistema.equals(QueryUtils.TIPO_SEACE_3)){
			sbQuery = QueryUtils.getQueryDocumentosInactivos(nidSistema);
			consulta = em.createNativeQuery(sbQuery.toString());
			consulta.setParameter("nidProceso", nidProceso);
			listaObjeto3 = consulta.getResultList();
		}
		 /**  004  FIN */
		
		if (listaObjeto != null) {
            for (int i = 0; i < listaObjeto.size(); i++) {
                Object obj[] = listaObjeto.get(i);
                DocumentoVO documentoVO = new DocumentoVO();
                documentoVO.setNumber(new Long(i+1));
                
                if(obj[0] != null)                
                	documentoVO.setIdCronograma(Long.valueOf(obj[0].toString()));
                
                
                documentoVO.setIdAlias(obj[1] != null ? Long.valueOf(obj[1].toString()) : null);
                
                if(nidSistema.equals(QueryUtils.TIPO_SEACE_3))
                	documentoVO.setEtapaDescripcion(obj[1]!=null?EtapaConfiguradorType.get(Integer.parseInt(obj[1].toString())).getValue() : null);
                else
                	documentoVO.setEtapaDescripcion(obj[1] != null ? obj[1].toString() : null);
                               
                /** Verificar Rutas Alternas de posibles documentos perdidos */
                if(nidSistema.equals(QueryUtils.TIPO_SEACE_2)){ //Verificar solo en casos de SEACE v2.0
                	String status = "";
                	if(obj[2] != null ){
                		status = Utils.getEstado(obj[2].toString().replace(" ", "%20"));
                		//Si no existe verificar en zonasegura/particion1
                		if(!status.equals("SI_EXISTE")){ 
                    		//status = Utils.getEstado(obj[2].toString().replace("http://zonasegura.seace.gob.pe/","http://zonasegura.seace.gob.pe/particion1/").replace(" ","%20"));
                    		status = Utils.getEstado(obj[2].toString().replace("https://zonasegura2.seace.gob.pe/documentos/","https://zonasegura2.seace.gob.pe/particion1/").replace(" ","%20"));
                    		//documentoVO.setDocumentoDescripcion(obj[2].toString().replace("http://zonasegura.seace.gob.pe/","http://zonasegura.seace.gob.pe/particion1/").replace(" ","%20"));
                    		documentoVO.setDocumentoDescripcion(obj[2].toString().replace("https://zonasegura2.seace.gob.pe/documentos/","https://zonasegura2.seace.gob.pe/particion1/").replace(" ","%20"));
                		}else{// Si existe documento
                    		documentoVO.setDocumentoDescripcion(obj[2].toString().replace(" ", "%20"));
                    	}
                	}
                }else{
                	documentoVO.setDocumentoDescripcion(obj[2] != null ? obj[2].toString() : null);	
                }
                documentoVO.setTamanioDocumento(obj[3]!=null?obj[3].toString() : null);
                documentoVO.setCodDocumentoAlfresco(obj[4]!=null?obj[4].toString() : null);
                documentoVO.setFechaPublicacion(obj[5]!=null?obj[5].toString() : null);
                documentoVO.setTipoDocumento(obj[6] != null ? obj[6].toString():null);
                /**  004  INICIO */
				/*#008 Inicio - SM-262-2019  VER HISTORIAL: ABSOLUCION E INTEGRACION*/
                if(listaObjeto3 !=null){
                for (int j = 0; j < listaObjeto3.size(); j++) {
                	Object obj2[] = listaObjeto3.get(j);

					if(documentoVO.getTipoDocumento().equals(obj2[0].toString()) ){
						documentoVO.setVerHistorial(true);
					}
                }
                }
				/*#008 Fin - SM-262-2019*/
                /**  004  FIN */
               	documentoVO.setTipoDocumentoDescripcion(TipoDocumentoConvocatoriaType.get(obj[6].toString()).getValue());
               	documentoVO.setExtensionDocumento(obj[7] != null ? obj[7].toString() : null);

               	/** inicio #001*/
               	if(nidSistema.equals(QueryUtils.TIPO_SEACE_2)){
               		documentoVO.setNombreDocumento(obj[9] != null ? obj[9].toString() : null);
               		documentoVO.setNumeroDocumento(obj[10] != null ? obj[10].toString() : null);
               	}
               	/** fin #001*/
                /**
                * Inicio 007 Dante Artica
  				*/
                if(nidSistema.equals(QueryUtils.TIPO_SEACE_3)){
                	documentoVO.setInstanciaPronunciamientoDescripcion(obj[8] != null ? obj[8].toString() : null);
            	}
				/**
  				* Fin 007 Dante Artica
  				*/
                listaDocumento.add(documentoVO);
            }
        }
		return listaDocumento;
	}
	
	/** inicio #002*/
	@Override
	public List<DocumentoAccionVO> obtenerListaDocumentosAcciones(Long nidProceso,
			Long nidSistema) throws Exception {
		if(nidSistema.equals(QueryUtils.TIPO_SEACE_3)){
			return null;
		}
			
		List<DocumentoAccionVO> listaDocumento = new ArrayList();
		StringBuilder sbQuery = new StringBuilder();
		sbQuery = QueryUtils.getQueryAcciones(nidSistema);
		Query consulta = em.createNativeQuery(sbQuery.toString());
		consulta.setParameter("nidProceso", nidProceso);
		List<Object[]> listaObjeto = consulta.getResultList();
		int numFila = 0;
		if (listaObjeto != null) {
            for (int i = 0; i < listaObjeto.size(); i++) {
            	numFila++;
                Object obj[] = listaObjeto.get(i);
                DocumentoAccionVO documentoAccionVO = new DocumentoAccionVO();
                documentoAccionVO.setNumber(new Long(numFila));
                documentoAccionVO.setTipoDocumentoDescripcion(obj[0] != null ? obj[0].toString():null);                
                documentoAccionVO.setFechaUpload(obj[1] != null ? obj[1].toString():null);
                documentoAccionVO.setObservacion(obj[2] != null ? obj[2].toString():null);
                documentoAccionVO.setCodigoTipoDocumento("ACC");                
                listaDocumento.add(documentoAccionVO);
            }
		}
		
		sbQuery = QueryUtils.getQueryDocumentosAcciones(nidSistema);		
		consulta = em.createNativeQuery(sbQuery.toString());
		consulta.setParameter("nidProceso", nidProceso);
		listaObjeto = consulta.getResultList();
		
		int cantCodTipDoc100 = 0;
		int cantCodTipDoc150 = 0;
		if (listaObjeto != null) {
            for (int i = 0; i < listaObjeto.size(); i++) {
            	numFila++;
                Object obj[] = listaObjeto.get(i);
                DocumentoAccionVO documentoAccionVO = new DocumentoAccionVO();
                documentoAccionVO.setNumber(new Long(numFila));
                documentoAccionVO.setNombreDocumentoObservacion(obj[0] != null ? obj[0].toString():null);
                documentoAccionVO.setTipoDocumentoDescripcion(obj[1] != null ? obj[1].toString():null);
                documentoAccionVO.setFechaUpload(obj[2] != null ? obj[2].toString():null);
                
                /** Verificación de documentos .... */
                if(nidSistema.equals(QueryUtils.TIPO_SEACE_2)){ //Verificar solo en casos de SEACE v2.0
                	String status = "";
                	if(obj[3] != null ){
                		status = Utils.getEstado(obj[3].toString().replace(" ", "%20"));
                		//Si no existe verificar en zonasegura/particion1
                		if(!status.equals("SI_EXISTE")){ 
                    		//status = Utils.getEstado(obj[3].toString().replace("http://zonasegura.seace.gob.pe/","http://zonasegura.seace.gob.pe/particion1/").replace(" ","%20"));
                    		//documentoAccionVO.setUrlDocumento(obj[3].toString().replace("http://zonasegura.seace.gob.pe/","http://zonasegura.seace.gob.pe/particion1/").replace(" ","%20"));
                    		status = Utils.getEstado(obj[3].toString().replace("https://zonasegura2.seace.gob.pe/documentos/","https://zonasegura2.seace.gob.pe/particion1/").replace(" ","%20"));
                    		documentoAccionVO.setUrlDocumento(obj[3].toString().replace("https://zonasegura2.seace.gob.pe/documentos/","https://zonasegura2.seace.gob.pe/particion1/").replace(" ","%20"));
                		}else{// Si existe documento
                    		documentoAccionVO.setUrlDocumento(obj[3].toString().replace(" ", "%20"));
                    	}
                	}
                }else{
                	documentoAccionVO.setUrlDocumento(obj[3] != null ? obj[3].toString():null);	
                }
                
                
                documentoAccionVO.setCodigoTipoDocumento(obj[4] != null ? obj[4].toString():null);
                documentoAccionVO.setIconoTipoDocumento(obj[5] != null ? obj[5].toString():null);
                documentoAccionVO.setNombreDocumento(obj[6] != null ? obj[6].toString():null);
                documentoAccionVO.setCodigoTipoFile(obj[7] != null ? obj[7].toString():null);
                documentoAccionVO.setObservacion(obj[8] != null ? obj[8].toString():null);
                
                //para no mostrar la primera version de las bases
                if(documentoAccionVO.getCodigoTipoDocumento()!=null && "100".equals(documentoAccionVO.getCodigoTipoDocumento())){
                	cantCodTipDoc100++;
                	if(cantCodTipDoc100==1){
                		numFila--;
                		continue;
                	}
                }
              //para diferenciar la primera version del resumene ejecutivo de posibilidades que ofrece el mercado
                if(documentoAccionVO.getCodigoTipoDocumento()!=null && "150".equals(documentoAccionVO.getCodigoTipoDocumento())){
                	cantCodTipDoc150++;
                	if(cantCodTipDoc150==1){
                		documentoAccionVO.setPrimerCodTipDoc150(true);
                	}else{
                		documentoAccionVO.setPrimerCodTipDoc150(false);
                	}
                }
                
                listaDocumento.add(documentoAccionVO);
            }
        }
		return listaDocumento;
	}
	
	@Override
	public List<NotificacionAccionVO> obtenerListaNotificacionesAcciones(Long nidProceso,
			Long nidSistema, int cantDocumentos) throws Exception {
		if(nidSistema.equals(QueryUtils.TIPO_SEACE_3)){
			return null;
		}
			
		List<NotificacionAccionVO> listaDocumento = new ArrayList();
		StringBuilder sbQuery = new StringBuilder();
		sbQuery = QueryUtils.getQueryNotificacionesAcciones(nidSistema);
		
		Query consulta = em.createNativeQuery(sbQuery.toString());
		consulta.setParameter("nidProceso", nidProceso);
		List<Object[]> listaObjeto = consulta.getResultList();
		
		int cantCodTipDoc100 = 0;
		int cantCodTipDoc150 = 0;
		if (listaObjeto != null) {
            for (int i = 0; i < listaObjeto.size(); i++) {
            	cantDocumentos++;
                Object obj[] = listaObjeto.get(i);
                NotificacionAccionVO notificacionAccionVO = new NotificacionAccionVO();
                notificacionAccionVO.setNumber(new Long(cantDocumentos));
                notificacionAccionVO.setNumNotificacion(obj[0] != null ? obj[0].toString():null);
                notificacionAccionVO.setAnhoNotificacion(obj[1] != null ? obj[1].toString():null);
                listaDocumento.add(notificacionAccionVO);
            }
        }
		return listaDocumento;
	}
		
	/** fin #002*/
		
	@Override
	public List<DocumentosConvocatoriaVO> obtenerListaDocumentosConvocatoria(Long idConvocatoria,
			Long nidSistema) throws Exception {
					
		List<DocumentosConvocatoriaVO> listaDocumento = new ArrayList<DocumentosConvocatoriaVO>();
		StringBuilder sbQuery = new StringBuilder();
		sbQuery = QueryUtils.getQueryDocumentosConvocatoria(nidSistema);
		if(sbQuery!=null){
			Query consulta = em.createNativeQuery(sbQuery.toString());
			consulta.setParameter("idConvocatoria", idConvocatoria);
			List<Object[]> listaObjeto = consulta.getResultList();			

			if (listaObjeto != null) {
	            for (int i = 0; i < listaObjeto.size(); i++) {	            	
	                Object obj[] = listaObjeto.get(i);	                
	                DocumentosConvocatoriaVO documentosConvocatoriaVO = new DocumentosConvocatoriaVO();
	        		if (obj[0] != null) {
	        			documentosConvocatoriaVO.setId(Long.valueOf(obj[0].toString()));
	        		}
	        		if (obj[1] != null) {
	        			documentosConvocatoriaVO.setTipoDocumento(obj[1].toString());
	        		}
	        		if (obj[2] != null) {
	        			documentosConvocatoriaVO.setNombreArchivo(obj[2].toString());
	        		}
	        		if (obj[3] != null) {
	        			documentosConvocatoriaVO.setTamanioArchivo(Integer.parseInt(obj[3].toString()));
	        		}
	        		if (obj[4] != null) {
	        			documentosConvocatoriaVO.setExtensionArchivo(obj[4].toString());
	        		}
	        		if (obj[5] != null) {
	        			documentosConvocatoriaVO.setIdAlfresco(obj[5].toString());
	        		}
	        		if (obj[6] != null) {
	        			documentosConvocatoriaVO.setFechaPublicacion(obj[6].toString());
	        		}
	        		if (obj[7] != null) {
	        			documentosConvocatoriaVO.setUsuarioPublicacion(obj[7].toString());
	        		}
	        		if (obj[8] != null) {
	        			documentosConvocatoriaVO.setUsuarioCreacion(obj[8].toString());
	        		}
	        		if (obj[9] != null) {
	        			documentosConvocatoriaVO.setFechaCreacion(obj[9].toString());
	        		}
	        		if (obj[10] != null) {
	        			documentosConvocatoriaVO.setUsuarioModificacion(obj[10].toString());
	        		}
	        		if (obj[11] != null) {	        			
	        			documentosConvocatoriaVO.setFechaModificacion(obj[11].toString());
	        		}
	        		if (obj[12] != null) {
	        			documentosConvocatoriaVO.setConvocatoria(new ConvocatoriaVO());
	        			documentosConvocatoriaVO.getConvocatoria().setNidConvocatoria(Long.valueOf(obj[12].toString()));
	        		}
	        		if (obj[13] != null) {
	        			documentosConvocatoriaVO.setEstado(obj[13].toString());
	        		}
	        		if (obj[14] != null) {
	        			documentosConvocatoriaVO.setObservacion(obj[14].toString());
	        		}
	        		if (obj[15] != null) {
	        			documentosConvocatoriaVO.setDocumento(obj[15].toString());
	        		}
	        		documentosConvocatoriaVO.setCronograma(new CronogramaVO());
	        		if (obj[16] != null) {
	        			documentosConvocatoriaVO.getCronograma().setNidCronograma(Long.valueOf(obj[16].toString()));
	        		}
	        		if (obj[17] != null) {
	        			documentosConvocatoriaVO.getCronograma().setNalias(Long.valueOf(obj[17].toString()));
	        		}	                	                
	                listaDocumento.add(documentosConvocatoriaVO);
	            }
	        }
		}
		return listaDocumento;
	}
		
	@Override
	public List<DatosDelProcesoVO> obtenerListaDatosProceso(Long nidConvoca,
			Long nidSistema) throws Exception {
			
		List<DatosDelProcesoVO> listaDatosProceso = new ArrayList();
		StringBuilder sbQuery = new StringBuilder();
		sbQuery = QueryUtils.getQueryListaDatosProceso(nidSistema);
		
		if (sbQuery != null ){
			Query consulta = em.createNativeQuery(sbQuery.toString());
			if(nidSistema.equals(QueryUtils.TIPO_SEACE_3)){				
				consulta.setParameter("nidConvoca", nidConvoca);
			} else {
				consulta.setParameter("nidProceso", nidConvoca);
			}	
			List<Object[]> listaObjeto = consulta.getResultList();
			if (listaObjeto != null) {
	            for (int i = 0; i < listaObjeto.size(); i++) {            	
	                Object obj[] = listaObjeto.get(i);
	                DatosDelProcesoVO datosDelProcesoVO = new DatosDelProcesoVO();	                
	                datosDelProcesoVO.setIdDocumento(obj[0] != null ? Long.valueOf(obj[0].toString()):null);                
	                datosDelProcesoVO.setEstado((obj[1] != null && obj[1].toString().length()>0 ) ? EstadoDocumentoProcedimientoState.get(Integer.parseInt(obj[1].toString())) : null); 
	                datosDelProcesoVO.setIdDocumentoAlfrescoTecnico(obj[2] != null ? obj[2].toString():null);
	                datosDelProcesoVO.setTipoDocumentoTecnico(obj[3] != null ? obj[3].toString():null);
	                datosDelProcesoVO.setNroDocumentoTecnico(obj[4] != null ? obj[4].toString():null);
	                datosDelProcesoVO.setFechaTecnico(obj[5] != null ? obj[5].toString():null);
	                datosDelProcesoVO.setCargoTecnico(obj[6] != null ? obj[6].toString():null);
	                datosDelProcesoVO.setNombreTecnico(obj[7] != null ? obj[7].toString():null);
	                datosDelProcesoVO.setaPaternoTecnico(obj[8] != null ? obj[8].toString():null);
	                datosDelProcesoVO.setaMaternoTecnico(obj[9] != null ? obj[9].toString():null);
	                datosDelProcesoVO.setCargoLegal(obj[10] != null ? obj[10].toString():null);
	                datosDelProcesoVO.setIdDocumentoAlfrescoLegal(obj[11] != null ? obj[11].toString():null);
	                datosDelProcesoVO.setTipoDocumentoLegal(obj[12] != null ? obj[12].toString():null);
	                datosDelProcesoVO.setNroDocumentoLegal(obj[13] != null ? obj[13].toString():null);
	                datosDelProcesoVO.setFechaLegal(obj[14] != null ? obj[14].toString():null);
	                datosDelProcesoVO.setNombreLegal(obj[15] != null ? obj[15].toString():null);
	                datosDelProcesoVO.setaPaternoLegal(obj[16] != null ? obj[16].toString():null);
	                datosDelProcesoVO.setaMaternoLegal(obj[17] != null ? obj[17].toString():null);
	                datosDelProcesoVO.setTipoDispositivo(obj[18] != null ? obj[18].toString():null);
	                datosDelProcesoVO.setNumeroSigla(obj[19] != null ? obj[19].toString():null);
	                datosDelProcesoVO.setNombreOrganismo(obj[20] != null ? obj[20].toString():null);	                
	                listaDatosProceso.add(datosDelProcesoVO);
	            }
	        }
		}
		return listaDatosProceso;
	}	
	
	@Override
	public List<DocumentoProcedimientoVO> obtenerListaDocumentoProcedimiento(Long nidProceso,
			Long nidSistema) throws Exception {			
		List<DocumentoProcedimientoVO> listaDatosProceso = new ArrayList<DocumentoProcedimientoVO>();
		StringBuilder sbQuery = new StringBuilder();
		sbQuery = QueryUtils.getQueryListaDocumentoProcedimiento(nidSistema);		
		if (sbQuery != null ){
			Query consulta = em.createNativeQuery(sbQuery.toString());
			consulta.setParameter("nidProceso", nidProceso);

			List<Object[]> listaObjeto = consulta.getResultList();
			if (listaObjeto != null) {
	            for (int i = 0; i < listaObjeto.size(); i++) {            	
	                Object obj[] = listaObjeto.get(i);
	                DocumentoProcedimientoVO documentoProcedimientoVO = new DocumentoProcedimientoVO();
	                documentoProcedimientoVO.setSubTitulo(obj[0] != null ? obj[0].toString():null);
	                /** Verificar Rutas Alternas de posibles documentos perdidos */
	                if(nidSistema.equals(QueryUtils.TIPO_SEACE_2)){ //Verificar solo en casos de SEACE v2.0
	                	String status = "";
	                	if(obj[1] != null ){
	                		status = Utils.getEstado(obj[1].toString().replace(" ", "%20"));
	                		//Si no existe verificar en zonasegura/particion1
	                		if(!status.equals("SI_EXISTE")){ 
	                    		//status = Utils.getEstado(obj[1].toString().replace("http://zonasegura.seace.gob.pe/","http://zonasegura.seace.gob.pe/particion1/").replace(" ","%20"));
	                    		//documentoProcedimientoVO.setIdAlfresco(obj[1].toString().replace("http://zonasegura.seace.gob.pe/","http://zonasegura.seace.gob.pe/particion1/").replace(" ","%20"));
	                    		status = Utils.getEstado(obj[1].toString().replace("https://zonasegura2.seace.gob.pe/documentos/","https://zonasegura2.seace.gob.pe/particion1/").replace(" ","%20"));
	                    		documentoProcedimientoVO.setIdAlfresco(obj[1].toString().replace("https://zonasegura2.seace.gob.pe/documentos/","https://zonasegura2.seace.gob.pe/particion1/").replace(" ","%20"));
	                    	}else{// Si existe documento
	                    		documentoProcedimientoVO.setIdAlfresco(obj[1].toString().replace(" ", "%20"));
	                    	}
	                	}
	                }else{
	                	documentoProcedimientoVO.setIdAlfresco(obj[1] != null ? obj[1].toString():null);	
	                }
	                documentoProcedimientoVO.setExtensionArchivo(obj[2] != null ? obj[2].toString():null);
	                documentoProcedimientoVO.setFechaHoraPublicacion(obj[3] != null ? obj[3].toString():null);
	                documentoProcedimientoVO.setTitulo(obj[4] != null ? obj[4].toString():null);
	                documentoProcedimientoVO.setNombreArchivo(obj[5] != null ? obj[5].toString():null);
	                documentoProcedimientoVO.setFecha(obj[6] != null ? obj[6].toString():null);
	                documentoProcedimientoVO.setNombre(obj[7] != null ? obj[7].toString():null);
	                documentoProcedimientoVO.setPaterno(obj[8] != null ? obj[8].toString():null);
	                documentoProcedimientoVO.setMaterno(obj[9] != null ? obj[9].toString():null);
	                documentoProcedimientoVO.setCargo(obj[10] != null ? obj[10].toString():null);
	                documentoProcedimientoVO.setCausal(obj[11] != null ? obj[11].toString():null);
	                listaDatosProceso.add(documentoProcedimientoVO);
	            }
	        }
		}
		return listaDatosProceso;
	}
	
	
	 /**  004  INICIO */	
	public List<DocumentoVO> obtenerListaHistorialDocumentos(Long nidSistema, Long idProceso, String tipoDoc) throws Exception{
	// TODO Auto-generated method stub
			List<DocumentoVO> listaDocumento = new ArrayList();
			StringBuilder sbQuery = new StringBuilder();
			sbQuery = QueryUtils.getQueryHistorialDocumentosProceso(nidSistema);
			if(nidSistema.equals(QueryUtils.TIPO_SEACE_3)){
			Query consulta = em.createNativeQuery(sbQuery.toString());
			consulta.setParameter("nidProceso", idProceso);
			consulta.setParameter("tipoDoc", tipoDoc);
			List<Object[]> listaObjeto = consulta.getResultList();
			if (listaObjeto != null) {
	            for (int i = 0; i < listaObjeto.size(); i++) {            	
	                Object obj[] = listaObjeto.get(i);
	                DocumentoVO historialDocumentoVO = new DocumentoVO();
	                historialDocumentoVO.setNumber(new Long(i+1));
	                //historialDocumentoVO.setEtapaDescripcion(obj[8] != null ? obj[8].toString():null);
	                historialDocumentoVO.setEtapaDescripcion(obj[8]!=null?EtapaConfiguradorType.get(Integer.parseInt(obj[8].toString())).getValue() : null);
	                historialDocumentoVO.setNombreDocumento(obj[2] != null ? obj[2].toString():null);
	                historialDocumentoVO.setCodDocumentoAlfresco(obj[3] != null ? obj[3].toString():null);
	                //historialDocumentoVO.setDocumentoDescripcion(obj[1] != null ? obj[1].toString():null);
	                historialDocumentoVO.setTamanioDocumento(obj[4] != null ? obj[4].toString():null);
	                historialDocumentoVO.setFechaPublicacion(obj[5] != null ? obj[5].toString():null);
	                historialDocumentoVO.setExtensionDocumento(obj[6] != null ? obj[6].toString():null);
	                historialDocumentoVO.setUsuarioPublica(obj[7] != null ? obj[7].toString():null);
	                historialDocumentoVO.setTipoDocumentoDescripcion(TipoDocumentoConvocatoriaType.get(tipoDoc).getValue());
	                
	           	     listaDocumento.add(historialDocumentoVO);
	                
	          /*
	            O.C_TIPDOC, O.C_NOMARC, O.C_ALFARC, O.N_TAMARC, O.D_FECPUB
	            */
			}
			 
			
	}
			}
			
			return listaDocumento;
	/**  004  FIN */
}

        /** 005 --> Inicio - MEMORANDO 428-2015/SDP   **/
	public List<HistorialDatosDelProceso> obtenerListaHistorialDatosDelProceso(Long nidSistema, Long idDatosProceso) throws Exception {
		// TODO Auto-generated method stub
		List<HistorialDatosDelProceso> listaDocumento = new ArrayList();
		StringBuilder sbQuery = new StringBuilder();
		sbQuery = QueryUtils.getQueryListaHistorialDatosDelProceso(nidSistema);
		if(nidSistema.equals(QueryUtils.TIPO_SEACE_3)){
			Query consulta = em.createNativeQuery(sbQuery.toString(),HistorialDatosDelProceso.class);
			consulta.setParameter("idDatosProceso", idDatosProceso);
			listaDocumento = consulta.getResultList();
		} 
		return listaDocumento;
	}
        /**  Fin - MEMORANDO 428-2015/SDP   **/
	
	
	/**Inicio 006*/
	   @Override
	    public List<DocumentoVO> getDocumentosPorExpediente( Long nidSistema, Long idExpediente) throws Exception {
		   
	   
		   List<DocumentoVO> listaDocumento = new ArrayList();

		   StringBuilder sbQuery = new StringBuilder();

		   sbQuery = QueryUtils.getDocumentosPorExpediente(nidSistema);
		   
		   if(nidSistema.equals(QueryUtils.TIPO_SEACE_3)){
			   Query consulta = em.createNativeQuery(sbQuery.toString());		
			   consulta.setParameter("idExpediente", idExpediente);				
				List<Object[]> listaObjeto = consulta.getResultList();
				
				if (listaObjeto != null) {
					DocumentoVO documentoVO;
		            for (int i = 0; i < listaObjeto.size(); i++) {            	
		                Object obj[] = listaObjeto.get(i);
		                documentoVO = new DocumentoVO();
		                
		                documentoVO.setNumber(new Long(i+1));		                
		                documentoVO.setExtensionDocumento(obj[0] != null ? obj[0].toString() : null);		                
		                documentoVO.setDocumentoDescripcion(obj[2] != null ? obj[2].toString() : null);
		                documentoVO.setTamanioDocumento(obj[3]!=null?obj[3].toString() : null);
		                documentoVO.setCodDocumentoAlfresco(obj[1]!=null?obj[1].toString() : null);		                 		    
		                listaDocumento.add(documentoVO);    
				}
			} 
			
	    }
		   
		   return listaDocumento;
		   
	}
		   
	   /**Inicio 006*/
	
	
}
			

