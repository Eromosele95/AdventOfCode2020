with open('AdventDay6_2.txt') as f:
    Lines = []
    Lines2 = []
    Ans = 0
    for line in f:
        line = line.strip()
        if line:    # Remove Empty Lines
            line = line.split(' ')
            line = [set(x) for x in line]  # Convert list of strings to set of singular strings(or char)
            u = set.intersection(*line)  # set intersection for unique votes
            Ans += len(u)
            Lines2.append(u)
            Lines.append(line)
    print(Ans)

