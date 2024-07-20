module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset state to 1
        end else begin
            q[4] <= q[0];                  // Shift operation
            q[3] <= q[4];                  // Shift operation
            q[2] <= q[3];                  // Shift operation
            q[1] <= q[2];                  // Shift operation
            q[0] <= q[4] ^ q[2];           // XOR feedback for taps at positions 5 and 3
        end
    end

endmodule
