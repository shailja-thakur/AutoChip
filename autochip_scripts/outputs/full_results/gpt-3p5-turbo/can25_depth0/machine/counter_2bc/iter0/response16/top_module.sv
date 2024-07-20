module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Internal register to hold the current state
    reg [1:0] current_state;
    
    // Initialize current state to 1 on asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01;
        else
            current_state <= next_state;
    end
    
    // Determine next state based on current state and inputs
    always_comb begin
        case (current_state)
            2'b00: begin
                if (train_valid)
                    current_state <= 2'b01;
                else
                    current_state <= 2'b00;
            end
            2'b01: begin
                if (train_taken && current_state < 2'b11)
                    current_state <= current_state + 1;
                else if (!train_taken && current_state > 2'b00)
                    current_state <= current_state - 1;
                else
                    current_state <= current_state;
            end
            2'b10: begin
                // This state is not used, so no transition necessary
                current_state <= current_state;
            end
            2'b11: begin
                // This state is not used, so no transition necessary
                current_state <= current_state;
            end
        endcase
    end
    
    // Assign current state to output
    assign state = current_state;
    
endmodule
