module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg p_next, q_next;
    
    always @(posedge clock) begin
        p <= p_next;
        q <= q_next;
    end

    always @* begin
        p_next = p;
        q_next = q;
        
        if (a) begin
            p_next = 1;
            q_next = 1;
        end else begin
            if (q) begin
                p_next = 0;
                q_next = q;
            end else begin
                p_next = p;
                q_next = 0;
            end
        end
    end

endmodule
