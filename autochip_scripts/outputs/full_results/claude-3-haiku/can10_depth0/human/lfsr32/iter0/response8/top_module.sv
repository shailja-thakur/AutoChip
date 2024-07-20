module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

reg [31:0] next_q;

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q[31] = q[0];
    next_q[30:23] = q[31:22];
    next_q[22] = q[0] ^ q[22];
    next_q[21:3] = q[30:2];
    next_q[2] = q[0] ^ q[2];
    next_q[1] = q[0] ^ q[1];
    next_q[0] = q[0];
end

endmodule
