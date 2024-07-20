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

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case(state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end else if (bump_left) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end else if (dig && ground) begin
                    state <= DIG;
                    walk_left <= 1;
                    walk_right <= 0;
                    digging <= 1;
                end else if (!ground) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end else if (bump_right) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end else if (dig && ground) begin
                    state <= DIG;
                    walk_left <= 0;
                    walk_right <= 1;
                    digging <= 1;
                end else if (!ground) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
            end
            FALL: begin
                if (ground) begin
                    if (walk_left) begin
                        state <= WALK_LEFT;
                    end else begin
                        state <= WALK_RIGHT;
                    end
                    walk_left <= (state == WALK_LEFT);
                    walk_right <= (state == WALK_RIGHT);
                    aaah <= 0;
                end
            end
            DIG: begin
                if (ground && !dig) begin
                    if (walk_left) begin
                        state <= WALK_LEFT;
                    end else begin
                        state <= WALK_RIGHT;
                    end
                    walk_left <= (state == WALK_LEFT);
                    walk_right <= (state == WALK_RIGHT);
                    digging <= 0;
                end
            end
        endcase
    end
end

endmodule
