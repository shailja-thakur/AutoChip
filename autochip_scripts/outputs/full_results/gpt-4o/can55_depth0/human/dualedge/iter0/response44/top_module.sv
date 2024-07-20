module top_module(
    input clk,
    input d,
    output reg q);

    reg q_posedge;
    reg q_negedge;

    // Process for positive edge-triggered flip-flop
    always @(posedge clk) begin
        q_posedge <= d;
    end

    // Process for negative edge-triggered flip-flop
    always @(negedge clk) begin
        q_negedge <= d;
    end

    // Combine the outputs of both edge-triggered flip-flops
    always @(*) begin
        if (clk)
            q = q_posedge;
        else
            q = q_negedge;
    end

endmodule
