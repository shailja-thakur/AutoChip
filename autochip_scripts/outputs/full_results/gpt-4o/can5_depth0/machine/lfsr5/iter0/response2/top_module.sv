module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    always @(*) begin
        q_next = {q[4:1], q[0]};      // q_next[4:1] = q[4:1], q_next[0] = q[0]
        q_next[4] = q[0];             // LSB bit becomes the MSB
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] XORed with LSB bit
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;                // reset value
        else
            q <= q_next;              // state transition
    end

endmodule
