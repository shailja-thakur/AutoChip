module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    logic [1:0] count;

    // Counter logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            count <= 2'b01; // Reset to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    if (count < 2'b11) begin
                        count <= count + 1; // Increment if not saturated
                    end
                end else begin
                    if (count > 2'b00) begin
                        count <= count - 1; // Decrement if not minimum
                    end
                end
            end
        end
    end

    // Assign counter value to output
    assign state = count;

endmodule
