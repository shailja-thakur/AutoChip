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

reg [1:0] state;

parameter IDLE = 2'b00; 
parameter WALK_LEFT = 2'b01;
parameter WALK_RIGHT = 2'b10;

always @(posedge clk or posedge areset) begin
    if(areset) begin
        state <= WALK_LEFT;
    end else begin
        case(state)
            IDLE: begin
                if(bump_left && !bump_right) begin
                    state <= WALK_RIGHT;
                end else if(bump_right && !bump_left) begin
                    state <= WALK_LEFT;
                end else if(bump_left && bump_right) begin
                    state <= WALK_RIGHT;
                end else if(!ground) begin
                    state <= IDLE;
                end
            end
            
            WALK_LEFT: begin
                if(bump_right && !bump_left) begin
                    state <= WALK_LEFT;
                end else if(!ground) begin
                    state <= IDLE;
                end else if(!bump_left && !bump_right) begin
                    state <= WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if(bump_left && !bump_right) begin
                    state <= WALK_RIGHT;
                end else if(!ground) begin
                    state <= IDLE;
                end else if(!bump_left && !bump_right) begin
                    state <= WALK_RIGHT;
                end
            end
        endcase
    end
end

assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;
assign aaah = (!ground && state != IDLE) ? 1'b1 : 1'b0;

endmodule
