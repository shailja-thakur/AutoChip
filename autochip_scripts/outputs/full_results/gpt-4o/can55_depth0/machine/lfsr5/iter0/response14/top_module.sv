module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;  // Declare q_next register
    
    // First always block to define state transition
    always @(q) begin
        q_next = q[4:1];      // Assign q_next with q[4:1]
        q_next[4] = q[0];     // Assign q_next[4] with q[0]
        q_next[2] = q[2] ^ q[0]; // XOR q[2] with q[0] and assign to q_next[2]
    end
    
    // Second always block for state update
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;       // If reset is active, assign q with reset value
        else
            q <= q_next;     // If reset is inactive, assign q with q_next
    end
endmodule
