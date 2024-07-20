module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b0100, 4'b1010, 4'b1011: f = 1'b0; // Don't care (d) cases can output 0
        4'b0101: f = 1'b1;
        4'b0011, 4'b1100, 4'b1101, 4'b1110: f = 1'b1;
        default: f = 1'b0; // Catch all for any other cases
    endcase
end

endmodule
