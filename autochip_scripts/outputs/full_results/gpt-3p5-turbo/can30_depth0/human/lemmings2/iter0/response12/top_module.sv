module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

// Define state types
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL
} StateType;

// Define state register and next state variables
reg [1:0] state_reg;
reg [1:0] state_next;

// Define output variables
wire walk_left;
wire walk_right;
wire aaah;

// Define state transition and output logic
always @(posedge clk or posedge areset) begin
    if (areset == 1) begin
        // Reset state to walk_left
        state_reg <= WALK_LEFT;
    end else begin
        // Update next state based on current state and inputs
        case (state_reg)
            WALK_LEFT: begin
                if (bump_right == 1) begin
                    state_next <= WALK_RIGHT;
                end else begin
                    state_next <= WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (bump_left == 1) begin
                    state_next <= WALK_LEFT;
                end else begin
                    state_next <= WALK_RIGHT;
                end
            end
            FALL: begin
                if (ground == 1) begin
                    // Lemming has landed, resume walking in same direction
                    if (state_reg == WALK_RIGHT) begin
                        state_next <= WALK_RIGHT;
                    end else begin
                        state_next <= WALK_LEFT;
                    end
                end else begin
                    state_next <= FALL;
                end
            end
            default: state_next <= WALK_LEFT;
        endcase
    end
end

always @(posedge clk) begin
    // Update state register with the next state
    state_reg <= state_next;
end

// Define output logic based on current state
always @(state_reg or bump_left or bump_right or ground) begin
    case (state_reg)
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
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
        end
        default: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        end
    endcase
end

endmodule
