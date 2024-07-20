module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    
    always @ (state or j or k) begin
        if (state == 2'b00) begin // State A
            if (j)
                next_state = 2'b01; // Transition to State B
            else
                next_state = 2'b00; // Stay in State A
        end
        else begin // State B
            if (k)
                next_state = 2'b00; // Transition to State A
            else
                next_state = 2'b01; // Stay in State B
        end
    end
    
    always @ (posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // Reset to State A
        else
            state <= next_state; // Update state based on next_state
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output high if state is B, otherwise low

endmodule
