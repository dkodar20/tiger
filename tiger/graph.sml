signature GRAPH = sig

type node
type 'a graph

(*
	Create a new node in the graph
	This operation is not a pure function.
*)
(*val empty   : unit -> 'a graph*)
(*val newNode : 'a graph -> 'a  -> node*)

(* If the data structure was supposed to be persistent the definition
	of new will not be of this form

	addNode : graph -> graph * node
	addEdge : graph -> node * node -> graph
*)


(*val addEdge : (node * node) -> unit*)

(* addEdge (a,b) should add and edge starting from a to b *)

(*val succ    : 'a graph -> node -> node list*)
(*val pred    : 'a graph -> node -> node list*)
(*val label   : 'a graph -> node -> 'a*)

(*val clear   : 'a graph -> unit*)
(*val all     : 'a graph -> node list*)

(* you might want functions that go over all the nodes

maps, folds etc
*)
end

structure Graph :> GRAPH = struct
	type node = word



	structure NodeHashKey : HASH_KEY = struct
		type hash_key = node
		fun  hashVal w = w
		fun  sameKey (w1,w2) = w1 = w2
	end

	structure NodeSet = HashSetFn (NodeHashKey)

	type nodeSet = NodeSet.set

	type 'a graph = { labels : (node, 'a)  HashTable.hash_table,
		(* edges *)
		successors   : (node, nodeSet) HashTable.hash_table,
		predecessors : (node, nodeSet) HashTable.hash_table,
		nextNode : node ref
	}

(*	fun empty () = {  labels = HastTable.mkTable 
							successors = HasTable.mkTable ....
							nextNode   = ref (Word.fromInt 0)
			}
*)
	(*fun new g a = .....*)



end