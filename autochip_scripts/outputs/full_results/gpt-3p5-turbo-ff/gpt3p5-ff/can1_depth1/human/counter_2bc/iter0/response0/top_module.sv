module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    logic [1:0] counter;

    // Saturating counter logic
    always_ff@(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken && counter < 2'b11) begin
                counter <= counter + 1; // Increment when train_valid = 1 and train_taken = 1
            end else if (!train_taken && counter > 2'b00) begin
                counter <= counter - 1; // Decrement when train_valid = 1 and train_taken = 0
            end
        end
    end

    // Output assignment
    assign state = counter;

endmodule
