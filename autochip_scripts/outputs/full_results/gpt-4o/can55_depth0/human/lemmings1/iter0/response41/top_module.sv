module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    typedef enum reg {S_LEFT, S_RIGHT} state_t;
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S_LEFT: begin
                if (bump_left || bump_right) begin
                    next_state = S_RIGHT;
                end else begin
                    next_state = S_LEFT;
                end
            end
            S_RIGHT: begin
                if (bump_left || bump_right) begin
                    next_state = S_LEFT;
                end else begin
                    next_state = S_RIGHT;
                end
            end
            default: next_state = S_LEFT;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic (based on state)
    always @(*) begin
        case (state)
            S_LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            S_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1;
                walk_right = 0;
            end
        endcase
    end

endmodule
