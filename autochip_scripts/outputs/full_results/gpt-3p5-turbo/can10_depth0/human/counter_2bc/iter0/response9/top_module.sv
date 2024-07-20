module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    reg [1:0] counter;

    // Saturating counter logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 2'b01; // Reset to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken && (counter < 2'b11)) begin
                    counter <= counter + 1; // Increment counter
                end else if (!train_taken && (counter > 2'b00)) begin
                    counter <= counter - 1; // Decrement counter
                end
            end
        end
    end

    // Assign the output
    assign state = counter;

endmodule
