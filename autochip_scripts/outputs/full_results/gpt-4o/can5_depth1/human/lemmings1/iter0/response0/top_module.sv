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
        LEFT = 2'b01,
        RIGHT = 2'b10
    } state_t;
    
    state_t current_state, next_state;

    // Moore Machine State Transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= LEFT;
        end 
        else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            LEFT: begin
                if (bump_left) begin
                    next_state = RIGHT;
                end
                else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (bump_right) begin
                    next_state = LEFT;
                end
                else begin
                    next_state = RIGHT;
                end
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
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
