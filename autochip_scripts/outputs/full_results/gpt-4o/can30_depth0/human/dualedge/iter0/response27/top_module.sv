module top_module(
    input clk,
    input d,
    output reg q);

    wire clk_posedge, clk_negedge;
    reg q_pos, q_neg;

    // Detect positive edge of clk
    reg clk_last;
    always @(posedge clk or negedge clk) begin
        clk_last <= clk;
    end
    assign clk_posedge = clk & ~clk_last;
    assign clk_negedge = ~clk & clk_last;

    // Flip-flops for positive and negative edges
    always @(posedge clk) begin
        q_pos <= d;
    end

    always @(negedge clk) begin
        q_neg <= d;
    end

    // Main flip-flop logic
    always @(*) begin
        if (clk_posedge)
            q = q_pos;
        else if (clk_negedge)
            q = q_neg;
    end
endmodule
