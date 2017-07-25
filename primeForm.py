
def rotation(P):
    M = P
    M.append(M.pop(0))
    M[-1] += 12
    return M

def primeForm(P):
    P = sorted(P)
    invP = [((12 - x)%12) for x in P]
    invP = sorted(invP)
    L = [P[i] for i in range(len(P))]
    invL = [invP[i] for i in range(len(P))]   
    rots = []
    invRots = []
    rots.append(L)
    invRots.append(invL)
    rotDist = []
    invRotDist = []
    rotDist.append(P[-1] - P[0])
    invRotDist.append(invP[-1] - invP[0])
    for i in range(len(P)):
        B = rotation(P)
        invB = rotation(invP)
        Q = [B[i] for i in range(len(B))]
        invQ = [invB[i] for i in range(len(invB))]
        rots.append(Q)
        invRots.append(invQ)
        rotDist.append(B[-1] - B[0])
        invRotDist.append(invB[-1] - invB[0])
        

    minSet = rots[rotDist.index(min(rotDist))]
    minInvSet = invRots[invRotDist.index(min(invRotDist))]
    minSet = [((minSet[i] - minSet[0]) % 12) for i in range(len(minSet))]
    minInvSet = [((minInvSet[i] - minInvSet[0]) % 12) for i in range(len(minInvSet))] 

    if (sum(minSet) <= sum(minInvSet)):
        print(minSet)
    else:
        print(minInvSet)
  
P = [int(x) for x in input().split()]
primeForm(P)
    
