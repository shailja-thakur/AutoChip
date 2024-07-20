module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end
    else begin
        q[31] <= q[30];
        q[30:22] <= q[29:21];
        q[21] <= q[20] ^ q[0];
        q[20:2] <= q[19:1];
        q[1] <= q[0] ^ q[31] ^ q[21] ^ q[1];
        q[0] <= q[31];
    end
end

endmodule
