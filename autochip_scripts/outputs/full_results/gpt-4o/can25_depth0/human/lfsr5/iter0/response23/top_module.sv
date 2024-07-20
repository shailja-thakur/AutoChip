module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    wire feedback;

    // Feedback for Galois LFSR with taps at bit positions 5 and 3
    assign feedback = q[4] ^ q[2];

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'b00001; // Active-high synchronous reset sets the output to 1
        else begin
            q <= {q[3:0], feedback}; // Shift and apply feedback to the LFSR
        end
    end
endmodule
