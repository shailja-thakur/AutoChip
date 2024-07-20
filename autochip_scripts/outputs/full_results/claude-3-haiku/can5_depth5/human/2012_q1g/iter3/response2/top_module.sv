module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b0001, 4'b0010, 4'b0100, 4'b1001, 4'b1010, 4'b1100: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
