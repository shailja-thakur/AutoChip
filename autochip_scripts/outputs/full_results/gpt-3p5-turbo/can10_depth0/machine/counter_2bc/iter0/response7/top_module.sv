module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] next_state;

    always_ff @(posedge clk, posedge areset)
        if (areset)
            state <= 2'b01;
        else if (train_valid)
            case(state)
                2'b00: if (train_taken) next_state = 2'b01; else next_state = 2'b00;
                2'b01: if (train_taken) next_state = 2'b10; else next_state = 2'b00;
                2'b10: if (train_taken) next_state = 2'b11; else next_state = 2'b01;
                2'b11: if (!train_taken) next_state = 2'b10; else next_state = 2'b11;
            endcase

    always_ff @(posedge clk)
        if (areset)
            state <= 2'b01;
        else
            state <= next_state;

endmodule
