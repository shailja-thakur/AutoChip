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

// Define the states
localparam [1:0] WALKING_LEFT = 2'b00, WALKING_RIGHT = 2'b01, FALLING = 2'b10, DIGGING = 2'b11;

// Internal state
reg [1:0] state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALKING_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case (state)
            WALKING_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (ground) begin
                    if (bump_right) begin
                        state <= WALKING_RIGHT;
                    end
                end else begin
                    state <= FALLING;
                    aaah <= 1;
                end
            end
            WALKING_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (ground) begin
                    if (bump_left) begin
                        state <= WALKING_LEFT;
                    end
                end else begin
                    state <= FALLING;
                    aaah <= 1;
                end
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (ground) begin
                    if (walk_left) begin
                        state <= WALKING_LEFT;
                    end else begin
                        state <= WALKING_RIGHT;
                    end
                    aaah <= 0;
                end
            end
            DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    state <= FALLING;
                    aaah <= 1;
                end else if (!dig) begin
                    state <= (walk_left) ? WALKING_LEFT : WALKING_RIGHT;
                    digging <= 0;
                end
            end
            default: begin
                state <= WALKING_LEFT;
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
end

endmodule
