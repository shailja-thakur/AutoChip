module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // first always block: define the state transition of q
    always @(q) begin
        q_next = {q[3:0], q[0]};
        q_next[2] = q_next[2] ^ q[0];
    end

    // second always block: logic description with clk and reset
    always @(posedge clk) begin
        if (reset)
            q <= 5'h1; // reset value
        else
            q <= q_next; // state transition
    end

endmodule
