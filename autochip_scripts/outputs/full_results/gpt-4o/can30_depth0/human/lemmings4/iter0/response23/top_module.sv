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
    typedef enum reg [2:0] {
        WL = 3'b000,  // Walk Left
        WR = 3'b001,  // Walk Right
        FALL_L = 3'b010,  // Fall from the Left state
        FALL_R = 3'b011,  // Fall from the Right state
        DIG_L = 3'b100,  // Dig from the Left state
        DIG_R = 3'b101,  // Dig from the Right state
        SPLAT = 3'b111  // Splattered state
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count;  // Counter to keep track of falling time

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_L || state == FALL_R) begin
                fall_count <= fall_count + 1;
            end else if (state == WL || state == WR || state == DIG_L || state == DIG_R) begin
                fall_count <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            WL: begin
                if (!ground) begin
                    next_state = FALL_L;
                end else if (dig) begin
                    next_state = DIG_L;
                end else if (bump_left || bump_right) begin
                    next_state = WR;
                end else begin
                    next_state = WL;
                end
            end
            WR: begin
                if (!ground) begin
                    next_state = FALL_R;
                end else if (dig) begin
                    next_state = DIG_R;
                end else if (bump_left || bump_right) begin
                    next_state = WL;
                end else begin
                    next_state = WR;
                end
            end
            FALL_L, FALL_R: begin
                if (fall_count > 20) begin
                    next_state = SPLAT;
                end else if (ground) begin
                    next_state = (state == FALL_L) ? WL : WR;
                end else begin
                    next_state = state;
                end
            end
            DIG_L: begin
                if (!ground) begin
                    next_state = FALL_L;
                end else begin
                    next_state = DIG_L;
                end
            end
            DIG_R: begin
                if (!ground) begin
                    next_state = FALL_R;
                end else begin
                    next_state = DIG_R;
                end
            end
            SPLAT: begin
                next_state = SPLAT;
            end
            default: begin
                next_state = WL;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            WL: walk_left = 1;
            WR: walk_right = 1;
            FALL_L, FALL_R: aaah = 1;
            DIG_L: digging = 1;
            DIG_R: digging = 1;
            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
endmodule
