module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

// 32-bit Galois LFSR with taps at bit positions 32, 22, 2, and 1
always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end else begin
        q <= {q[0], q[31:1]};
        q[0] <= q[31] ^ q[22] ^ q[2] ^ q[1];
    end
end

endmodule
