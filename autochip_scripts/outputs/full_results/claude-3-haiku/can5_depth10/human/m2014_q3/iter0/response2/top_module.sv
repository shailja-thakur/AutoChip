module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b0101, 4'b1010, 4'b1011: f = 1'b0; // Don't care outputs as 0
        4'b0001, 4'b0111, 4'b1100, 4'b1101: f = 1'b1; // Don't care outputs as 1
        default: f = 1'b1; // All other cases output 1
    endcase
end

endmodule
