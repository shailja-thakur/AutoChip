module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

    always @* begin
        case ({a, b, c, d})
            // Cases where q is 1
            4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0111, 4'b1001: q = 1;
            // Cases where q is 0
            4'b0100, 4'b0101, 4'b1000, 4'b1100, 4'b1110, 4'b1111: q = 0;
        endcase
    end
  
endmodule
