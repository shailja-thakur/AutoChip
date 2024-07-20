module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    localparam IDLE = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;
    
    // Define the current state variable
    reg [1:0] current_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state 1
            current_state <= STATE_1;
        end else if (train_valid) begin
            // Transition between states based on the taken signal
            if (train_taken && current_state < STATE_3) begin
                current_state <= current_state + 1;
            end else if (!train_taken && current_state > STATE_1) begin
                current_state <= current_state - 1;
            end else begin
                // Remain in current state
                current_state <= current_state;
            end
        end
    end
    
    // Assign the current state to the output
    assign state = current_state;
    
endmodule
