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

    // Declare internal signals and variables
    reg [31:0] updated_predict_history;
    
    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            // Reset predict_history to 0
            predict_history <= 0;
        end else begin
            if (train_mispredicted) begin
                // Update predict_history with train_history and train_taken signals
                updated_predict_history = train_history;
                updated_predict_history[31] <= train_taken;
                
                // Overwrite predict_history with updated history
                predict_history <= updated_predict_history;
            end else if (predict_valid) begin
                // Update predict_history with predict_taken signal
                predict_history[31:1] <= predict_history[30:0];
                predict_history[0] <= predict_taken;
            end
        end
    end

endmodule
