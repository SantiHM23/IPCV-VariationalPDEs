function uk=Inpainting_Tichonov(f,M,tao,K,lambda)
for k=1:K
    if k==1
        uk=f;
    else
        Igradx = gradx(uk);
        Igrady = grady(uk);
        uk=uk+tao*(lambda*(f-uk).*M+div(Igradx, Igrady));
    end
end
