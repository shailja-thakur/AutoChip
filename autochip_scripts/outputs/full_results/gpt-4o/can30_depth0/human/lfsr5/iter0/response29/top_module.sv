module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset to 1
        end else begin
            q[0] <= q[4]; // Shift right
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2] ^ q[4]; // Tap at position 3
            q[4] <= q[3]; // Tap at position 5
        end
    end
endmodule
