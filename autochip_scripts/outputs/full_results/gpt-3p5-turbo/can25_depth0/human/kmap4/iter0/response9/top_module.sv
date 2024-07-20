module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @(a, b, c, d) begin
        case ({c, d})
            2'b00: out = a & ~b;
            2'b01: out = ~a & b;
            2'b10: out = a ^ b;
            2'b11: out = ~(a ^ b);
        endcase
    end

endmodule
