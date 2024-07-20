module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    logic [1:0] temp_state;

    // Saturating counter logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            temp_state <= 2'b01;
        else if (train_valid) begin
            if (train_taken) begin
                if (temp_state < 2) begin
                    temp_state <= temp_state + 1;
                end
            end else begin
                if (temp_state > 0) begin
                    temp_state <= temp_state - 1;
                end
            end
        end
    end

    // Assign value to output state
    assign state = temp_state;

endmodule
