module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    always @(*) begin
        q_next = q[4:1];   // Assign q_next with q except LSB
        q_next[4] = q[0];  // Assign q_next[4] with LSB of q
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with LSB of q
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;  // Assign reset value when reset is active
        else
            q <= q_next;  // Assign q_next at positive edge of clk
    end

endmodule
