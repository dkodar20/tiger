signature GRAPH = sig

	type node
	type 'a graph

(*
	Create a new node in the graph
	This operation is not a pure function.
*)
	val empty   : unit -> 'a graph
	val newNode : 'a graph -> 'a  -> node

(* If the data structure was supposed to be persistent the definition
	of new will not be of this form

	addNode : graph -> graph * node
	addEdge : graph -> node * node -> graph
*)


val addEdge : (node * node) -> unit

(* addEdge (a,b) should add and edge starting from a to b *)

(*val succ    : 'a graph -> node -> node list*)
(*val pred    : 'a graph -> node -> node list*)
(*val label   : 'a graph -> node -> 'a*)

(*val clear   : 'a graph -> unit*)
(*val all     : 'a graph -> node list*)

(* you might want functions that go over all the nodes

maps, folds etc *)

end

structure Graph :> GRAPH = struct
	type node = word


	structure NodeHashKey : HASH_KEY = struct
		type hash_key = node
		fun  hashVal w = w
		fun  sameKey (w1,w2) = (w1 = w2)
	end

	structure NodeSet = HashSetFn (NodeHashKey)

	type nodeSet = NodeSet.set

	type 'a graph = { labels : (node, 'a)  HashTable.hash_table,
		successors   : (node, nodeSet) HashTable.hash_table,
		predecessors : (node, nodeSet) HashTable.hash_table,
		nextNode : node ref
	}
	

	fun empty () = {  	labels = HashTable.mkTable (NodeHashKey.hashVal, NodeHashKey.sameKey) (50, Fail "not found"),
						successors = HashTable.mkTable (NodeHashKey.hashVal, NodeHashKey.sameKey) (50, Fail "not found"),
						predecessors = HashTable.mkTable (NodeHashKey.hashVal, NodeHashKey.sameKey) (50, Fail "not found"),
						nextNode   = ref (Word.fromInt 0)
			}
	

	fun newNode (g : ('a graph)) a =
		let
			val n = !(#nextNode g)
		in
			HashTable.insert (#labels g) (n, a);
			HashTable.insert (#successors g) (n, NodeSet.mkEmpty 50);
			HashTable.insert (#predecessors g) (n, NodeSet.mkEmpty 50);
			#nextNode g := n + 0w1;
			n
		end



end