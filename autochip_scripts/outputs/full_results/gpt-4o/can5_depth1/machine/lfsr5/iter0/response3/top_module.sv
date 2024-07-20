module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // always block for state transition
    always @(q) begin
        q_next = {q[0], q[4:1]}; // q_next[4:1] <= q[3:0], q_next[4] <= q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
    end

    // always block for logic description
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // reset value
        end else begin
            q <= q_next; // state transition
        end
    end

endmodule
