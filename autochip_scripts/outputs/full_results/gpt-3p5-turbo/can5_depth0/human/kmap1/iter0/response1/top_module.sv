module top_module(
    input a, 
    input b,
    input c,
    output reg out
);
	
	always @(*) begin
		case({a, b, c})
			3'b000: out = 1'b0;
			3'b001: out = 1'b1;
			3'b010: out = 1'b1;
			3'b011: out = 1'b1;
			3'b100: out = 1'b1;
			default: out = 1'b1;
		endcase
	end
	
endmodule
