module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    // Define the initial value of q as 32'h1
    initial q = 32'h1;

    // Process that runs on the rising edge of clk or when reset is high
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;  // Reset q to the initial value 32'h1
        end else begin
            q <= q_next;  // Update q with q_next at every clock cycle
        end
    end

    // Process that runs on every clock cycle to determine the next value of q (q_next)
    always @(*) begin
        q_next = {q[30:0], q[31]};  // Shift q to the left by 1 bit and wrap around
        q_next[31] = q[0] ^ q[21] ^ q[1];  // XOR q[0] with q[21] and q[1] for bit 31
    end

endmodule
