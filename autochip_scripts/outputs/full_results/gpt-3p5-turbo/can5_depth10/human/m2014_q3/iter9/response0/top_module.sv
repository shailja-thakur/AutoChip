module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case (x)
            4'b00xx: f = 1'b1;
            4'b0010: f = 1'b0;
            4'b0101: f = 1'b0;
            4'b0111: f = 1'b1;
            4'b1100: f = 1'b1;
            4'b11xx: f = 1'b0;
            4'b1010: f = 1'b0;
            default: f = 1'b0;
        endcase
    end
endmodule
