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

reg state;
parameter WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end
    else begin
        if (ground) begin
            if (dig) begin
                state <= state;
                digging <= 1'b1;
            end
            else begin
                if (bump_left) begin
                    state <= WALK_RIGHT;
                    digging <= 1'b0;
                end
                else if (bump_right) begin
                    state <= WALK_LEFT;
                    digging <= 1'b0;
                end
                else begin
                    state <= state;
                    digging <= 1'b0;
                end
            end
        end
        else begin
            state <= state;
            digging <= 1'b0;
        end
    end
end

assign walk_left = (state == WALK_LEFT) && ground;
assign walk_right = (state == WALK_RIGHT) && ground;
assign aaah = ~ground;

endmodule
