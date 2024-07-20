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

// Register to store the state
reg [31:0] predict_history_reg;
reg [31:0] predict_history_next;

// Always block to check the clock and reset signals
always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history_reg <= 0;
    end else begin
        if (train_mispredicted) begin
            predict_history_next <= {train_taken, predict_history_reg[30:1]};
        end else if (predict_valid) begin
            predict_history_next <= {predict_taken, predict_history_reg[30:1]};
        end else begin
            predict_history_next <= predict_history_reg;
        end
        predict_history_reg <= predict_history_next;
    end
end

// Assign the output
assign predict_history = predict_history_reg;

endmodule
