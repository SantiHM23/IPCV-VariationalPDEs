function uk=Denoise_Tikhonov(f,K,lambda)
%uk+1 = uk + ?(?(f ? uk) + ?uk)
tao=1/(lambda+4);
for k=1:K
    if k==1
        uk=f;
    else
        uk=uk+tao*(lambda*(f-uk)+div(gradx(uk),grady(uk)));
    end
end
