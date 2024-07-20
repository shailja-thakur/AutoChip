module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define state encoding
    typedef enum reg {
        LEFT = 1'b0,
        RIGHT = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            LEFT: begin
                if (bump_left || (bump_left && bump_right)) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (bump_right || (bump_left && bump_right)) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (current_state)
            LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
        endcase
    end

endmodule
