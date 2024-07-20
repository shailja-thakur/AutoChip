module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    
    reg D;
    
    always @(posedge clk) begin
        if (L) begin
            D <= R;
        end else if (E) begin
            D <= w;
        end
    end
    
    always @(posedge clk) begin
        if (E || L) begin
            Q <= D;
        end
    end

endmodule
