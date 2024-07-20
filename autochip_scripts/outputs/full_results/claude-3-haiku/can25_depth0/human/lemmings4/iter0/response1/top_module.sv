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
localparam WALK_LEFT  = 2'b00;
localparam WALK_RIGHT = 2'b01;
localparam FALLING    = 2'b10;
localparam DIGGING    = 2'b11;

reg [1:0] state;
reg [4:0] fall_count; // Counter for tracking the duration of falling

always @(posedge clk, posedge areset) begin
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
                    state <= FALLING;
                    fall_count <= 1;
                end
                else if (dig) begin
                    state <= DIGGING;
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
                    state <= FALLING;
                    fall_count <= 1;
                end
                else if (dig) begin
                    state <= DIGGING;
                    digging <= 1;
                end
            end
            FALLING: begin
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
                    if (fall_count >= 20) begin
                        state <= WALK_LEFT; // Reset to walk left
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                end
            end
            DIGGING: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    state <= FALLING;
                    digging <= 0;
                    fall_count <= 1;
                end
                else if (!dig) begin
                    state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                    digging <= 0;
                end
            end
        endcase
    end
end

endmodule
