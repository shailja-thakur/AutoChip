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

    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            if (train_mispredicted) begin
                predict_history <= {train_history, train_taken};
            end
            else if (predict_valid) begin
                predict_history <= predict_taken;
            end
        end
        else begin
            predict_history <= 0;
        end
    end

endmodule
