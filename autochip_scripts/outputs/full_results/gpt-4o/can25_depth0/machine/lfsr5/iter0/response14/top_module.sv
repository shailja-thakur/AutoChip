module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;
    
    // First always block for state transition logic
    always @(*) begin
        q_next = {q[3:0], q[0]};  // Assign q_next with q[4:1] and q[0] to q_next[4]
        q_next[2] = q_next[2] ^ q[0];  // XOR q_next[2] with q[0]
    end
    
    // Second always block for state update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;  // Reset q to 5'h1
        end else begin
            q <= q_next;  // Update q with q_next
        end
    end

endmodule
