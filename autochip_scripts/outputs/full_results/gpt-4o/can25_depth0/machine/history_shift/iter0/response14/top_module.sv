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
            if (train_taken) begin
                predict_history <= train_history | 32'b1; // Set LSB if branch was taken
            end else begin
                predict_history <= train_history & ~32'b1; // Clear LSB if branch was not taken
            end
        end else if (predict_valid) begin
            if (predict_taken) begin
                predict_history <= predict_history | 32'b1; // Set LSB if branch was predicted taken
            end else begin
                predict_history <= predict_history & ~32'b1; // Clear LSB if branch was predicted not taken
            end
        end
    end
end

endmodule
