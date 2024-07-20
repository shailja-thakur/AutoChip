module top_module(
    input clk,
    input d,
    output reg q);
    
    reg q_sync;

    always @(posedge clk) begin
        q_sync <= d;
    end

    always @(negedge clk) begin
        q <= q_sync;
    end
    
endmodule
