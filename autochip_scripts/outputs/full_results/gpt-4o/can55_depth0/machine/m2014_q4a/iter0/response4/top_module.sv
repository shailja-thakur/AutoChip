module top_module (
	input d,
	input ena,
	output logic q
);

always_comb begin
	if (ena) 
		q = d;
	else
		q = q; // q retains its previous value
end

endmodule
