module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg q_next;
reg state_next;

always @(posedge clk) begin
    q <= q_next;
    state <= state_next;
end

always @(posedge clk) begin
    case (state)
        2'b00: begin
            if (a & b)
                state_next <= 2'b10;
            else
                state_next <= 2'b00;
        end
        2'b01: begin
            if (!a & b)
                state_next <= 2'b00;
            else
                state_next <= 2'b01;
        end
        2'b10: begin
            if (!a & !b)
                state_next <= 2'b00;
            else
                state_next <= 2'b11;
        end
        2'b11: begin
            if (a | b)
                state_next <= 2'b01;
            else
                state_next <= 2'b10;
        end
    endcase
end

always @(posedge clk) begin
    if (state == 2'b01)
        q_next <= a;
    else if (state == 2'b10)
        q_next <= b;
    else
        q_next <= q;
end

endmodule
