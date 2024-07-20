module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    reg next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to state B
        end else begin
            state <= next_state; // Update state based on next_state
        end
    end
    
    always @(*) begin
        case(state)
            2'b00: begin // State A
                if (in) begin
                    next_state = 2'b00; // Stay in state A
                    out = 1'b1;
                end else begin
                    next_state = 2'b01; // Transition to state B
                    out = 1'b0;
                end
            end
            
            2'b01: begin // State B
                if (in) begin
                    next_state = 2'b01; // Stay in state B
                    out = 1'b1;
                end else begin
                    next_state = 2'b00; // Transition to state A
                    out = 1'b0;
                end
            end
        endcase
    end
    
endmodule
