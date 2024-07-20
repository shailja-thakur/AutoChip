module top_module(
    input clk,
    input d,
    output reg q);
    reg q_prev;

    always @(posedge clk) begin
        q_prev <= q;
    end

    always @(posedge clk) begin
        if (d) begin
            q <= ~q_prev;
        end
    end
endmodule
