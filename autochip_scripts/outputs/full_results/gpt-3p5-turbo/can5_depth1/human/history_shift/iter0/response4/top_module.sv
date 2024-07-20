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
    reg update_history;
    
    always @(posedge clk or posedge areset)
    if (areset) begin
        history_reg <= 0;
        update_history <= 0;
    end else if (predict_valid) begin
        history_reg <= {history_reg[30:0], predict_taken};
        update_history <= 1;
    end else if (train_mispredicted) begin
        history_reg <= {train_history, train_taken};
        update_history <= 1;
    end else begin
        if (update_history) begin
            history_reg <= history_reg << 1;
            update_history <= 0;
        end
    end
    
    assign predict_history = history_reg;
    
endmodule
