module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    logic [1:0] next_state;

    // Asynchronous reset
    always_ff @(posedge areset or posedge clk)
    begin
        if (areset)
            next_state <= 2'b01;
        else
            next_state <= state;
    end

    // Counter logic
    always_ff @(posedge clk)
    begin
        if (train_valid)
        begin
            if (train_taken)
            begin
                if (state == 2'b11)
                    next_state <= 2'b11; // Max value (3)
                else
                    next_state <= state + 1;
            end
            else
            begin
                if (state == 2'b00)
                    next_state <= 2'b00; // Min value (0)
                else
                    next_state <= state - 1;
            end
        end
    end

    // Assign next state to current state
    always_comb
    begin
        state <= next_state;
    end

endmodule
