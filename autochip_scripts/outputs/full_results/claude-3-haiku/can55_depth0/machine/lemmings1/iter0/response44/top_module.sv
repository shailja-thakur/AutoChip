module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define the two states of the state machine
    parameter WL = 1'b0;
    parameter WR = 1'b1;

    // Register to store the current state
    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the state machine to the initial state (WL)
            state <= WL;
        end else begin
            // Update the state based on the current state and the bump inputs
            case (state)
                WL: begin
                    if (bump_left) begin
                        state <= WR;
                    end else begin
                        state <= WL;
                    end
                end
                WR: begin
                    if (bump_right) begin
                        state <= WL;
                    end else begin
                        state <= WR;
                    end
                end
                default: begin
                    state <= WL;
                end
            endcase
        end
    end

    // Assign the walk_left and walk_right outputs based on the current state
    always @(*) begin
        case (state)
            WL: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            WR: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
