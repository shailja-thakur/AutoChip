module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block for the state transition logic
    always @(*) begin
        q_next = q[4:1];      // Assign q_next with q[4:1]
        q_next[4] = q[0];     // Assign q[4] with q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
    end

    // Second always block for the sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;        // Assign q with reset value 5'h1
        else
            q <= q_next;      // Assign q with q_next on positive edge of clk
    end

endmodule
