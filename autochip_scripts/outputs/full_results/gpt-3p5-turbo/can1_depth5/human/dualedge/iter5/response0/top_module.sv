module top_module(
    input clk,
    input d,
    output reg q);

    reg q1, q2;
    reg q1_q2;

    always @(posedge clk) begin
        q1 <= d;
        q1_q2 <= q1 ^ q2;
        q2 <= q1;
    end

    always @(posedge clk) begin
        if (q1_q2) begin
            q <= q1;
        end
    end

endmodule
