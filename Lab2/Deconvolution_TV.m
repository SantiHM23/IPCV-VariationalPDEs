function uk=Deconvolution_TV(f,G,tao,eps,K,lambda)
for k=1:K
    if k==1
        uk=f;
    else
        Igradx = gradx(uk);
        Igrady = grady(uk);
        graduk = sqrt(Igradx.^2 + Igrady.^2);
        divx=Igradx./sqrt((graduk).^2+eps^2);
        divy=Igrady./sqrt((graduk).^2+eps^2);
        uk=uk+tao*(lambda*conv2((f-conv2(uk,G,'same')),G,'same')+div(divx,divy));
    end
end
