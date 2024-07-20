module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

reg [31:0] q_next;
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 32'd1;
    else
        q <= q_next;
    q_next[0] <= q[30] ^ q[0];
    q_next[31:1] <= q[30:0];
end

endmodule
