module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b1010, 4'b1100, 4'b1110: f = 1;
        default: f = 0;
    endcase
end

endmodule
