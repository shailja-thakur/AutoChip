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
logic [31:0] shift_register;
logic [31:0] updated_history;

// Create always block for shifting the register and updating history
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        shift_register <= 0;
        predict_history <= 0;
    end else if (predict_valid) begin
        shift_register <= {shift_register[30:0], predict_taken};
    end else if (train_mispredicted) begin
        updated_history <= {train_history, train_taken};
        shift_register <= {shift_register[30:0], updated_history[0]};
    end
    predict_history <= shift_register;
end

endmodule
