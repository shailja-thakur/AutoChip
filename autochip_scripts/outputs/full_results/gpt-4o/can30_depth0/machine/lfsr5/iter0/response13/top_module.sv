module top_module (
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = q[4:1];        // Shift q right by one
        q_next[4] = q[0];       // Assign MSB of q_next with LSB of q
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with LSB of q
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;          // Assign reset value
        else
            q <= q_next;        // Assign state transition
    end

endmodule
