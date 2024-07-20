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

    reg [31:0] updated_predict_history;

    always @(posedge clk or negedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end else begin
            updated_predict_history <= predict_history;
            
            if (train_mispredicted) begin
                updated_predict_history <= {train_history, train_taken};
            end else if (predict_valid) begin
                updated_predict_history <= {updated_predict_history[30:0], predict_taken};
            end
            
            predict_history <= updated_predict_history;
        end
    end
    
endmodule
