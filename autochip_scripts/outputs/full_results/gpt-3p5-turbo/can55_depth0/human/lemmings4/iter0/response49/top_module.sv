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
reg fall;

parameter WALK_LEFT = 3'b000;
parameter WALK_RIGHT = 3'b001;
parameter FALL = 3'b010;
parameter DIG = 3'b011;
parameter SPLATTER = 3'b100;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall <= 0;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    fall <= 0;
                end else if (!ground) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    fall <= 1;
                end else if (dig) begin
                    state <= DIG;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    fall <= 0;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall <= 0;
                end else if (!ground) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    fall <= 1;
                end else if (dig) begin
                    state <= DIG;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    fall <= 0;
                end
            end
            FALL: begin
                if (ground) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall <= 0;
                end else if (fall >= 20) begin
                    state <= SPLATTER;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall <= 0;
                end
            end
            DIG: begin
                if (ground && !dig) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall <= 0;
                end else if (!ground) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    fall <= 1;
                end
            end
            SPLATTER: begin
                // Remain in splattered state
                state <= SPLATTER;
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall <= 0;
            end
        endcase
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        fall <= 0;
    end else if (state == FALL) begin
        fall <= fall + 1;
    end else if (state == WALK_LEFT || state == WALK_RIGHT || state == DIG) begin
        fall <= 0;
    end
end

endmodule
