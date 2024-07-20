module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    // Tap positions at bit positions 5 and 3: 10011 in binary is 18 in hexadecimal

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Reset state to 1
        end else begin
            q[0] <= q[4]; // The new bit 0 gets the old bit 4
            q[1] <= q[0]; // Shifting the rest of the bits
            q[2] <= q[1];
            q[3] <= q[2] ^ q[4]; // XOR with tap at bit 3
            q[4] <= q[3]; // Shift bit 4
        end
    end
endmodule
