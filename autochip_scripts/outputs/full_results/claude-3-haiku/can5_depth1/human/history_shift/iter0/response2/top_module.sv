module top_module(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

logic [31:0] history_reg;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        history_reg <= 0;
    end
    else if (train_mispredicted) begin
        history_reg <= {train_history, train_taken};
    end
    else if (predict_valid) begin
        history_reg <= {history_reg[30:0], predict_taken};
    end
end

assign predict_history = history_reg;

endmodule
