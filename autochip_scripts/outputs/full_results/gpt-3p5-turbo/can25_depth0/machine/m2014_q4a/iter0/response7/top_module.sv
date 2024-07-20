module top_module (
	input d,
	input ena,
	output logic q
);

// Assign the output port 'q' with the value of the input port 'd' when the enable port 'ena' is active (high)
always_comb begin
	if (ena) begin
		q = d;
	end
end

endmodule
