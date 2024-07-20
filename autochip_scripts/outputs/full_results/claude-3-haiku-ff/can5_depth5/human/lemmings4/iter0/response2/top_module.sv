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

parameter FALLING_THRESHOLD = 20;

reg [4:0] falling_counter;
reg [1:0] state;

localparam WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALLING = 2'b10, DIGGING = 2'b11;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        falling_counter <= 0;
        state <= WALK_LEFT;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                falling_counter <= 0;
                if (bump_right)
                    state <= WALK_RIGHT;
                else if (!ground)
                    state <= FALLING;
                else if (dig && ground)
                    state <= DIGGING;
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                falling_counter <= 0;
                if (bump_left)
                    state <= WALK_LEFT;
                else if (!ground)
                    state <= FALLING;
                else if (dig && ground)
                    state <= DIGGING;
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                falling_counter <= falling_counter + 1;
                if (falling_counter >= FALLING_THRESHOLD && !ground)
                    state <= 0; // Splatter
                else if (ground)
                    state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
            end
            DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                falling_counter <= 0;
                if (!ground)
                    state <= FALLING;
                else if (!dig)
                    state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
            end
            default: begin // Splatter state
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                falling_counter <= 0;
            end
        endcase
    end
end

endmodule
