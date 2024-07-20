module top_module (
    input [4:1] x,
    output logic f
);


always_comb begin
    case (x)
        // x[3]x[4]   00 01 11 10
        // Don't care values output 0 (instead of 1)
        4'b00??, 4'b01??,  4'b11??: f = 0;
        4'b0000, 4'b0010,  4'b1000: f = 0;
        4'b0011,  4'b1100, 4'b0110: f = 1;
        default: f = 0;
    endcase
end


endmodule
