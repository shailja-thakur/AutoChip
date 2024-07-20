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
        // Shifting and XORing bits as specified
        q_next[31] = q[0];
        q_next[30] = q[31];
        q_next[29:2] = q[30:3];
        q_next[1] = q[2];
        q_next[0] = q[1] ^ q[21] ^ q[0];
    end

endmodule
