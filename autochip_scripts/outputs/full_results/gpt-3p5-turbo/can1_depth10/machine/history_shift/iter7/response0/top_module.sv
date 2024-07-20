module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);


always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 0;
    end else begin
        if (train_mispredicted) begin
            predict_history <= {train_taken, predict_history[30:1]};
        end else if (predict_valid) begin
            predict_history <= {predict_taken, predict_history[30:1]};
        end 
    end
end

endmodule
