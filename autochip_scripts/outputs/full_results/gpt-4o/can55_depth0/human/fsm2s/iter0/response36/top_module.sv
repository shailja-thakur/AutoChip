module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    typedef enum logic [1:0] {OFF=2'b00, ON=2'b01} state_t;
    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
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
