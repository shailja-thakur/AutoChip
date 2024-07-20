module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // Reset to 32'h1 on active high reset
        end else begin
            // Calculate the feedback based on taps at bit positions 32, 22, 2, and 1
            wire feedback = q[31] ^ q[21] ^ q[1] ^ q[0];
            q <= {q[30:0], feedback}; // Shift and insert feedback bit
        end
    end
endmodule
