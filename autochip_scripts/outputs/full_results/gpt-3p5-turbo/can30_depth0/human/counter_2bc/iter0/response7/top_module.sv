module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    logic [1:0] counter_value;

    // Always block for counter logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            counter_value <= 2'b01; // Reset to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken && (counter_value != 2'b11)) begin
                    counter_value <= counter_value + 2'b01; // Increment when train_taken = 1
                end else if (!train_taken && (counter_value != 2'b00)) begin
                    counter_value <= counter_value - 2'b01; // Decrement when train_taken = 0
                end
            end
        end
    end

    // Assign counter value to output
    assign state = counter_value;

endmodule
