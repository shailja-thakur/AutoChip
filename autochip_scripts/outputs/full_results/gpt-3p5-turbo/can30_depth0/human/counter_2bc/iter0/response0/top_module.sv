module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Reset to weakly not-taken
        else if (train_valid) begin
            if (train_taken) begin
                if (state == 2'b11)
                    state <= 2'b11; // Maximum value, saturated
                else
                    state <= state + 1; // Increment counter
            end
            else begin
                if (state == 2'b00)
                    state <= 2'b00; // Minimum value, saturated
                else
                    state <= state - 1; // Decrement counter
            end
        end
    end
endmodule
