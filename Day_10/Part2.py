with open('AdventDay10.txt') as f:
    One_diff = 0
    three_diff = 0
    index = 0
    thelist = []
    for line in f:
        thelist.append(int(line.strip('\n')))
    thelist = sorted(thelist)

combinations = {0: 1}  # initial connect option - direct connection
for num in thelist:
    combinations[num] = 0
    combinations[num] += combinations.get(num - 1, 0)
    combinations[num] += combinations.get(num - 2, 0)
    combinations[num] += combinations.get(num - 3, 0)
print(combinations[thelist[-1]])

