module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0001, 4'b0101, 4'b1100, 4'b1101: f = 0;
        4'b0011, 4'b1111, 4'b1110: f = 1;
        default: f = 1'bx; // Don't care condition
    endcase
end

endmodule
