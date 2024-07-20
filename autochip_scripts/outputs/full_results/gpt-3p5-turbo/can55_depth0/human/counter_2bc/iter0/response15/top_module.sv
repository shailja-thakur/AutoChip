module two_bit_saturating_counter (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken && (state < 2'b11)) begin // increment condition
                state <= state + 1;
            end else if (!train_taken && (state > 2'b00)) begin // decrement condition
                state <= state - 1;
            end
        end
    end

endmodule
module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    two_bit_saturating_counter counter_inst (
        .clk(clk),
        .areset(areset),
        .train_valid(train_valid),
        .train_taken(train_taken),
        .state(state)
    );

endmodule
