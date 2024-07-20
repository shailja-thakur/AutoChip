module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // state declarations
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    // state update logic
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // next state and output logic
    always @(*) begin
        case (state)
            OFF: begin
                out = 0;
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                out = 1;
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF;
                out = 0;
            end
        endcase
    end

endmodule
