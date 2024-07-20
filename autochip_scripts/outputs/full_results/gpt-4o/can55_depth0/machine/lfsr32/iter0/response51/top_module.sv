module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // Reset value
        end else begin
            q <= q_next;
        end
    end

    always @(*) begin
        q_next[31] = q[0];   // Shifting out bit 0 goes to bit 31
        q_next[30:0] = q[31:1];  // Shift right by 1 bit
        q_next[21] = q_next[21] ^ q[0]; // XOR bit 21 with bit 0
        q_next[1] = q_next[1] ^ q[0];   // XOR bit 1 with bit 0
    end

endmodule
