module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] next_q;

always @(posedge clk) begin
    if (reset)
        q <= 5'b1;
    else
        q <= next_q;
end

always @(*) begin
    next_q[4] = q[4] ^ q[2];
    next_q[3:0] = q[3:0] >> 1;
end

endmodule
