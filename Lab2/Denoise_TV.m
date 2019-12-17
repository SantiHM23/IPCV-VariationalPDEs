function uk=Denoise_TV(f,tao,K,lambda,eps)
%eps=ones(size(f))*eps;
for k=1:K
    if k==1
        uk=f;
    else
        Igradx = gradx(uk);
        Igrady = grady(uk);
        graduk = sqrt(Igradx.^2 + Igrady.^2);
        divx=Igradx./sqrt((graduk).^2+eps);
        divy=Igrady./sqrt((graduk).^2+eps);
        uk=uk+tao*(lambda*(f-uk)+div(divx,divy));
    end
end
