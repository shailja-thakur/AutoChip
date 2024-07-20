module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Internal signal to store the current value of the counter
    logic [1:0] counter_value;
  
    // Saturating counter logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset, reset the counter to weakly not-taken (2'b01)
            counter_value <= 2'b01;
        end else begin
            if (train_valid) begin
                if (train_taken && (counter_value < 2'b11)) begin
                    // Increment the counter if train_valid = 1 and train_taken = 1
                    counter_value <= counter_value + 1'b1;
                end else if (!train_taken && (counter_value > 2'b00)) begin
                    // Decrement the counter if train_valid = 1 and train_taken = 0
                    counter_value <= counter_value - 1'b1;
                end
            end
        end
    end

    // Output the current value of the counter
    assign state = counter_value;
endmodule
