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

parameter IDLE = 2'd0;
parameter WALK_LEFT = 2'd1;
parameter WALK_RIGHT = 2'd2;
parameter FALL = 2'd3;
parameter DIG = 2'd4;
parameter DIG_FALL = 2'd5;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case (state)
            IDLE: begin
                if (ground == 0) begin
                    state <= FALL;
                end else if (bump_left == 1 && bump_right == 1) begin
                    state <= WALK_RIGHT;
                end else if (bump_left == 1) begin
                    state <= WALK_RIGHT;
                end else if (bump_right == 1) begin
                    state <= WALK_LEFT;
                end else if (dig == 1) begin
                    state <= DIG;
                end
            end
            WALK_LEFT: begin
                if (bump_left == 1 && bump_right == 1) begin
                    state <= WALK_RIGHT;
                end else if (bump_left == 1) begin
                    state <= WALK_RIGHT;
                end else if (dig == 1) begin
                    state <= DIG;
                end else if (ground == 0) begin
                    state <= FALL;
                end
            end
            WALK_RIGHT: begin
                if (bump_left == 1 && bump_right == 1) begin
                    state <= WALK_LEFT;
                end else if (bump_right == 1) begin
                    state <= WALK_LEFT;
                end else if (dig == 1) begin
                    state <= DIG;
                end else if (ground == 0) begin
                    state <= FALL;
                end
            end
            FALL: begin
                if (ground == 1) begin
                    state <= IDLE;
                end
            end
            DIG: begin
                if (ground == 0) begin
                    state <= DIG_FALL;
                end
            end
            DIG_FALL: begin
                if (ground == 1) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;
assign aaah = (state == FALL || state == DIG_FALL) ? 1'b1 : 1'b0;
assign digging = (state == DIG || state == DIG_FALL) ? 1'b1 : 1'b0;

endmodule
