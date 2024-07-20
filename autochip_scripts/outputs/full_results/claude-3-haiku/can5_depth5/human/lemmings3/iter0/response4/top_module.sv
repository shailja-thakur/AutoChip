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

// Define the states of the Lemming
localparam [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALLING = 2'b10, DIGGING = 2'b11;

// Declare the current and next state variables
reg [1:0] current_state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        current_state <= next_state;
        case (current_state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_right) begin
                    next_state <= WALK_RIGHT;
                end else if (!ground) begin
                    next_state <= FALLING;
                end else if (dig) begin
                    next_state <= DIGGING;
                end else begin
                    next_state <= WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    next_state <= WALK_LEFT;
                end else if (!ground) begin
                    next_state <= FALLING;
                end else if (dig) begin
                    next_state <= DIGGING;
                end else begin
                    next_state <= WALK_RIGHT;
                end
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (ground) begin
                    next_state <= current_state;
                end else begin
                    next_state <= FALLING;
                end
            end
            DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    next_state <= FALLING;
                end else begin
                    next_state <= DIGGING;
                end
            end
        endcase
    end
end

endmodule
