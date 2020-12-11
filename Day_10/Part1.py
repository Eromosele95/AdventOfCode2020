with open('AdventDay10.txt') as f:
    One_diff = 0
    three_diff = 0
    index = 0
    thelist = []
    for line in f:
        thelist.append(int(line.strip('\n')))
    thelist = sorted(thelist)

    while index <= len(thelist) - 1:

        if thelist[index] + 1 in thelist:
            index = thelist.index(thelist[index] + 1)
            One_diff += 1  # Add to Difference of one

        elif thelist[index] + 3 in thelist:
            index = thelist.index(thelist[index] + 3)
            three_diff += 1

        else:
            index += 1  # indicate end of array

print((One_diff + 1) * (three_diff + 1))

# One Diff for the difference in One (Added one for initial inclusion)
# Three Diff for difference in three (Added one for last inclusion)

