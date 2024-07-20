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

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            predict_history <= 0;
        else begin
            if (train_mispredicted)
                predict_history <= {train_history, train_taken};
            else if (predict_valid)
                predict_history <= predict_taken;
        end
    end

endmodule
