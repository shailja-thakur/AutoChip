module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output aaah
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;  // initial state: walking left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
        end else begin
            case (state)
                2'b00: begin
                    if (bump_left && !bump_right) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        aaah <= 1'b0;
                        state <= 2'b01;  // bumped left, switch to walking right
                    end else if (!bump_left && bump_right) begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        state <= 2'b10;  // bumped right, switch to walking left
                    end else begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                        state <= 2'b00;  // no bump, walking left
                    end
                end
                2'b01: begin
                    if (!bump_left && !bump_right) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        aaah <= 1'b0;
                        state <= 2'b00;  // no bump, walking left
                    end else begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        aaah <= 1'b1;
                        state <= 2'b01;  // bump but not yet falling
                    end
                end
                2'b10: begin
                    if (!bump_left && !bump_right) begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        state <= 2'b00;  // no bump, walking right
                    end else begin
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                        state <= 2'b10;  // bump but not yet falling
                    end
                end
            endcase
        end
    end
endmodule
