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

    reg [31:0] history_temp;
    
    always @(posedge clk or negedge areset) begin
        if (areset) begin
            history_temp <= 0;
            predict_history <= 0;
        end else begin
            if (train_mispredicted) begin
                history_temp <= {train_history, train_taken};
                predict_history <= history_temp;
            end else if (predict_valid) begin
                history_temp <= {predict_history[30:0], predict_taken};
                predict_history <= history_temp;
            end
        end
    end
    
endmodule
