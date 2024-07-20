module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

// Input combination
reg [3:0] input_comb;

always @* begin
    // Combine the input bits into a 4-bit vector
    input_comb = {a, b, c, d};
    
    // Determine the output based on the input combination
    case(input_comb)
        4'b0000: out = 1'b0;
        4'b0001: out = 1'b0;
        4'b0010: out = 1'b0;
        4'b0011: out = 1'b0;
        4'b0100: out = 1'b0;
        4'b0101: out = 1'b0;
        4'b0110: out = 1'b0;
        4'b0111: out = 1'b0;
        4'b1000: out = 1'b0;
        4'b1001: out = 1'b0;
        4'b1010: out = 1'b0;
        4'b1011: out = 1'b1;
        4'b1100: out = 1'b0;
        4'b1101: out = 1'b1;
        4'b1110: out = 1'b1;
        4'b1111: out = 1'b1;
        default: out = 1'b0; // Added default case to handle invalid input combinations
    endcase
end

endmodule
