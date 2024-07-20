module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = q[4:1];          // Assign q_next with q except the LSB bit
        q_next[4] = q[0];         // Assign q_next[4] with q[0] (LSB bit)
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with q[0]
    end

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            q <= 5'h1;           // Assign reset value
        else 
            q <= q_next;         // State transition
    end

endmodule
