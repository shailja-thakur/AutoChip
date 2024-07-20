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

    always_ff @(posedge clk, negedge areset) begin
        if (areset == 0) begin      // Reset signal is asserted
            predict_history <= 0;
        end else if (train_mispredicted == 1) begin      // train_mispredicted signal is asserted
            predict_history <= {train_history, train_taken};
        end else if (predict_valid == 1) begin      // predict_valid signal is asserted
            predict_history <= predict_taken;
        end
    end

endmodule
