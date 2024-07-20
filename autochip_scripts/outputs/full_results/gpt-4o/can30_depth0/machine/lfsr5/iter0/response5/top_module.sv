module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block: Defines state transitions based on q
    always @(q) begin
        q_next = q[4:1];        // Assign q_next with q except LSB bit
        q_next[4] = q[0];       // Assign q_next[4] with q[0]
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
    end

    // Second always block: Triggered at the positive edge of clk
    always @(posedge clk) begin
        if (reset)
            q <= 5'h1;          // Assign q with reset value 5'h1
        else
            q <= q_next;        // Assign q with the next state value
    end

endmodule
