module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

always @(posedge clk) begin
	// Sequential logic
	state <= a & b;
end

always @(posedge clk) begin
	// Combinational logic
	if(state == 1'b1) begin
		q <= a;
	end else begin
		q <= 1'b0;
	end
end

endmodule
