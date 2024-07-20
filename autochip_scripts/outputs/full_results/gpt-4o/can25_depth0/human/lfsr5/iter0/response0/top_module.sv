module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    // Initialize LFSR output to 1 on reset, otherwise implement Galois LFSR with taps at bit positions 5 and 3
    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001;  // Active-high synchronous reset to 1
        end else begin
            q[0] <= q[4];  // Feedback to bit 0
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2] ^ q[4];  // Tap at bit position 3
            q[4] <= q[3];
        end
    end
endmodule
