module top_module (
    input [4:1] x,
    output logic f
);
    always_comb begin
        case (x)
            4'bxx00: f = 1'b1;
            4'bxx01: f = 1'b0;
            4'bxx10: f = 1'bz;
            4'bxx11: f = 1'b1;
            4'b01xx: f = 1'b1;
            4'b10xx: f = 1'b1;
            4'b11xx: f = 1'bz;
            default: f = 1'b0;
        endcase
    end
endmodule
