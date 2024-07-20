module top_module
(
    input [4:1] x,
    output logic f
);

    always_comb
    begin
        case (x)
            4'b0000, 4'b0001, 4'b0100, 4'b0101: f = 0;
            4'b0110: f = 1;
            4'b0111: f = x[3] | x[4];
            4'b1000, 4'b1001, 4'b1010: f = 1;
            4'b1011: f = 0;
            4'b1100: f = x[4];
            4'b1101, 4'b1110: f = x[3] & x[4];
            default: f = 0;
        endcase
    end
endmodule
