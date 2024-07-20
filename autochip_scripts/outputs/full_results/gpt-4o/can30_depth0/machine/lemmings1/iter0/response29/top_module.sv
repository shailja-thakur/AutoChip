module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define state parameters
    parameter WL = 1'b0, WR = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left) begin
                    next_state = WR;
                end else begin
                    next_state = WL;
                end
            end
            WR: begin
                if (bump_right) begin
                    next_state = WL;
                end else begin
                    next_state = WR;
                end
            end
            default: next_state = WL; // Default state
        endcase
    end
    
    // Sequential logic block to update state on rising edge of clk or areset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL; // Reset to initial state
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic based on current state
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
