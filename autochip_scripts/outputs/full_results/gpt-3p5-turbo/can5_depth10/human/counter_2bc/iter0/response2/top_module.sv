module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Registers to store the counter value
    logic [1:0] counter;

    // Positive edge triggered asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 2'b01; // Reset to weakly not-taken
        end else begin
            // Counter logic
            if (train_valid && train_taken) begin
                if (counter < 2'b11) begin
                    counter <= counter + 1;
                end
            end else if (train_valid && !train_taken) begin
                if (counter > 2'b00) begin
                    counter <= counter - 1;
                end
            end
        end
    end

    // Assign the counter value to the output
    assign state = counter;

endmodule
