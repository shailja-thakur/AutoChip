module top_module(
    input clk,
    input d,
    output reg q);
    
    reg temp_q;
    
    always @(posedge clk) begin
        temp_q <= d;
    end
    
    always @(negedge clk) begin
        q <= temp_q;
    end
endmodule
