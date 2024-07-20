module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    reg [31:0] q_next;  // Register to hold the next value

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;  // Reset the register to the initial value
        end else begin
            q <= q_next;  // Update q with the next value
        end
    end

    always @ (*) begin
        q_next = {q[30:0], q[0]};  // Shift q register by 1 bit

        // XOR operations
        q_next[31] = q[0];
        q_next[21] = q[21] ^ q[0];
        q_next[1]  = q[1] ^ q[0];
        q_next[0]  = q[0] ^ q[0];  // This XOR will always be 0
    end

endmodule
