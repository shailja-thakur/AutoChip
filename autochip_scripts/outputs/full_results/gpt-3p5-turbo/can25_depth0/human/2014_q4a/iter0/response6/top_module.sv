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
        if (L == 1'b1) begin
            D <= R;
        end else if (E == 1'b1) begin
            D <= w;
        end else begin
            D <= Q;
        end
    end
    
    always @(posedge clk) begin
        if (L == 1'b1) begin
            Q <= R;
        end else if (E == 1'b1) begin
            Q <= D;
        end
    end
    
endmodule
