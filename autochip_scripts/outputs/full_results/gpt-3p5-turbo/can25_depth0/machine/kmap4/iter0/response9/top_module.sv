module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	case ({a, b, c, d})
	    4'b0000: out = 1'b0; // If inputs a, b, c, and d are all 0, output out is 0
	    4'b1111: out = 1'b1; // If inputs a, b, c, and d are all 1, output out is 1
	    default: out = 1'b0; // For any other combination of inputs, output out is 0
	endcase
end

endmodule
