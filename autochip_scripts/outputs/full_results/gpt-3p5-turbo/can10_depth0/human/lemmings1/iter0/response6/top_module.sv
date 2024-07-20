module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define states
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT
} state_type;

// Define variables
reg [1:0] state;
reg [1:0] next_state;

// Define output
assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;

// State transition and output logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

always @(state, bump_left, bump_right) begin
    case(state)
        WALK_LEFT: begin
            if (bump_left)
                next_state = WALK_RIGHT;
            else if (bump_right)
                next_state = WALK_LEFT;
        end
        
        WALK_RIGHT: begin
            if (bump_right)
                next_state = WALK_LEFT;
            else if (bump_left)
                next_state = WALK_RIGHT;
        end
    endcase
end

endmodule
