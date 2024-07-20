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

    // Internal signal to store the shifted predict_history
    logic [31:0] shifted_predict_history;
    
    // Internal signal to store the merged train_history and train_taken
    logic [31:0] merged_train;
    
    // Register to store the previous train_history when a misprediction occurs
    logic [31:0] prev_train_history;
    
    // Register to store the previous predict_history when a misprediction occurs
    logic [31:0] prev_predict_history;
    
    // Register to store the current predict_history
    logic [31:0] curr_predict_history;
    
    // Register to store the current train_history
    logic [31:0] curr_train_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the predict_history to zero
            predict_history <= 0;
        end else begin
            // Shift in predict_taken to update the branch history for the predicted branch
            shifted_predict_history[31:1] <= predict_history[30:0];
            shifted_predict_history[0] <= predict_taken;
            
            // Update the current predict_history
            curr_predict_history <= predict_valid ? shifted_predict_history : predict_history;
            
            // Load the branch history register with the history after the completion of the mispredicted branch
            if (train_mispredicted) begin
                // Concatenate the previous train_history and the actual result of the branch
                merged_train[31:1] <= prev_train_history[30:0];
                merged_train[0] <= train_taken;
                
                // Update the current train_history
                curr_train_history <= merged_train;
                
                // Update the predict_history with the current train_history
                predict_history <= curr_train_history;
                
                // Store the previous train_history and predict_history
                prev_train_history <= train_history;
                prev_predict_history <= curr_predict_history;
            end else begin
                // Update the predict_history with the current predict_history
                predict_history <= curr_predict_history;
            end
        end
    end
endmodule
