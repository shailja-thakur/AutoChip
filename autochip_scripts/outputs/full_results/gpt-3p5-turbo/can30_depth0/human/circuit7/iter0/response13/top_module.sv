module top_module (
	input clk,
	input a, 
	output reg q
);
	
	always @(posedge clk) begin
		case ({q, a})
			2'b10: q <= 1; // when q is 1 and a is 0
			2'b00: q <= q; // when q is 0 and a is 0
			2'b01: q <= 0; // when q is 0 and a is 1
			2'b11: q <= 0; // when q is 1 and a is 1
		endcase
	end
	
endmodule
