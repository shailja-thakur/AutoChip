module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

reg [31:0] next_q;

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q = {q[0], q[31:23], q[21], q[20:3], q[1]};
    if (q[0] ^ q[21] ^ q[1] ^ q[0]) begin
        next_q[0] = 1'b1;
    end else begin
        next_q[0] = 1'b0;
    end
end

endmodule
