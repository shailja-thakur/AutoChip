module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;
parameter OFF = 1'b0, ON = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= OFF;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        OFF: begin
            if (j == 1'b0) begin
                next_state = OFF;
            end
            else begin
                next_state = ON;
            end
            out = 1'b0;
        end
        ON: begin
            if (k == 1'b0) begin
                next_state = ON;
            end
            else begin
                next_state = OFF;
            end
            out = 1'b1;
        end
        default: begin
            next_state = OFF;
            out = 1'b0;
        end
    endcase
end

endmodule
