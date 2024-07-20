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

    logic [31:0] temp_predict_history;
    logic [31:0] temp_train_history;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end else begin
            if (train_mispredicted) begin
                temp_predict_history <= {train_history[30:0], train_taken};
            end else begin
                temp_predict_history <= {predict_history[30:0], predict_taken};
            end
        end
    end

    always_comb begin
        if (train_mispredicted) begin
            predict_history <= temp_predict_history;
        end else begin
            predict_history <= temp_predict_history;
        end
    end

endmodule
