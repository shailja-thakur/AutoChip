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

    typedef enum logic [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALLING_LEFT = 3'b010,
        FALLING_RIGHT = 3'b011,
        DIGGING_LEFT = 3'b100,
        DIGGING_RIGHT = 3'b101,
        SPLATTER = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 5'd0;
        end else begin
            state <= next_state;
            if (state == FALLING_LEFT || state == FALLING_RIGHT) begin
                if (ground)
                    fall_count <= 5'd0;
                else
                    fall_count <= fall_count + 1;
            end else begin
                fall_count <= 5'd0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            
            RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            
            FALLING_LEFT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = LEFT;
                end else
                    next_state = FALLING_LEFT;
            end
            
            FALLING_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = RIGHT;
                end else
                    next_state = FALLING_RIGHT;
            end
            
            DIGGING_LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else
                    next_state = DIGGING_LEFT;
            end
            
            DIGGING_RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else
                    next_state = DIGGING_RIGHT;
            end
            
            SPLATTER: begin
                next_state = SPLATTER;
            end
            
            default: next_state = LEFT;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            case (state)
                LEFT: walk_left <= 1;
                RIGHT: walk_right <= 1;
                FALLING_LEFT: aaah <= 1;
                FALLING_RIGHT: aaah <= 1;
                DIGGING_LEFT: digging <= 1;
                DIGGING_RIGHT: digging <= 1;
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
