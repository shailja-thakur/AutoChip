module top_module (
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

    // Define states
    typedef enum logic [3:0] {
        WALK_LEFT = 4'b0001,
        WALK_RIGHT = 4'b0010,
        FALL_LEFT = 4'b0100,
        FALL_RIGHT = 4'b1000,
        DIG_LEFT = 4'b0001,
        DIG_RIGHT = 4'b0010,
        SPLATTER = 4'b0000
    } state_t;
    
    state_t current_state, next_state;
    logic [4:0] fall_count;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_count <= 5'd0;
        end
        else begin
            current_state <= next_state;
            if (aaah)
                fall_count <= fall_count + 1;
            else
                fall_count <= 5'd0;
        end
    end
    
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
                else next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
                else next_state = WALK_RIGHT;
            end
            FALL_LEFT: begin
                if (!ground && fall_count >= 5'd21) next_state = SPLATTER;
                else if (ground) next_state = WALK_LEFT;
                else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (!ground && fall_count >= 5'd21) next_state = SPLATTER;
                else if (ground) next_state = WALK_RIGHT;
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
            SPLATTER: begin
                next_state = SPLATTER;
            end
        endcase
    end
    
    assign walk_left = (current_state == WALK_LEFT);
    assign walk_right = (current_state == WALK_RIGHT);
    assign aaah = (current_state == FALL_LEFT) || (current_state == FALL_RIGHT);
    assign digging = (current_state == DIG_LEFT) || (current_state == DIG_RIGHT);
    
endmodule
