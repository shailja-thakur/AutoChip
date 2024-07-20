module top_module(
    input clk,
    input areset, 
    
    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken, 
    output [6:0] predict_history,
    
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);
    
    reg [6:0] global_history;
    reg [6:0] pht_index;
    reg [1:0] pht_result;
    reg predict_taken;
    
    reg [6:0] training_pc;
    reg training_taken;
    reg training_mispredicted;
    reg [6:0] training_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            global_history <= 0;
        else if (predict_valid && predict_pc == pht_index)
            pht_result <= pht[pht_index];
        else if (train_valid && train_pc == pht_index)
            pht_result <= pht[pht_index];
        else
            pht_result <= pht_result;
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            pht[pht_index] <= 0;
        else if (predict_valid && predict_pc == pht_index && predict_taken)
            pht[pht_index] <= $past[pht_result] + 1;
        else if (train_valid && train_pc == pht_index && train_mispredicted)
            pht[pht_index] <= $past[pht_result] - 1;
        else if (train_valid && train_pc == pht_index && train_taken)
            pht[pht_index] <= $past[pht_result] + 1;
        else
            pht[pht_index] <= pht[pht_index];
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            predict_taken <= 0;
        else if (predict_valid && predict_pc == pht_index)
            predict_taken <= (pht_result == 3 || pht_result == 2);
        else
            predict_taken <= predict_taken;
    end
    
    assign pht_index = predict_pc ^ global_history;
    assign predict_history = global_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            training_pc <= 0;
            training_taken <= 0;
            training_mispredicted <= 0;
            training_history <= 0;
        end else if (train_valid && !training_mispredicted) begin
            training_pc <= train_pc;
            training_taken <= train_taken;
            training_mispredicted <= train_mispredicted;
            training_history <= train_history;
        end
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            global_history <= 0;
        else if (training_mispredicted) begin
            global_history <= $past[training_history];
            if (train_valid) // discard the prediction
                pht_result <= 0;
        end else if (train_valid && (train_pc != pht_index || !train_taken)) begin
            global_history <= $past[training_history];
            if (train_valid && train_pc == pht_index) // discard the prediction
                pht_result <= 3;
        end else if (train_valid) begin
            global_history <= $past[training_history] << 1 | train_taken;
            if (train_pc == pht_index) // discard the prediction
                pht_result <= 0;
        end
    end

endmodule
