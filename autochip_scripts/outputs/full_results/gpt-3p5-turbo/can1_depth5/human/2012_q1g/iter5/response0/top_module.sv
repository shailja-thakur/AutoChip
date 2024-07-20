module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case (x)
        4'b0000: f = 1'b1; // 00
        4'b0001: f = 1'b0; // 01
        4'b0011: f = 1'b1; // 11
        4'b0010: f = 1'b0; // 10
        4'b0110: f = 1'b0; // 0110
        4'b0111: f = 1'b0; // 0111
        4'b0101: f = 1'b0; // 0101
        4'b0100: f = 1'b0; // 0100
        4'b1100: f = 1'b0; // 1100
        4'b1101: f = 1'b1; // 1101
        4'b1111: f = 1'b0; // 1111
        4'b1110: f = 1'b1; // 1110
        4'b1010: f = 1'b0; // 1010
        4'b1011: f = 1'b1; // 1011
        4'b1001: f = 1'b0; // 1001
        4'b1000: f = 1'b1; // 1000
        default: f = 1'b0;
    endcase
end

endmodule
