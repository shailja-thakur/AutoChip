module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition
    always @(*) begin
        q_next = {q[0], q[4:1]}; // {q[0]} is the LSB bit followed by q[4:1]
        q_next[2] = q_next[2] ^ q[0]; // Xoring q_next[2] with LSB bit of q
    end

    // Update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset value
        else
            q <= q_next; // State transition
    end

endmodule
