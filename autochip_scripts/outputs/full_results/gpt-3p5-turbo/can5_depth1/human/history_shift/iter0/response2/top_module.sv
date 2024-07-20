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


    // Shift Register to hold the branch history
    logic [31:0] history_register;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_register <= 0;
        end else begin
            if (train_mispredicted) begin
                // Load the branch history register with history after the completion of the mispredicted branch
                history_register <= {train_history[31:1], train_taken};
            end else if (predict_valid) begin
                // Shift in predict_taken from the LSB side to update the branch history for the predicted branch
                history_register <= {history_register[30:0], predict_taken};
            end
        end
    end
    
    assign predict_history = history_register;

endmodule
