from libc.stdint cimport uint32_t, uint16_t
from libcpp cimport bool


cdef extern from "ua_plugin_network.h":

    ctypedef struct UA_ConnectionConfig:
        pass

    UA_ConnectionConfig UA_ConnectionConfig_standard;

cdef extern from "ua_server.h":
    ctypedef struct UA_Server:
        pass

cdef extern from "ua_types.h":
    ctypedef bool UA_Boolean;
    ctypedef uint32_t UA_StatusCode;

cdef extern from "ua_server.h":

    ctypedef struct UA_ServerNetworkLayer:
        void (*deleteMembers)(UA_ServerNetworkLayer *nl);

    ctypedef struct UA_ServerConfig:
        UA_ServerNetworkLayer *networkLayers;
        size_t networkLayersSize;


    UA_Server * UA_Server_new(const UA_ServerConfig *config);

    UA_StatusCode UA_Server_run(UA_Server *server, UA_Boolean *running) nogil;
    void UA_Server_delete(UA_Server *server);
    void UA_ServerConfig_delete(UA_ServerConfig *config);

cdef extern from "ua_config_default.h":
    UA_ServerConfig * UA_ServerConfig_new_default();
    UA_ServerConfig * UA_ServerConfig_new_minimal(uint16_t port, const char *certificate);

cdef extern from "ua_network_tcp.h":
    UA_ServerNetworkLayer UA_ServerNetworkLayerTCP(UA_ConnectionConfig conf, uint16_t port);

