module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Declare internal variables
    logic [1:0] current_state;
  
    // State register
    always_ff@(posedge clk or negedge areset)
    begin
        if (!areset)
            current_state <= 2'b01; // Reset to state 1
        else if (train_valid)
        begin
            case (current_state)
                2'b00:
                    if (train_taken)
                        current_state <= 2'b01;
                2'b01:
                    if (train_taken)
                        current_state <= 2'b10;
                    else
                        current_state <= 2'b00;
                2'b10:
                    if (!train_taken)
                        current_state <= 2'b01;
                    else
                        current_state <= 2'b11;
                2'b11:
                    if (!train_taken)
                        current_state <= 2'b10;
            endcase
        end
    end

    // Output the current state
    assign state = current_state;

endmodule
