module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    reg D;
    reg Q_next;
    
    always @(posedge clk) begin
        if (E) begin
            D <= w;
        end
        else if (L && R) begin
            D <= R;
        end
        else begin
            D <= Q;
        end
    end
    
    always @(posedge clk) begin
        if (L) begin
            Q <= D;
        end
        else begin
            Q <= Q_next;
        end
    end
    
endmodule
