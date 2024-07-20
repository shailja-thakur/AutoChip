module top_module(
    input clk,
    input d,
    output reg q);

    reg q_posedge, q_negedge;

    always @(posedge clk) begin
        q_posedge <= d;
    end

    always @(negedge clk) begin
        q_negedge <= d;
    end

    always @(posedge clk or negedge clk) begin
        q <= clk ? q_negedge : q_posedge;
    end

endmodule
