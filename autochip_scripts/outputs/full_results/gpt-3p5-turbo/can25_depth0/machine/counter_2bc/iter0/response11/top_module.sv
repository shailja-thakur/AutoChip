module top_module(
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);
    
    // State variable
    logic [1:0] current_state;
    
    always_ff @(posedge clk or posedge areset) begin
        // Reset state machine if asynchronous reset is asserted
        if (areset) begin
            current_state <= 2'b01;
        end
        else begin
            // Transition between states based on input signals
            if (train_valid) begin
                if (train_taken && current_state < 2'b11) begin
                    current_state <= current_state + 1;
                end
                else if (!train_taken && current_state > 2'b00) begin
                    current_state <= current_state - 1;
                end
            end
        end
    end
    
    assign state = current_state;
    
endmodule
