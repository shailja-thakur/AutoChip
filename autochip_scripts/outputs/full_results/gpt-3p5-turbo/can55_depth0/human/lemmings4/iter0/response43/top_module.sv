module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);
    reg [4:0] state; // State register
    reg [4:0] counter; // Counter to keep track of falling cycles
    
    // Assign default values to outputs
    assign walk_left = state == 0 || state == 1;
    assign walk_right = state == 2 || state == 3;
    assign aaah = state == 5;
    assign digging = state == 4;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 0; // Reset to initial state
            counter <= 0; // Reset counter
        end else begin
            case (state)
                0: begin // Walking left
                    if (bump_right) // Switch direction on right bump
                        state <= 3;
                    else if (!ground) // Start falling when ground disappears
                        state <= 5;
                    else if (dig) // Start digging if walking on ground and dig signal is high
                        state <= 4;
                end
                1: begin // Walking left and bumped on left
                    if (bump_left || bump_right) // Switch direction on any bump
                        state <= 3;
                    else if (!ground) // Start falling when ground disappears
                        state <= 5;
                    else if (dig) // Start digging if walking on ground and dig signal is high
                        state <= 4;
                end
                2: begin // Walking right
                    if (bump_left) // Switch direction on left bump
                        state <= 1;
                    else if (!ground) // Start falling when ground disappears
                        state <= 5;
                    else if (dig) // Start digging if walking on ground and dig signal is high
                        state <= 4;
                end
                3: begin // Walking right and bumped on right
                    if (bump_left || bump_right) // Switch direction on any bump
                        state <= 1;
                    else if (!ground) // Start falling when ground disappears
                        state <= 5;
                    else if (dig) // Start digging if walking on ground and dig signal is high
                        state <= 4;
                end
                4: begin // Digging
                    if (!ground) // Start falling when ground disappears
                        state <= 5;
                    else if (!dig) // Stop digging if dig signal goes low
                        state <= 2;
                end
                5: begin // Falling
                    if (ground) // Resume walking when ground reappears
                        state <= 2;
                    else if (counter >= 20) // Splatter if falling for more than 20 cycles
                        state <= 6;
                    else
                        counter <= counter + 1; // Increment counter
                end
                6: begin // Splatter state, cease all actions
                    state <= 6;
                end
            endcase
        end
    end
    
endmodule
