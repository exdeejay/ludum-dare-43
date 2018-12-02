var queue = []

func append(elem, priority):
	queue.append([elem, priority])


func pop_front():
	var index = 0
	for i in range(1, queue.size()):
		if queue[i][1] < queue[index][1]:
			index = i
	var result = queue[index][0]
	queue.remove(index)
	return result


func size():
	return queue.size()
