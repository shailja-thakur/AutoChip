module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    reg [1:0] state; // State register
    wire switch_direction; // Output wire
    
    // Define state constants
    localparam IDLE = 2'b00;
    localparam WALK_LEFT = 2'b01;
    localparam WALK_RIGHT = 2'b10;
    
    // Define output assignments
    assign walk_left = (state == WALK_LEFT); // Output walk_left
    assign walk_right = (state == WALK_RIGHT); // Output walk_right
    
    // Define the next state logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT; // Reset state to WALK_LEFT
        end
        else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right) begin
                        state <= WALK_RIGHT; // Switch to WALK_RIGHT state if bumped on the right
                    end
                    else if (bump_left && !bump_right) begin
                        state <= WALK_LEFT; // Remain in WALK_LEFT state if bumped on the left only
                    end
                end
                WALK_RIGHT: begin
                    if (bump_left) begin
                        state <= WALK_LEFT; // Switch to WALK_LEFT state if bumped on the left
                    end
                    else if (!bump_left && bump_right) begin
                        state <= WALK_RIGHT; // Remain in WALK_RIGHT state if bumped on the right only
                    end
                end
                default: state <= WALK_LEFT; // Default state: WALK_LEFT
            endcase
        end
    end
endmodule
