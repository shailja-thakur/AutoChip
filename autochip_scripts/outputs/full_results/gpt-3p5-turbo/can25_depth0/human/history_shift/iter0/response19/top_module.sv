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

    // Registers for the global history shift register
    logic [31:0] history_register;
    logic [31:0] updated_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_register <= 32'b0;
        end else begin
            // Shift in predict_taken to update branch history for predicted branch
            if (predict_valid) begin
                history_register <= {history_register[30:0], predict_taken};
            end
            // Load branch history register with history after completion of mispredicted branch
            if (train_mispredicted) begin
                updated_history = {train_history, train_taken};
                history_register <= updated_history;
            end
        end
    end

    assign predict_history = history_register;

endmodule
