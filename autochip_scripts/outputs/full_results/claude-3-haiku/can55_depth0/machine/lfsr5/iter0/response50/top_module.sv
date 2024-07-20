module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next[4:1] = q[4:1];
        q_next[4] = q[0];
        q_next[2] = q[0] ^ q[2];
    end

    // State update logic
    always @(posedge clk) begin
        if (reset)
            q <= 5'h1;
        else
            q <= q_next;
    end

endmodule
