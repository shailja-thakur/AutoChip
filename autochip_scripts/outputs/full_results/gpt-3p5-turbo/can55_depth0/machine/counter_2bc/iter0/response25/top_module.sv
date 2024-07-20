module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Define the four states
    logic [1:0] state_reg;
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    
    // State register for next state calculation
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state_reg <= S1;     // Reset to state 1
        else begin
            case (state_reg)
                S0: begin
                    if (train_valid) begin
                        if (train_taken)
                            state_reg <= S1;     // Transition to state 1
                    end
                end
                S1: begin
                    if (train_valid) begin
                        if (train_taken)
                            state_reg <= S2;     // Transition to state 2
                        else
                            state_reg <= S0;     // Transition to state 0
                    end
                end
                S2: begin
                    if (train_valid) begin
                        if (train_taken)
                            state_reg <= S3;     // Transition to state 3
                        else
                            state_reg <= S1;     // Transition to state 1
                    end
                end
                S3: begin
                    if (train_valid) begin
                        if (!train_taken)
                            state_reg <= S2;     // Transition to state 2
                    end
                end
                default: state_reg <= S1;    // Default state is state 1
            endcase
        end
    end
    
    // Output the current state
    always_comb begin
        state = state_reg;
    end
endmodule
