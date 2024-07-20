module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

// 5-bit Galois LFSR with taps at bit positions 5 and 3
always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001; // reset to 1
    end
    else begin
        q[4:1] <= q[3:0]; // shift
        q[0] <= q[4] ^ q[2]; // feedback
    end
end

endmodule
