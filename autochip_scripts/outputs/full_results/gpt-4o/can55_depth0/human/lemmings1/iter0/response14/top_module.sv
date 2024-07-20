module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    typedef enum reg [1:0] {
        WALK_LEFT = 2'b01,
        WALK_RIGHT = 2'b10
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT; // Asynchronous reset to WALK_LEFT state
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_left) begin
                    next_state = WALK_RIGHT; // Switch to WALK_RIGHT if bump_left
                end else begin
                    next_state = WALK_LEFT; // Continue walking left
                end
            end
            WALK_RIGHT: begin
                if (bump_right) begin
                    next_state = WALK_LEFT; // Switch to WALK_LEFT if bump_right
                end else begin
                    next_state = WALK_RIGHT; // Continue walking right
                end
            end
            default: next_state = WALK_LEFT; // Default case
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1'b1; // Initial state when reset is to walk left
            walk_right <= 1'b0;
        end else begin
            case (current_state)
                WALK_LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                WALK_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
            endcase
        end
    end

endmodule
