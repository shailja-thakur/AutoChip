module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b10x0: f = 0;
        4'b11x1: f = 1;
        default: f = 1;
    endcase
end

endmodule
