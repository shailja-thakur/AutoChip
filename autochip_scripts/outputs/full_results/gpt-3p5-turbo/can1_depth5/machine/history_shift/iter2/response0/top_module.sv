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

    // Variable to store the updated predict_history signal
    logic [31:0] updated_predict_history;
    
    always_ff @(posedge clk or negedge areset)
    begin
        // Asynchronous reset
        if (!areset)
            predict_history <= 0;
        // Predict_valid and train_mispredicted signals
        else if (train_mispredicted)
            updated_predict_history <= {predict_history[30:0], train_taken};
        else if (predict_valid)
            updated_predict_history <= {predict_history[30:0], predict_taken};
    end
    
    // Assign the updated predict_history signal
    always_comb
    begin
        if (!areset)
            predict_history <= 0;
        else
            predict_history <= updated_predict_history;
    end
    
endmodule
