module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b00001; // Reset the LFSR to the non-zero state 1
    end
    else begin
        q[4:1] <= q[3:0]; // Shift the bits
        q[0] <= q[4] ^ q[2]; // XOR the tapped bits to produce the new LSB
    end
end

endmodule
