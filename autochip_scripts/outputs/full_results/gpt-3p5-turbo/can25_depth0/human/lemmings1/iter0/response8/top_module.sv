module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    // Define states
    reg [1:0] state;
    parameter LEFT = 2'b00;
    parameter RIGHT = 2'b01;
    
    // Define outputs
    reg walk_left;
    reg walk_right;
    
    // Define internal signals
    wire hit_left;
    wire hit_right;
    
    // Detect if Lemming is bumped on left or right
    assign hit_left = areset ? 0 : (bump_left & (~bump_right));
    assign hit_right = areset ? 0 : (bump_right & (~bump_left));
    
    always @(posedge clk or negedge areset) begin
        if (areset) begin
            // Reset Lemming to walk left
            state <= LEFT;
        end else begin
            // State transitions
            case (state)
                LEFT:
                    // Switch to right if bumped on left
                    if (hit_left) begin
                        state <= RIGHT;
                    end
                RIGHT:
                    // Switch to left if bumped on right
                    if (hit_right) begin
                        state <= LEFT;
                    end
            endcase
        end
    end
    
    always @(state) begin
        // Define Lemming's walking direction based on state
        case (state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
        endcase
    end
    
endmodule
