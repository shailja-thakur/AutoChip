module top_module (
	input clk,
	input a, 
	output reg q
);
    
	// Always block triggered on the positive edge of the clock signal
	always @(posedge clk) begin
		q <= ~a;  // Output q is set to the inverse of input a
	end

endmodule
