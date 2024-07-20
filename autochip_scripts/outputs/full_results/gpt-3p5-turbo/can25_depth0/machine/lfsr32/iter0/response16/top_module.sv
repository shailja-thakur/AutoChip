module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;   // Register to store next value of q

    always @(posedge clk) begin
        if (reset)
            q <= 32'h1;  // Reset q to initial value
        else
            q <= q_next;  // Update q with the value stored in q_next

        // Update q_next on every clock cycle
        q_next[31:1] <= q[30:0];  // Shift all bits of q to the right
        q_next[21] <= q[0] ^ q[21];  // XOR bit 0 with bit 21 and store in q_next[21]
        q_next[1] <= q[0] ^ q[1];  // XOR bit 0 with bit 1 and store in q_next[1]
        q_next[0] <= q[0] ^ q[0];  // XOR bit 0 with bit 0 and store in q_next[0]
    end

endmodule
