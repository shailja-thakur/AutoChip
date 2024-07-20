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
        
        load_next <= (E & L);
        
        if (load_next)
            q_next <= R;
        else if (w)
            q_next <= w;
        else
            q_next <= tmp;
    end
    
    always @(posedge clk) begin
        Q <= q_next;
    end
endmodule
