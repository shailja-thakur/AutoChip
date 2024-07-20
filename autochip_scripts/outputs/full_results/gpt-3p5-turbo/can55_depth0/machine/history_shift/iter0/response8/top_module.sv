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

    always_ff @(posedge clk or negedge areset) begin
        if (!areset)
            predict_history <= 32'b0;
        else begin
            if (train_mispredicted)
                predict_history <= { predict_history[30:0], train_taken };
            else if (predict_valid)
                predict_history <= { predict_history[30:0], predict_taken };
        end
    end

endmodule
