module top_module(
    input clk,
    input d,
    output reg q);

    reg q_reg;
    reg q_reg2;
    
    always @(posedge clk or negedge clk) begin
        if (clk) begin
            q_reg <= d;
            q_reg2 <= q_reg;
        end else begin
            q <= q_reg2;
        end
    end

endmodule
