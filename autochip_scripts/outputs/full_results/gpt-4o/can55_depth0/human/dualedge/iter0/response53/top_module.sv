module top_module(
    input clk,
    input d,
    output reg q);

    reg d_pos, d_neg;

    always @(posedge clk) begin
        d_pos <= d;
    end

    always @(negedge clk) begin
        d_neg <= d;
    end

    always @(posedge clk or negedge clk) begin
        if (clk)
            q <= d_pos;
        else
            q <= d_neg;
    end

endmodule
