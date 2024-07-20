module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    // Define states
    typedef enum reg [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALL = 2'b10,
        DIG = 2'b11
    } state_t;

    state_t state, next_state;
    reg direction;  // 0: left, 1: right

    // State transitions
    always @(*) begin
        next_state = state;  // Default: stay in the same state
        case (state)
            LEFT: begin
                if (~ground) begin
                    next_state = FALL;
                end
                else if (dig) begin
                    next_state = DIG;
                end
                else if (bump_left) begin
                    next_state = RIGHT;
                end
            end
            RIGHT: begin
                if (~ground) begin
                    next_state = FALL;
                end
                else if (dig) begin
                    next_state = DIG;
                end
                else if (bump_right) begin
                    next_state = LEFT;
                end
            end
            FALL: begin
                if (ground) begin
                    next_state = direction ? RIGHT : LEFT;
                end
            end
            DIG: begin
                if (~ground) begin
                    next_state = FALL;
                end
            end
        endcase
    end

    // State and direction update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            direction <= 0;
        end
        else begin
            state <= next_state;
            if (state == LEFT || state == RIGHT) begin
                direction <= (state == RIGHT);
            end
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALL: aaah = 1;
            DIG: digging = 1;
        endcase
    end

endmodule
