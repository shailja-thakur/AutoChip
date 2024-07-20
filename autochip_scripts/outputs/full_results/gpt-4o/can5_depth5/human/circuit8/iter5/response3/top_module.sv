module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg p_next, q_next;

    // Sequential logic
    always @(posedge clock) begin
        p <= p_next;
    end

    always @(posedge clock) begin
        q <= q_next;
    end

    always @* begin
        if (clock) begin
            if (a) begin
                p_next = 1;
            end else begin
                p_next = 0;
            end
            q_next = p;
        end else begin
            q_next = q;
        end
    end
    
endmodule
