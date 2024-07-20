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
    // Create registers to hold the previous values
    reg [31:0] prev_predict_history;
    reg [31:0] prev_train_history;
    reg prev_train_mispredicted;
    reg prev_train_taken;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            predict_history <= 0;
        else
        begin
            if (train_mispredicted)
                predict_history <= {train_history, train_taken};
            else if (predict_valid)
                predict_history <= predict_taken;
        end
    end
    
    always @(posedge clk)
    begin
        if (areset)
        begin
            prev_predict_history <= 0;
            prev_train_history <= 0;
            prev_train_mispredicted <= 0;
            prev_train_taken <= 0;
        end
        else
        begin
            prev_predict_history <= predict_history;
            prev_train_history <= train_history;
            prev_train_mispredicted <= train_mispredicted;
            prev_train_taken <= train_taken;
        end
    end
endmodule
