module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition always block
    always @(q) begin
        q_next = q[4:1];       // Take the upper 4 bits of q
        q_next[4] = q[0];      // Assign LSB to the MSB of q_next
        q_next[2] = q_next[2] ^ q[0]; // XOR bit 2 with the original LSB of q
    end

    // Sequential always block for state update
    always @(posedge clk) begin
        if (reset)
            q <= 5'h1;         // Reset value
        else
            q <= q_next;       // Next state
    end

endmodule
