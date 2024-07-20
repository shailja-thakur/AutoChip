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

    logic [31:0] updated_history;
    
    always_ff @(posedge clk or negedge areset) begin
        if (!areset) begin
            if (train_mispredicted) begin
                updated_history <= {train_history, train_taken};
            end else if (predict_valid) begin
                updated_history <= predict_taken;
            end
        end
    end
    
    always @(posedge clk or negedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end else begin
            predict_history <= updated_history;
        end
    end

endmodule
