module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= q_next;
        end
    end

    always @(*) begin
        q_next[31] = q[0]; // Shift bit 0 to bit 31
        q_next[30:0] = q[31:1]; // Shift everything else right by 1

        // XORing specific bits with bit 0
        q_next[1] = q_next[1] ^ q[0];
        q_next[21] = q_next[21] ^ q[0];
    end
endmodule
