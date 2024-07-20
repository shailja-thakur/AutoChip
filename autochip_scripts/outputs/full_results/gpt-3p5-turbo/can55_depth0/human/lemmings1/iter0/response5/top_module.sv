module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
	
reg [1:0] state;

// states
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;

// Moore output
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_left && !bump_right) begin
                    state <= WALK_RIGHT;
                end
            end
            
            WALK_RIGHT: begin
                if (bump_right && !bump_left) begin
                    state <= WALK_LEFT;
                end
            end
        endcase
    end
end

endmodule
