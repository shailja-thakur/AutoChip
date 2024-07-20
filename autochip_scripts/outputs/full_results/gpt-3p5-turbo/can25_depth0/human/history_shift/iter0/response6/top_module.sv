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

    logic [31:0] update_history;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end else begin
            if (train_mispredicted) begin
                update_history <= {train_history[30:0], train_taken};
            end else if (predict_valid) begin
                update_history <= {predict_history[30:0], predict_taken};
            end
            predict_history <= update_history;
        end
    end

endmodule
