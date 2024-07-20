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

reg [1:0] state; // 2-bit register for current state

parameter WALK_LEFT = 2'b00; 
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;
parameter RESUME = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT; // Reset state to default - walking left
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (ground == 0) begin
                    state <= FALLING;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (ground == 0) begin
                    state <= FALLING;
                end
            end
            FALLING: begin
                if (ground == 1) begin
                    state <= RESUME;
                end
            end
            RESUME: begin
                if (ground == 0) begin
                    state <= FALLING;
                end else if (bump_left || bump_right) begin
                    if (bump_left && bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (bump_left) begin
                        state <= WALK_LEFT;
                    end else begin
                        state <= WALK_RIGHT;
                    end
                end
            end
        endcase
    end
end

// State outputs
always @(posedge clk or posedge areset) begin
    if (areset) begin
        walk_left <= 0;
        walk_right <= 0;
        aaah <= 0;
    end else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
            end
            RESUME: begin
                // Same direction as before fall
                if (walk_left == 1) begin
                    walk_left <= 1;
                    walk_right <= 0;
                end else if (walk_right == 1) begin
                    walk_left <= 0;
                    walk_right <= 1;
                end
                aaah <= 0;
            end
        endcase
    end
end

endmodule
