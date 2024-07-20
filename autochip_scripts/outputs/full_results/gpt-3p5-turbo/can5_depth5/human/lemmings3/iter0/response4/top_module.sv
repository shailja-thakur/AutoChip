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

// State Definition
typedef enum logic [2:0] {
    S_WalkLeft,
    S_WalkRight,
    S_Fall,
    S_Dig
} state_t;

// State Register
state_t state_reg;
 
// Output Register
reg walk_left_reg;
reg walk_right_reg;
reg aaah_reg;
reg digging_reg;

always_ff @(posedge clk or posedge areset) begin
    if (areset)
        state_reg <= S_WalkLeft;
    else begin
        case (state_reg)
            S_WalkLeft:
                if (bump_right)
                    state_reg <= S_WalkRight;
                else if (dig && ground)
                    state_reg <= S_Dig;
                else if (!ground)
                    state_reg <= S_Fall;
                else
                    state_reg <= S_WalkLeft;
            S_WalkRight:
                if (bump_left)
                    state_reg <= S_WalkLeft;
                else if (dig && ground)
                    state_reg <= S_Dig;
                else if (!ground)
                    state_reg <= S_Fall;
                else
                    state_reg <= S_WalkRight;
            S_Fall:
                if (ground)
                    state_reg <= S_WalkLeft;
                else
                    state_reg <= S_Fall;
            S_Dig:
                if (!ground)
                    state_reg <= S_Fall;
                else if (dig)
                    state_reg <= S_Dig;
                else
                    state_reg <= S_WalkLeft;
            default:
                state_reg <= S_WalkLeft;
        endcase
    end
end

always_comb begin
    case (state_reg)
        S_WalkLeft:
            walk_left_reg = 1;
            walk_right_reg = 0;
            aaah_reg = 0;
            digging_reg = 0;
        S_WalkRight:
            walk_left_reg = 0;
            walk_right_reg = 1;
            aaah_reg = 0;
            digging_reg = 0;
        S_Fall:
            walk_left_reg = 0;
            walk_right_reg = 0;
            aaah_reg = 1;
            digging_reg = 0;
        S_Dig:
            walk_left_reg = 1;
            walk_right_reg = 0;
            aaah_reg = 0;
            digging_reg = 1;
        default:
            walk_left_reg = 0;
            walk_right_reg = 0;
            aaah_reg = 0;
            digging_reg = 0;
    endcase
end

assign walk_left = walk_left_reg;
assign walk_right = walk_right_reg;
assign aaah = aaah_reg;
assign digging = digging_reg;

endmodule
