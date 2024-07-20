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
    logic [31:0] temp_history_reg;

    always @(posedge clk or posedge areset)begin
        if (areset)begin
            history_reg <= 0;
        end
        else if (predict_valid)begin
            history_reg <= {history_reg[30:0], predict_taken};
        end
        else if (train_mispredicted)begin
            temp_history_reg <= {train_history, train_taken};
            history_reg <= temp_history_reg;
        end
        else begin
            temp_history_reg <= history_reg;
            history_reg <= temp_history_reg;
        end
    end

    assign predict_history = history_reg;

endmodule
