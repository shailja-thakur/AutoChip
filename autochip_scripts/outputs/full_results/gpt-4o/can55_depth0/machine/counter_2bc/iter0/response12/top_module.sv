module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define states as parameters
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    parameter STATE_2 = 2'b10;
    parameter STATE_3 = 2'b11;

    // Internal register to hold the state
    logic [1:0] current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // By default, stay in the current state
        next_state = current_state;

        if (train_valid) begin
            if (train_taken) begin
                // Taken signal is asserted, move to the next state if possible
                if (current_state < STATE_3) begin
                    next_state = current_state + 1;
                end
            end else begin
                // Taken signal is not asserted, move to the previous state if possible
                if (current_state > STATE_0) begin
                    next_state = current_state - 1;
                end
            end
        end
    end

    // Output the current state
    assign state = current_state;

endmodule
