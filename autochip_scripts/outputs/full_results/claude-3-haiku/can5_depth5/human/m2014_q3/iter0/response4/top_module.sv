module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b0011, 4'b1011, 4'b1111, 4'b1110: f = 1'b1;
        4'b0001, 4'b0110, 4'b0010: f = 1'b0;
        default: f = 1'b0; // Don't-care (d) is treated as 0
    endcase
end

endmodule
