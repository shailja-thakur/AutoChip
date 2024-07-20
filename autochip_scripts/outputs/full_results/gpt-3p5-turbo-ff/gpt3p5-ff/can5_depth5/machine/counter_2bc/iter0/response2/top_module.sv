module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Declare internal variables
    logic [1:0] next_state;

    // Clock edge detection
    always @(posedge clk) begin
        if (areset) begin
            // Asynchronous reset
            state <= 2'b01;
        end else if (train_valid) begin
            // State transition based on train_taken
            case (state)
                2'b00: if (train_taken) next_state <= 2'b01; else next_state <= 2'b00;
                2'b01: if (train_taken) next_state <= 2'b10; else next_state <= 2'b00;
                2'b10: if (train_taken) next_state <= 2'b11; else next_state <= 2'b01;
                2'b11: if (!train_taken) next_state <= 2'b10; else next_state <= 2'b11;
            endcase
        end
    end

    // Assign next_state to state
    always @(*) begin
        state <= next_state;
    end

endmodule
