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
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (ground == 0) begin
                    next_state = FALL;
                end else if (bump_left == 1) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if (ground == 0) begin
                    next_state = FALL;
                end else if (bump_right == 1) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            
            FALL: begin
                if (ground == 1) begin
                    if (state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    next_state = FALL;
                end
            end
            
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            FALL: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end

endmodule
