module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Define the states
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    
    // Define the signals and variables
    logic [1:0] next_state;
    
    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1;
        end else begin
            state <= next_state;
        end
    end
    
    // State transition logic
    always_comb begin
        if (train_valid) begin
            if (train_taken) begin
                next_state = (state == S3) ? state : state + 1;
            end else begin
                next_state = (state == S0) ? state : state - 1;
            end
        end else begin
            next_state = state;
        end
    end
endmodule
