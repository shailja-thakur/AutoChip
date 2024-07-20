module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block: state transition logic
    always @(*) begin
        q_next = q[4:1];       // Assign q[4:1] to q_next[3:0]
        q_next[4] = q[0];      // Assign q[0] to q_next[4]
        q_next[2] = q_next[2] ^ q[0]; // Xor q_next[2] with q[0]
    end

    // Second always block: state update
    always @(posedge clk or posedge reset) begin
        if (reset) 
            q <= 5'h1;         // Assign q with reset value on reset
        else 
            q <= q_next;       // Assign q with q_next at positive edge of clk
    end
    
endmodule
