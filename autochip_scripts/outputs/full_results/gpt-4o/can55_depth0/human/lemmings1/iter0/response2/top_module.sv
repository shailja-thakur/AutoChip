module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT  = 2'b00,
        WALK_RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            default: begin
                next_state = WALK_LEFT; // Default state
            end
        endcase
    end
    
    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic (combinational)
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1; // Default output
                walk_right = 0;
            end
        endcase
    end

endmodule
