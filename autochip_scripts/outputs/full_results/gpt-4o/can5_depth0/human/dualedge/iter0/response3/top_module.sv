module top_module(
    input clk,
    input d,
    output reg q);

    reg clk_prev;
    
    always @(posedge clk or negedge clk) begin
        clk_prev <= clk;
    end

    always @(posedge clk or negedge clk) begin
        if (clk ^ clk_prev) // XOR to detect a clock edge change (rise or fall)
            q <= d;
    end

endmodule
