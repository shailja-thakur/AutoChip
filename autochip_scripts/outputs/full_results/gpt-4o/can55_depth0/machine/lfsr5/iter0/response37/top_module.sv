module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    always @(*) begin
        q_next = q[4:1];     // Assign q_next with q except LSB
        q_next[4] = q[0];    // q_next[4] is assigned with q[0] (LSB)
        q_next[2] = q_next[2] ^ q[0];  // q_next[2] is XORed with q[0]
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;   // Reset value of q
        end else begin
            q <= q_next; // State transition
        end
    end

endmodule
