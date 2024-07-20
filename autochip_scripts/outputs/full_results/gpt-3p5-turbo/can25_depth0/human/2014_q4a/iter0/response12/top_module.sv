module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    reg R_reg;
    
    always @(posedge clk) begin
        if (L) begin
            R_reg <= R;
        end else if (E) begin
            R_reg <= Q;
        end else begin
            R_reg <= R_reg;
        end
        
        if (E) begin
            Q <= w;
        end else begin
            Q <= R_reg;
        end
    end

endmodule
