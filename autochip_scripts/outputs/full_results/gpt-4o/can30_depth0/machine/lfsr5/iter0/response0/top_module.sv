module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;
    
    // State transition logic
    always @* begin
        q_next = {q[3:0], q[0]};    // Assign q[4:1] to q_next[4:1] and q[0] to q_next[4]
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
    end
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;   // Reset value
        else
            q <= q_next; // State transition
    end

endmodule
