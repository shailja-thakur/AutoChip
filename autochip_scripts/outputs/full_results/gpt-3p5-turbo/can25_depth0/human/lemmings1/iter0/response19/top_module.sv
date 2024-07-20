module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

reg [1:0] state;
wire switch_direction;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else if (switch_direction) begin
        state <= (state == WALK_LEFT) ? WALK_RIGHT : WALK_LEFT;
    end else begin
        state <= state;
    end
end

assign switch_direction = (bump_left || bump_right);

assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);

endmodule
