module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Variable to hold the current state
    logic [1:0] current_state;
    
    // Assign the initial state
    initial begin
        current_state <= 2'b01;
    end
    
    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset state to 01 when areset is asserted
            current_state <= 2'b01;
        end else if (train_valid) begin
            // Transition to the next state if taken is asserted and current state is less than 3
            if (train_taken && current_state < 2'b11) begin
                current_state <= current_state + 2'b01;
            end
            // Transition to the previous state if taken is not asserted and current state is greater than 0
            else if (!train_taken && current_state > 2'b00) begin
                current_state <= current_state - 2'b01;
            end
            // Remain in current state otherwise
            else begin
                current_state <= current_state;
            end
        end
    end
    
    // Assign the computed state to the output
    assign state = current_state;
    
endmodule
