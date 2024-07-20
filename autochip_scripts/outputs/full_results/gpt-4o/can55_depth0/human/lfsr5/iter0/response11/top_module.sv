module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b00001; // Active-high synchronous reset to 1
    end else begin
        q[0] <= q[4]; // Shift right the output bit of the register
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
        q[4] <= q[3] ^ q[0]; // Performing XOR with the taps at bit positions 5 and 3
    end
end

endmodule
