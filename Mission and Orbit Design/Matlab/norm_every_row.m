function vector = norm_every_row(Matrix)

vector = (sum((Matrix(:,1:3)).^2,2)).^0.5;

end