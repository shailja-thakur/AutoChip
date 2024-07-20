module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 5'b00001; // On reset, set LFSR to 00001
    else begin
        q[4] <= q[3]; // Shift bit 4 to 3
        q[3] <= q[2]; // Shift bit 3 to 2
        q[2] <= q[1]; // Shift bit 2 to 1
        q[1] <= q[0]; // Shift bit 1 to 0
        q[0] <= q[4] ^ q[2]; // New bit is XOR of bit 4 and bit 2
    end
end

endmodule
