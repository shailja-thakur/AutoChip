module top_module 
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    always @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            // Reset predict_history signal to 0
            predict_history <= 0;
        end else begin
            // Update predict_history signal based on train_mispredicted and predict_valid signals
            if (train_mispredicted == 1) begin
                // Update predict_history with train_history and train_taken signals
                predict_history <= {predict_history[30:0], train_taken};
            end else if (predict_valid == 1) begin
                // Update predict_history with predict_taken signal
                predict_history <= {predict_history[30:0], predict_taken};
            end
        end
    end

endmodule
