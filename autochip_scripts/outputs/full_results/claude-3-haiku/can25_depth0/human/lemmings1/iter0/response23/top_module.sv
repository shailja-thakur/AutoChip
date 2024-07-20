module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

reg state;
parameter WALK_LEFT = 1'b0;
parameter WALK_RIGHT = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                if (bump_left) begin
                    state <= WALK_RIGHT;
                end
            end
            WALK_RIGHT: begin
                if (bump_right) begin
                    state <= WALK_LEFT;
                end
            end
            default: state <= WALK_LEFT;
        endcase
    end
end

assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);

endmodule
