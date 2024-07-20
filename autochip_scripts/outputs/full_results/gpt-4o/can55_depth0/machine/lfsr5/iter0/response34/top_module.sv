module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block: state transitions
    always @(q) begin
        q_next = q[4:1];   // Assign q_next with q except the LSB bit
        q_next[4] = q[0];  // Assign q_next[4] with q[0] (the LSB bit)
        q_next[2] = q_next[2] ^ q[0];  // XOR q_next[2] with q[0]
    end

    // Second always block: logic description, triggered on positive edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;  // Reset value
        else
            q <= q_next;  // State transition
    end

endmodule
