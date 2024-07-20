module top_module(
    input clk,
    input d,
    output reg q);

    reg q_ff;
    reg q_tmp;

    always @(posedge clk) begin
        q_tmp <= d;
    end

    always @(negedge clk) begin
        q_ff <= q_tmp;
    end

    always @(posedge clk or negedge clk) begin
        q <= q_ff;
    end

endmodule
