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
        4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111:
            out = 1'b0;
        4'b1011, 4'b1100:
            out = 1'b1;
        default:
            out = 1'b1;
    endcase
end

endmodule
