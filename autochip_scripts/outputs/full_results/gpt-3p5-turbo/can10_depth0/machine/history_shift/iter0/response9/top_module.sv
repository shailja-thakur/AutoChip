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

reg [31:0] history;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        // Reset predict_history to 0
        predict_history <= 0;
    end else begin
        if (train_mispredicted == 1) begin
            // Update predict_history with train_history and train_taken
            predict_history <= {train_history, train_taken};
        end else if (predict_valid == 1) begin
            // Update predict_history with predict_taken
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end
end

endmodule
