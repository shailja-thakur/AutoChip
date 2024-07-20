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

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 0; // reset predict_history to 0
        end else begin
            if (predict_valid) begin
                predict_history <= predict_taken; // update predict_history with predict_taken
            end else if (train_mispredicted) begin
                predict_history <= {train_history, train_taken}; // update predict_history with train_history and train_taken
            end
        end
    end
    
endmodule
