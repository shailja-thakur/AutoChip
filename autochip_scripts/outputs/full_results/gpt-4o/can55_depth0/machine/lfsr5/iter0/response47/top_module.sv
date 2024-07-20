module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = q[4:1];    // q_next is assigned with q except the LSB bit
        q_next[4] = q[0];   // q_next[4] is assigned with q[0], the LSB bit
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
    end

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;    // If reset is active, q is assigned with 5'h1
        end else begin
            q <= q_next;  // If reset is inactive, q is assigned with q_next
        end
    end

endmodule
