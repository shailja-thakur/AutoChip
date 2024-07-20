module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    // States
    typedef enum reg [1:0] {
        LEFT        = 2'b00,
        RIGHT       = 2'b01,
        FALL_LEFT   = 2'b10,
        FALL_RIGHT  = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition (Moore FSM)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    next_state = LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            default: begin
                next_state = LEFT;  // Default state if something goes wrong
            end
        endcase
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule
