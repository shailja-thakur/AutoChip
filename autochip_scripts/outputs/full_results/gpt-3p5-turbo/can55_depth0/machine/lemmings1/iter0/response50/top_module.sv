module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
   
    // Define the states
    parameter WL = 1'b0;
    parameter WR = 1'b1;
   
    // Declare the state register
    reg state;
   
    // Declare the next state
    reg next_state;
   
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the state machine to initial state WL
            state <= WL;
        end else begin
            // Determine the next state based on current state and inputs
            if (state == WL) begin
                if (bump_left) begin
                    next_state <= WR;
                end else begin
                    next_state <= WL;
                end
            end else if (state == WR) begin
                if (bump_right) begin
                    next_state <= WL;
                end else begin
                    next_state <= WR;
                end
            end
        end
    end
   
    always @(posedge clk) begin
        // Update the state on the rising edge of clk
        state <= next_state;
       
        // Assign the outputs based on the current state
        if (state == WL) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end else if (state == WR) begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
        end
    end
   
endmodule
