module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Internal state
reg [1:0] state;

// Moore state machine
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Initialize state to walk left
        walk_left <= 1;
        walk_right <= 0;
    end else begin
        case(state)
            2'b00: begin // State when walking left
                if (bump_left) begin
                    state <= 2'b10; // Switch to state walk right
                    walk_left <= 0;
                    walk_right <= 1;
                end else if (bump_right) begin
                    state <= 2'b01; // Stay in state walk left
                    walk_left <= 1;
                    walk_right <= 0;
                end
            end
            2'b01: begin // State when walking left
                if (bump_right) begin
                    state <= 2'b10; // Switch to state walk right
                    walk_left <= 0;
                    walk_right <= 1;
                end else if (bump_left) begin
                    state <= 2'b00; // Stay in state walk left
                    walk_left <= 1;
                    walk_right <= 0;
                end
            end
            2'b10: begin // State when walking right
                if (bump_left || bump_right) begin
                    state <= 2'b11; // Switch to state switch direction
                    walk_left <= 0;
                    walk_right <= 0;
                end
            end
            2'b11: begin // State when switching direction
                state <= 2'b10; // Switch to state walk right
                walk_left <= 0;
                walk_right <= 1;
            end
        endcase
    end
end

endmodule
