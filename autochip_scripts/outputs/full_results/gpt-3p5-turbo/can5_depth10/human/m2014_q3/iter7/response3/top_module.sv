module top_module (
    input [4:0] x,
    output logic f
);

    always_comb begin
        case (x)
            5'b00x0: f = 1'b0;
            5'b00x1: f = 1'b0;
            5'b0101: f = 1'b0;
            5'b0111: f = 1'b1;
            5'b11x0: f = 1'b1;
            5'b1100: f = 1'b1;
            5'b1101: f = 1'b0;
            default: f = 1'b0;
        endcase
    end
endmodule
