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

reg [4:0] state;

parameter [4:0] WALK_LEFT = 5'b01;
parameter [4:0] WALK_RIGHT = 5'b10;
parameter [4:0] FALL = 5'b11;
parameter [4:0] DIG = 5'b100;
parameter [4:0] SPLATTER = 5'b101;
parameter [4:0] RESUME = 5'b110;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end else if (ground == 0) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (dig) begin
                    state <= DIG;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end else if (ground == 0) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (dig) begin
                    state <= DIG;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
            end
            FALL: begin
                if (ground) begin
                    state <= RESUME;
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= 0;
                    digging <= 0;
                end else if (state == SPLATTER) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            end
            DIG: begin
                if (ground) begin
                    state <= RESUME;
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= 0;
                    digging <= 0;
                end else if (state == SPLATTER) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            end
            RESUME: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end else if (bump_left) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end else if (ground == 0) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end else if (dig) begin
                    state <= DIG;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
            end
        endcase
    end
end

always @(posedge clk) begin
    if (state == SPLATTER || state == FALL || state == DIG) begin
        if (ground == 1) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else if (state == SPLATTER) begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
    end
end

endmodule
