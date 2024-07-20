module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Define the state machine states
    localparam STATE_0 = 2'b00; // Represents state 0
    localparam STATE_1 = 2'b01; // Represents state 1
    localparam STATE_2 = 2'b10; // Represents state 2
    localparam STATE_3 = 2'b11; // Represents state 3
    
    // Declare the current state variable
    logic [1:0] current_state;
    
    // Assign initial state to current state on reset
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            current_state <= STATE_1;
    end
    
    // Transition between states based on inputs
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= STATE_1;
        else if (train_valid)
        begin
            case (current_state)
                STATE_0:
                    if (train_taken)
                        state <= STATE_1;
                STATE_1:
                    if (train_taken)
                        state <= STATE_2;
                    else
                        state <= STATE_0;
                STATE_2:
                    if (train_taken)
                        state <= STATE_3;
                    else
                        state <= STATE_1;
                STATE_3:
                    if (!train_taken)
                        state <= STATE_2;
            endcase
        end
    end
endmodule
