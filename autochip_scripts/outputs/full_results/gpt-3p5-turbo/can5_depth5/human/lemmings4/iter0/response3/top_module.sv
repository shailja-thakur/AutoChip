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

reg [4:0] state;
parameter [4:0]
        WALK_LEFT = 0,
        WALK_RIGHT = 1,
        FALLING = 2,
        DIGGING = 3,
        SPLATTER = 4;

always @(posedge clk or posedge areset) begin
    if (areset == 1) begin
        state <= WALK_LEFT;
    end else begin
        case(state)
            WALK_LEFT:
                if (bump_right == 1 && bump_left == 0) begin
                    state <= WALK_RIGHT;
                end else if (ground == 0) begin
                    state <= FALLING;
                end else if (dig == 1 && ground == 1) begin
                    state <= DIGGING;
                end else begin
                    state <= WALK_LEFT;
                end

            WALK_RIGHT:
                if (bump_left == 1 && bump_right == 0) begin
                    state <= WALK_LEFT;
                end else if (ground == 0) begin
                    state <= FALLING;
                end else if (dig == 1 && ground == 1) begin
                    state <= DIGGING;
                end else begin
                    state <= WALK_RIGHT;
                end

            FALLING:
                if (ground == 1) begin
                    if (bump_right == 1 || bump_left == 1) begin
                        state <= WALK_RIGHT;
                    end else begin
                        state <= WALK_RIGHT;
                    end
                end else if (dig == 1 && ground == 1) begin
                    state <= DIGGING;
                end else if (state == SPLATTER) begin
                    state <= SPLATTER;
                end else if (state == WALK_LEFT) begin
                    state <= WALK_LEFT;
                end else if (state == WALK_RIGHT) begin
                    state <= WALK_RIGHT;
                end else begin
                    state <= FALLING;
                end

            DIGGING:
                if (ground == 0) begin
                    state <= FALLING;
                end else begin
                    state <= DIGGING;
                end

            SPLATTER:
                state <= SPLATTER;
        endcase
    end
end

always @(state) begin
    case(state)
        WALK_LEFT:
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;

        WALK_RIGHT:
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;

        FALLING:
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;

        DIGGING:
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;

        SPLATTER:
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
    endcase
end

endmodule
