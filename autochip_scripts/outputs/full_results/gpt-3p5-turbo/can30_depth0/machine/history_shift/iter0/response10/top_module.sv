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

    // Registers to store the current state
    logic [31:0] current_history;

    always @(posedge clk or posedge areset) begin
        // Reset the predict_history signal if areset is asserted
        if (areset) begin
            predict_history <= 0;
        end
        // Update the predict_history signal if it's not areset
        else begin
            // Update the predict_history signal with train_history and train_taken if train_mispredicted is asserted
            if (train_mispredicted) begin
                predict_history <= {train_history[31:1], train_taken};
            end
            // Update the predict_history signal with predict_taken if predict_valid is asserted
            else if (predict_valid) begin
                predict_history <= {predict_history[31:1], predict_taken};
            end
        end
    end
    
endmodule
