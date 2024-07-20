module top_module(
    input clk,
    input d,
    output reg q);

    reg d_posedge, d_negedge;

    always @(posedge clk) begin
        d_posedge <= d;
    end

    always @(negedge clk) begin
        d_negedge <= d;
    end

    always @(posedge clk or negedge clk) begin
        if (clk)
            q <= d_posedge;
        else
            q <= d_negedge;
    end

endmodule
