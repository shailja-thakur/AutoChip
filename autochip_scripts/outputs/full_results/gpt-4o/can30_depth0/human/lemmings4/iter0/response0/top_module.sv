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
typedef enum logic [2:0] {
    WALK_LEFT = 3'b000,
    WALK_RIGHT = 3'b001,
    FALL_LEFT = 3'b010,
    FALL_RIGHT = 3'b011,
    DIG_LEFT = 3'b100,
    DIG_RIGHT = 3'b101,
    SPLATTER = 3'b110
} state_t;

state_t state, next_state;
reg [4:0] fall_count; // 5-bit counter to count falls up to 20

// Asynchronous reset
always @(posedge areset or posedge clk) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end else begin
        state <= next_state;
        if (state == FALL_LEFT || state == FALL_RIGHT)
            fall_count <= fall_count + 1;
        else
            fall_count <= 0;
    end
end

// State transition logic
always @(*) begin
    next_state = state; // Default to self transition
    case (state)
        WALK_LEFT: begin
            if (~ground)
                next_state = FALL_LEFT;
            else if (dig)
                next_state = DIG_LEFT;
            else if (bump_left)
                next_state = WALK_RIGHT;
        end
        WALK_RIGHT: begin
            if (~ground)
                next_state = FALL_RIGHT;
            else if (dig)
                next_state = DIG_RIGHT;
            else if (bump_right)
                next_state = WALK_LEFT;
        end
        FALL_LEFT: begin
            if (ground && fall_count > 20)
                next_state = SPLATTER;
            else if (ground)
                next_state = WALK_LEFT;
        end
        FALL_RIGHT: begin
            if (ground && fall_count > 20)
                next_state = SPLATTER;
            else if (ground)
                next_state = WALK_RIGHT;
        end
        DIG_LEFT: begin
            if (~ground)
                next_state = FALL_LEFT;
        end
        DIG_RIGHT: begin
            if (~ground)
                next_state = FALL_RIGHT;
        end
        SPLATTER: begin
            next_state = SPLATTER; // Remain splattered
        end
    endcase
end

// Output logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
            end
            FALL_LEFT: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
            end
            FALL_RIGHT: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
            end
            DIG_LEFT: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
            end
            DIG_RIGHT: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
            end
            SPLATTER: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
end

endmodule
