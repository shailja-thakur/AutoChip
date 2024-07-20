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
        predict_history <= 32'b0;
    end else begin
        if (train_mispredicted) begin
            if (train_taken)
                predict_history <= train_history | (1 << (32 - 1)); //Set the highest bit if train_taken is true
            else
                predict_history <= train_history & ~(1 << (32 - 1)); //Clear the highest bit if train_taken is false
        end

        if (predict_valid) begin
            if (predict_taken)
                predict_history <= predict_history | (1 << (32 - 1)); //Set the highest bit if predict_taken is true
            else
                predict_history <= predict_history & ~(1 << (32 - 1)); //Clear the highest bit if predict_taken is false
        end
    end
end

endmodule
