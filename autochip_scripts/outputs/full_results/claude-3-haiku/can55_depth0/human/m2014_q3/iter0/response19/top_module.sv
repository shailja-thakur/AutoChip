module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0001, 4'b1000, 4'b1001, 4'b1010: f = 1'b1; // 01, 11, 10
        4'b0010, 4'b0100, 4'b1011: f = 1'b0; // 00, 01, 11
        default: f = 1'b0; // Don't-care cases
    endcase
end

endmodule
