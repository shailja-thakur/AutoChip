module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg p_next;
reg q_next;

always @(posedge clock) begin
    case ({a, p, q})
        3'b000: begin
            p_next = 1'b0;
            q_next = 1'b0;
        end
        3'b010: begin
            p_next = 1'b1;
            q_next = 1'b0;
        end
        3'b100: begin
            p_next = 1'b0;
            q_next = 1'b1;
        end
        3'b110: begin
            p_next = 1'b0;
            q_next = 1'b0;
        end
        default: begin
            p_next = p;
            q_next = q;
        end
    endcase

    p <= p_next;
    q <= q_next;
end

endmodule
