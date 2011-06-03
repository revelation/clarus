require "junodoc/version"
require 'java'

$CLASSPATH << '/Applications/OpenOffice.org.app/Contents/MacOS/'
$CLASSPATH << '/Applications/OpenOffice.org.app/Contents/basis-link/ure-link/share/java'
$CLASSPATH << '/Applications/OpenOffice.org.app/Contents/basis-link/program/classes'

require 'java_uno.jar'
require 'juh.jar'
require 'jurt.jar'
require 'ridl.jar'
require 'unoloader.jar'
require 'unoil.jar'

module JunoDoc
  class Document
    attr_accessor :name

    def initialize
      component_context = create_context()
      open_writer(component_context);
    end

    def create_context
      com::sun::star::comp::helper::Bootstrap.bootstrap()
    end

    def open_writer(context)
      xMCF = context.getServiceManager();
      oDesktop = xMCF.createInstanceWithContext("com.sun.star.frame.Desktop", context);
      xCLoader = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::frame::XComponentLoader.java_class, oDesktop);
      # This is creating a new java array
      szEmptyArgs = Java::com.sun.star.beans.PropertyValue[0].new
      xComp = xCLoader.loadComponentFromURL("private:factory/swriter", "_blank", 0, szEmptyArgs);
      xDoc = com::sun::star::uno::UnoRuntime.queryInterface(com::sun::star::text::XTextDocument.java_class, xComp);
      return xDoc;
    end
  end
end
