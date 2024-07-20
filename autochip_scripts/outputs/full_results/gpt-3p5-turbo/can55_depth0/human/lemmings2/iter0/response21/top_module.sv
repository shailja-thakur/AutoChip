module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10;  // initialize state to walking left
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
        end else begin
            case(state)
                2'b00: begin  // falling state
                    walk_left <= walk_left;  // continue walking in the same direction
                    walk_right <= walk_right;
                    aaah <= 1;  // say "aaah!"
                    if (ground)  // check if ground reappears
                        state <= 2'b01;  // transition to walking state
                end

                2'b01: begin  // walking state
                    if (bump_left && !bump_right) begin  // bumped on the left
                        walk_left <= 0;  // switch direction to walking right
                        walk_right <= 1;
                    end else if (!bump_left && bump_right) begin  // bumped on the right
                        walk_left <= 1;  // switch direction to walking left
                        walk_right <= 0;
                    end else if (!bump_left && !bump_right) begin  // not bumped on either side
                        walk_left <= walk_left;  // continue walking in the same direction
                        walk_right <= walk_right;
                    end else begin  // bumped on both sides
                        walk_left <= !walk_left;  // switch direction
                        walk_right <= !walk_right;
                    end

                    if (!ground)  // check if ground disappears
                        state <= 2'b00;  // transition to falling state
                end

                default: begin
                    state <= 2'b10;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end
            endcase
        end
    end

endmodule
