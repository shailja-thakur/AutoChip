module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal state register
    logic [1:0] current_state;

    // Asynchronous reset
    always_ff @(posedge clk, negedge areset) begin
        if (areset == 0) begin
            current_state <= 2'b01;
        end
    end

    // State transition logic
    always_ff @(posedge clk) begin
        if (train_valid) begin
            if (train_taken && current_state < 2'b11) begin
                current_state <= current_state + 2'b01;
            end else if (!train_taken && current_state > 2'b00) begin
                current_state <= current_state - 2'b01;
            end
        end
    end

    // Output assignment
    assign state = current_state;

endmodule
