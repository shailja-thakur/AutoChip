module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end else begin
        q[31] <= q[30];
        q[30] <= q[29];
        q[29] <= q[28];
        // Remaining shift register bits
        q[28:2] <= q[27:1];
        // Taps at bit positions 32, 22, 2, and 1
        q[1] <= q[31] ^ q[21] ^ q[1] ^ q[0];
        q[0] <= q[31];
    end
end

endmodule
