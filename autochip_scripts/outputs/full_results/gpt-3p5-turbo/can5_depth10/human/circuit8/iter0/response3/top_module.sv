module top_module (
    input wire clock,
    input wire a, 
    output reg p,
    output reg q
);
    
    reg p_reg;
    reg q_reg;
    
    always @(posedge clock) begin
        if (a == 1'b1) begin
            p_reg <= 1'b0;
            q_reg <= 1'b0;
        end else begin
            p_reg <= p_reg;
            q_reg <= p_reg;
        end
    end
    
    always @(posedge clock) begin
        if (a == 1'b1) begin
            p <= p_reg;
            q <= q_reg;
        end
    end

endmodule
