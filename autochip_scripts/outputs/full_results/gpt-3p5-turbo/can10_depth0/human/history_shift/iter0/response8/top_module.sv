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

    logic [31:0] history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin // Reset history counter to zero
            history <= 32'b0;
        end else if (train_mispredicted) begin // Load history after mispredicted branch
            history <= {train_history, train_taken};
        end else if (predict_valid) begin // Shift in predict_taken to update branch history
            history <= {history[30:0], predict_taken};
        end
    end
    
    assign predict_history = history;
    
endmodule
