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
    next_q = {q[30:0], q[0] ^ q[21] ^ q[22] ^ q[31]};
end

endmodule
