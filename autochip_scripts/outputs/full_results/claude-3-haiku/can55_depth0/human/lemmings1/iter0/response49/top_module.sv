module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// State definitions
parameter LEFT = 1'b0;
parameter RIGHT = 1'b1;

// State register
reg state;

// Next state logic
always @(*) begin
    case (state)
        LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            if (bump_right) begin
                state = RIGHT;
            end else begin
                state = LEFT;
            end
        end
        RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            if (bump_left) begin
                state = LEFT;
            end else begin
                state = RIGHT;
            end
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            state = LEFT;
        end
    endcase
end

// Synchronous reset
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
    end else begin
        state <= state;
    end
end

endmodule
