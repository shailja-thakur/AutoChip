module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define states
    parameter STATE0 = 0;
    parameter STATE1 = 1;
    parameter STATE2 = 2;
    parameter STATE3 = 3;
    
    // Define state registers
    logic [1:0] current_state;
    logic [1:0] next_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE1;
        end else begin
            current_state <= next_state;
        end
    end
    
    always_comb begin
        // Default next state is the same as current state
        next_state = current_state;
        
        if (train_valid) begin
            if (train_taken && current_state < STATE3) begin
                next_state = current_state + 1;
            end else if (!train_taken && current_state > STATE0) begin
                next_state = current_state - 1;
            end
        end
    end
    
    assign state = current_state;
    
endmodule
