module top_module(
    input clk,
    input d,
    output reg q);
    
    reg q1;

    always @(posedge clk) begin
        q1 <= d;
    end

    always @(negedge clk) begin
        q <= q1;
    end

endmodule
