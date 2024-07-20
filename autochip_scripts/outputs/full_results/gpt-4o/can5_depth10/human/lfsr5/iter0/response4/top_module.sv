module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    // Galois LFSR with 5 bits and taps at bit positions 5 and 3
    wire feedback;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Active-high synchronous reset to 1.
        end
        else begin
            // Feedback is XOR of tap positions 5 and 3 with the output bit
            feedback = q[4] ^ q[2]; 
            q <= {q[3:0], feedback}; // Shift left and insert feedback
        end
    end

endmodule
