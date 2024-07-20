module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block: State transition
    always @(*) begin
        q_next = q[4:1];        // q_next is q except the LSB bit
        q_next[4] = q[0];       // q_next[4] is assigned with q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with q[0]
    end

    // Second always block: State update
    always @(posedge clk) begin
        if (reset) begin
            q <= 5'h1;         // Reset value
        end else begin
            q <= q_next;       // State transition
        end
    end

endmodule
