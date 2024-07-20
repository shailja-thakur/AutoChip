module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    
    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // Reset to state A
        else
            state <= next_state; // Update state on rising edge of clk
    end
    
    always @* begin
        case (state)
            2'b00: begin // State A
                if (in)
                    next_state = 2'b01; // Transition to state B if input is 1
                else
                    next_state = 2'b00; // Transition to state A if input is 0
            end
            2'b01: begin // State B
                if (in)
                    next_state = 2'b01; // Transition to state B if input is 1
                else
                    next_state = 2'b10; // Transition to state C if input is 0
            end
            2'b10: begin // State C
                if (in)
                    next_state = 2'b11; // Transition to state D if input is 1
                else
                    next_state = 2'b00; // Transition to state A if input is 0
            end
            2'b11: begin // State D
                if (in)
                    next_state = 2'b01; // Transition to state B if input is 1
                else
                    next_state = 2'b10; // Transition to state C if input is 0
            end
        endcase
    end
    
    assign out = (state == 2'b11); // Set out to 1 when in state D
    
endmodule
