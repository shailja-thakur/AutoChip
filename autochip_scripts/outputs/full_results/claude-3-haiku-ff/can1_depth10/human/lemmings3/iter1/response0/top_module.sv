module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output aaah,
    output reg digging
);

reg state;
parameter WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        digging <= 1'b0;
    end
    else begin
        if (ground) begin
            if (dig) begin
                state <= state;
                walk_left <= state;
                walk_right <= ~state;
                digging <= 1'b1;
            end
            else begin
                if (bump_left) begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    digging <= 1'b0;
                end
                else if (bump_right) begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    digging <= 1'b0;
                end
                else begin
                    state <= state;
                    walk_left <= state;
                    walk_right <= ~state;
                    digging <= 1'b0;
                end
            end
        end
        else begin
            state <= state;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b0;
        end
    end
end

assign aaah = ~ground;

endmodule
