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

    // State definition
    typedef enum reg [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        AAH_LEFT = 3'b010,
        AAH_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTER = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // To count the clock cycles while falling

    // State transition on positive edge of clock or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;

            // Manage fall counter
            if (aaah) begin
                if (ground) begin
                    fall_counter <= 0;
                end else begin
                    fall_counter <= fall_counter + 1;
                end
            end else begin
                fall_counter <= 0;
            end
        end
    end

    // Next state logic
    always @* begin
        // default values
        next_state = state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            LEFT: begin
                if (!ground) begin
                    next_state = AAH_LEFT;
                    aaah = 1;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                    digging = 1;
                end else if (bump_left) begin
                    next_state = RIGHT;
                    walk_right = 1;
                end else begin
                    walk_left = 1;
                end
            end

            RIGHT: begin
                if (!ground) begin
                    next_state = AAH_RIGHT;
                    aaah = 1;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                    digging = 1;
                end else if (bump_right) begin
                    next_state = LEFT;
                    walk_left = 1;
                end else begin
                    walk_right = 1;
                end
            end

            AAH_LEFT: begin
                aaah = 1;
                if (fall_counter > 20) begin
                    next_state = SPLATTER;
                end else if (ground) begin
                    next_state = LEFT;
                    walk_left = 1;
                end
            end

            AAH_RIGHT: begin
                aaah = 1;
                if (fall_counter > 20) begin
                    next_state = SPLATTER;
                end else if (ground) begin
                    next_state = RIGHT;
                    walk_right = 1;
                end
            end

            DIG_LEFT: begin
                digging = 1;
                if (!ground) begin
                    next_state = AAH_LEFT;
                    aaah = 1;
                end
            end

            DIG_RIGHT: begin
                digging = 1;
                if (!ground) begin
                    next_state = AAH_RIGHT;
                    aaah = 1;
                end
            end

            SPLATTER: begin
                // All outputs remain 0
            end
        endcase
    end
endmodule
