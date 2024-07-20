module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    // LFSR next state logic with taps at positions 5 and 3.
    wire feedback = q[4] ^ q[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Initialize to 1 on reset.
        end else begin
            q <= {q[3:0], feedback}; // Shift and introduce feedback.
        end
    end

endmodule
