module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00; // Reset to state A
        end else begin
            case(state)
                2'b00: begin // State A
                    if (in) begin
                        state <= 2'b01; // Transition to state B on next input 1
                    end else begin
                        state <= 2'b00; // Transition to state A on next input 0
                    end
                end
                
                2'b01: begin // State B
                    if (in) begin
                        state <= 2'b01; // Transition to state B on next input 1
                    end else begin
                        state <= 2'b10; // Transition to state C on next input 0
                    end
                end
                
                2'b10: begin // State C
                    if (in) begin
                        state <= 2'b00; // Transition to state A on next input 1
                    end else begin
                        state <= 2'b11; // Transition to state D on next input 0
                    end
                end
                
                2'b11: begin // State D
                    if (in) begin
                        state <= 2'b10; // Transition to state C on next input 1
                    end else begin
                        state <= 2'b11; // Transition to state D on next input 0
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        case(state)
            2'b00: out <= 1'b0; // Output 0 in state A
            2'b01: out <= 1'b0; // Output 0 in state B
            2'b10: out <= 1'b0; // Output 0 in state C
            2'b11: out <= 1'b1; // Output 1 in state D
        endcase
    end
    
endmodule
