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

    logic [31:0] history;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            history <= '0;
        end
        else if (train_mispredicted) begin
            history <= {train_history, train_taken};
        end
        else if (predict_valid) begin
            history <= {history[30:0], predict_taken};
        end
    end

    assign predict_history = history;

endmodule
