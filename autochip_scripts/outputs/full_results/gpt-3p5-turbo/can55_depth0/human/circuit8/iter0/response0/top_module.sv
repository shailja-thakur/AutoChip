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
    
    always @(a or p or q) begin
        case ({a, p, q})
            3'b000: begin
                p_next = 1'b0;
                q_next = 1'b0;
            end
            
            3'b001: begin
                p_next = 1'b0;
                q_next = 1'b1;
            end
            
            3'b010: begin
                p_next = 1'b1;
                q_next = 1'b1;
            end
            
            default: begin
                p_next = 1'b1;
                q_next = 1'b0;
            end
        endcase
    end
endmodule
