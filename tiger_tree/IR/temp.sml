structure Temp = struct

   type temp  = int (* 2ʷ many variables on a w-sized machine *)
		      (* you can use IntInf.int if you want unbounded *)
   type label = string

   val nextTemp       = ref 0 (* Keep track of how many temps have been allocated *)
end