module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    // Define states
    typedef enum logic [2:0] {
        STATE_WALK_LEFT = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALL_LEFT = 3'b010,
        STATE_FALL_RIGHT = 3'b011,
        STATE_DIG_LEFT = 3'b100,
        STATE_DIG_RIGHT = 3'b101,
        STATE_SPLATTERED = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count; // To count falling cycles, max 32, we need 5 bits
    
    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (aaah)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    // Next state logic
    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                if (!ground) next_state = STATE_FALL_LEFT;
                else if (dig) next_state = STATE_DIG_LEFT;
                else if (bump_left) next_state = STATE_WALK_RIGHT;
                else next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                walk_right = 1;
                if (!ground) next_state = STATE_FALL_RIGHT;
                else if (dig) next_state = STATE_DIG_RIGHT;
                else if (bump_right) next_state = STATE_WALK_LEFT;
                else next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL_LEFT: begin
                aaah = 1;
                if (ground && fall_count > 20) next_state = STATE_SPLATTERED;
                else if (ground) next_state = STATE_WALK_LEFT;
                else next_state = STATE_FALL_LEFT;
            end
            STATE_FALL_RIGHT: begin
                aaah = 1;
                if (ground && fall_count > 20) next_state = STATE_SPLATTERED;
                else if (ground) next_state = STATE_WALK_RIGHT;
                else next_state = STATE_FALL_RIGHT;
            end
            STATE_DIG_LEFT: begin
                digging = 1;
                if (!ground) next_state = STATE_FALL_LEFT;
                else next_state = STATE_DIG_LEFT;
            end
            STATE_DIG_RIGHT: begin
                digging = 1;
                if (!ground) next_state = STATE_FALL_RIGHT;
                else next_state = STATE_DIG_RIGHT;
            end
            STATE_SPLATTERED: begin
                // All outputs remain 0, Lemming is splattered forever
                next_state = STATE_SPLATTERED;
            end
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

endmodule
