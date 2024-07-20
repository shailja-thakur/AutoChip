module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

// Implement the truth table using a case statement
always @(*) begin
    case({c, d})
        2'b00: out = a & ~b;
        2'b01: out = ~a & b;
        2'b10: out = ~a & ~b;
        2'b11: out = a & b;
    endcase
end

endmodule
