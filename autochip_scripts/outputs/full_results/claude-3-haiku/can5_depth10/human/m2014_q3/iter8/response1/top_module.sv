module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0001, 4'b0011, 4'b1011, 4'b1101, 4'b1111: f = 1'b1;
        4'b0101, 4'b0111, 4'b1001, 4'b1010, 4'b1100: f = 1'b0; // Don't care conditions
        default: f = 1'b0;
    endcase
end

endmodule
