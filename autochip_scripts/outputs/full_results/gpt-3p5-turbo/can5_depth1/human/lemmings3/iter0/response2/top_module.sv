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
	reg [1:0] state;
	parameter [1:0] WALK_LEFT = 2'b00;
	parameter [1:0] WALK_RIGHT = 2'b01;
	parameter [1:0] FALL = 2'b10;
	parameter [1:0] DIG = 2'b11;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
		end else begin
			case(state)
				WALK_LEFT: begin
					if (bump_right || (bump_left && !bump_right))
                        state <= WALK_RIGHT;
				end
				WALK_RIGHT: begin
					if (bump_left || (bump_left && bump_right))
                        state <= WALK_LEFT;
				end
				FALL: begin
					if (ground)
                        state <= walk_left ? WALK_LEFT : WALK_RIGHT;
				end
				DIG: begin
					if (!ground)
                        state <= FALL;
				end
			endcase
		end
    end
    
    always@(state) begin
        case(state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
            end
            FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
            end
            DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
            end
        endcase
    end

endmodule
