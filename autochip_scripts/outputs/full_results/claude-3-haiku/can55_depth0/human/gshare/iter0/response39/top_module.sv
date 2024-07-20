module top_module(
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

// 7-bit PC and global history, hashed into 7-bit index
wire [6:0] index = predict_pc ^ predict_history;

// 128-entry table of 2-bit saturating counters
reg [1:0] pht [127:0];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Initialize PHT to weakly not taken
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01;
        end
        predict_history <= 7'b0;
    end
    else begin
        // Prediction
        if (predict_valid) begin
            predict_taken <= pht[index][1];
            predict_history <= {predict_history[5:0], predict_taken};
        end
        
        // Training
        if (train_valid) begin
            // Update PHT
            if (train_taken) begin
                if (pht[index] != 2'b11) pht[index] <= pht[index] + 1'b1;
            end
            else begin
                if (pht[index] != 2'b00) pht[index] <= pht[index] - 1'b1;
            end
            
            // Recover branch history on misprediction
            if (train_mispredicted) begin
                predict_history <= train_history;
            end
            else begin
                predict_history <= {predict_history[5:0], train_taken};
            end
        end
    end
end

endmodule
