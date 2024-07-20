module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Defining internal signals
    logic [1:0] nextState;

    // Positive edge triggered asynchronous reset
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b01;
        else
            state <= nextState;
    end

    // Updating the counter based on train_valid and train_taken values
    always_comb
    begin
        case ({train_valid, train_taken})
            // Increment the counter
            2'b11: nextState = (state == 2'b11) ? 2'b11 : state + 1;

            // Decrement the counter
            2'b10: nextState = (state == 2'b00) ? 2'b00 : state - 1;

            // Keep the counter unchanged
            default: nextState = state;
        endcase
    end

endmodule
