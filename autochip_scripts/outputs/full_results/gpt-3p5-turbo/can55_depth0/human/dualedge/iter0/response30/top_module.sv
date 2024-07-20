module top_module(
    input clk,
    input d,
    output reg q);
    
    reg q_prev;

    always @(posedge clk) begin
        if (clk) begin
            q <= d;
            q_prev <= q;
        end
        else begin
            q_prev <= q;
        end
    end

    always @(negedge clk) begin
        if (~clk) begin
            q <= q_prev;
        end
    end

endmodule
