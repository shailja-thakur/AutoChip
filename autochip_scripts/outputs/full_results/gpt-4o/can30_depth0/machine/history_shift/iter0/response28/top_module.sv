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
                predict_history <= train_history;
                if (train_taken) begin
                    predict_history[0] <= 1; // Update the least significant bit for train_taken
                end else begin
                    predict_history[0] <= 0; // Update the least significant bit for not taken
                end
            end else if (predict_valid) begin
                if (predict_taken) begin
                    predict_history <= {predict_history[30:0], 1'b1}; // Shift left and set LSB to 1
                end else begin
                    predict_history <= {predict_history[30:0], 1'b0}; // Shift left and set LSB to 0
                end
            end
        end
    end

endmodule
