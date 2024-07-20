module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Define the states as parameters
    parameter STATE0 = 2'b00;
    parameter STATE1 = 2'b01;
    parameter STATE2 = 2'b10;
    parameter STATE3 = 2'b11;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE1; // Reset to state 1
        end
        else if (train_valid) begin
            if (train_taken) begin
                if (state < STATE3) begin
                    state <= state + 1;
                end
                else begin
                    state <= state;
                end
            end
            else begin
                if (state > STATE0) begin
                    state <= state - 1;
                end
                else begin
                    state <= state;
                end
            end
        end
    end

endmodule
