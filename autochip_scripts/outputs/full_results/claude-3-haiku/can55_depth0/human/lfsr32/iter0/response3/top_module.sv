module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

reg [31:0] next_q;

always @(*) begin
    next_q[0] = q[31];
    next_q[31:1] = q[30:0];
    next_q[31] = q[31] ^ q[22] ^ q[2] ^ q[0];
end

always @(posedge clk) begin
    if (reset)
        q <= 32'h1;
    else
        q <= next_q;
end

endmodule
