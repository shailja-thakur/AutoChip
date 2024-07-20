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

    reg [2:0] state, next_state;
    reg [4:0] fall_counter;

    // State encoding
    localparam WALK_LEFT = 3'b000,
               WALK_RIGHT = 3'b001,
               FALL_LEFT = 3'b010,
               FALL_RIGHT = 3'b011,
               DIG_LEFT = 3'b100,
               DIG_RIGHT = 3'b101,
               SPLAT = 3'b110;

    // State transition logic
    always @(*) begin
        case(state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left && bump_right)
                    next_state = WALK_RIGHT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_LEFT;
            end

            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left && bump_right)
                    next_state = WALK_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end

            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLAT;
                    else
                        next_state = WALK_LEFT;
                end else
                    next_state = FALL_LEFT;
            end

            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLAT;
                    else
                        next_state = WALK_RIGHT;
                end else
                    next_state = FALL_RIGHT;
            end

            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
            end

            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end

            SPLAT: begin
                next_state = SPLAT;
            end

            default: next_state = WALK_LEFT;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Fall counter logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            fall_counter <= 0;
        else if (!ground && (state == FALL_LEFT || state == FALL_RIGHT))
            fall_counter <= fall_counter + 1;
        else
            fall_counter <= 0;
    end

    // Output logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL_LEFT || state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT || state == DIG_RIGHT);

endmodule
