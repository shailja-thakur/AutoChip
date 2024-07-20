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

    always @(posedge clk or negedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end else if (train_mispredicted == 1'b1 && predict_valid == 1'b0) begin
            predict_history <= {train_history, train_taken};
        end else if (train_mispredicted == 1'b0 && predict_valid == 1'b1) begin
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end
    
endmodule
