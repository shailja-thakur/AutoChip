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
    logic [31:0] history_reg;
    
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
        begin
            // Handle asynchronous reset
            history_reg <= 32'b0;
        end
        else if (train_mispredicted)
        begin
            // Update history register with mispredicted branch history
            history_reg <= {train_history[31:1], train_taken};
        end
        else if (predict_valid)
        begin
            // Update history register with predicted branch history
            history_reg <= {history_reg[30:0], predict_taken};
        end
    end
    
    assign predict_history = history_reg;
    
endmodule
