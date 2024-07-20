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


reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= 0;
    end else begin
        case (state)
            0: begin  // walking left
                if (bump_right == 1 && bump_left == 0) begin
                    state <= 1;
                end else if (ground == 0) begin
                    state <= 2;
                end else if (dig == 1 && ground == 1) begin
                    state <= 3;
                end
            end
            1: begin  // walking right
                if (bump_left == 1 && bump_right == 0) begin
                    state <= 0;
                end else if (ground == 0) begin
                    state <= 2;
                end else if (dig == 1 && ground == 1) begin
                    state <= 3;
                end
            end
            2: begin  // falling
                if (ground == 1) begin
                    state <= (walk_right == 1) ? 1 : 0;
                end
            end
            3: begin  // digging
                if (ground == 0) begin
                    state <= 2;
                end
            end
        endcase
    end
end

always @(state, ground, dig) begin
    case (state)
        0: begin  // walking left
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        1: begin  // walking right
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        2: begin  // falling
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        end
        3: begin  // digging
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
    endcase
end

endmodule
