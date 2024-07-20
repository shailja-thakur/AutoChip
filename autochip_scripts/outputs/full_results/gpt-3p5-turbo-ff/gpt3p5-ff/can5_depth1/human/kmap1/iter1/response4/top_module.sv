module top_module(
    input a, 
    input b,
    input c,
    output reg out
);

always @(a, b, c) begin
    case ({a, b, c})
        3'b000, 3'b010, 3'b100, 3'b110: out = 1;
        default: out = 0;
    endcase
end

endmodule
