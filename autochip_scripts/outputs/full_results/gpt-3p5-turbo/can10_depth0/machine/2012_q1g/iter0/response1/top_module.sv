module top_module (
    input [4:0] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b0000: f = 1; // If x is 0x0, the output will be 1.
            4'b0001: f = 1; // If x is 0x1, the output will be 1.
            4'b0010: f = 0; // If x is 0x2, the output will be 0.
            4'b0011: f = 0; // If x is 0x3, the output will be 0.
            4'b0100: f = 1; // If x is 0x4, the output will be 1.
            4'b0101: f = 1; // If x is 0x5, the output will be 1.
            4'b0110: f = 1; // If x is 0x6, the output will be 1.
            4'b0111: f = 0; // If x is 0x7, the output will be 0.
            4'b1000: f = 0; // If x is 0x8, the output will be 0.
            4'b1001: f = 0; // If x is 0x9, the output will be 0.
            4'b1010: f = 0; // If x is 0xa, the output will be 0.
            4'b1011: f = 0; // If x is 0xb, the output will be 0.
            4'b1100: f = 1; // If x is 0xc, the output will be 1.
            4'b1101: f = 0; // If x is 0xd, the output will be 0.
            4'b1110: f = 1; // If x is 0xe, the output will be 1.
            4'b1111: f = 1; // If x is 0xf, the output will be 1.
            default: f = 0; // Default case, output is 0.
        endcase
    end

endmodule
