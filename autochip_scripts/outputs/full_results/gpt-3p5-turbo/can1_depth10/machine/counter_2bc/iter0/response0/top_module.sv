module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    parameter STATE_2 = 2'b10;
    parameter STATE_3 = 2'b11;
    
    // Define the current state register
    logic [1:0] current_state;
    
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            current_state <= STATE_1;
        else if (train_valid)
        begin
            if (train_taken && (current_state < STATE_3))
                current_state <= current_state + 1;
            else if (!train_taken && (current_state > STATE_0))
                current_state <= current_state - 1;
        end
    end
    
    // Output the current state
    assign state = current_state;

endmodule
