module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // Always block for state transitions
    always @(*) begin
        q_next = q[4:1]; // Assign the value of q except the LSB bit to q_next
        q_next[4] = q[0]; // Assign the LSB bit to q_next[4]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with q[0]
    end

    // Always block for sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset value of q
        end else begin
            q <= q_next; // State transition
        end
    end

endmodule
