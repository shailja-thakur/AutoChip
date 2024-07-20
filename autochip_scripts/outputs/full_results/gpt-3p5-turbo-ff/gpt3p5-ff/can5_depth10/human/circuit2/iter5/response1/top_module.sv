module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

always @* begin
    case ({a, b, c, d})
        4'b0001,
        4'b0010,
        4'b0100,
        4'b0110,
        4'b1000,
        4'b1010,
        4'b1100,
        4'b1111: q = 1;
        default: q = 0;
    endcase
end

endmodule
