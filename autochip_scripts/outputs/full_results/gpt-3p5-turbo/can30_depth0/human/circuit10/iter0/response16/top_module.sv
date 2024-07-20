module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    reg state
);
	
	always @(posedge clk) begin
		if (a && b)
			state <= 1'b1;
		else if (~a)
			state <= 1'b0;
	end
	
	always @(posedge clk) begin
		if (state)
			q <= 1'b1;
		else
			q <= 1'b0;
	end

endmodule
