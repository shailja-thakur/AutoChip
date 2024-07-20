module top_module(
    input clk,
    input d,
    output reg q);

    reg q_ff;
    reg q_ff1;

    always @(posedge clk) begin
        q_ff1 <= d;
    end

    always @(posedge clk) begin
        q_ff <= q_ff1;
    end

    always @(negedge clk) begin
        q <= q_ff;
    end

endmodule
