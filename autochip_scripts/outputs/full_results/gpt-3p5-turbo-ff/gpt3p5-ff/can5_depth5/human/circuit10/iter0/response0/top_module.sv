module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg state;
reg q;

always @(posedge clk) begin
	if (state) begin
		q <= 1'b1;
	end else begin
		q <= 1'b0;
	end
	
	if (a && ~b) begin
		state <= 1'b0;
	end else if (~a && b) begin
		state <= 1'b1;
	end
end

assign state = q;

endmodule
