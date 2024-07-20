module top_module (
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    logic [31:0] temp_predict_history; // Temporary signal for updating predict_history

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end else if (train_mispredicted) begin
            temp_predict_history <= {train_history, train_taken};
        end else if (predict_valid) begin
            temp_predict_history <= {predict_history[30:0], predict_taken};
        end
    end
    
    assign predict_history = temp_predict_history;

endmodule
