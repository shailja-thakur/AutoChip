module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b10x0: f = 0;
        4'b11x1: f = 1;
        4'b00x1: f = 0;
        4'b01x0: f = 1;
        4'b11xx: f = 1;
        default: f = 0;
    endcase
end

endmodule
