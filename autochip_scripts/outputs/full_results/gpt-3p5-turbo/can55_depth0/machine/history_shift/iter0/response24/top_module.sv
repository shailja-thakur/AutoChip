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
    // Registers to hold the state of the predict_history signal
    logic [31:0] predict_history_reg;
    
    // Always block to update the predict_history signal based on training signals
    always @(posedge clk) begin
        if (areset) begin
            predict_history_reg <= 0;
        end else begin
            if (train_mispredicted) begin
                predict_history_reg <= {train_history, train_taken};
            end else if (predict_valid) begin
                predict_history_reg <= {predict_history_reg[30:0], predict_taken};
            end
        end
    end
    
    // Assign the predict_history_reg to the predict_history output
    assign predict_history = predict_history_reg;
    
endmodule
