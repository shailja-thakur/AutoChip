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

    // State encoding
    typedef enum logic [2:0] {
        LEFT_WALK  = 3'b000,
        RIGHT_WALK = 3'b001,
        LEFT_FALL  = 3'b010,
        RIGHT_FALL = 3'b011,
        LEFT_DIG   = 3'b100,
        RIGHT_DIG  = 3'b101,
        SPLATTER   = 3'b110
    } state_t;
    state_t state, next_state;

    // Other variables
    logic [4:0] fall_count;
    logic ground_rising_edge;

    // Outputs based on state
    assign walk_left  = (state == LEFT_WALK);
    assign walk_right = (state == RIGHT_WALK);
    assign aaah       = (state == LEFT_FALL) || (state == RIGHT_FALL);
    assign digging    = (state == LEFT_DIG) || (state == RIGHT_DIG);

    // Rising edge detector for ground
    always_ff @(posedge clk) begin
        ground_rising_edge <= ground;
    end

    // State transition on clock edge or asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT_WALK;
            fall_count <= 0;
        end else begin
            if (!ground) begin
                fall_count <= fall_count + 1;
            end else if (ground_rising_edge) begin
                fall_count <= 0;
            end

            if (fall_count > 20 && ground) begin
                state <= SPLATTER;
            end else begin
                state <= next_state;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            LEFT_WALK: begin
                if (!ground) begin
                    next_state = LEFT_FALL;
                end else if (dig) begin
                    next_state = LEFT_DIG;
                end else if (bump_left) begin
                    next_state = RIGHT_WALK;
                end
            end

            RIGHT_WALK: begin
                if (!ground) begin
                    next_state = RIGHT_FALL;
                end else if (dig) begin
                    next_state = RIGHT_DIG;
                end else if (bump_right) begin
                    next_state = LEFT_WALK;
                end
            end

            LEFT_FALL: begin
                if (ground) begin
                    next_state = LEFT_WALK;
                end
            end

            RIGHT_FALL: begin
                if (ground) begin
                    next_state = RIGHT_WALK;
                end
            end

            LEFT_DIG: begin
                if (!ground) begin
                    next_state = LEFT_FALL;
                end
            end

            RIGHT_DIG: begin
                if (!ground) begin
                    next_state = RIGHT_FALL;
                end
            end
            
            SPLATTER: begin
                next_state = SPLATTER; // Remain in SPLATTER state indefinitely
            end
        endcase
    end

endmodule
