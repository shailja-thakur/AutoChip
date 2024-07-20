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

    // Internal register for branch history
    reg [31:0] history_reg;
    
    // Assign the output to the internal register
    assign predict_history = history_reg;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            history_reg <= 32'h0;
        end
        else begin
            if (train_mispredicted) begin
                // Load history with train_history concatenated with train_taken
                history_reg <= {train_history[30:0], train_taken};
            end
            else if (predict_valid) begin
                // Shift in predict_taken from LSB side
                history_reg <= {history_reg[30:0], predict_taken};
            end
        end
    end

endmodule
