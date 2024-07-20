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

// Define internal signals and registers
reg [31:0] history_register;
reg [31:0] new_history;
reg [0:0] prediction_enabled;

// Synchronous reset
always @(posedge clk or posedge areset)
begin
    if (areset)
    begin
        history_register <= 0;
        prediction_enabled <= 0;
    end
    else
    begin
        // Shift in predict_taken for branch history update
        if (predict_valid)
            new_history <= {history_register[30:0], predict_taken};
        else
            new_history <= history_register;
        
        // Load branch history register after misprediction
        if (train_mispredicted)
            history_register <= {train_history, train_taken};
        else
            history_register <= new_history;
        
        // Enable predictions
        prediction_enabled <= predict_valid;
    end
end

// Assign predict_history output
assign predict_history = history_register;

endmodule
