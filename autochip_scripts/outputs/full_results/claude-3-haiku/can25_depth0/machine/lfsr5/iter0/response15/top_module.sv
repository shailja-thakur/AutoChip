module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // First always block for state transition
    always @(*) begin
        q_next[4:1] = q[4:1];  // q_next[4:1] = q[4:1]
        q_next[0]   = q[0];
        q_next[2]   = q[0] ^ q_next[2];
    end

    // Second always block for state update
    always @(posedge clk) begin
        if (reset)
            q <= 5'h1;
        else
            q <= q_next;
    end

endmodule
