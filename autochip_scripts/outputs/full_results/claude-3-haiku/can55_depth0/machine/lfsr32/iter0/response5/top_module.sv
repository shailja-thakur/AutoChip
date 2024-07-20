module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // Reset the register to the initial value
        end
        else begin
            q <= q_next; // Update the q register with the next value
        end
    end

    always @(*) begin
        q_next = {q[30:0], q[31]}; // Shift the register value right by 1 bit
        q_next[0] = q[0] ^ q[21] ^ q[1]; // XOR bits 21 and 1 with bit 0
    end

endmodule
