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

    typedef enum reg [2:0] {
        LEFT  = 3'b001,
        RIGHT = 3'b010,
        FALL  = 3'b100
    } state_t;

    state_t state, next_state;
    reg prev_ground;

    // State transition logic (combinational logic)
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL: begin
                if (ground && prev_ground == 0) begin
                    if (walk_left)
                        next_state = LEFT;
                    else if (walk_right)
                        next_state = RIGHT;
                end else
                    next_state = FALL;
            end
            default: 
                next_state = LEFT;  // Default fallback state
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            prev_ground <= 1'b1;
        end else begin
            state <= next_state;
            prev_ground <= ground;
        end
    end

    // Output logic (combinational logic)
    always @(*) begin
        case (state)
            LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
            end
            RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
            end
            FALL: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
            end
        endcase
    end

endmodule
