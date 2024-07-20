module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    reg [4:0] q_next;

    // Logic description and state transitions
    always @(q) begin
        q_next = {q[0], q[4:1]}; // Shift q to the right, with q[0] at the MSB
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
    end

    // State transition based on clock and reset signals
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset value
        else
            q <= q_next; // State transition
    end

endmodule
