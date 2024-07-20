module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b0111, 4'b1010: f = 1'b0; // x[3:1] = 000, 011, 101
        4'b0101: f = 1'b1;
        4'b1100, 4'b1101, 4'b1111: f = 1'b1; // x[3:1] = 110, 111
        default: f = 1'b0; // Don't care
    endcase
end

endmodule
