module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[3], x[4], x[1], x[2]})
        4'b0001: f = 0;
        4'b0011: f = 1;
        4'b0101: f = 1;
        4'b0111: f = 0;
        4'b1001: f = 1;
        4'b1011: f = 1;
        default: f = 1; // Don't care
    endcase
end

endmodule
