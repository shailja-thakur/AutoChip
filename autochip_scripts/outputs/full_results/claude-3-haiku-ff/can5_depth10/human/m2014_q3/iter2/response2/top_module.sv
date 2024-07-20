module top_module (
    input [3:0] x,
    output logic f
);

always_comb begin
    case ({x[3], x[2], x[1], x[0]})
        4'b0000, 4'b0011, 4'b1100, 4'b1111: f = 1'b0;
        4'b0101, 4'b1001, 4'b1010: f = 1'b1;
        default: f = 1'b1;
    endcase
end

endmodule
