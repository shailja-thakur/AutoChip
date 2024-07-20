module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition logic
    always @(q) begin
        q_next = q[4:1];   // Assign q[4:1] to q_next's 4 MSBs
        q_next[4] = q[0];  // Assign LSB of q to MSB of q_next
        q_next[2] = q_next[2] ^ q[0];  // XOR q_next[2] with q's LSB
    end

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;  // Assign reset value
        else
            q <= q_next;  // State transition
    end

endmodule
