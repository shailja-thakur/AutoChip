module top_module (
	input d,
	input ena,
	output logic q
);

	always @(posedge ena)
		if (ena) begin
			q <= d;
		end
		else begin
			q <= q;  // Added this line to handle the case when ena is low
		end
	
endmodule
