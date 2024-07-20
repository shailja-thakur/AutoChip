module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    // Parameters to represent the two states of the state machine
    parameter WL = 0;
    parameter WR = 1;
    
    // Define state register
    reg [1:0] state;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            // Reset state machine to initial state (WL)
            state <= WL;
        end else begin
            // Update state machine based on current state and input signals
            if (state == WL) begin
                if (bump_left) begin
                    state <= WR;
                end else begin
                    state <= WL;
                end
            end else begin // state == WR
                if (bump_right) begin
                    state <= WL;
                end else begin
                    state <= WR;
                end
            end
        end
    end
    
    assign walk_left = (state == WL) ? 1'b1 : 1'b0; // Set walk_left high if state is WL, else set it low
    assign walk_right = (state == WR) ? 1'b1 : 1'b0; // Set walk_right high if state is WR, else set it low

endmodule
