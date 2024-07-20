module top_module(
    input [3:0] y,  // corrected the range of y to [3:0]
    input w,
    output reg Y2
);
    
    always_comb begin  // changed always_ff to always_comb
        case(y)  // changed y to 4-bit input variable
            4'b0000: Y2 = 1'b0;  // corrected the output value for 4'b0000
            4'b0001: Y2 = 1'b0;
            4'b0010: Y2 = 1'b1;
            4'b0011: Y2 = 1'b1;
            4'b0100: Y2 = 1'b0;
            4'b0101: Y2 = 1'b1;
            4'b0110: Y2 = 1'b0;
            4'b0111: Y2 = 1'b0;
            4'b1000: Y2 = 1'b0;
            4'b1001: Y2 = 1'b1;
            4'b1010: Y2 = 1'b1;
            4'b1011: Y2 = 1'b1;
            default: Y2 = 1'b0;  // added a default case to handle all other inputs
        endcase
    end
    
endmodule
