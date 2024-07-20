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
    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTER = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (aaah)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        next_state = state;

        case (state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                    aaah = 1;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                    digging = 1;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                    walk_right = 1;
                end else begin
                    walk_left = 1;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                    aaah = 1;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                    digging = 1;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                    walk_left = 1;
                end else begin
                    walk_right = 1;
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_LEFT;
                    walk_left = (fall_count <= 20);
                end else begin
                    aaah = 1;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_RIGHT;
                    walk_right = (fall_count <= 20);
                end else begin
                    aaah = 1;
                end
            end
            DIG_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                    aaah = 1;
                end else begin
                    digging = 1;
                end
            end
            DIG_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                    aaah = 1;
                end else begin
                    digging = 1;
                end
            end
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

endmodule
