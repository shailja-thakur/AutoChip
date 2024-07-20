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

reg [31:0] global_history;
reg [31:0] history_backup;

always @(posedge clk) begin
    if (areset) begin
        global_history <= 0;
    end else if (train_mispredicted) begin
        global_history <= {train_history, train_taken};
    end else if (predict_valid) begin
        global_history <= {predict_history[30:0], predict_taken};
    end
end

always @(posedge clk) begin
    if (train_mispredicted) begin
        history_backup <= global_history;
    end
end

always @(posedge clk) begin
    if (areset) begin
        predict_history <= 0;
    end else if (train_mispredicted) begin
        predict_history <= history_backup;
    end else if (predict_valid) begin
        predict_history <= global_history;
    end
end

endmodule
