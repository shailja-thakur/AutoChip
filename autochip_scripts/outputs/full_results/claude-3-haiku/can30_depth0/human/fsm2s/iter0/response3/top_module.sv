module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

typedef enum {OFF, ON} state_t;
state_t state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= OFF;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        OFF: begin
            if (j)
                next_state = ON;
            else
                next_state = OFF;
            out = 0;
        end
        ON: begin
            if (k)
                next_state = OFF;
            else
                next_state = ON;
            out = 1;
        end
        default: begin
            next_state = OFF;
            out = 0;
        end
    endcase
end

endmodule
