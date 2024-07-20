module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next[4:1] = q[3:0]; // Assign q_next[4:1] with q[3:0]
        q_next[0] = q[4];     // Assign q_next[0] with q[4]
        q_next[2] = q[0] ^ q[2]; // XOR q[0] with q[2]
    end

    // Update q on positive edge of clk
    always @(posedge clk) begin
        if (reset)
            q <= 5'h1; // Reset q to 5'h1
        else
            q <= q_next; // Assign q with q_next
    end

endmodule
