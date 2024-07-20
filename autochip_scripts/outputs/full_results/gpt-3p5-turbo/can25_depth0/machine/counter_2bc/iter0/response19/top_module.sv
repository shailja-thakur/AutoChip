module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Internal state variable
    reg [1:0] current_state;
    
    // State machine logic
    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            current_state <= 2'b01; // Reset to state 1
        end else begin
            case (current_state)
                2'b00: begin
                    if (train_taken) begin
                        current_state <= 2'b01; // Transition to state 1
                    end
                end
                2'b01: begin
                    if (train_taken && current_state < 2'b11) begin
                        current_state <= current_state + 1; // Transition to next state
                    end else if (!train_taken && current_state > 2'b00) begin
                        current_state <= current_state - 1; // Transition to previous state
                    end
                end
                2'b10: begin
                    if (train_taken && current_state < 2'b11) begin
                        current_state <= current_state + 1; // Transition to next state
                    end else if (!train_taken && current_state > 2'b00) begin
                        current_state <= current_state - 1; // Transition to previous state
                    end
                end
                2'b11: begin
                    if (!train_taken) begin
                        current_state <= 2'b10; // Transition to state 2
                    end
                end
            endcase
        end
    end
    
    // Assign state output
    assign state = current_state;
    
endmodule
