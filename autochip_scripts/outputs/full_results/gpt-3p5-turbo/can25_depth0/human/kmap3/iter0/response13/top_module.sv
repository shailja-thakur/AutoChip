module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b00??: out = 1;  // d is don't-care, output 1 for any combination
        4'b0101: out = 1;  // specific combination
        4'b01??: out = d;  // d is don't-care, output d for any combination
        4'b11??: out = 1;  // d is don't-care, output 1 for any combination
        4'b1???: out = 1;  // d is don't-care, output 1 for any combination
        default: out = 0;  // all other combinations
    endcase
end

endmodule
