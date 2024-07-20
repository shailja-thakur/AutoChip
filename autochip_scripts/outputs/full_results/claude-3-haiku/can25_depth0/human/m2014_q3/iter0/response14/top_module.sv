module top_module (
    input [4:1] x,
    output logic f
);

logic [3:0] x_inv;
assign x_inv = ~x[4:1];

always_comb begin
    case (x_inv)
        4'b0001, 4'b1011, 4'b1100: f = 1'b1;
        4'b0100, 4'b0110, 4'b1010: f = 1'b0;
        default: f = 1'b0; // Don't-care condition, output 0
    endcase
end

endmodule
