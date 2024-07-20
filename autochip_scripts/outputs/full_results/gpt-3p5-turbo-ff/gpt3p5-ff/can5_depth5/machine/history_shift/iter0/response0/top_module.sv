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

    // Registers to store state
    reg [31:0] predict_history_reg;

    always @(posedge clk or negedge areset) begin
        if (areset) begin
            predict_history_reg <= 0;
        end else if (train_mispredicted) begin
            predict_history_reg <= {train_history, train_taken};
        end else if (predict_valid) begin
            predict_history_reg <= predict_taken;
        end
    end
    
    assign predict_history = predict_history_reg;
    
endmodule
