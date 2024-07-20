module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define state enum
    typedef enum logic [1:0] {
        LEFT,
        RIGHT
    } State;

    // Define state register
    reg [1:0] curr_state;
    
    // Define next state register
    reg [1:0] next_state;

    // Define state output
    assign walk_left = (curr_state == LEFT);
    assign walk_right = (curr_state == RIGHT);

    // Synchronous state machine
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Initialize state as LEFT
            curr_state <= LEFT;
        end
        else begin
            // Update next state based on current state and inputs
            case (curr_state)
                LEFT: begin
                    if (bump_right) begin
                        // Transition to RIGHT state if bumped on right
                        next_state <= RIGHT;
                    end
                    else begin
                        // Stay in LEFT state otherwise
                        next_state <= LEFT;
                    end
                end
                RIGHT: begin
                    if (bump_left) begin
                        // Transition to LEFT state if bumped on left
                        next_state <= LEFT;
                    end
                    else begin
                        // Stay in RIGHT state otherwise
                        next_state <= RIGHT;
                    end
                end
                default: next_state <= LEFT; // Default to LEFT state
            endcase
        end
    end

    // Update current state at the end of the clock cycle
    always @(*) begin
        curr_state <= next_state;
    end

endmodule
