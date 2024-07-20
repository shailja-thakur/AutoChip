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

localparam WALK_LEFT = 0, WALK_RIGHT = 1, FALL = 2, DIG = 3, SPLATTER = 4;

reg [2:0] state;
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
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
                    digging <= 1;
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
                    digging <= 1;
                end
            end
            FALL: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 1;
                digging <= 0;
                if (ground) begin
                    state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                    aaah <= 0;
                end
                else begin
                    fall_count <= fall_count + 1;
                    if (fall_count >= 20 && ground) begin
                        state <= SPLATTER;
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                end
            end
            DIG: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    state <= FALL;
                    fall_count <= 1;
                end
            end
            SPLATTER: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
end

endmodule
