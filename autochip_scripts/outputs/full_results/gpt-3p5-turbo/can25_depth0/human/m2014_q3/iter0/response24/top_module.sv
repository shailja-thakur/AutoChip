module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case(x)
        4'b00x0: f = 0; // x[4] don't care
        4'b0100: f = 1;
        4'b011x: f = 0;
        4'b11xx: f = 1;
        4'b10x0: f = 0; // x[4] don't care
        default: f = 0; // default don't care
    endcase
end

endmodule
