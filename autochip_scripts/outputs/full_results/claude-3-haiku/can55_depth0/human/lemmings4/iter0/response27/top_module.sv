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

// State definitions
parameter WALK_LEFT = 0, WALK_RIGHT = 1, FALL = 2, DIG = 3;

// Internal variables
reg [1:0] state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end
                else if (!ground) begin
                    state <= FALL;
                    fall_count <= 1;
                end
                else if (dig) begin
                    state <= DIG;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    state <= WALK_LEFT;
                end
                else if (!ground) begin
                    state <= FALL;
                    fall_count <= 1;
                end
                else if (dig) begin
                    state <= DIG;
                end
            end
            FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (ground) begin
                    if (fall_count >= 20) begin
                        state <= WALK_LEFT;
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                        fall_count <= 0;
                    end
                    else begin
                        state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                        fall_count <= 0;
                    end
                end
                else begin
                    fall_count <= fall_count + 1;
                end
            end
            DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    state <= FALL;
                    fall_count <= 1;
                end
                else if (!dig) begin
                    state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                end
            end
        endcase
    end
end

endmodule
