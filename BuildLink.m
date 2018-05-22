% BuildLink(CandidateNode1,CandidateNode2,Nodes,Links)
% Updated LinkList
function NewLinkList =  BuildLink(Node1,Node2,Nodes,Links,CapValue)
    NewLinkList = Links;
    a=numel(Links);
    NewLinkList(a+1).StartNode=Node1;
    NewLinkList(a+1).EndNode=Node2;
    NewLinkList(a+1).Length=calcLinkLength(Nodes,NewLinkList(a+1));
    NewLinkList(a+1).Capacity=CapValue;
end

