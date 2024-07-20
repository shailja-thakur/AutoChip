module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case ({x[3], x[4], x[2], x[1]})
            4'b00?0: f = 1'b0;
            4'b00?1: f = 1'b0;
            4'b0101: f = 1'b1;
            4'b0111: f = 1'b1;
            4'b11?0: f = 1'b1;
            4'b1100: f = 1'b1;
            4'b1101: f = 1'b0;
            default: f = 1'b0;
        endcase
    end
endmodule
