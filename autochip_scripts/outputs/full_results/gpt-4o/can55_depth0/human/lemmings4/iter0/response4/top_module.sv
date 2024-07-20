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
    // State encoding
    typedef enum logic [3:0] {
        WALK_LEFT    = 4'd0,
        WALK_RIGHT   = 4'd1,
        FALL_LEFT    = 4'd2,
        FALL_RIGHT   = 4'd3,
        DIG_LEFT     = 4'd4,
        DIG_RIGHT    = 4'd5,
        SPLATTER     = 4'd6
    } state_t;
    
    state_t state, next_state;
    logic [4:0] fall_count; // 5 bits to count up to 20

    // State transition and fall counter
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end
        else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                fall_count <= fall_count + 1;
            end
            else begin
                fall_count <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
            end
            FALL_LEFT: begin
                if (ground) next_state = (fall_count > 20) ? SPLATTER : WALK_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) next_state = (fall_count > 20) ? SPLATTER : WALK_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
            end
            SPLATTER: begin
                // Stays in Splat state indefinitely unless reset (handled by areset)
            end
        endcase
    end

    // Output logic based on the state (Moore FSM)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            {walk_left, walk_right, aaah, digging} <= 4'b1000;
        end
        else begin
            case (state)
                WALK_LEFT: begin
                    {walk_left, walk_right, aaah, digging} <= 4'b1000;
                end
                WALK_RIGHT: begin
                    {walk_left, walk_right, aaah, digging} <= 4'b0100;
                end
                FALL_LEFT,
                FALL_RIGHT: begin
                    {walk_left, walk_right, aaah, digging} <= 4'b0010;
                end
                DIG_LEFT: begin
                    {walk_left, walk_right, aaah, digging} <= 4'b0001;
                end
                DIG_RIGHT: begin
                    {walk_left, walk_right, aaah, digging} <= 4'b0001;
                end
                SPLATTER: begin
                    {walk_left, walk_right, aaah, digging} <= 4'b0000;
                end
            endcase
        end
    end
endmodule
