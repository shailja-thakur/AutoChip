module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg p_next;
reg q_next;

always @(posedge clock) begin
    case ({p, q, a})
        {2'b00, 1'b0} : begin
            p_next = 1'b0;
            q_next = 1'b0;
        end
        {2'b00, 1'b1} : begin
            p_next = 1'b0;
            q_next = 1'b0;
        end
        {2'b01, 1'b0} : begin
            p_next = 1'b0;
            q_next = 1'b0;
        end
        {2'b01, 1'b1} : begin
            p_next = 1'b0;
            q_next = 1'b0;
        end
        {2'b10, 1'b0} : begin
            p_next = 1'b1;
            q_next = 1'b0;
        end
        {2'b10, 1'b1} : begin
            p_next = 1'b1;
            q_next = 1'b0;
        end
        {2'b11, 1'b0} : begin
            p_next = 1'b0;
            q_next = 1'b1;
        end
        {2'b11, 1'b1} : begin
            p_next = 1'b0;
            q_next = 1'b1;
        end
        default: begin
            p_next = 1'b0;
            q_next = 1'b0;
        end
    endcase
end

always @(posedge clock) begin
    p <= p_next;
    q <= q_next;
end

endmodule
