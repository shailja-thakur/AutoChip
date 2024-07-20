module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] next_q;
    always @(posedge clk or posedge reset) begin
        if (reset)
            next_q <= 5'b1;
        else begin
            next_q[4] <= q[2] ^ q[4];
            next_q[3] <= q[4] ^ q[3];
            next_q[2] <= q[3] ^ q[2];
            next_q[1] <= q[2] ^ q[1];
            next_q[0] <= q[1] ^ q[0];
        end
    end

    always @(posedge clk)
        if (reset)
            q <= next_q;
        else
            q <= next_q;

endmodule
