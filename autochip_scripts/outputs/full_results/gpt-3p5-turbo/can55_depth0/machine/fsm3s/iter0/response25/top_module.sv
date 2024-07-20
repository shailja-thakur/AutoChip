module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    reg [1:0] state;
    reg nextState;
    
    always @(posedge clk or posedge reset) begin
        if (reset) state <= 2'b00; // Reset to A
        else state <= nextState; // Next state determined by nextState
    end
    
    always @(state or in) begin
        case(state)
            2'b00: begin // State A
                if (in) nextState = 2'b01; // Transition to B
                else nextState = 2'b00; // Remain in A
            end
            
            2'b01: begin // State B
                if (in) nextState = 2'b01; // Remain in B
                else nextState = 2'b10; // Transition to C
            end
            
            2'b10: begin // State C
                if (in) nextState = 2'b11; // Transition to D
                else nextState = 2'b00; // Transition to A
            end
            
            2'b11: begin // State D
                if (in) nextState = 2'b01; // Transition to B
                else nextState = 2'b10; // Transition to C
            end
        endcase
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output is 1 when state is D
endmodule
