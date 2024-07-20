module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // Initialize state to A (0)
    end else begin
        state <= next_state; // Update state based on next_state
    end
end

always @(*) begin
    case(state)
        // State A (0)
        3'b000: begin
            case(w)
                1'b1: next_state = 3'b010; // Transition to B (2)
                1'b0: next_state = 3'b000; // Transition to A (0)
            endcase
        end
        
        // State B (2)
        3'b010: begin
            case(w)
                1'b1: next_state = 3'b100; // Transition to C (4)
                1'b0: next_state = 3'b110; // Transition to D (6)
            endcase
        end
        
        // State C (4)
        3'b100: begin
            case(w)
                1'b1: next_state = 3'b100; // Transition to C (4)
                1'b0: next_state = 3'b110; // Transition to D (6)
            endcase
        end
        
        // State D (6)
        3'b110: begin
            case(w)
                1'b1: next_state = 3'b101; // Transition to E (5)
                1'b0: next_state = 3'b000; // Transition to A (0)
            endcase
        end
        
        // State E (5)
        3'b101: begin
            case(w)
                1'b1: next_state = 3'b101; // Transition to E (5)
                1'b0: next_state = 3'b110; // Transition to D (6)
            endcase
        end
        
        // State F (3)
        3'b001: begin
            case(w)
                1'b1: next_state = 3'b100; // Transition to C (4)
                1'b0: next_state = 3'b110; // Transition to D (6)
            endcase
        end
    endcase
end

assign z = (state == 3'b101 || state == 3'b001) ? 1'b1 : 1'b0;

endmodule
