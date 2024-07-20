module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    logic [1:0] current_state; // current state of the state machine
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01; //reset to state 1
        end else begin
            if (train_valid) begin
                if (train_taken && current_state < 2'b11) begin
                    current_state <= current_state + 2'b01; //transition to next state if taken
                end else if (!train_taken && current_state > 2'b00) begin
                    current_state <= current_state - 2'b01; //transition to previous state if not taken
                end
            end
        end
    end
    
    assign state = current_state; // assign current state to output
    
    
endmodule
