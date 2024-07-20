module top_module(
    input clk,
    input d,
    output reg q);

    // Two single edge-triggered flip-flops to mimic dual-edge behavior
    reg q_posedge, q_negedge;

    always @(posedge clk) begin
        q_posedge <= d;
    end

    always @(negedge clk) begin
        q_negedge <= d;
    end

    // Combining the values from both flip-flops
    always @(posedge clk or negedge clk) begin
        q <= clk ? q_posedge : q_negedge;
    end
endmodule
