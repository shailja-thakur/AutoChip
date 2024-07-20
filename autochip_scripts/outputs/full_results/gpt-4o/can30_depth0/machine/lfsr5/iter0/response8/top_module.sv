module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block for state transition logic
    always @(*) begin
        q_next = q[4:1];  // Assign q_next with q[4:1]
        q_next[4] = q[0]; // Assign the MSB of q_next with LSB bit of q
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with q[0]
    end

    // Second always block for sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset value for q
        else
            q <= q_next; // State transition
    end

endmodule
