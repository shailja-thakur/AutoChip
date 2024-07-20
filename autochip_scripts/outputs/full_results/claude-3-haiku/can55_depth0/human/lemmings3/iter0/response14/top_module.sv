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

// Define the states of the finite state machine
localparam WALK_LEFT = 1'b0;
localparam WALK_RIGHT = 1'b1;

reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
                else if (~ground) begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                end
                else if (dig && ground) begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    digging <= 1'b1;
                end
                else begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                else if (~ground) begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                end
                else if (dig && ground) begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    digging <= 1'b1;
                end
                else begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
