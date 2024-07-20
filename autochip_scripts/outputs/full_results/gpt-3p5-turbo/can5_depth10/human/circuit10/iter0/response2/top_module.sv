module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

// flip flop declaration
reg q;
wire state;

// combination logic
always @(posedge clk) begin
	if (a & ~b)
		q <= 1'b1;
	else if (~a & b)
		q <= 1'b0;
	end
	
	// output state
	assign state = q;
end

endmodule
