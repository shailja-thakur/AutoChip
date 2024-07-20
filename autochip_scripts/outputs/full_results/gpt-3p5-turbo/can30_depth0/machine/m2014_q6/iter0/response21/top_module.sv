module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    reg [2:0] state;
    wire next_state_w_low;
    wire next_state_w_high;
    
    // Transition logic for next state
    assign next_state_w_low = (w == 0);
    assign next_state_w_high = (w == 1);
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b001; // Reset to state A
        end else begin
            case (state)
                3'b001: begin // State A
                    if (next_state_w_low) begin
                        state <= 3'b010; // Transition to state B
                    end else if (next_state_w_high) begin
                        state <= 3'b001; // Stay in state A
                    end
                end
                
                3'b010: begin // State B
                    if (next_state_w_high) begin
                        state <= 3'b100; // Transition to state D
                    end else if (next_state_w_low) begin
                        state <= 3'b011; // Transition to state C
                    end
                end
                
                3'b011: begin // State C
                    if (next_state_w_high) begin
                        state <= 3'b100; // Transition to state D
                    end else if (next_state_w_low) begin
                        state <= 3'b101; // Transition to state E
                    end
                end
                
                3'b100: begin // State D
                    if (next_state_w_high) begin
                        state <= 3'b001; // Transition to state A
                    end else if (next_state_w_low) begin
                        state <= 3'b110; // Transition to state F
                    end
                end
                
                3'b101: begin // State E
                    if (next_state_w_high) begin
                        state <= 3'b100; // Transition to state D
                    end else if (next_state_w_low) begin
                        state <= 3'b101; // Stay in state E
                    end
                end
                
                3'b110: begin // State F
                    if (next_state_w_high) begin
                        state <= 3'b100; // Transition to state D
                    end else if (next_state_w_low) begin
                        state <= 3'b011; // Transition to state C
                    end
                end
            endcase
        end
    end
    
    // Output z logic
    always @(state) begin
        if (state == 3'b101 || state == 3'b110) begin
            z <= 1; // State E or F, output high
        end else begin
            z <= 0; // Other states, output low
        end
    end
    
endmodule
