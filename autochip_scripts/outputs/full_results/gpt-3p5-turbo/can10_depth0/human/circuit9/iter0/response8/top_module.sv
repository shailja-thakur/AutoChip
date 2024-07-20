module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

// Flip-flop
always @(posedge clk) begin
    if (a)
        q <= q + 1;
    else
        q <= 0;
end

endmodule
