module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition block
    always @(*) begin
        q_next = q[4:1];     // q[4:1]
        q_next[4] = q[0];    // q_next[4] = q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] ^= q[0]
    end

    // Sequential logic block for state update
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;   // Reset value
        else
            q <= q_next; // State transition
    end

endmodule
