module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

localparam [1:0] WALK_LEFT = 2'b01;
localparam [1:0] WALK_RIGHT = 2'b10;
localparam [1:0] FALL = 2'b00;

reg [1:0] state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                if (ground == 0) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
                else if (bump_right && !bump_left) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                end
                else begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end
            end
            WALK_RIGHT: begin
                if (ground == 0) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
                else if (bump_left && !bump_right) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end
                else begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                end
            end
            FALL: begin
                if (ground == 1) begin
                    if (state == WALK_LEFT) begin
                        state <= WALK_LEFT;
                        walk_left <= 1;
                        walk_right <= 0;
                    end
                    else begin
                        state <= WALK_RIGHT;
                        walk_left <= 0;
                        walk_right <= 1;
                    end
                    aaah <= 0;
                end
                else begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
            end
            default: begin
                state <= WALK_LEFT;
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
            end
        endcase
    end
end

endmodule
