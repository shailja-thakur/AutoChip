module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    reg Q_next;

    always @(posedge clk) begin
        if (E) begin
            if (L) begin
                Q <= R;
            end else begin
                Q <= Q_next;
            end
        end
    end
    
    always @* begin
        if (E) begin
            Q_next = w;
        end
    end
    
    always @(posedge clk) begin
        Q <= Q_next;
    end
    
endmodule
