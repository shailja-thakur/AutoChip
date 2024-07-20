module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Internal signals
    reg [1:0] current_state;
    
    // State machine transitions
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01; // State 1
        end else if (train_valid) begin
            if (train_taken && (current_state < 2'b11)) begin
                current_state <= current_state + 2'b01; // Next state
            end else if (!train_taken && (current_state > 2'b00)) begin
                current_state <= current_state - 2'b01; // Previous state
            end
        end
    end
    
    // Assign output
    assign state = current_state;
endmodule
