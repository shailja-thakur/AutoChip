module top_module (
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

logic [31:0] branch_history;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        branch_history <= 32'b0;
    end
    else if (train_mispredicted) begin
        branch_history <= {train_history, train_taken};
    end
    else if (predict_valid) begin
        branch_history <= {branch_history[30:0], predict_taken};
    end
end

assign predict_history = branch_history;

endmodule
