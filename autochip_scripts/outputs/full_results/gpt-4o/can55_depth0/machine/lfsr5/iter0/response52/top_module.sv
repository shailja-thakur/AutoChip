module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // Always block for state transitions
    always @(*) begin
        q_next = q[4:1]; // Assign q[4:1] to q_next
        q_next[4] = q[0]; // Assign q[0] (LSB) to q_next[4]
        q_next[2] = q_next[2] ^ q[0]; // XOR q[0] with q_next[2]
    end

    // Always block for sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Assign reset value to q
        end else begin
            q <= q_next; // Update q with q_next
        end
    end

endmodule
