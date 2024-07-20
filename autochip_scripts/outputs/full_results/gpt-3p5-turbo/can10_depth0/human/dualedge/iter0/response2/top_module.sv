module top_module(
    input clk,
    input d,
    output reg q);
    
    reg q_temp;
    reg clk_prev = 1'b0;

    always @(posedge clk) begin
        if(clk_prev == 1'b0) begin
            q <= d;
        end
        clk_prev <= ~clk_prev;
    end
    
    always @(negedge clk) begin
        if(clk_prev == 1'b0) begin
            q_temp <= d;
        end
    end
    
    always @(posedge clk) begin
        if(clk_prev == 1'b1) begin
            q <= q_temp;
        end
    end

endmodule
