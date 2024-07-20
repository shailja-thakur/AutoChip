module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @* begin
	// combine the inputs into a 4-bit vector
    case ({a, b, c, d})
    	4'b0000: out = 1'b0; // if all inputs are 0, output is 0
        4'b1111: out = 1'b1; // if all inputs are 1, output is 1
        default: out = 1'b0; // for any other input combination, output is 0
    endcase
end

endmodule
