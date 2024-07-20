module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

// Asynchronous reset
always @(posedge areset or posedge clk) begin
    if (areset) begin
        state <= 2'b01; // Weakly not-taken
    end else if (train_valid) begin
        if (train_taken) begin
            if (state < 2'b11) begin
                state <= state + 1;
            end else begin
                state <= 2'b11; // Saturate at maximum value
            end
        end else begin
            if (state > 2'b00) begin
                state <= state - 1;
            end else begin
                state <= 2'b00; // Saturate at minimum value
            end
        end
    end
end

endmodule
