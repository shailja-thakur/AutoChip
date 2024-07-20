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
    next_q[31] = q[0] ^ q[10] ^ q[30] ^ q[31];
    next_q[30:1] = q[29:0];
    next_q[0] = q[0] ^ q[10] ^ q[30] ^ q[31];
end

endmodule
