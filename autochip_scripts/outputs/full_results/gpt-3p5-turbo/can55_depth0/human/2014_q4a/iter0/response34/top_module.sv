module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    reg shift_reg;
    
    always @(posedge clk) begin
        if (E) begin
            if (L) begin
                shift_reg <= R;
            end else begin
                shift_reg <= shift_reg << 1;
                shift_reg[0] <= w;
            end
        end
    end
    
    always @(posedge clk) begin
        if (E && !L) begin
            Q <= shift_reg[n];
        end
    end
endmodule
