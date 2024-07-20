module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    typedef enum reg [1:0] {
        WALK_LEFT  = 2'b01,
        WALK_RIGHT = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @* begin
        case (state)
            WALK_LEFT: begin
                if (bump_left | bump_right) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (bump_left | bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @* begin
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            WALK_RIGHT: begin
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
