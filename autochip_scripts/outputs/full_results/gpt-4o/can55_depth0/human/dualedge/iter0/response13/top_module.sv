module top_module(
    input clk,
    input d,
    output reg q);

    reg q_posedge, q_negedge;

    // Trigger on the positive edge of the clock.
    always @(posedge clk) begin
        q_posedge <= d;
    end

    // Trigger on the negative edge of the clock.
    always @(negedge clk) begin
        q_negedge <= d;
    end

    // Combine the outputs of the two always blocks
    always @(posedge clk or negedge clk) begin
        q <= (clk) ? q_posedge : q_negedge;
    end

endmodule
