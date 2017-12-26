set_sepolicy $SOURCE init unix_stream_socket connectto
set_sepolicy $SOURCE property_socket sock_file getattr,open,read,write,execute
set_sepolicy $SOURCE
set_sepolicy audio_prop