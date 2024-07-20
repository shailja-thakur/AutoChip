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

    // Define the states
    typedef enum reg [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground) next_state = LEFT;
                else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) next_state = RIGHT;
                else next_state = FALL_RIGHT;
            end
            default: next_state = LEFT;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) 
            current_state <= LEFT;
        else 
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        case (current_state)
            LEFT: walk_left = 1'b1;
            RIGHT: walk_right = 1'b1;
            FALL_LEFT: aaah = 1'b1;
            FALL_RIGHT: aaah = 1'b1;
        endcase
    end

endmodule
