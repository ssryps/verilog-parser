.section .data
.align 4 # which either means 4 or 2**4 depending on arch!

.global _binary_obj_user_myapp_start
.type _binary_obj_user_myapp_start, @object
_binary_obj_user_myapp_start:
.incbin "obj/user/myapp"

.align 4
.global _binary_obj_user_myapp_end
_binary_obj_user_myapp_end:

