import matplotlib.pyplot as graph

with open("./graphfile.txt") as f:
    s = map(lambda x: [int(x[0]), int(x[1]), int(x[2])], map(lambda x : x.split(" "), f.read().split("\n")) )
array = [0,1,2,3,4]

graph.yticks(array)

graph.ylabel("Queue Number")
graph.xlabel("Ticks")
data = list(s)
print(data)
processes = 10
for pid in range(4,processes + 4):
    plotx = []
    ploty = []
    for point in data:
        if(point[1] == pid):
            plotx.append(point[0])
            ploty.append(point[2])
    print(plotx,ploty)
    graph.plot(plotx, ploty,linestyle='-', marker='.', label = str(pid))
graph.legend()
graph.show()
