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

    reg [31:0] history_reg; // branch history register
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            history_reg <= 0; // reset the history counter to zero
        else begin
            if (train_mispredicted) begin
                // load the branch history register with the history after the completion of the mispredicted branch
                history_reg <= {train_history, train_taken};
            end else if (predict_valid) begin
                // shift in predict_taken from the LSB side to update the branch history for the predicted branch
                history_reg <= {history_reg[30:0], predict_taken};
            end          
        end
    end
    
    assign predict_history = history_reg; // output the branch history register
    
endmodule
