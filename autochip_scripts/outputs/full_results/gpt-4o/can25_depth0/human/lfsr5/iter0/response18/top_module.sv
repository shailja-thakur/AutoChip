module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset LFSR to 1.
        end
        else begin
            q[4] <= q[3]; // Shift bit 4 to bit 5.
            q[3] <= q[2]; // Shift bit 3 to bit 4.
            q[2] <= q[1]; // Shift bit 2 to bit 3.
            q[1] <= q[0]; // Shift bit 1 to bit 2.
            q[0] <= q[4] ^ q[2]; // XOR of taps 5 and 3 to bit 0.
        end
    end
endmodule
