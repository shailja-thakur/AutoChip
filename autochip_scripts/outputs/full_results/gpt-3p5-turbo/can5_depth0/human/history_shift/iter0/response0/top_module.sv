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

wire [0:31] history_temp;  // temporary variable to hold the updated branch history
logic [0:30] history_last;  // variable to hold the history before the mispredicted branch
logic [0:0] result_taken;  // variable to hold the actual result of the mispredicted branch

reg [31:0] history_reg;  // register to store the branch history

always @(posedge clk or posedge areset) begin
    if (areset)
        history_reg <= 0;
    else if (predict_valid)
        history_reg <= {history_reg[30:0], predict_taken};
    else if (train_mispredicted) begin
        history_last = history_reg;
        result_taken = train_taken;
        history_reg <= {train_history, train_taken};
    end
end

assign predict_history = history_reg;

endmodule
