module top_module
(
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic predict_taken,
    output logic [31:0] predict_history,
    
    input logic train_mispredicted,
    input logic train_taken,
    input [31:0] train_history
);

always_ff @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        predict_history <= 0;
    end else begin
        if (train_mispredicted == 1) begin
            predict_history <= {train_taken, train_history[30:0]};
        end else if (predict_valid == 1) begin
            predict_history <= {predict_taken, predict_history[30:0]};
        end
    end
end

endmodule
