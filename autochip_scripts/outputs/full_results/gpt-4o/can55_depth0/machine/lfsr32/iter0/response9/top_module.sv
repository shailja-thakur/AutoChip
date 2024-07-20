module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // Reset to the initial value
        end else begin
            q <= q_next; // Update q with q_next
        end
    end

    always @(*) begin
        q_next = {q[30:0], q[0]}; // Shift q left by 1 bit and wrap q[0] to q[31]
        q_next[0] = q[21] ^ q[1] ^ q[0]; // Bits 21 and 1 XORed with bit 0, q[0] also XORed with itself
    end
endmodule
