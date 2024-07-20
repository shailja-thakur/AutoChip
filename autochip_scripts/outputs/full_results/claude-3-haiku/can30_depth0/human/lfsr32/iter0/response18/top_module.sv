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
        q[31] <= q[0];
        q[30:21] <= q[31:22];
        q[20:3] <= q[19:2];
        q[2:1] <= q[1:0] ^ q[31];
        q[0] <= q[31] ^ q[21] ^ q[1] ^ q[0];
    end
end

endmodule
