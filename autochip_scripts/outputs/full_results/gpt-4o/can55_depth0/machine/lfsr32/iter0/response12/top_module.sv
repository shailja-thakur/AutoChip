module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= q_next;
        end
    end

    always @(*) begin
        q_next[31] = q[0];
        q_next[30:22] = q[31:23];
        q_next[21] = q[22];
        q_next[20:2] = q[21:3];
        q_next[1] = q[2];
        q_next[0] = q[1] ^ q[21] ^ q[0];
    end

endmodule
