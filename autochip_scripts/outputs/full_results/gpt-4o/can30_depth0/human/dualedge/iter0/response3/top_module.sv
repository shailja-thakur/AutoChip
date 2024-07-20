module top_module(
    input clk,
    input d,
    output reg q);

    // Internal signals to capture the value on both edges of the clock
    reg q_posedge, q_negedge;

    always @(posedge clk) begin
        q_posedge <= d;
    end

    always @(negedge clk) begin
        q_negedge <= d;
    end

    always @* begin
        q = clk ? q_posedge : q_negedge;
    end

endmodule
