module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define state encoding
    typedef enum reg [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_WALK_LEFT: begin
                if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State register logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            STATE_WALK_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
