module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    always @(q) begin
        q_next = q[4:1]; // q_next is assigned with q[4:1]
        q_next[4] = q[0]; // q_next[4] is assigned with q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // q is assigned with 5'h1 at reset
        else
            q <= q_next; // q is assigned with q_next at positive edge of clk
    end
endmodule
