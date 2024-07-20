module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @*
begin
    case({a, b, c, d})
        4'b0000: out = 1'b0; // if the inputs are all 0, output is 0
        4'b1111: out = 1'b1; // if the inputs are all 1, output is 1
        default: out = 1'b0; // for any other combination of the inputs, output is 0
    endcase
end

endmodule
