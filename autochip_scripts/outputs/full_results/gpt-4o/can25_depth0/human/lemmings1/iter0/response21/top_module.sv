module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    // States
    typedef enum reg [1:0] {
        LEFT  = 2'b00,
        RIGHT = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end

            RIGHT: begin
                if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end

            default: next_state = LEFT; // Default state as fail-safe
        endcase
    end

    // State Register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
