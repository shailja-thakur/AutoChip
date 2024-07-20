module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

// Intermediate signals
reg ab, cd;

// Internal logic
assign ab = a & b;
assign cd = c & d;

always @* begin
    case ({cd, ab})
        2'b00: out = 1'b1;
        2'b01: out = d;
        2'b10: out = 1'b0;
        2'b11: out = ab;
        default: out = 1'b0;
    endcase
end

endmodule
