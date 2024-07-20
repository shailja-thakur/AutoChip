module top_module(
    input clk,
    input d,
    output reg q);

    reg d_edge1, d_edge2;

    always @(posedge clk) begin
        d_edge1 <= d;
    end

    always @(negedge clk) begin
        d_edge2 <= d;
    end

    always @(posedge clk or negedge clk) begin
        if (clk)
            q <= d_edge1;
        else
            q <= d_edge2;
    end
    
endmodule
