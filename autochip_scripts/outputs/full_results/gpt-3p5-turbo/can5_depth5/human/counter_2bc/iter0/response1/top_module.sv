module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    if (state == 2'b11) begin
                        state <= 2'b11; // Maximum value, saturate
                    end else begin
                        state <= state + 1; // Increment
                    end
                end else begin
                    if (state == 2'b00) begin
                        state <= 2'b00; // Minimum value, saturate
                    else begin
                        state <= state - 1; // Decrement
                    end
                end
            end
        end
    end
    
endmodule
