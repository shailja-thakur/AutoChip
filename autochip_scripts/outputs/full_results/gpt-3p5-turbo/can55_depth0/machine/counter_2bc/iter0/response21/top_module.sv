module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define states
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    parameter STATE_2 = 2'b10;
    parameter STATE_3 = 2'b11;

    // Internal signals
    logic [1:0] next_state;
    logic [1:0] current_state;

    // Assign current state
    always_ff @(posedge clk or posedge areset)
        if (areset)
            current_state <= STATE_1;
        else
            current_state <= next_state;

    // Assign next state
    always_comb begin
        case (current_state)
            STATE_0:
                if (train_taken)
                    next_state = STATE_1;
                else
                    next_state = STATE_0;

            STATE_1:
                if (train_taken && current_state < STATE_3)
                    next_state = current_state + 1;
                else if (!train_taken && current_state > STATE_0)
                    next_state = current_state - 1;
                else
                    next_state = current_state;

            STATE_2:
                if (train_taken && current_state < STATE_3)
                    next_state = current_state + 1;
                else if (!train_taken && current_state > STATE_0)
                    next_state = current_state - 1;
                else
                    next_state = current_state;

            STATE_3:
                if (!train_taken && current_state > STATE_0)
                    next_state = current_state - 1;
                else
                    next_state = current_state;
        endcase
    end

    // Assign output state
    assign state = current_state;

endmodule
