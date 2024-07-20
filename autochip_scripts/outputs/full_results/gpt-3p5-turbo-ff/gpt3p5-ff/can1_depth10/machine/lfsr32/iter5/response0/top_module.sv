module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk) begin
        if (reset)
            q <= 32'h1;
        else begin
            q_next[0] <= q[21] ^ q[1] ^ q[0];
            q_next[31:1] <= {q[30:1], q_next[0]};
            q <= q_next;
        end
    end

endmodule
