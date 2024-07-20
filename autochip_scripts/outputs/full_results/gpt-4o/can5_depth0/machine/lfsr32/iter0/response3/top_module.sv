module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;  // Reset to initial value
        end else begin
            q <= q_next;
        end
    end

    always @(q) begin
        q_next[31] = q[0];  // Bit 0 shifted to Bit 31
        q_next[30:0] = q[31:1];  // Shift q right by 1
        q_next[0] = q[0] ^ q[21] ^ q[1];  // XOR bits 0, 21, and 1
    end

endmodule
