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
    
    parameter LEFT = 3'b000, RIGHT = 3'b001, FALL_LEFT = 3'b010, FALL_RIGHT = 3'b011, 
              DIG_LEFT = 3'b100, DIG_RIGHT = 3'b101, SPLAT = 3'b110;
    
    reg [2:0] state, next_state;
    reg [4:0] fall_counter;  // 5-bit counter to count clock cycles for falling
    
    // State transitions
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground) next_state = (fall_counter >= 20) ? SPLAT : LEFT;
                else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) next_state = (fall_counter >= 20) ? SPLAT : RIGHT;
                else next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            SPLAT: next_state = SPLAT;
            default: next_state = LEFT;  // Default case
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (aaah) 
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 0;
        end
    end
    
    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALL_LEFT: aaah = 1;
            FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
    
endmodule
