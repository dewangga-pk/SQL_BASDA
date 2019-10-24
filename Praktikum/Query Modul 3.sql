--Transact SQL

--Program 1

declare
	@bil1 int,
	@bil2 int,
	@selisih int
begin
	select @bil1 = 10
	select @bil2 = 15
	select @selisih = @bil1-@bil2
	print @selisih
	
	if @bil1>=@bil2
		begin
		print('Bilangan 1 lebih atau sama dengan bilangan 2')
		if (@bil1-@bil2)<0
			begin
			print('Selisih antara bilangan 1 dan bilangan 2 bernilai positif : '+str(@bil2-@bil1))
			end
		else
			begin
			print('Selisih antara bilangan 1 dan bilangan 2 bernilai positif : '+str(@selisih))
			end
		end
	else 
		begin
		print('Bilangan 1 kurang atau sama dari bilangan 2')
		if (@bil1-@bil2)<0
			begin
			print('Selisih antara bilangan 1 dan bilangan 2 bernilai positif : '+str(@bil2-@bil1))
			end
		else
			begin
			print('Selisih antara bilangan 1 dan bilangan 2 bernilai positif : '+str(@selisih))
			end
		end
end