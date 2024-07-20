module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000: f = 1'b0; // x[3]x[4] = 00, x[1]x[2] = 00
        4'b0001: f = 1'b0; // x[3]x[4] = 00, x[1]x[2] = 01
        4'b0011: f = 1'b1; // x[3]x[4] = 00, x[1]x[2] = 11
        4'b0010: f = 1'b1; // x[3]x[4] = 00, x[1]x[2] = 10
        4'b0101: f = 1'b0; // x[3]x[4] = 01, x[1]x[2] = 01
        4'b0111: f = 1'b1; // x[3]x[4] = 01, x[1]x[2] = 11
        4'b0110: f = 1'b0; // x[3]x[4] = 01, x[1]x[2] = 10
        4'b1011: f = 1'b1; // x[3]x[4] = 11, x[1]x[2] = 11
        4'b1010: f = 1'b1; // x[3]x[4] = 11, x[1]x[2] = 10
        default: f = 1'b0; // Don't care cases
    endcase
end

endmodule
