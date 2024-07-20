module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to hold the current state value
    reg [1:0] current_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to weakly not-taken (2'b01)
            current_state <= 2'b01;
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    // Increment the counter (up to maximum of 3)
                    if (current_state < 2'b11) begin
                        current_state <= current_state + 1;
                    end
                end else begin
                    // Decrement the counter (down to minimum of 0)
                    if (current_state > 2'b00) begin
                        current_state <= current_state - 1;
                    end
                end
            end
        end
    end
    
    // Assign the current_state value to the output state
    assign state = current_state;
    
endmodule
