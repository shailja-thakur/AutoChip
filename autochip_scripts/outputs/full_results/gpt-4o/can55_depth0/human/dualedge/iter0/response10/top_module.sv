module top_module(
    input clk,
    input d,
    output reg q);

    reg q_pos, q_neg;

    always @(posedge clk) begin
        q_pos <= d;
    end

    always @(negedge clk) begin
        q_neg <= d;
    end

    // Output logic, triggered by both posedge and negedge clock
    always @* begin
        if (clk)
            q = q_pos;
        else
            q = q_neg;
    end

endmodule
