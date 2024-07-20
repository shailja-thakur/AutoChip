module top_module(
    input clk,
    input d,
    output reg q
);

    reg q_pos, q_neg;
    
    // Capture the value of d on the positive edge of clk
    always @(posedge clk) begin
        q_pos <= d;
    end
    
    // Capture the value of d on the negative edge of clk
    always @(negedge clk) begin
        q_neg <= d;
    end

    // Combine the values captured on both edges
    always @(posedge clk or negedge clk) begin
        if (clk) begin
            q <= q_pos;
        end else begin
            q <= q_neg;
        end
    end

endmodule
