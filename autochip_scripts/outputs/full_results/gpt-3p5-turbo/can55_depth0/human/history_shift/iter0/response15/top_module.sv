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
reg [31:0] shift_reg;
reg [31:0] train_history_temp;

always @(posedge clk or posedge areset) begin
    if (areset)
        shift_reg <= 0;
    else if (predict_valid)
        shift_reg <= {shift_reg[30:0], predict_taken};
    else if (train_mispredicted) begin
        train_history_temp <= {train_history, train_taken};
        shift_reg <= train_history_temp[31:0];
    end
end

assign predict_history = shift_reg;

endmodule
