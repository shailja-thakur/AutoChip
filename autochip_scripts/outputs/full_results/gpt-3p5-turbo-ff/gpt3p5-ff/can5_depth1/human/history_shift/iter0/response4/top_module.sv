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

    // Define internal signals
    logic [31:0] history_reg;
    logic [31:0] mispredict_history;
    logic [31:0] new_history_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the history counter
            history_reg <= 32'h0;
        end else if (predict_valid) begin
            // Shift in predict_taken from the LSB side
            new_history_reg[31:1] <= history_reg[30:0];
            new_history_reg[0] <= predict_taken;
            history_reg <= new_history_reg;
        end else if (train_mispredicted) begin
            // Load the branch history register with the history after completion of the mispredicted branch
            mispredict_history = {train_history, train_taken};
            history_reg <= mispredict_history;
        end
    end
    
    assign predict_history = history_reg;
    
endmodule
