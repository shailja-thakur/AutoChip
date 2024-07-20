module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
// Define state enum
typedef enum logic [1:0] {
    STATE_WALK_LEFT,
    STATE_WALK_RIGHT
} state_t;

// Define state register and next state variables
reg [1:0] state_reg;
reg [1:0] state_next;

// Define output register
reg walk_left_reg;
reg walk_right_reg;

// Define state transition and output next variables
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state_reg <= STATE_WALK_LEFT;
    end else begin
        state_reg <= state_next;
    end
end

// Define state machine logic
always @* begin
    case (state_reg)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                state_next = STATE_WALK_RIGHT;
            end else begin
                state_next = STATE_WALK_LEFT;
            end
            
            walk_left_reg = 1;
            walk_right_reg = 0;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                state_next = STATE_WALK_LEFT;
            end else begin
                state_next = STATE_WALK_RIGHT;
            end
            
            walk_left_reg = 0;
            walk_right_reg = 1;
        end
        default: begin
            state_next = STATE_WALK_LEFT;
            walk_left_reg = 1;
            walk_right_reg = 0;
        end
    endcase
end

// Define output assignments
assign walk_left = walk_left_reg;
assign walk_right = walk_right_reg;

endmodule
