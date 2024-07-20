module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output reg q
);

    always @(*)
    begin
        case ({c, d})
            2'b00: q = 1'b0;
            2'b01: q = 1'b0;
            2'b10: q = a;
            2'b11: q = 1'b1;
        endcase
    end

endmodule
