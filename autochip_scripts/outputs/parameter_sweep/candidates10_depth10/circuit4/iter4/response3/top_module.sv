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
            2'b00: q = a & b;
            2'b01: q = a | b;
            2'b10: q = a ^ b;
            2'b11: q = a & ~b;
        endcase
    end

endmodule
