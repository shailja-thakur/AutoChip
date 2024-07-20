module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            OFF: begin
                out = 0;
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                out = 1;
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: begin
                next_state = OFF;
                out = 0;
            end
        endcase
    end
endmodule
