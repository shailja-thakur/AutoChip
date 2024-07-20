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

    // State encoding
    typedef enum reg [2:0] {
        LEFT = 3'b001,
        RIGHT = 3'b010,
        FALLING_LEFT = 3'b011,
        FALLING_RIGHT = 3'b100
    } state_t;
    
    state_t state, next_state;
    
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALLING_LEFT;
                end else if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALLING_RIGHT;
                end else if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            FALLING_LEFT: begin
                if (ground) begin
                    next_state = LEFT;
                end else begin
                    next_state = FALLING_LEFT;
                end
            end
            FALLING_RIGHT: begin
                if (ground) begin
                    next_state = RIGHT;
                end else begin
                    next_state = FALLING_RIGHT;
                end
            end
            default: next_state = LEFT;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            FALLING_LEFT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
            FALLING_RIGHT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
            default: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
            end
        endcase
    end
    
endmodule
