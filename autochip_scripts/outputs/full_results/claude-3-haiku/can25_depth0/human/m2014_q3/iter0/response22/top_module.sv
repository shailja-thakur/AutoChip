module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b0010, 4'b1010: f = 1'b0; // d, 0, d, d
        4'b0100, 4'b0101, 4'b1000: f = 1'b1; // 0, d, 1, 0
        4'b1100, 4'b1101, 4'b1110: f = 1'b1; // 1, 1, d, d
        default: f = 1'b0;
    endcase
end

endmodule
