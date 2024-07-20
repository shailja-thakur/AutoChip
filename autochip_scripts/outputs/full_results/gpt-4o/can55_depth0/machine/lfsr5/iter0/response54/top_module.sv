module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition definition
    always @(q) begin
        q_next = q[4:1]; // Assign with q except LSB
        q_next[4] = q[0]; // Assign q_next[4] with LSB of q
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with LSB of q
    end

    // Logic description
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset value
        else
            q <= q_next; // State transition
    end

endmodule
