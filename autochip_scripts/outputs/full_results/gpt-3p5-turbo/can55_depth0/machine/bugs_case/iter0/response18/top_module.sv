module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);
	always @*
    begin
		case(code)
            8'h45: out = 4'b0000; // 0
            8'h16: out = 4'b0001; // 1
            8'h1e: out = 4'b0010; // 2
            8'h26: out = 4'b0011; // 3
            8'h25: out = 4'b0100; // 4
            8'h2e: out = 4'b0101; // 5
            8'h36: out = 4'b0110; // 6
            8'h3d: out = 4'b0111; // 7
            8'h3e: out = 4'b1000; // 8
            8'h46: out = 4'b1001; // 9
            default: out = 4'b0000; // Invalid code, set output to 0
        endcase
        valid = (code == 8'h45) | (code == 8'h16) | (code == 8'h1e) | (code == 8'h26) | (code == 8'h25) | (code == 8'h2e) | (code == 8'h36) | (code == 8'h3d) | (code == 8'h3e) | (code == 8'h46);
    end
endmodule
