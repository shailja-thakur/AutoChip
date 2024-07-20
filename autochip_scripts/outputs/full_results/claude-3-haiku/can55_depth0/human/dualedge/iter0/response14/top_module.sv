module top_module(
    input clk,
    input d,
    output reg q
);

    reg q_posedge, q_negedge;

    // Posedge-triggered flip-flop
    always @(posedge clk) begin
        q_posedge <= d;
    end

    // Negedge-triggered flip-flop
    always @(negedge clk) begin
        q_negedge <= d;
    end

    // Output mux to combine posedge and negedge flip-flops
    always @(posedge clk or negedge clk) begin
        if (clk)
            q <= q_posedge;
        else
            q <= q_negedge;
    end

endmodule
