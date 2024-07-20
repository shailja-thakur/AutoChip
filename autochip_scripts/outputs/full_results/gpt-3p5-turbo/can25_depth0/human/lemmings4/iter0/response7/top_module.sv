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

reg [4:0] state;

parameter [4:0] WALK_LEFT = 5'b00001;
parameter [4:0] WALK_RIGHT = 5'b00010;
parameter [4:0] FALL = 5'b00100;
parameter [4:0] DIG = 5'b01000;
parameter [4:0] SPLATTER = 5'b10000;

assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL) || (state == SPLATTER);
assign digging = (state == DIG);

always @ (posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (!ground) begin
                    state <= FALL;
                end else if (dig && ground) begin
                    state <= DIG;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (!ground) begin
                    state <= FALL;
                end else if (dig && ground) begin
                    state <= DIG;
                end
            end
            FALL: begin
                if (ground) begin
                    state <= WALK_RIGHT;
                end else if (state_timer == 20) begin
                    state <= SPLATTER;
                end
            end
            DIG: begin
                if (!ground) begin
                    state <= FALL;
                end
            end
            SPLATTER: begin
                // No state transition
            end
        endcase
    end
end

always @ (posedge clk or posedge areset) begin
    if (areset) begin
        state_timer <= 0;
    end else begin
        if (state == FALL && !ground) begin
            state_timer <= state_timer + 1;
        end else begin
            state_timer <= 0;
        end
    end
end

endmodule
