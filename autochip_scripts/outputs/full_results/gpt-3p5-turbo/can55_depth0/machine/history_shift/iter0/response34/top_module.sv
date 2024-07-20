module top_module
(
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic predict_taken,
    output logic [31:0] predict_history,
    
    input logic train_mispredicted,
    input logic train_taken,
    input logic [31:0] train_history
);
    
    always @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            predict_history <= 0;
        end else begin
            if (train_mispredicted == 1) begin
                predict_history <= {train_history, train_taken};
            end else if (predict_valid == 1) begin
                predict_history <= predict_taken;
            end
        end
    end
    
endmodule
