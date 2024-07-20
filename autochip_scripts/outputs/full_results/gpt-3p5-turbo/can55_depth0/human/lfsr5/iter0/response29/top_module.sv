module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q_next <= 5'b1;
        else
            q_next <= {q[3] ^ q[4], q[0:3]};
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'b1;
        else
            q <= q_next;
    end
endmodule
