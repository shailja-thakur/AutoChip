module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;   // Reset to the initial state of 1
        end
        else begin
            q[4] <= q[0];                   // Shift left
            q[3] <= q[4] ^ q[0];            // Apply XOR tap from bit positions 4 and 0 (since position is 5 and 3 but zero-indexed)
            q[2] <= q[3];
            q[1] <= q[2];
            q[0] <= q[1];
        end
    end
endmodule
