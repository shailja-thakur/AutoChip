module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    reg [1:0] curr_state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            curr_state <= 2'b01;  // Reset to state 1
        else if (train_valid) begin
            case(curr_state)
                2'b00: if (train_taken) next_state <= 2'b01;  // Transition to state 1 if train_taken is asserted
                2'b01: if (!train_taken) next_state <= 2'b00;  // Transition to state 0 if train_taken is not asserted
                2'b10: if (train_taken) next_state <= 2'b11;  // Transition to state 3 if train_taken is asserted
                2'b11: if (!train_taken) next_state <= 2'b10;  // Transition to state 2 if train_taken is not asserted
            endcase
        end
    end

    always @(posedge clk) begin
        if (areset)
            state <= 2'b01;  // Reset to state 1
        else
            state <= next_state;
    end

endmodule
