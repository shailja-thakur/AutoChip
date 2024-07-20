module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    logic [1:0] counter;

    // Counter logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 2'b01; // Reset counter to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                counter <= (counter == 2'b11) ? 2'b11 : counter + 1; // Increment counter up to 3
            end else begin
                counter <= (counter == 2'b00) ? 2'b00 : counter - 1; // Decrement counter down to 0
            end
        end
    end

    // Output assignment
    assign state = counter;

endmodule
