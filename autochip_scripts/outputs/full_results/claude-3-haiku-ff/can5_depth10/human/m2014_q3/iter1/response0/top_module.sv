module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0000, 4'b0010, 4'b1100, 4'b1110: f = 1'b0;
        4'b0101, 4'b1001, 4'b1011: f = 1'b1;
        default: f = 1'b1;
    endcase
end

endmodule
