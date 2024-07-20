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
    // Shift register for branch history
    reg [31:0] shift_register;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the shift register to zero
            shift_register <= 0;
        end else begin
            // Shift in predict_taken from the LSB side
            if (predict_valid) begin
                shift_register <= {shift_register[30:0], predict_taken};
            end
            // Load the shift register with the history after the completion of the mispredicted branch
            if (train_mispredicted) begin
                shift_register <= {train_history, train_taken};
            end
        end
    end
    
    // Output the shifted branch history
    assign predict_history = shift_register;
endmodule
