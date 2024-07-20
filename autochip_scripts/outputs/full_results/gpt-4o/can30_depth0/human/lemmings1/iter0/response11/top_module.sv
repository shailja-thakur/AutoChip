module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define state encoding
    typedef enum reg [1:0] {
        LEFT,
        RIGHT
    } state_t;
    
    state_t state, next_state;
    
    // Asynchronous reset to walk left
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left || bump_right) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (bump_left || bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            default: next_state = LEFT; // Default case to ensure safe initialization
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1; // Safe default values
                walk_right = 0;
            end
        endcase
    end

endmodule
