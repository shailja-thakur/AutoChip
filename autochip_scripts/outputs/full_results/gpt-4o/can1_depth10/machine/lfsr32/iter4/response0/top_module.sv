module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= q_next;
        end
    end

    always @(*) begin
        // Feedback calculation based on the specifications
        // Bits 21 and 1 are XORed with the value of bit 0, and bit 0 itself is XORed with these calculated values
        q_next = {q[30:0], q[0] ^ q[21] ^ q[1]};
    end

endmodule
