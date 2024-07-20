module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = q[4:1]; // Assigning q[4:1] to q_next
        q_next[4] = q[0]; // Assigning q[0] to q_next[4] (MSB)
        q_next[2] = q_next[2] ^ q[0]; // XORing q_next[2] with q[0]
    end

    // State register and reset logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Assigning reset value
        end else begin
            q <= q_next; // Assigning next state
        end
    end
endmodule
