module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[3], x[4], x[1], x[2]})
        4'b0000, 4'b1010, 4'b1100, 4'b1101: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
