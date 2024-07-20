module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
    
    // Declare states
    reg [3:0] state;
    
    // Declare next states
    reg [3:0] next_state;
    
    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;  // Initial state
        end else begin
            state <= next_state;  // Update state based on next_state value
        end
    end
    
    // Next state logic
    always @* begin
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = state;  // No state change
                end
            end
            
            B: begin
                if (w) begin
                    next_state = S11;
                end else begin
                    next_state = S10;
                end
            end
            
            C: begin
                if (w) begin
                    next_state = S11;
                end else begin
                    next_state = S10;
                end
            end
            
            S10: begin
                if (w) begin
                    next_state = S21;
                end else begin
                    next_state = S20;
                end
            end
            
            S11: begin
                if (w) begin
                    next_state = S22;
                end else begin
                    next_state = S21;
                end
            end
            
            S20: begin
                next_state = B;
            end
            
            S21: begin
                if (w) begin
                    next_state = C;
                end else begin
                    next_state = B;
                end
            end
            
            S22: begin
                if (w) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        case (state)
            A: begin
                // No output
            end
            
            B: begin
                // No output
            end
            
            C: begin
                // No output
            end
            
            S10: begin
                // No output
            end
            
            S11: begin
                // No output
            end
            
            S20: begin
                // No output
            end
            
            S21: begin
                // No output
            end
            
            S22: begin
                // No output
            end
        endcase
        
        // Output z
        if (state == A) begin
            z <= 0;
        end else begin
            z <= 1;
        end
    end
endmodule
