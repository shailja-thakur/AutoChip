module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Internal signals
    logic [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            next_state <= 2'b01; // Reset to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    if (state == 2'b11) begin
                        next_state <= 2'b11; // Saturate at maximum value
                    end else begin
                        next_state <= state + 2'b01; // Increment counter
                    end
                end else begin
                    if (state == 2'b00) begin
                        next_state <= 2'b00; // Saturate at minimum value
                    end else begin
                        next_state <= state - 2'b01; // Decrement counter
                    end
                end
            else begin
                next_state <= state; // Keep value unchanged
            end
        end
    end
    
    assign state = next_state;
endmodule
