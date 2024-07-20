module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // Reset the register to the initial value
        end else begin
            q <= q_next; // Update q with q_next on the rising edge of clk
        end
    end

    always @(*) begin
        q_next[31] = q[0];                // MSB gets the shifted out LSB
        q_next[30:1] = q[29:0];           // Shift left by 1 bit
        q_next[0] = q[0] ^ q[1] ^ q[21];  // XOR bit 0 with bit 1 and bit 21
    end

endmodule
