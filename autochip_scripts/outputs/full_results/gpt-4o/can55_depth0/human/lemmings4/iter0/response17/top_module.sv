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
    reg [4:0] fall_count; // 5-bit counter to count falling clock cycles

    parameter LEFT  = 3'b000,
              RIGHT = 3'b001,
              FALL_L = 3'b010,
              FALL_R = 3'b011,
              DIG_L = 3'b100,
              DIG_R = 3'b101,
              SPLATTER = 3'b111;

    // State transition
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_L;
                else if (dig) next_state = DIG_L;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_R;
                else if (dig) next_state = DIG_R;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALL_L: begin
                if (ground) next_state = (fall_count <= 20) ? LEFT : SPLATTER;
                else next_state = FALL_L;
            end
            FALL_R: begin
                if (ground) next_state = (fall_count <= 20) ? RIGHT : SPLATTER;
                else next_state = FALL_R;
            end
            DIG_L: begin
                if (!ground) next_state = FALL_L;
                else next_state = DIG_L;
            end
            DIG_R: begin
                if (!ground) next_state = FALL_R;
                else next_state = DIG_R;
            end
            SPLATTER: next_state = SPLATTER; // Remain splattered indefinitely
            default: next_state = LEFT;
        endcase
    end

    // State and counters update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
        end else begin
            if (state == FALL_L || state == FALL_R) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 0;
            end
            state <= next_state;
        end
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L || state == FALL_R);
    assign digging = (state == DIG_L || state == DIG_R);

endmodule
