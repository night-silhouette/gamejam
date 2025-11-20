extends Node

func u_sequence(total:int):#2,1,0,1,2
	var middle=int(total/2)
	var res:Array=[]
	if total%2==0:
		res.append_array(Array(range(middle-1,-1,-1)))
		res.append_array(Array(range(0,middle)))
	else :
		res.append_array(Array(range(middle,1,-1)))
		res.append_array(Array(range(1,middle+1)))
		
	return res

func zero_cross_sequence(total):#-2,-1,0,1,2
	var middle=int(total/2)
	var res:Array=[]
	if total%2==0:
		res.append_array(Array(range(-middle+1,1)))
		res.append_array(Array(range(0,middle)))
	else:
		res.append_array(Array(range(-middle,0)))
		res.append_array(Array(range(0,middle+1)))
	return res				
	
		
	
	
	
	
	
	
	
	
	
	
	
