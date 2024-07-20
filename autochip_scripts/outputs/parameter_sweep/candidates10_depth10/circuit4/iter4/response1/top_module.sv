module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output reg q
);

    always @(*)
    begin
        case ({a, b, c, d})
            4'b0000: q = 1'b0;
            4'b0010: q = 1'b0;
            4'b0101: q = 1'b0;
            4'b0110: q = 1'b0;
            4'b1000: q = 1'b0;
            4'b1001: q = 1'b0;
            4'b1010: q = 1'b1;
            4'b1011: q = 1'b1;
            4'b1100: q = 1'b1;
            4'b1101: q = 1'b1;
            4'b1110: q = 1'b1;
            4'b1111: q = 1'b1;
            default: q = 1'b0;
        endcase
    end

endmodule
