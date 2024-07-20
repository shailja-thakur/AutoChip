module top_module (
    input [4:1] x,
    output logic f
);

    always_comb begin
        case(x)
            4'b00_00 : f = 1'b1;
            4'b00_01 : f = 1'b0;
            4'b00_11 : f = 1'b0;
            4'b00_10 : f = 1'b1;
            4'b01_00 : f = 1'b0;
            4'b01_01 : f = 1'b0;
            4'b01_11 : f = 1'b0;
            4'b01_10 : f = 1'b0;
            4'b11_00 : f = 1'b1;
            4'b11_01 : f = 1'b1;
            4'b11_11 : f = 1'b1;
            4'b11_10 : f = 1'b0;
            4'b10_00 : f = 1'b1;
            4'b10_01 : f = 1'b1;
            4'b10_11 : f = 1'b0;
            4'b10_10 : f = 1'b1;
            default : f = 1'b0;
        endcase
    end
endmodule
