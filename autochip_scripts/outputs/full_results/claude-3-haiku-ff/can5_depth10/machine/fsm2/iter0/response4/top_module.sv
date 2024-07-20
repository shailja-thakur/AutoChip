module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg state, next_state;
    
    // Combinational block to determine the next state
    always @(*) begin
        case (state)
            1'b0: begin // State A
                if (j) begin
                    next_state = 1'b1; // Go to State B
                end else begin
                    next_state = 1'b0; // Remain in State A
                end
            end
            1'b1: begin // State B
                if (k) begin
                    next_state = 1'b0; // Go to State A
                end else begin
                    next_state = 1'b1; // Remain in State B
                end
            end
            default: begin
                next_state = 1'b0; // Default to State A
            end
        endcase
    end
    
    // Clocked block to update the state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b0; // Reset to State A
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    assign out = state; // Output the current state

endmodule
