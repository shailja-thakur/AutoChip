module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);

always @(code) begin
	case (code)
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
		default: valid = 1'b0;
	endcase
end

always @(code) begin
	if (code == 8'h45 || code == 8'h16 || code == 8'h1e || code == 8'h26 || code == 8'h25 || code == 8'h2e || code == 8'h36 || code == 8'h3d || code == 8'h3e || code == 8'h46)
		valid = 1'b1;
	else
		valid = 1'b0;
end

endmodule
