module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    localparam LEFT = 0, RIGHT = 1;
    
    // State register
    reg state, next_state;
    
    // Asynchronous reset and state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT; // On reset, walk left
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            default: begin
                next_state = LEFT; // Default state
            end
        endcase
    end
    
    // Output logic
    always @(state) begin
        case (state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
        endcase
    end

endmodule
