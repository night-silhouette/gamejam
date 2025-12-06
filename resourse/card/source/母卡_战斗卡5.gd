extends Card

var num=0

func attack():
	skill()

func skill():
	super().skill()
	GameStateMachine.update_prop_self("reduction",0)
	obj.special+=1
	
	
	obj.be_hurt.connect(func(hurt):
		if obj.special>0:
			obj.special-=1
			num+=1
			if num==5:
				spawn()
		if obj.special==0:
			num=0
			GameStateMachine.update_prop_self("reduction",1)
		,CONNECT_ONE_SHOT)
		
		
		
func spawn():
	pass		
