function uk=Inpainting_TV(f,M,tao,eps,K,lambda)
for k=1:K
    if k==1
        uk=f;
    else
        Igradx = gradx(uk);
        Igrady = grady(uk);
        graduk = sqrt(Igradx.^2 + Igrady.^2);
        divx=Igradx./sqrt((graduk).^2+eps^2);
        divy=Igrady./sqrt((graduk).^2+eps^2);
        uk=uk+tao*(lambda*((f-uk).*M)+div(divx,divy));
    end
end
