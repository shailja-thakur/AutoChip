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

    // Define internal wires and registers
    wire predict_valid_input;
    wire predict_taken_input;
    wire predict_valid_temp;
    wire [31:0] new_history;
    reg [31:0] history_reg;
    
    // Assign inputs to internal wires
    assign predict_valid_input = predict_valid;
    assign predict_taken_input = predict_taken;
    
    // Register to hold the history
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            history_reg <= 0;
        else if (train_mispredicted)
            history_reg <= {train_history, train_taken};
        else if (predict_valid_temp)
            history_reg <= new_history;
    end
    
    // Logic to shift the history
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            predict_valid_temp <= 0;
        else
            predict_valid_temp <= predict_valid_input;
    end
    
    always @(posedge clk)
    begin
        if (areset)
            new_history <= 0;
        else if (predict_valid_temp)
           new_history <= {history_reg, predict_taken_input};
    end
    
    // Assign internal wires to outputs
    assign predict_history = history_reg;

endmodule
