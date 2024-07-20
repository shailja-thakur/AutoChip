module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state, next_state; // Define state variable and next state variable

always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= 2'b00; // Reset state
    end
    else begin
        state <= next_state; // Update state based on next state
    end
end

always @* begin
    next_state = state; // Initialize next state with current state value
    
    case(state)
        2'b00: begin // State A
            if(s) begin
                next_state = 2'b01; // Move to State B when s = 1
            end
        end
        2'b01: begin // State B
            if(w) begin
                next_state = 2'b10; // Move to State C when w = 1
            end
        end
        2'b10: begin // State C
            if(w) begin
                next_state = 2'b11; // Move to State D when w = 1
            end
        end
        2'b11: begin // State D
            if(w) begin
                z <= 1; // Set z to 1 when w = 1 in exactly two of the next three clock cycles
            end
            else begin
                z <= 0; // Set z to 0 otherwise
            end
        end
    endcase
end

endmodule
