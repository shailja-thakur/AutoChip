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

// Define the states
localparam [1:0] 
    WALK_LEFT = 2'b00,
    WALK_RIGHT = 2'b01,
    FALLING = 2'b10,
    DIGGING = 2'b11;

// Declare state variable
reg [1:0] state, next_state;

// Declare counter for fall duration
reg [4:0] fall_counter;

// State transitions
always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) next_state = WALK_RIGHT;
            else if (~ground) next_state = FALLING;
            else if (dig) next_state = DIGGING;
        end
        WALK_RIGHT: begin
            if (bump_left) next_state = WALK_LEFT;
            else if (~ground) next_state = FALLING;
            else if (dig) next_state = DIGGING;
        end
        FALLING: begin
            if (ground) next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end
        DIGGING: begin
            if (~ground) next_state = FALLING;
        end
    endcase
end

// State outputs
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;
    case (state)
        WALK_LEFT: walk_left = 1;
        WALK_RIGHT: walk_right = 1;
        FALLING: aaah = 1;
        DIGGING: digging = 1;
    endcase
end

// State update
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            WALK_LEFT, WALK_RIGHT: begin
                if (~ground) begin
                    state <= FALLING;
                    fall_counter <= 1;
                end
            end
            FALLING: begin
                fall_counter <= fall_counter + 1;
                if (ground & (fall_counter >= 20)) begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            end
            DIGGING: begin
                if (~ground) begin
                    state <= FALLING;
                    fall_counter <= 1;
                end
            end
        endcase
    end
end

endmodule
