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

    logic [31:0] history_counter;
    logic [31:0] next_history_counter;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            history_counter <= 0;
        else if (train_mispredicted)
            history_counter <= {train_history, train_taken};
        else if (predict_valid)
            history_counter <= {predict_history[29:0], predict_taken};
    end
    
    always @(posedge clk) begin
        if (areset)
            predict_history <= 0;
        else if (predict_valid || train_mispredicted)
            predict_history <= history_counter;
    end

endmodule
