module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1;
        else
            q <= q_next;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q_next <= 1;
        else
            q_next <= {q[3] ^ q[0], q[4:1]};
    end
endmodule
