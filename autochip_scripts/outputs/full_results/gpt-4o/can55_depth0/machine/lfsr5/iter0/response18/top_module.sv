module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] q_next;

always @(*) begin
    q_next = {q[0], q[4:1]};    // State transition based on q changes
    q_next[2] = q_next[2] ^ q[0];
end

always @(posedge clk or posedge reset) begin
    if (reset) 
        q <= 5'h1;             // Reset condition
    else 
        q <= q_next;           // Update state on clock edge
end

endmodule
