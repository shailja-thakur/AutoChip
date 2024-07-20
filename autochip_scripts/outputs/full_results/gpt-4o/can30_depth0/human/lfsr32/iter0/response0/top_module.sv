module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // Reset the LFSR to the initial value
        end else begin
            // Compute the new MSB using taps at bit positions 32, 22, 2, and 1
            wire feedback = q[31] ^ q[21] ^ q[1] ^ q[0];
            // Shift left and introduce the feedback bit into the least significant bit
            q <= {q[30:0], feedback};
        end
    end
endmodule
