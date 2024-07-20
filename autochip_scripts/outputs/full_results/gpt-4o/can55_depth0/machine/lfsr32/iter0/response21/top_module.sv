module top_module (
    input clk,
    input reset,
    output reg [31:0] q
);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1;
        else
            q <= q_next;
    end

    always @(*) begin
        // Shifting q register by 1 bit
        q_next = {q[30:0], q[31]};
        // Updating bits with XOR operation
        q_next[31] = q[0];
        q_next[21] = q[1] ^ q[0];
        q_next[1] = q[0] ^ q[1];
        q_next[0] = q[0] ^ q[0];
    end

endmodule
