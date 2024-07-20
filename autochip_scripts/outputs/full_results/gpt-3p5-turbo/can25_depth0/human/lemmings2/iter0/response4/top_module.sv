module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

// Define states
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL
} state_t;

// Define signals
reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right && !bump_left && !ground) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                end else if (bump_left || (bump_left && bump_right) || (bump_left && ground && !fall)) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end else if (!ground) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
            end
            
            WALK_RIGHT: begin
                if (bump_left && !bump_right && !ground) begin
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end else if (bump_right || (bump_left && bump_right) || (bump_right && ground && !fall)) begin
                    state <= WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                end else if (!ground) begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
            end
            
            FALL: begin
                if (ground) begin
                    if (state == WALK_LEFT) begin
                        state <= WALK_LEFT;
                        walk_left <= 1;
                        walk_right <= 0;
                        aaah <= 0;
                    end else if (state == WALK_RIGHT) begin
                        state <= WALK_RIGHT;
                        walk_left <= 0;
                        walk_right <= 1;
                        aaah <= 0;
                    end
                end else begin
                    state <= FALL;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
            end
        endcase
    end
end

endmodule
