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
localparam [2:0] WALK_LEFT = 3'b000, WALK_RIGHT = 3'b001, FALLING = 3'b010, DIGGING = 3'b011, SPLATTERED = 3'b100;

reg [2:0] state, next_state;
reg [4:0] fall_count; // Counter for how long the Lemming has been falling

// State transition logic
always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            if (bump_right) next_state = WALK_RIGHT;
            else if (!ground) next_state = FALLING;
            else if (dig) next_state = DIGGING;
        end
        WALK_RIGHT: begin
            if (bump_left) next_state = WALK_LEFT;
            else if (!ground) next_state = FALLING;
            else if (dig) next_state = DIGGING;
        end
        FALLING: begin
            if (ground) next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else if (fall_count == 20) next_state = SPLATTERED;
        end
        DIGGING: begin
            if (!ground) next_state = FALLING;
        end
        SPLATTERED: begin
            // Remain in SPLATTERED state
        end
    endcase
end

// State output logic
always @(*) begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        WALK_LEFT: walk_left = 1;
        WALK_RIGHT: walk_right = 1;
        FALLING: aaah = 1;
        DIGGING: digging = 1;
        SPLATTERED: ; // Do nothing
    endcase
end

// State update logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        fall_count <= 0;
    end
    else begin
        state <= next_state;

        if (state == FALLING) begin
            fall_count <= (ground) ? 0 : fall_count + 1;
        end
        else begin
            fall_count <= 0;
        end
    end
end

endmodule
