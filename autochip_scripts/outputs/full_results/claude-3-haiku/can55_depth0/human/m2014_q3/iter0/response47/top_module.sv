module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b0011, 4'b1100, 4'b1101: f = 1'b0; // Don't care cases
        4'b0101: f = 1'b0;
        4'b0111: f = 1'b1;
        4'b1011, 4'b1111: f = 1'b1;
        default: f = 1'bx; // Impossible cases
    endcase
end

endmodule
