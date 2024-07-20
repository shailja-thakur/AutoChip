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

    // Internal signals
    logic [31:0] shift_in;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
        begin
            predict_history <= 32'h0; // Reset history counter to zero
        end
        else
        begin
            if (train_mispredicted)
            begin
                predict_history <= {train_history[30:0], train_taken}; // Load branch history with history after completion of mispredicted branch
            end
            else if (predict_valid)
            begin
                shift_in <= predict_taken; // Shift in predict_taken to update branch history for predicted branch
                predict_history <= {predict_history[30:0], shift_in};
            end
        end
    end

endmodule
