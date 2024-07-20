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

    reg [31:0] history_reg;
    reg [31:0] temp_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_reg <= 0;
        end else if (train_mispredicted) begin
            history_reg <= {train_history, train_taken};
        end else if (predict_valid) begin
            temp_history[31:1] <= history_reg[30:0];
            temp_history[0] <= predict_taken;
            history_reg <= temp_history;
        end
    end

    assign predict_history = history_reg;

endmodule
