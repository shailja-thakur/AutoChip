module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b0001, 4'b1010: f = 0;
        4'b0011, 4'b1011, 4'b1110, 4'b1111: f = 1;
        default: f = 1; // Don't care condition
    endcase
end

endmodule
