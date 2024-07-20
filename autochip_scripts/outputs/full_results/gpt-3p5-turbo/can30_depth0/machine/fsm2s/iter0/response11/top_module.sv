module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    reg [1:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Initializing state A
        end else begin
            state <= next_state; // Updating state based on next_state
        end
    end

    always @(state, j, k) begin
        case (state)
            2'b00: begin // State A
                if (j) begin
                    next_state = 2'b01; // Transition to state B
                end else begin
                    next_state = 2'b00; // Remain in state A
                end
                out <= 1'b0; // Output is low when state is A
            end
            2'b01: begin // State B
                if (k) begin
                    next_state = 2'b00; // Transition to state A
                end else begin
                    next_state = 2'b01; // Remain in state B
                end
                out <= 1'b1; // Output is high when state is B
            end
        endcase
    end
    
    // Optional initial block to set initial values
    initial begin
        state <= 2'b00;
        next_state <= 2'b00;
        out <= 1'b0; 
    end
endmodule
