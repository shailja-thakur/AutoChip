module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

reg [1:0] state;

// Define the states
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;

always @(posedge clk or negedge areset) begin
    if (areset) begin
        // Reset the module to the initial state
        state <= WALK_LEFT;
    end else begin
        case(state)
            WALK_LEFT: begin
                if (bump_left && !bump_right) begin
                    // If bumped on the left only, switch to walking right
                    state <= WALK_RIGHT;
                end else if (bump_left && bump_right) begin
                    // If bumped on both sides, switch to walking right
                    state <= WALK_RIGHT;
                end else begin
                    // Default: continue walking left
                    state <= WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if (!bump_left && bump_right) begin
                    // If bumped on the right only, switch to walking left
                    state <= WALK_LEFT;
                end else if (bump_left && bump_right) begin
                    // If bumped on both sides, switch to walking left
                    state <= WALK_LEFT;
                end else begin
                    // Default: continue walking right
                    state <= WALK_RIGHT;
                end
            end
        endcase
    end
end

// Output logic
always @(state) begin
    case(state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
        end
        
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
        end
    endcase
end

endmodule
