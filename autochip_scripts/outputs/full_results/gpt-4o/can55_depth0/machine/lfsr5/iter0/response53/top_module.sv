module top_module(
    input clk,
    input reset,
    output reg [4:0] q
    );
    
    reg [4:0] q_next;
    
    // First always block for state transition
    always @(*) begin
        q_next = q[4:1];       // Assign q_next with q[4:1]
        q_next[4] = q[0];      // q_next[4] takes the value of q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
    end
    
    // Second always block for sequential logic based on clk and reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;       // Assign reset value 5'h1
        else
            q <= q_next;     // State transition value
    end
    
endmodule
