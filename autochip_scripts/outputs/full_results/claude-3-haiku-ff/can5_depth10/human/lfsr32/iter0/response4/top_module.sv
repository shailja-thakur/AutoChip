module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1; // Reset the LFSR to the initial state of 32'h1
    end else begin
        q[31] <= q[0]; // Shift the bits
        q[30:0] <= q[31:1];
        q[0] <= q[32] ^ q[22] ^ q[2] ^ q[1]; // XOR the tapped bits to produce the next state
    end
end

endmodule
