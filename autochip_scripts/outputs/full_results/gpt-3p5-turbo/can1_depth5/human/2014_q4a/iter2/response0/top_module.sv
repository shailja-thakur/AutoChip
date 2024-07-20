module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    reg tmp;
    reg load_next;
    reg q_next;
    
    always @(posedge clk) begin
        if (E) begin
            if (load_next)
                tmp <= R;
            else
                tmp <= Q;
        end else begin
            tmp <= Q;
        end
        
        load_next <= (L) ? 1'b1 : 1'b0;
        
        if (load_next)
            q_next <= tmp;
        else if (w)
            q_next <= w;
        else
            q_next <= Q;
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst)
            Q <= 1'b0;
        else
            Q <= q_next;
    end
endmodule
