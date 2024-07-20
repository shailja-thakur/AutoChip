module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);
	always @(code) begin
		case(code)
			8'h45: out <= 4'b0000; // case for input 8'h45
			8'h16: out <= 4'b0001; // case for input 8'h16
			8'h1e: out <= 4'b0010; // case for input 8'h1e
			8'h26: out <= 4'b0011; // case for input 8'h26
			8'h25: out <= 4'b0100; // case for input 8'h25
			8'h2e: out <= 4'b0101; // case for input 8'h2e
			8'h36: out <= 4'b0110; // case for input 8'h36
			8'h3d: out <= 4'b0111; // case for input 8'h3d
			8'h3e: out <= 4'b1000; // case for input 8'h3e
			8'h46: out <= 4'b1001; // case for input 8'h46
			default: out <= 4'b0000; // default case for unmatched input
		endcase
		
		valid <= (out == 4'b0000) ? 1'b0 : 1'b1; // set valid based on value of out
	end
endmodule
