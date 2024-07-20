module top_module (
	input d,
	input ena,
	output logic q
);

always @(*) begin
	if (ena) begin
		q = d;
	end else begin
		q = q; // Hold the previous value when ena is low
	end
end

endmodule
