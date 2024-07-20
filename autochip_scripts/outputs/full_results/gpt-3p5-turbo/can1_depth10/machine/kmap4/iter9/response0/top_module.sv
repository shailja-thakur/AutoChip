module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    always @* begin
        case({a, b, c, d})
            4'b0000: out = 1'b0; 
            4'b0001: out = 1'b0; // Set output value for 4'b0001 as 0
            4'b0010: out = 1'b0; // Set output value for 4'b0010 as 0
            4'b0011: out = 1'b0; // Set output value for 4'b0011 as 0
            4'b0100: out = 1'b0; // Set output value for 4'b0100 as 0
            4'b0101: out = 1'b0; // Set output value for 4'b0101 as 0
            4'b0110: out = 1'b0; // Set output value for 4'b0110 as 0
            4'b0111: out = 1'b0; // Set output value for 4'b0111 as 0
            4'b1000: out = 1'b0; // Set output value for 4'b1000 as 0
            4'b1001: out = 1'b0; // Set output value for 4'b1001 as 0
            4'b1010: out = 1'b0; // Set output value for 4'b1010 as 0
            4'b1011: out = 1'b0; // Set output value for 4'b1011 as 0
            4'b1100: out = 1'b0; // Set output value for 4'b1100 as 0
            4'b1101: out = 1'b0; // Set output value for 4'b1101 as 0
            4'b1110: out = 1'b0; // Set output value for 4'b1110 as 0
            4'b1111: out = 1'b1; // Set output value for 4'b1111 as 1
        endcase
    end
endmodule
