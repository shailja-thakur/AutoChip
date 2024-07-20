module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @* begin
    case ({a, b, c, d})

        // case for all inputs being 0
        4'b0000: out = 1'b0;
        
        // case for all inputs being 1
        4'b1111: out = 1'b1;

        // case for inputs a=0, b=1, c=0, d=1
        4'b0101: out = 1'b0;
        
        // add more cases for different input combinations as needed
        
        default: out = 1'b0; // default case, output 0 if no other cases match
    endcase
end

endmodule
