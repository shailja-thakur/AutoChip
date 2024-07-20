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

// Define the states for the state machine
typedef enum logic [2:0] {
    STATE_WALK_LEFT,
    STATE_WALK_RIGHT,
    STATE_FALL,
    STATE_DIG,
    STATE_SPLATTER
} state_t;

// Define the signals for the state machine
reg [2:0] state;
reg [4:0] fall_count;

// Initialize the state and signals
initial begin
    state = STATE_WALK_LEFT;
    fall_count = 0;
end

// Use always_ff for synchronous logic
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT; // reset to walk left
        fall_count <= 0; // reset the fall count
    end else begin
        case (state)
            STATE_WALK_LEFT: begin
                if (bump_right) begin
                    state <= STATE_WALK_RIGHT; // switch to walk right when bumped on the right
                end else if (bump_left && ~bump_right) begin
                    state <= STATE_WALK_LEFT; // stay in walk left when bumped on the left
                end else if (~bump_left && ~bump_right) begin
                    state <= STATE_FALL; // start falling when not bumped on either side
                end
            end
            STATE_WALK_RIGHT: begin
                if (bump_left) begin
                    state <= STATE_WALK_LEFT; // switch to walk left when bumped on the left
                end else if (~bump_left && bump_right) begin
                    state <= STATE_WALK_RIGHT; // stay in walk right when bumped on the right
                end else if (~bump_left && ~bump_right) begin
                    state <= STATE_FALL; // start falling when not bumped on either side
                end
            end
            STATE_FALL: begin
                if (~ground) begin
                    state <= STATE_FALL; // stay in fall until ground appears
                end else begin
                    if (fall_count >= 20) begin
                        state <= STATE_SPLATTER; // splatter if fall count exceeds 20
                    end else begin
                        state <= (dig && ground) ? STATE_DIG : state; // transition to dig state if dig is true and ground is present
                    end
                end
            end
            STATE_DIG: begin
                if (~ground) begin
                    state <= STATE_FALL; // start falling when ground disappears during digging
                end else begin
                    state <= (dig && ground) ? STATE_DIG : state; // continue digging while ground is present
                end
            end
            STATE_SPLATTER: begin
                state <= STATE_SPLATTER; // stay in splatter state forever
            end
        endcase
    end
end

// Generate the outputs based on the current state
always_comb begin
    walk_left = (state == STATE_WALK_LEFT);
    walk_right = (state == STATE_WALK_RIGHT);
    aaah = (state == STATE_FALL || state == STATE_SPLATTER);
    digging = (state == STATE_DIG);
end

endmodule
