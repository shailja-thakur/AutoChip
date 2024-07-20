module top_module(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    // State encoding
    typedef enum logic [2:0] {
        S_WALK_LEFT = 3'b000,
        S_WALK_RIGHT = 3'b001,
        S_FALL_LEFT = 3'b010,
        S_FALL_RIGHT = 3'b011,
        S_DIG_LEFT = 3'b100,
        S_DIG_RIGHT = 3'b101,
        S_SPLATTER = 3'b110
    } state_t;
    
    state_t state, next_state;
    logic [4:0] fall_counter;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (!ground && state != S_SPLATTER) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end
    
    always_comb begin
        next_state = state;
        case (state)
            S_WALK_LEFT: begin
                if (!ground) next_state = S_FALL_LEFT;
                else if (dig) next_state = S_DIG_LEFT;
                else if (bump_left || bump_right) next_state = S_WALK_RIGHT;
            end
            S_WALK_RIGHT: begin
                if (!ground) next_state = S_FALL_RIGHT;
                else if (dig) next_state = S_DIG_RIGHT;
                else if (bump_right || bump_left) next_state = S_WALK_LEFT;
            end
            S_FALL_LEFT: begin
                if (fall_counter > 20) next_state = S_SPLATTER;
                else if (ground) next_state = S_WALK_LEFT;
            end
            S_FALL_RIGHT: begin
                if (fall_counter > 20) next_state = S_SPLATTER;
                else if (ground) next_state = S_WALK_RIGHT;
            end
            S_DIG_LEFT: begin
                if (!ground) next_state = S_FALL_LEFT;
            end
            S_DIG_RIGHT: begin
                if (!ground) next_state = S_FALL_RIGHT;
            end
            S_SPLATTER: begin
                // Remains in splatter state.
            end
            default: next_state = S_WALK_LEFT;
        endcase
    end
    
    assign walk_left  = (state == S_WALK_LEFT);
    assign walk_right = (state == S_WALK_RIGHT);
    assign aaah       = (state == S_FALL_LEFT) || (state == S_FALL_RIGHT);
    assign digging    = (state == S_DIG_LEFT) || (state == S_DIG_RIGHT);

endmodule
