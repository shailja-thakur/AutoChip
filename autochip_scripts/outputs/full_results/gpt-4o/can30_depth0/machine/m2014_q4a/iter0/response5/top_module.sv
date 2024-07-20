module top_module (
	input d,
	input ena,
	output logic q
);

always @(*) begin
	if (ena) begin
		q = d;
	end
	// When 'ena' is low, 'q' remains unchanged, assuming 'q' holds the previous value. As 'q' is neither assigned nor changed here.
end

endmodule
