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

reg [6:0] global_history = 0;
reg [6:0] predict_history_reg;
reg predict_taken_reg;

reg [6:0] pht_index_predict;
reg [6:0] pht_index_train;

reg [1:0] pht [0:127];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset all the registers
        for (int i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b00;
        end
        global_history <= 7'b0;
    end else begin
        // Update the prediction history register
        if (predict_valid) begin
            pht_index_predict <= predict_pc ^ global_history;
            predict_history_reg <= global_history;
            predict_taken_reg <= (pht[pht_index_predict] > 1);
        end
        
        // Update the pattern history table and global history register
        if (train_valid) begin
            pht_index_train <= train_pc ^ train_history;
            
            if (train_mispredicted) begin
                global_history <= {1'b0, global_history[5:0]};
            end else begin
                global_history <= {train_taken, global_history[6:1]};
            end
            
            if (train_taken) begin
                if (pht[pht_index_train] < 2'b11) begin
                    pht[pht_index_train] <= pht[pht_index_train] + 1;
                end
            end else begin
                if (pht[pht_index_train] > 2'b00) begin
                    pht[pht_index_train] <= pht[pht_index_train] - 1;
                end
            end
        end
    end
end

assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_reg;

endmodule
