module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State Transition
    always @* begin
        q_next = q[4:1];   // Assign q[4:1] to q_next
        q_next[4] = q[0];  // Assign LSB q[0] to the MSB of q_next
        q_next[2] = q_next[2] ^ q[0]; // XOR q[0] with q_next[2]
    end

    // State updating on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset value
        else
            q <= q_next; // Update to next state
    end

endmodule
