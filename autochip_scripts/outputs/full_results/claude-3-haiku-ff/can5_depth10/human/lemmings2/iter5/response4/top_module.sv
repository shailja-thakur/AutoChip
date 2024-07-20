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

// Declare the states
parameter [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10;

// Declare the state register
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
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end
                else if (~ground) begin
                    state <= FALL;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                if (bump_left) begin
                    state <= WALK_LEFT;
                end
                else if (~ground) begin
                    state <= FALL;
                end
            end
            FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                if (ground) begin
                    if (walk_left) begin
                        state <= WALK_LEFT;
                    end
                    else begin
                        state <= WALK_RIGHT;
                    end
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
