module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Internal signal
    logic [1:0] counter_state;

    // Assign default values to signals
    always_comb begin
        state = counter_state;
    end

    // Saturating counter logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            counter_state <= 2'b01;  // Reset state to weakly not-taken
        end else begin
            case ({train_valid, train_taken})
                2'b11: begin  // Increment when train_valid = 1 and train_taken = 1
                    if (counter_state < 2'b11) begin
                        counter_state <= counter_state + 1;
                    end
                end
                2'b10: begin  // Decrement when train_valid = 1 and train_taken = 0
                    if (counter_state > 2'b00) begin
                        counter_state <= counter_state - 1;
                    end
                end
                default: begin  // Keep the counter unchanged when train_valid = 0
                    counter_state <= counter_state;
                end
            endcase
        end
    end
endmodule
