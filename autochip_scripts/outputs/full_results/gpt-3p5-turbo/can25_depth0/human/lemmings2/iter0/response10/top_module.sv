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

// Define states
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL
} State;

// Define signals
reg [1:0] current_state;
reg [1:0] next_state;

// Initialize signals
initial begin
    current_state <= WALK_LEFT;
    walk_left <= 1;
    walk_right <= 0;
    aaah <= 0;
end

// State transition logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
    end else begin
        current_state <= next_state;
    end
end

always @* begin
    // Default next state
    next_state = current_state;

    case (current_state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (!ground) begin
                next_state = FALL;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (!ground) begin
                next_state = FALL;
            end
        end
        FALL: begin
            if (ground) begin
                if (current_state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else if (current_state == WALK_RIGHT) begin
                    next_state = WALK_RIGHT;
                end
            end
        end
    endcase
end

// Output logic
always @* begin
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
        end
        FALL: begin
            walk_left = walk_left;
            walk_right = walk_right;
            aaah = 1;
        end
    endcase
end

endmodule
