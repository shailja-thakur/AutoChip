module top_module(
    input clk,
    input d,
    output reg q);
    
    reg d_latch_pos;
    reg d_latch_neg;

    always @(posedge clk) begin
        d_latch_pos <= d;
    end

    always @(negedge clk) begin
        d_latch_neg <= d;
    end

    always @(posedge clk or negedge clk) begin
        if(clk)
            q <= d_latch_pos;
        else
            q <= d_latch_neg;
    end

endmodule
