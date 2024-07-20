module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;  // Reset to initial value
        end
        else begin
            q <= q_next;  // Update q with q_next
        end
    end

    always @(*) begin
        // Compute the next state of the shift register
        q_next = {q[30:0], q[31] ^ q[1] ^ q[21]};

        // XOR bit 0 with itself (which does nothing in practice)
        q_next[31] = q[31] ^ q[0];
    end

endmodule
