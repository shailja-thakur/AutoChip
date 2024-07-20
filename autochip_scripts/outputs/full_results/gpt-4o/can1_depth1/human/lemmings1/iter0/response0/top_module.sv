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
        STATE_LEFT = 2'b01,
        STATE_RIGHT = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition
    always_comb begin
        case (state)
            STATE_LEFT: 
                if (bump_left)
                    next_state = STATE_RIGHT;
                else
                    next_state = STATE_LEFT;
            
            STATE_RIGHT:
                if (bump_right)
                    next_state = STATE_LEFT;
                else
                    next_state = STATE_RIGHT;

            default:
                next_state = STATE_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end else begin
            case (state)
                STATE_LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                STATE_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
                default: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
            endcase
        end
    end

endmodule
