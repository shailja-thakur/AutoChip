module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signal to hold the current state
    logic [1:0] current_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01;
        else begin
            case (current_state)
                2'b00:
                    if (train_taken && current_state < 2'b11)
                        current_state <= current_state + 1;
                    else if (!train_taken && current_state > 2'b00)
                        current_state <= current_state - 1;
                2'b01:
                    if (train_valid)
                        current_state <= current_state + 1;
                2'b10:
                    if (train_taken && current_state < 2'b11)
                        current_state <= current_state + 1;
                    else if (!train_taken && current_state > 2'b00)
                        current_state <= current_state - 1;
                2'b11:
                    if (!train_taken && current_state > 2'b00)
                        current_state <= current_state - 1;
            endcase
        end
    end

    assign state = current_state;

endmodule
