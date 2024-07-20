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

    // Branch history shift register
    logic [31:0] history_register;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_register <= 0;
        end else if (train_mispredicted) begin
            // Load branch history register with history after mispredicted branch
            history_register <= {train_history, train_taken};
        end else if (predict_valid) begin
            // Shift in predict_taken on LSB side to update branch history
            history_register <= {history_register[30:0], predict_taken};
        end
    end

    // Output the branch history register
    assign predict_history = history_register;

endmodule
