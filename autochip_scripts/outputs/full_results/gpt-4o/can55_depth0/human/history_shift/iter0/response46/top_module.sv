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

    // Declare an internal register for the history
    reg [31:0] history;

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            history <= 32'b0;
        end else begin
            if (train_mispredicted) begin
                // Load the history after the mispredicted branch
                history <= {train_history[30:0], train_taken};
            end else if (predict_valid) begin
                // Update the history with the predicted branch
                history <= {history[30:0], predict_taken};
            end
        end
    end

    // Output the current branch history
    assign predict_history = history;

endmodule
