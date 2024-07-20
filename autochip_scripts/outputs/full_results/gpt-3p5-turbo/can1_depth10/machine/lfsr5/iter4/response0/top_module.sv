module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    always @(posedge clk) begin
        if (reset)
            q <= 5'b1;
        else
            q <= q_next;
    end

    always @(q) begin
        q_next[4:1] = q[3:0];
        q_next[0] = q[4];
        q_next[2] = q[0] ^ q[1];
    end

endmodule
