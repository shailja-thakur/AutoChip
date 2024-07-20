module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    // Registers to store the prediction history and training history
    logic [31:0] history_reg;
    
    // Always block for clock and reset signals
    always_ff @(posedge clk or negedge areset) begin
        if (!areset) begin
            // Reset the predict_history signal
            predict_history <= 0;
        end else begin
            if (train_mispredicted) begin
                // Update predict_history with train_history and train_taken
                history_reg <= {history_reg[30:0], train_taken};
            end else if (predict_valid) begin
                // Update predict_history with predict_taken
                history_reg <= {history_reg[30:0], predict_taken};
            end
        end
    end
    
    // Assign the predict_history signal to the history_reg
    assign predict_history = history_reg;

endmodule
