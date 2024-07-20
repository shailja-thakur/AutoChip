module gshare_predictor (
    input clk,
    input areset,
    
    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,
    
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // 7-bit PC and 7-bit global history, hashed into a 7-bit index
    wire [6:0] index = predict_pc ^ predict_history;
    
    // 128-entry table of 2-bit saturating counters
    reg [1:0] pht[127:0];
    
    // Update the branch history register on prediction
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 7'b0;
        end
        else if (predict_valid) begin
            predict_history <= {predict_history[5:0], predict_taken};
        end
    end
    
    // Make a prediction
    always @(*) begin
        if (predict_valid) begin
            predict_taken = (pht[index] >= 2'b10);
        end
        else begin
            predict_taken = 1'b0;
        end
    end
    
    // Train the branch predictor
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b10;
            end
            predict_history <= 7'b0;
        end
        else begin
            if (train_valid) begin
                // Update the pattern history table
                if (train_taken) begin
                    if (pht[train_pc ^ train_history] != 2'b11) begin
                        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1;
                    end
                end
                else begin
                    if (pht[train_pc ^ train_history] != 2'b00) begin
                        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1;
                    end
                end
                
                // Recover the branch history register on misprediction
                if (train_mispredicted) begin
                    predict_history <= train_history;
                end
            end
        end
    end

endmodule
