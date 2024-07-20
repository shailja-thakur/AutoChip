module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b0010, 4'b1010, 4'b1110: f = 1'b0; // x[3]:x[1] = 00, 01, 10, 11
        4'b0011: f = 1'b1;
        4'b0101, 4'b0111, 4'b1001, 4'b1011: f = 1'b1; // x[3]:x[1] = 01, 11
        default: f = 1'b0; // Don't care cases
    endcase
end

endmodule
