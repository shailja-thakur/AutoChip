module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);

always @(*) begin
	case(code)
		8'h45: out = 4'h0;
		8'h16: out = 4'h1;
		8'h1e: out = 4'h2;
		8'h26: out = 4'h3;
		8'h25: out = 4'h4;
		8'h2e: out = 4'h5;
		8'h36: out = 4'h6;
		8'h3d: out = 4'h7;
		8'h3e: out = 4'h8;
		8'h46: out = 4'h9;
		default: out = 4'h0;
	endcase
	
	if (out == 4'h0) begin
		valid = 1'b0;
	end else begin
		valid = 1'b1;
	end
end

endmodule
