object @unlock

extends "api_v1/unlocks/base"

# this is an example; maybe we only want 'description' on the #show JSON...
# so we extend the *base* template with our @unlock object and then we
# add in the extra 'description' attribute.
attributes :description