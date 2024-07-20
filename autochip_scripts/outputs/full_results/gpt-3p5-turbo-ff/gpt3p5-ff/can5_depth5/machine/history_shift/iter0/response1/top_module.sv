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

    always @(posedge clk or negedge areset) begin
        if (areset == 0) // check if reset signal is asserted
            predict_history <= 0; // reset predict_history signal to 0
        else begin // if reset signal is not asserted
            if (train_mispredicted == 1) // check if train_mispredicted signal is asserted
                predict_history <= {predict_history[30:0], train_taken}; // update predict_history with train_history and train_taken signals
            else if (predict_valid == 1) // check if predict_valid signal is asserted
                predict_history <= {predict_history[30:0], predict_taken}; // update predict_history with predict_taken signal
        end
    end

endmodule
