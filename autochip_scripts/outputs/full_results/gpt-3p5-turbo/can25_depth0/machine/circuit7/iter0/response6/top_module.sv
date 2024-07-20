module top_module (
	input clk,
	input a, 
	output reg q
);

// positive edge-triggered always block
always @(posedge clk) begin
    q <= ~a;
end

endmodule
