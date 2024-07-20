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

reg [4:0] state;
reg splattered;

parameter [4:0] WALK_LEFT = 5'b00001;
parameter [4:0] WALK_RIGHT = 5'b00010;
parameter [4:0] FALL = 5'b00100;
parameter [4:0] DIG = 5'b01000;
parameter [4:0] SPLATTER = 5'b10000;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        splattered <= 0;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (ground && !dig && !splattered) begin
                    state <= WALK_LEFT;
                end else if (!ground && !dig && !splattered) begin
                    state <= FALL;
                end else if (dig && !splattered) begin
                    state <= DIG;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (ground && !dig && !splattered) begin
                    state <= WALK_RIGHT;
                end else if (!ground && !dig && !splattered) begin
                    state <= FALL;
                end else if (dig && !splattered) begin
                    state <= DIG;
                end
            end
            FALL: begin
                if (ground && !dig && !splattered) begin
                    state <= (state == FALL) ? WALK_LEFT : WALK_RIGHT;
                end else if (!ground && !dig && !splattered) begin
                    state <= FALL;
                end else if (dig && !splattered) begin
                    state <= DIG;
                end else if (ground && splattered) begin
                    state <= SPLATTER;
                end
            end
            DIG: begin
                if (ground && !dig && !splattered) begin
                    state <= (state == DIG) ? WALK_LEFT : WALK_RIGHT;
                end else if (!ground && !dig && !splattered) begin
                    state <= FALL;
                end else if (!dig) begin
                    state <= WALK_RIGHT;
                end else if (ground && splattered) begin
                    state <= SPLATTER;
                end
            end
            SPLATTER: begin
                state <= SPLATTER;
            end
        endcase
    end
end

always @* begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        end
        DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
        SPLATTER: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            splattered = 1;
        end
        default: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            splattered = 0;
        end
    endcase
end

endmodule
