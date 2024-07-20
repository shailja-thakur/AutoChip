module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // Always block for state transition based on q changes
    always @(*) begin
        q_next = {q[3:0], q[0]}; // q_next is assigned with q[4:1], q_next[4] = q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with q[0]
    end

    // Always block for updating q on positive clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset state
        else
            q <= q_next; // State transition
    end

endmodule
