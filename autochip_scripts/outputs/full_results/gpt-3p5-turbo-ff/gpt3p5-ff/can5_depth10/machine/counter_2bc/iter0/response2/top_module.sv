module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Define states
    parameter STATE0 = 2'b00;
    parameter STATE1 = 2'b01;
    parameter STATE2 = 2'b10;
    parameter STATE3 = 2'b11;
    
    // Define state variables
    logic [1:0] current_state;
    
    // Always block to update state
    always_ff @(posedge clk or negedge areset) begin
        if (!areset) begin
            current_state <= STATE1; // Reset to state 1
        end else begin
            if (train_valid) begin
                case (current_state)
                    STATE0: begin
                        if (train_taken) begin
                            current_state <= STATE1; // Transition from state 0 to state 1
                        end else begin
                            current_state <= STATE0; // Remain in state 0
                        end
                    end
                    STATE1: begin
                        if (train_taken) begin
                            current_state <= STATE2; // Transition from state 1 to state 2
                        end else begin
                            current_state <= STATE0; // Transition from state 1 to state 0
                        end
                    end
                    STATE2: begin
                        if (train_taken) begin
                            current_state <= STATE3; // Transition from state 2 to state 3
                        end else begin
                            current_state <= STATE1; // Transition from state 2 to state 1
                        end
                    end
                    STATE3: begin
                        if (!train_taken) begin
                            current_state <= STATE2; // Transition from state 3 to state 2
                        end else begin
                            current_state <= STATE3; // Remain in state 3
                        end
                    end
                endcase
            end
        end
    end
    
    // Assign current_state to output
    assign state = current_state;
    
endmodule
