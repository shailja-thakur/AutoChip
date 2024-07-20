module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);
	always @(code) begin
		case(code)
			8'h45:	out = 4'b0000;	// key 0
			8'h16:	out = 4'b0001;	// key 1
			8'h1e:	out = 4'b0010;	// key 2
			8'h26:	out = 4'b0011;	// key 3
			8'h25:	out = 4'b0100;	// key 4
			8'h2e:	out = 4'b0101;	// key 5
			8'h36:	out = 4'b0110;	// key 6
			8'h3d:	out = 4'b0111;	// key 7
			8'h3e:	out = 4'b1000;	// key 8
			8'h46:	out = 4'b1001;	// key 9
			default: out = 4'b0000;	// invalid key
		endcase
		valid = (out != 4'b0000); // valid if not key 0
	end
endmodule
