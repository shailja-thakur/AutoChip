module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1; // reset the register to the initial value
        else
            q <= q_next; // update the register with the next value
    end

    always @(*) begin
        q_next[31] = q[0]; // bit 31 gets the value of bit 0
        q_next[30:1] = q[29:0]; // shift the rest
        q_next[0] = q[0] ^ q[1] ^ q[21]; // XOR bits 0, 1, and 21
    end
endmodule
