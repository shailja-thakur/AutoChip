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

    // Registers to store previous values
    reg [31:0] previous_predict_history;
    reg [31:0] previous_train_history;
    reg previous_train_mispredicted;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 0;
            previous_predict_history <= 0;
            previous_train_history <= 0;
            previous_train_mispredicted <= 0;
        end else begin
            if (train_mispredicted) begin
                predict_history <= {train_history, train_taken};
            end else if (predict_valid) begin
                predict_history <= {previous_predict_history[30:0], predict_taken};
            end
            
            previous_predict_history <= predict_history;
            previous_train_history <= train_history;
            previous_train_mispredicted <= train_mispredicted;
        end
    end

endmodule
