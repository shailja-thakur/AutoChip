module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0001: f = 0;
        4'b0011: f = 1;
        4'b0101: f = 0;
        4'b0110: f = 0;
        4'b1001: f = 1;
        4'b1011: f = 1;
        4'b1100: f = 0;
        4'b1101: f = 0;
        default: f = 1; // Don't care conditions
    endcase
end

endmodule
