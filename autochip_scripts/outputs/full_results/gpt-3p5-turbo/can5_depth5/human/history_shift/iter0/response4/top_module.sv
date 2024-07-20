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

    logic [31:0] temp_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 0;
            temp_history <= 0;
        end else begin
            if (train_mispredicted) begin
                temp_history <= {train_history, train_taken};
                predict_history <= temp_history;
            end else begin
                if (predict_valid) begin
                    temp_history <= {predict_history[30:0], predict_taken};
                    predict_history <= temp_history;
                end
            end
        end
    end

endmodule
