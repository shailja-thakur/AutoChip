module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

// Define states for the finite state machine
typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALLING,
    DIGGING,
    SPLATTERED
} state_t;

// Define states for the sub-state machine
typedef enum logic [1:0] {
    DIGGING_LEFT,
    DIGGING_RIGHT
} dig_state_t;

// Define signals for the finite state machine and sub-state machine
reg [2:0] curr_state, next_state;
reg [1:0] curr_dig_state, next_dig_state;
reg [4:0] fall_counter;

// Define output signals
assign walk_left = (curr_state == WALK_LEFT);
assign walk_right = (curr_state == WALK_RIGHT);
assign aaah = (curr_state == FALLING) && (fall_counter >= 20);
assign digging = (curr_state == DIGGING);

// State transition and output logic
always@(posedge clk or posedge areset) begin
    if (areset) begin
        curr_state <= WALK_LEFT;
        next_state <= WALK_LEFT;
    end else begin
        curr_state <= next_state;
        curr_dig_state <= next_dig_state;
        fall_counter <= (ground == 0 && curr_state == FALLING) ? fall_counter + 1 : 0;
    end
end

always@(*) begin
    case (curr_state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (!ground && !dig) begin
                next_state = FALLING;
            end else if (dig && ground) begin
                next_state = DIGGING;
                next_dig_state = DIGGING_LEFT;
            end else begin
                next_state = WALK_LEFT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (!ground && !dig) begin
                next_state = FALLING;
            end else if (dig && ground) begin
                next_state = DIGGING;
                next_dig_state = DIGGING_RIGHT;
            end else begin
                next_state = WALK_RIGHT;
            end
        end
        FALLING: begin
            if (ground) begin
                next_state = curr_state; // Continue falling in the same direction
            end else begin
                next_state = FALLING;
            end
        end
        DIGGING: begin
            if (!dig || !ground) begin
                next_state = curr_state;
                next_dig_state = curr_dig_state;
            end else if (curr_dig_state == DIGGING_LEFT) begin
                next_state = DIGGING;
                next_dig_state = (ground) ? DIGGING_LEFT : DIGGING_RIGHT;
            end else begin // curr_dig_state == DIGGING_RIGHT
                next_state = DIGGING;
                next_dig_state = (ground) ? DIGGING_RIGHT : DIGGING_LEFT;
            end
        end
        default: begin // SPLATTERED
            next_state = SPLATTERED;
        end
    endcase
end

endmodule
