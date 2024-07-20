module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL_LEFT = 2'b10,
        FALL_RIGHT = 2'b11
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case(state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (bump_left || bump_right) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (bump_left || bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
        end else begin
            case(state)
                WALK_LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                end
                WALK_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                end
                FALL_LEFT, FALL_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                end
            endcase
        end
    end

endmodule
