module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    // Internal signal for next state
    reg [4:0] q_next;

    // First always block for state transition logic
    always @(*) begin
        q_next = q[4:1];        // Assign q[4:1] to q_next[3:0]
        q_next[4] = q[0];       // Assign LSB bit q[0] to q_next[4]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] xored with q[0]
    end

    // Second always block for state update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Assign reset value when reset is active
        end else begin
            q <= q_next; // Assign next state when reset is inactive
        end
    end

endmodule
