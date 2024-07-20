module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] d; // three D flip-flops

assign z = ~(^d); // output z is the negation of the XOR of all flip-flop outputs

// D flip-flops
always @(posedge clk) begin
    d[0] <= (x ^ d[0]);
    d[1] <= (~d[0] & x);
    d[2] <= (~d[1] | x);
end

endmodule
