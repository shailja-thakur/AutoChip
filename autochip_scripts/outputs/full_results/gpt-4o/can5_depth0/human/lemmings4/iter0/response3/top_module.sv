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
    reg [4:0] fall_count; // Counter for fall cycles
    localparam [2:0] LEFT = 3'b000, RIGHT = 3'b001, FALL_LEFT = 3'b010,
                     FALL_RIGHT = 3'b011, DIG_LEFT = 3'b100, DIG_RIGHT = 3'b101,
                     SPLATTERED = 3'b110;

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
                if (ground) begin
                    if (fall_count >= 21) next_state = SPLATTERED;
                    else next_state = LEFT;
                end else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count >= 21) next_state = SPLATTERED;
                    else next_state = RIGHT;
                end else next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            SPLATTERED: begin
                next_state = SPLATTERED;
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) fall_count <= fall_count + 1;
            else fall_count <= 0;
        end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);

endmodule
