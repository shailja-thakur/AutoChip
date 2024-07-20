module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b00x0: f = 1'b0;
            4'b00x1: f = 1'b0;
            4'b0111: f = 1'b1;
            4'b1100: f = 1'b1;
            default: f = 1'bx; // consider 'x' as don't care value
        endcase
    end
endmodule
