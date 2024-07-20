module top_module(
    input clk,
    input d,
    output reg q);

    reg d_pos, d_neg;

    // Latch input data on both edges of the clock
    always @(posedge clk) begin
        d_pos <= d;
    end
    
    always @(negedge clk) begin
        d_neg <= d;
    end

    // Output latch, updates on both edges of the clock
    always @(posedge clk or negedge clk) begin
        q <= (clk) ? d_pos : d_neg;
    end
    
endmodule
