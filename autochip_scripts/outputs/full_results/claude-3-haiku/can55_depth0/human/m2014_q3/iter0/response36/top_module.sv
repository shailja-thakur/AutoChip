module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0001: f = 1'b0; // 00 10
        4'b0011: f = 1'b1; // 01 11
        4'b0110: f = 1'b1; // 01 11
        4'b0111: f = 1'b0; // 01 11
        4'b1001: f = 1'b1; // 11 10
        4'b1010: f = 1'b1; // 11 10
        default: f = 1'b0; // Don't care cases
    endcase
end

endmodule
