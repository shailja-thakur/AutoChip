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
localparam [1:0] 
    WALK_LEFT = 2'b00,
    WALK_RIGHT = 2'b01,
    FALL = 2'b10,
    DIG = 2'b11;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) next_state = WALK_RIGHT;
            else if (!ground) next_state = FALL;
            else if (dig & ground) next_state = DIG;
        end
        WALK_RIGHT: begin
            if (bump_left) next_state = WALK_LEFT;
            else if (!ground) next_state = FALL;
            else if (dig & ground) next_state = DIG;
        end
        FALL: begin
            if (ground) next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        end
        DIG: begin
            if (!ground) next_state = FALL;
        end
    endcase
end

// Output logic
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
        end
        WALK_RIGHT: begin
            walk_right = 1;
        end
        FALL: begin
            aaah = 1;
        end
        DIG: begin
            digging = 1;
        end
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
    end
    else begin
        state <= next_state;
    end
end

endmodule
