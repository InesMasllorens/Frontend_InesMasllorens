import 'package:get/get.dart';

class LocalString extends Translations{
  @override

  Map<String, Map<String, String>> get keys => {
 
    'en_US':{
       // pantalla de login  
      'escoge_idioma': 'Choose a language',
      'iniciar sesion': 'Login',
      'email': 'Email',
      'contraseña': 'Password',
      'btn_continuar': 'Continue',
      'aviso': 'Are you a new user? Create an account!',
      'btn_registrarse': 'Register',
      'idioma': 'Language',
      //control errores pantalla login
      'usuario_incorrecto': 'Wrong user!',
      'control_usuarioNoExiste': 'Wrong password or email. If you want to access with these data you will have to register first.',
      'control_camposRellenos': 'Both fields are required.',

      //-------------------------------------------------------------------------------------------------
      // pantalla de register 
      'register': 'Register',
      'nombre': 'Name',
      'apellido': 'Surname',
      'btn_registrar': 'REGISTER',
      //control errores pantalla register
      'control_FormatoEmail': 'The email format is not correct.',
      'control_FormatoContraseña': 'The password mus contain a minimum of 8 characters, a number and a special character.',
      'control_ConstraseñasIguales': 'The password fields must be the same.',
      'control_CamposObligatorios': 'All the fields are required.',
      'control_EmailExistente': 'This email is already registered. Please use another.',
      'control_UsuarioRegistrado': 'User registered successfully!',

      //-------------------------------------------------------------------------------------------------
      // pantalla list grupos
      'titulo_grupo': 'MY GROUPS',
      'codigo': 'Code:',
      'confirmar': 'Confirm',
      'aviso_borrarGrupo': 'Are you sure you want to delete this group?',
      'cancelar': 'Cancel',
      'si': 'Yes',
      'crear_grupo': 'Create group',
      'unirse_grupo': 'Join a group',
      'grupos': 'Groups',
      'btn_ayuda_grupos':'On this screen you can see all your groups. If you want to create a new one, click on the + icon located in the lower right corner and complete the fields with the information of the new group.',
      'cerrar': 'Close',
      'aviso_noGrupos': 'There are no groups',

      //-------------------------------------------------------------------------------------------------
      // pantalla crear grupos
      'nuevo_grupo': 'NEW GROUP',
      'btn_ayuda_crearGrupos': 'On this screen you must fill in the Name and Description fields to create a new group.',
      'nombre_grupo': 'Name group',
      'descripcion_grupo': 'Group description',
      //control errores pantalla crear grupos
      'control_nombre': 'Please enter a group name',
      'control_añadirGrupo': 'Failed to add the group.',

      //-------------------------------------------------------------------------------------------------
      // pantalla unirse a un grupo
      'unir_grupo': 'Join a group',
      'btn_ayuda_unirGrupo': 'On this screen you can join a group. You must enter the group code that your friends have sent you.',
      'codigo_grupo': 'Group code',
      //control errores pantalla unirse grupos
      'control_codigo': 'Please introduce a group code.',
      'error_unirse': 'Join failed.',
      
      //-------------------------------------------------------------------------------------------------
      // pantalla drawer
      'perfil': 'Profile',
      'quien_somos':'Who are we?',
      'cerrar_sesion': 'Log out',
      'FAQS': 'FAQs',

      //-------------------------------------------------------------------------------------------------
      // pantalla quienes somos
      'titulo_equipo': 'PRICEDIVIDER TEAM',
      'texto': 'We are pleased to introduce the team behind the development of a new application, a group of highly trained students committed to creating a high quality and innovative solution. The team is made up of (from left to right):',
      'texto2': 'The team is made up of talented and passionate programmers, who bring their expertise in different programming languages and technologies. Together, the development team of this application is committed to creating a high-quality and innovative solution to meet the needs of its users.',

      //----------------------------------------------------------------------------------------------------
      //pantalla FAQs
      'pregunta1': 'How can I see my profile information?',
      'respuesta1': 'To see your profile information (name, surname and email) you must click on the button with 3 horizontal lines located in the upper left corner of the main screen. Next, a menu of options will open, there is an option of "Profile". Click on that option.',
      'pregunta2': 'How do I create a group?',
      'respuesta2': 'To create a group you must go to the main page and click on the floating icon with a "+" symbol. Two options will appear, one of them is "Create Group". Once this option is selected, fill in the "Group name" field and click on the "Create Group" button.',
      'pregunta3': 'How do I join a group?',
      'respuesta3': 'To join a group you must go to the main page and click on the floating icon with a "+" symbol. Two options will appear one of them is "Join a group". Once this option is selected, fill in the "Group Code" field with the code that your friend has sent you to join the group. Finally, click on the "Join Group" button.',
      'pregunta4': 'How can I leave a group?',
      'respuesta4': 'To leave a group you must go to the main page, where the list of groups is displayed. Next, you must click on the icon of a trash can that is displayed to the right of each group. Finally, you must confirm that you want to leave the selected group.',


      //----------------------------------------------------------------------------------------------------
      //pantalla tutorial
      'crea_un_grupo': 'Create a group',
      'comparte_codigo': 'Share the code with your friends',
      'crea_tickets': 'Create new tickets',
      'añade_productos': 'Add the products of the ticket',
      'selecciona_productos': 'Select your products',
      'valida_seleccion': 'Validate your selection',
      'resuelve_deudas': 'Resolve your debts',


      //-------------------------------------------------------------------------------------------------------
      //pantalla idiomas
      'idiomas':'Idiomas',

      //-------------------------------------------------------------------------------------------------------
      //pantalla tickets
      'btn_ayuda_tickets': 'On this screen you can see all the tickets of a group. If you want to create a new one, click on the + icon located in the lower right corner and complete the fields with the information of the new ticket.',
      'grupo': 'Group',
      'deudas':'Debts',
      'mapa': 'Map',
      'editar_pantalla': 'Edit screen',
      'crear_ticket': 'Create ticket',
      //pantalla list tickets
      'completar_tickets': 'Complete all tickets',
      'enviar_tickets': 'Send complete tickets',
      'Deseleccionar_ticket': 'Deselect all tickets',
      'aviso_noTickets': 'There are no tickets in this group',
      'anfitrion': 'Host',
      'borrar_ticket': 'Are you sure you want to delete this ticket?',

      //-------------------------------------------------------------------------------------------------------
      //pantalla crear tickets
      'nuevo_ticket':'NEW TICKET',
      'btn_ayuda_crearTicket' : 'In this screen you must add a name for the new ticket and you must also select the location of the ticket on the map.',
      'nombre_ticket': 'Ticket name',
      'coordenadas': 'Coordinates',
      //control errores pantalla crear tickets
      'ticket_añadido': 'Failed to add ticket',

      //-------------------------------------------------------------------------------------------------------
      //pantalla lista productos
      'productos': 'Ticket products',
      'añadir_producto': 'Add product',
      'btn_ayuda_listaProductos': 'On this screen you must add the products of your ticket. You must enter the name, price and units of the new item.',
      'cantidad': 'Quantity',
      'nombre_producto': 'Name',
      'precio_total': 'Total price',
      'unidades_pagar': 'Units to pay',
      //control errores pantalla lista productos
      'control_productos_ticket': 'There are no products in this ticket',
      'formato_incorrecto': 'Wrong name format',
      'actualizar_unidades': 'Update units to pay',
      'idProducto': 'ProductId',
      'formato_cantidad': 'Wrong quantity format',
      'formato_price': 'Wrong price format',

      //-------------------------------------------------------------------------------------------------------------
      //pantalla chat
      'bienvenidos': 'Welcome to the group chat',
      'start':'START',
      'entrar_chat':'Join the chat group',
      'mensaje':'Message',
      'send':'Send',

      //---------------------------------------------------------------------------------------------------------------
      //widget participantes
      'participantes': 'Participants',

      //---------------------------------------------------------------------------------------------------------------
      //widget info_grupo
      'descripcion': 'Description',

  //-----------------------------------------------------------------------------------------------------------------
      //widget list_deudas
      'endeudado': 'INDEBTED',
      'beneficiario': 'BENEFICIARY',
      'cantidad_mayus': 'QUANTITY',
      'productos_noAsignados':'Products that no one has assigned:',
      'producto_mayus': 'PRODUCT',
      'aviso_noCompletado': 'CAREFUL! Not all participants have completed the tickets',
      'aviso_Completado': 'ALL participants have completed the tickets',











    },
    'es_ES':{
       // pantalla de login 
      'escoge_idioma': 'Escoge un idioma',
      'iniciar sesion': 'Iniciar sesion',
      'email': 'Correo electrónico',
      'contraseña': 'Contraseña',
      'btn_continuar': 'Continuar',
      'aviso': '¿Eres un usuario nuevo? Create una cuenta!',
      'btn_registrarse': 'Registrarse',
      'idioma': 'idioma',
      //control errores pantalla login
      'usuario_incorrecto': 'Usuario incorrecto!',
      'control_usuarioNoExiste': 'Contrasña o correo electrónico incorrectos. Si quieres acceder con estos datos tendrás que registrarte primero.',
      'control_camposRellenos': 'Los dos campos son obligatorios.',


      //--------------------------------------------------------------------------------------------------------
       // pantalla de register 
      'register': 'Registro',
      'nombre': 'Nombre',
      'apellido': 'Apellido',
      'btn_registrar': 'REGISTRARSE',
      //control errores pantalla register
      'control_FormatoEmail': 'El formato de correo electrónico no es correcto.',
      'control_FormatoContraseña': 'La contraseña debe contener minimo 8 caracteres, un número y un caracter especial.',
      'control_ConstraseñasIguales': 'Los campos contraseña deben ser iguales',
      'control_CamposObligatorios': 'Todos los campos son obligatorios',
      'control_EmailExistente': 'Este correo electrónico ya está registrado. Por favor, utiliza otro.',
      'control_UsuarioRegistrado': 'Usuario registrado correctamente!',

      //-------------------------------------------------------------------------------------------------
      // pantalla list grupos
      'titulo_grupo': 'MIS GRUPOS',
      'codigo': 'Código:',
      'confirmar': 'Confirmar',
      'aviso_borrarGrupo': '¿Seguro que quieres borrar este grupo?',
      'cancelar': 'Cancelar',
      'si': 'Sí',
      'crear_grupo': 'Crear Grupo',
      'unirse_grupo': 'Unirse a un grupo',
      'grupos': 'Grupos',
      'btn_ayuda_grupos':'En esta pantalla puedes ver todos tus grupos. Si quieres crear uno nuevo, pulsa en el icono + situado en la esquina inferior derecha y completa los campos con la información del grupo nuevo.',
      'cerrar': 'Cerrar',
      'aviso_noGrupos': 'No hay grupos',

       //-------------------------------------------------------------------------------------------------
      // pantalla crear grupos
      'nuevo_grupo': 'NUEVO GRUPO',
      'btn_ayuda_crearGrupos': 'En esta pantalla debes rellenar los campos Nombre y Descripción para crear un nuevo grupo.',
      'nombre_grupo': 'Nombre grupo',
      'descripcion_grupo': 'Descripción grupo',
      //control errores pantalla crear grupos
      'control_nombre': 'Por favor, introduzca un nombre de grupo.',
      'control_añadirGrupo': 'No se ha podido añadir el grupo.',

      //-------------------------------------------------------------------------------------------------
      // pantalla unirse a un grupo
      'unir_grupo': 'Unirse a un grupo',
      'btn_ayuda_unirGrupo': 'En esta pantalla puedes unnirte a un grupo. Debes introducir el código de grupo que te han enviado tus amigos.',
      'codigo_grupo': 'Código grupo',
      //control errores pantalla unirse grupo
      'control_codigo': 'Por favor, introduzca el código del grupo.',
      'error_unirse': 'error al unirse.',

      //-------------------------------------------------------------------------------------------------
      // pantalla drawer
      'perfil': 'Perfil',
      'quien_somos':'¿Quién somos?',
      'cerrar_sesion': 'Cerrar Sesión',
      'FAQS': 'Preguntas Frecuentes',

      
      //-------------------------------------------------------------------------------------------------
      // pantalla quienes somos
      'titulo_equipo': 'EQUIPO PRICEDIVIDER',
      'texto': 'Nos complace presentar al equipo detrás del desarrollo de una nueva aplicación, un grupo de alumnos altamente capacitados y comprometidos con la creación de una solución innovadora y de alta calidad. El equipo está compuesto por (de izquierda a derecha):',
      'texto2': 'El equipo está formado por programadores talentosos y apasionados, quienes aportan su experiencia en diferentes lenguajes de programación y tecnologías. En conjunto, el equipo de desarrollo de esta aplicación está comprometido en crear una solución innovadora y de alta calidad para satisfacer las necesidades de sus usuarios.',

      
      //----------------------------------------------------------------------------------------------------
      //pantalla FAQs
      'pregunta1': '¿Cómo puedo ver la información de mi perfil?',
      'respuesta1': 'Para ver la información de su perfil (nombre, apellido y correo) debe pulsar sobre el botón de 3 líneas horizontales situado en la esquina izquierdda superior de la pantalla principal. A continuación se abrirá un menú de opciones entre las cuales estará "Perfil". Pulse en esa opción.',
      'pregunta2': '¿Cómo puedo crear un grupo?',
      'respuesta2': 'Para crear un grupo debe ir a la página principal y pulsar sobre el icono flotante con un símbolo "+". Aparecerán dos opciones entre las cuales está "Crear Grupo". Una vez seleccionada esta opción, rellene el campo "Nombre del grupo" y pulse sobre el botón "Crear Grupo".',
      'pregunta3': '¿Cómo puedo unirme a un grupo?',
      'respuesta3': 'Para unirse a un grupo debe ir a la página principal y pulsar sobre el icono flotante con un símbolo "+". Aparecerán dos opciones entre las cuales está "Unirme a un grupo". Una vez seleccionada esta opción, rellene el campo "CodigoGrupo" con el código que le ha enviado su amigo para unirse al grupo. Finalmente, pulse sobre el botón "Unirme al grupo".',
      'pregunta4': '¿Cómo puedo salir de un grupo?',
      'respuesta4': 'Para salir de un grupo debe ir a la página principal, donde se muestra la lista de grupos. A continuación, debe pulsar en el incono de una papelera que se muestra a la derecha de cada grupo. Finalmente, debe confirmar que quiere salir del grupo seleccionado.',

          
      //----------------------------------------------------------------------------------------------------
      //pantalla tutorial
      'crea_un_grupo': 'Crea un grupo',
      'comparte_codigo': 'Comparte el código con tus amigos',
      'crea_tickets': 'Crea nuevos tickets',
      'añade_productos': 'Añade los productos del ticket',
      'selecciona_productos': 'Selecciona tus productos',
      'valida_seleccion': 'Valida tu selección',
      'resuelve_deudas': 'Resuelve tus deudas',

      //-------------------------------------------------------------------------------------------------------
      //pantalla tickets
      'btn_ayuda_tickets': 'En esta pantalla puedes ver todos los tickets de un grupo. Si quieres crear uno nuevo, pulsa en el icono + situado en la esquina inferior derecha y completa los campos con la información del ticket nuevo.',
      'grupo': 'Grupo',
      'deudas':'Deudas',
      'mapa': 'Mapa',
      'editar_pantalla': 'Editar pantalla',
      'crear_ticket': 'Crear ticket',

      //pantalla list tickets
      'completar_tickets': 'Completar todos los tickets',
      'enviar_tickets': 'Enviar tickets completados',
      'Deseleccionar_ticket': 'Deseleccionar todos los tickets',
      'aviso_noTickets': 'No hay tickets en este grupo',
      'anfitrion': 'Anfitrión',
      'borrar_ticket': '¿Seguro que quieres borrar este ticket?',

     //-------------------------------------------------------------------------------------------------------
      //pantalla crear tickets
      'nuevo_ticket':'NUEVO TICKET',
      'btn_ayuda_crearTicket' : 'En esta pantalla debes añadir un nombre para el nuevo ticket y tmbién debes seleccionar la ubocación del ticket en el mapa.',
      'nombre_ticket': 'Nombre ticket',
      'coordenadas': 'Coordenadas',
      //control errores pantalla crear tickets
      'ticket_añadido': 'No se ha podido añadir el ticket',

      //-------------------------------------------------------------------------------------------------------
      //pantalla lista productos
      'productos': 'Productos del ticket',
      'añadir_producto': 'Añadir producto',
      'btn_ayuda_listaProductos': 'En esta pantalla debes añadir los productos de tu ticket. Debes introducir el nombre, el precio y las unidades del artículo nuevo.',
      'cantidad': 'Cantidad',
      'nombre_producto': 'Nombre',
      'precio_total': 'Precio total',
      'unidades_pagar': 'Unidades a pagar',
      //control errores pantalla lista productos
      'control_productos_ticket': 'No hay productos en este ticket',
      'formato_incorrecto': 'Formato nombre incorrecto',
      'actualizar_unidades': 'Actualizar unidades a pagar',
      'idProducto': 'idProducto',
      'formato_cantidad': 'Formato cantidad incorrecto',
      'formato_price': 'Formato precio incorrecto',

      //-------------------------------------------------------------------------------------------------------------
      //pantalla chat
      'bienvenidos': 'Bienvenido al chat grupal',
      'start':'EMPEZAR',
      'entrar_chat':'Entrar al chat del grupo',
      'mensaje':'Mensaje',
      'send':'Enviar',

      //---------------------------------------------------------------------------------------------------------------
      //widget participantes
      'participantes': 'Participantes',

      //---------------------------------------------------------------------------------------------------------------
      //widget info_grupo
      'descripcion': 'Descripción',

      //-----------------------------------------------------------------------------------------------------------------
      //widget list_deudas
      'endeudado': 'ENDEUDADO',
      'beneficiario': 'BENEFICIARIO',
      'cantidad_mayus': 'CANTIDAD',
      'productos_noAsignados':'Productos que nadie se ha asignado:',
      'producto_mayus': 'PRODUCTO',
      'aviso_noCompletado': '¡CUIDADO! No todos los participantes han completado los tickets',
      'aviso_Completado': 'TODOS los participantes han completado los tickets',
      
      



    },
  };
}