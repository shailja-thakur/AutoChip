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

    reg [31:0] global_history; // 32-bit global history shift register

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0; // Asynchronous reset sets the history counter to zero
        end else begin
            if (train_mispredicted) begin
                global_history <= {train_history[30:0], train_taken}; // Load history after the completion of the mispredicted branch
            end else if (predict_valid) begin
                global_history <= {global_history[30:0], predict_taken}; // Shift in predict_taken from the LSB side to update the branch history for the predicted branch
            end
        end
    end

    assign predict_history = global_history;

endmodule
