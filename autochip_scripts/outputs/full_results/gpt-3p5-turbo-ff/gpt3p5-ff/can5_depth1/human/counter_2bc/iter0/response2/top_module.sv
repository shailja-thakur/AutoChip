module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Create a temporary variable to store the updated state
    logic [1:0] temp_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            temp_state <= 2'b01;
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    // Increment the counter (up to a maximum of 3)
                    if (temp_state == 2'b11) begin
                        temp_state <= 2'b11;
                    end else begin
                        temp_state <= temp_state + 1;
                    end
                end else begin
                    // Decrement the counter (down to a minimum of 0)
                    if (temp_state == 2'b00) begin
                        temp_state <= 2'b00;
                    end else begin
                        temp_state <= temp_state - 1;
                    end
                end
            end
        end
    end

    // Assign the value of the temporary state to the output
    assign state = temp_state;

endmodule
