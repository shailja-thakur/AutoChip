module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);
reg [31:0] q_next;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 32'h1;
    end else begin
        q <= q_next;
    end
end

always @(q) begin
    q_next[0] <= (q[31] ^ q[21] ^ q[1] ^ q[0]);
    q_next[1] <= q[0];
    q_next[2] <= q[1];
    q_next[31:3] <= q[30:2];
end
    
endmodule
