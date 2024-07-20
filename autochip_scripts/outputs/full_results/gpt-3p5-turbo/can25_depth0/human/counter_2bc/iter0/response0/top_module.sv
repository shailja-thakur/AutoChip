module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Declare internal signals
    logic [1:0] next_state;

    // Sequential logic for next_state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            next_state <= 2'b01;
        else if (train_valid) begin
            if (train_taken) begin
                if (state == 2'b11)
                    next_state <= 2'b11;
                else
                    next_state <= state + 2'b01;
            end else begin
                if (state == 2'b00)
                    next_state <= 2'b00;
                else
                    next_state <= state - 2'b01;
            end
        end else
            next_state <= state;
    end

    // Combinational logic for state
    always_comb begin
        state = next_state;
    end
endmodule
