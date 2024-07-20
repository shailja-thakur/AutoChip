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
wire should_fall;
reg dig_enable;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

assign should_fall = !ground & (state == WALK_LEFT | state == WALK_RIGHT);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        dig_enable <= 0;
    end else begin
        case(state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (should_fall) begin
                    state <= FALL;
                end else if (dig & ground) begin
                    state <= DIG;
                    dig_enable <= 1;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (should_fall) begin
                    state <= FALL;
                end else if (dig & ground) begin
                    state <= DIG;
                    dig_enable <= 1;
                end
            end
            FALL: begin
                if (ground) begin
                    state <= state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
                end
            end
            DIG: begin
                if (!ground) begin
                    state <= FALL;
                end else if (!dig) begin
                    if (state == WALK_LEFT | state == WALK_RIGHT) begin
                        state <= state;
                    end else begin
                        state <= state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
                    end
                    dig_enable <= 0;
                end
            end
        endcase
    end
end

always @(state) begin
    case(state)
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
            digging = dig_enable;
        end
        default: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    endcase
end

endmodule
