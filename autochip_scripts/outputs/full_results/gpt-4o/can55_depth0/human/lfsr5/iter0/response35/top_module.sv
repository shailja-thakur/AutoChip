module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Reset state
        end else begin
            q[4] <= q[0];
            q[3] <= q[4];
            q[2] <= q[3];
            q[1] <= q[2];
            q[0] <= q[1] ^ q[4]; // Taps at bit positions 5 and 3 (q[4] and q[2])
        end
    end
endmodule
