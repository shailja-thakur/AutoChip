module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Define the four states using a parameter
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    parameter STATE_2 = 2'b10;
    parameter STATE_3 = 2'b11;
    
    // Create a reg for the current state
    reg [1:0] current_state;
    
    // Initialize the state machine at state 1
    initial begin
        current_state <= STATE_1;
    end
    
    // Reset the state machine when areset is asserted
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_1;
    end
    
    // Transition states based on train_valid and train_taken signals
    always @(posedge clk) begin
        if (train_valid) begin
            if (train_taken && (current_state < STATE_3))
                current_state <= current_state + 1;
            else if (!train_taken && (current_state > STATE_0))
                current_state <= current_state - 1;
        end
    end
    
    // Assign the current_state to the output state
    assign state = current_state;
    
endmodule
