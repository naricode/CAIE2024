clc;
clear;
close all;

%% Problem Definition

CostFunction=@Sphere;       % Cost Function

nVar=10;                    % Number of Variables
VarSize=[1 nVar];           % Size of Variables Matrix

VarMin=-5;                  % Lower Bound of Variables
VarMax= 5;                  % Upper Bound of Variables

VarRange=[VarMin VarMax];   % Variation Range of Variables

VelMax=(VarMax-VarMin)/10;  % Maximum Velocity
VelMin=-VelMax;             % Minimum Velocity


%% KGA Parameters

MaxIt=200;      % Maximum Number of Iterations

nPop=50;        % Population Size
nClusters=5;      % Number of Clusters 

pCrossover=0.7;                         % Crossover Percentage
nCrossover=round(pCrossover*nPop/2)*2;  % Number of Parents (Offsprings)

pMutation=0.2;                      % Mutation Percentage
nMutation=round(pMutation*nPop);    % Number of Mutants

global NFE
NFE=0;
%% Initialization

% Empty Structure to Hold Individuals Data
empty_individual.Position=[];
empty_individual.Cost=[];

% Create Population Matrix
pop=repmat(empty_individual,nPop,1);

% Initialize Positions
for i=1:nPop
    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    pop(i).Cost=CostFunction(pop(i).Position);
   
end

% Sort Population

Costs=[pop.Cost]';
[popList,C] = kmeans(Costs,nClusters);
A=randi([1 nClusters],1,1);
idx=find(popList==A);
Costs=Costs(idx);
[Costs, SortOrder]=sort(Costs);
pop=pop(SortOrder);



% Store Best Solution
BestSol=pop(1);

% Vector to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

%% GA Main Loop
tic
for it=1:MaxIt
    
    % Crossover
    popc=repmat(empty_individual,nCrossover/2,2);
    for k=1:nCrossover/2
        
        i1=randi([1 numel(pop)]);
        i2=randi([1 numel(pop)]);
        
        p1=pop(i1);
        p2=pop(i2);
        
        [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position,p2.Position,VarRange);
        
        popc(k,1).Cost=CostFunction(popc(k,1).Position);
        popc(k,2).Cost=CostFunction(popc(k,2).Position);
        
        
    end
    popc=popc(:);
    
    
    % Mutation
    popm=repmat(empty_individual,nMutation,1);
    for k=1:nMutation
        
        i=randi([1 numel(pop)]);
        
        p=pop(i);
        
        popm(k).Position=Mutate(p.Position,VarRange);
        
        popm(k).Cost=CostFunction(popm(k).Position);
        
        
    end
    
    % Merge Population
    pop=[pop
         popc
         popm];
    
    % Sort Population
    pop=SortPopulation(pop);
    
    % Delete Extra Individuals
    pop=pop(1:nPop);
    
    % Update Best Solution
    BestSol=pop(1);
    
    % Store Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ' NFE = ' num2str(NFE) ': Best Cost = ' num2str(BestCost(it))]);
   
    
end

%% Plots
Time=toc;
figure;
semilogy(BestCost);

Results.Iteration=MaxIt;
Results.Time=Time;
Results.NFE=NFE;
struct2table(Results)


