module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal state register
    logic [1:0] next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Weakly not-taken
        else
            state <= next_state;
    end

    always_comb begin
        case(state)
            2'b00: next_state = (train_valid && train_taken) ? 2'b01 : 2'b00;
            2'b01: next_state = (train_valid && train_taken) ? 2'b10 : (train_valid && !train_taken) ? 2'b00 : 2'b01;
            2'b10: next_state = (train_valid && train_taken) ? 2'b11 : (train_valid && !train_taken) ? 2'b01 : 2'b10;
            2'b11: next_state = (train_valid && !train_taken) ? 2'b10 : 2'b11;
            default: next_state = state;
        endcase
    end

endmodule
