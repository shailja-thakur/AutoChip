module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Declare the internal state variable
    logic [1:0] current_state;
    
    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            // Reset the state to 1 when areset is asserted
            current_state <= 2'b01;
        end else begin
            // Transition between states based on train_valid and train_taken signals
            case (current_state)
                2'b00: begin
                    if (train_valid && train_taken) begin
                        // Transition to the next state if train_valid and train_taken are both asserted
                        current_state <= 2'b01;
                    else if (!train_valid && !train_taken) begin
                        // Transition to the previous state if train_valid and train_taken are both not asserted
                        current_state <= 2'b11;
                    end
                end
                
                2'b01: begin
                    if (train_valid && train_taken) begin
                        current_state <= 2'b10;
                    else if (!train_valid && !train_taken) begin
                        current_state <= 2'b00;
                    end
                end
                
                2'b10: begin
                    if (train_valid && train_taken) begin
                        current_state <= 2'b11;
                    else if (!train_valid && !train_taken) begin
                        current_state <= 2'b01;
                    end
                end
                
                2'b11: begin
                    if (train_valid && train_taken) begin
                        current_state <= 2'b00;
                    else if (!train_valid && !train_taken) begin
                        current_state <= 2'b10;
                    end
                end
            endcase
        end
    end
        
    // Assign the current state to the output signal
    assign state = current_state;
        
endmodule
