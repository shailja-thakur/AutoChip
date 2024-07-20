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

    // Declare the state register
    reg [1:0] state;

    // Define the state transitions and outputs
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Initialize the state to walk_left
        end else begin
            case (state)
                2'b00: begin // Current state is walk_left
                    if (ground) begin
                        if (bump_right) begin
                            state <= 2'b01; // Switch to walk_right state
                        end
                    end else begin
                        if (bump_right || bump_left) begin
                            state <= 2'b01; // Switch to walk_right state
                        end else if (!ground) begin
                            state <= 2'b10; // Transition to aaah state
                        end
                    end
                end
                2'b01: begin // Current state is walk_right
                    if (ground) begin
                        if (bump_left) begin
                            state <= 2'b00; // Switch to walk_left state
                        end
                    end else begin
                        if (bump_left || bump_right) begin
                            state <= 2'b00; // Switch to walk_left state
                        end else if (!ground) begin
                            state <= 2'b10; // Transition to aaah state
                        end
                    end
                end
                2'b10: begin // Current state is aaah
                    if (ground) begin
                        state <= 2'b00; // Transition to walk_left state
                    end
                end
            endcase
        end
    end
    
    // Assign the outputs based on the current state
    always @(*) begin
        case (state)
            2'b00: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            2'b01: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            2'b10: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end

endmodule
