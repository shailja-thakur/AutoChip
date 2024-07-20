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
            predict_history <= 32'd0; // Reset predict_history to 0
        end else begin
            if (train_mispredicted) begin
                // Update predict_history with train_history and train_taken
                if (train_taken) begin
                    predict_history <= train_history | 32'h1;
                end else begin
                    predict_history <= train_history & 32'hFFFFFFFE;
                end
            end else if (predict_valid) begin
                // Update predict_history with predict_taken
                if (predict_taken) begin
                    predict_history <= {predict_history[30:0], 1'b1};
                end else begin
                    predict_history <= {predict_history[30:0], 1'b0};
                end
            end
        end
    end

endmodule
