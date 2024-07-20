module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

    // Intermediate wire to hold the 4-bit input combination
    wire [3:0] input_combination;

    // Combine the inputs into a 4-bit vector
    assign input_combination = {a, b, c, d};

    always @(*) begin
        // Use a case statement to determine the output based on the 4-bit input combination
        case (input_combination)
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
            4'b1011: out = 1'b0;
            4'b1100: out = 1'b0;
            4'b1101: out = 1'b0;
            4'b1110: out = 1'b0;
            4'b1111: out = 1'b1;
            default: out = 1'b0;  // Default case to handle any unexpected values
        endcase
    end
    
endmodule
