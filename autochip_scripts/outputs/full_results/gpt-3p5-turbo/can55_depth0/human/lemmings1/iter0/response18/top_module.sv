module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    
    reg [1:0] state; // State variable
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b0; // Reset the state to 0 (walking left)
        end else begin
            case(state)
                2'b00: begin // State 0: walking left
                    if (bump_left) begin
                        state <= 2'b01; // Transition to state 1 if bumped on left
                    end else if (bump_right) begin
                        state <= 2'b10; // Transition to state 2 if bumped on right
                    end
                end
                
                2'b01: begin // State 1: walking right
                    if (bump_right) begin
                        state <= 2'b10; // Transition to state 2 if bumped on right
                    end else if (bump_left || (bump_left && bump_right)) begin
                        state <= 2'b00; // Transition to state 0 if bumped on left or both sides
                    end
                end
                
                2'b10: begin // State 2: walking left
                    if (bump_left) begin
                        state <= 2'b01; // Transition to state 1 if bumped on left
                    end else if (bump_right || (bump_left && bump_right)) begin
                        state <= 2'b00; // Transition to state 0 if bumped on right or both sides
                    end
                end
            endcase
        end
    end
    
    // Output assignment based on state
    always @(state) begin
        case(state)
            2'b00: begin // State 0: walking left
                walk_left = 1;
                walk_right = 0;
            end
            
            2'b01: begin // State 1: walking right
                walk_left = 0;
                walk_right = 1;
            end
            
            2'b10: begin // State 2: walking left
                walk_left = 1;
                walk_right = 0;
            end
        endcase
    end
endmodule
