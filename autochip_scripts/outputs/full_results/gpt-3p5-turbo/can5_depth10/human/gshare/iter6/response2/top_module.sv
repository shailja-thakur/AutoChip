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

reg [1:0] pht [0:127];
reg [6:0] global_history = 0;
reg [6:0] predict_history_reg;
reg predict_taken_reg;
reg [6:0] predict_pc_reg;

reg [6:0] train_pc_reg;
wire mispredict;
reg [1:0] pht_entry;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset all the registers
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b00;
        end
        global_history <= 7'b0;
        
        // Clear the output registers
        predict_history_reg <= 7'b0;
        predict_taken_reg <= 1'b0;
        predict_pc_reg <= 7'b0;
    end else begin
        // Update the prediction history register
        predict_history_reg <= global_history;
        
        // Update the pattern history table
        if (predict_valid) begin
            predict_taken_reg <= (pht[predict_pc_reg ^ global_history] > 1'b1);
        end
        
        // Update the pattern history table and global history register
        if (train_valid || mispredict) begin
            pht_entry <= pht[train_pc_reg ^ train_history];
            pht[train_pc_reg ^ train_history] <= train_taken ? (pht_entry == 2'b00 ? 2'b01 : (pht_entry == 2'b11 ? 2'b11 : 2'b10)) : (pht_entry == 2'b00 ? 2'b00 : (pht_entry == 2'b11 ? 2'b10 : 2'b01));
            
            // Update the global history register
            if (train_mispredicted || mispredict) begin
                global_history <= {1'b0, global_history[6:1]};
                
                if (train_mispredicted) begin
                    predict_pc_reg <= train_pc_reg;
                end
            end else begin
                global_history <= {1'b1, global_history[6:1]};
            end
        end else begin
            global_history <= {1'b1, global_history[6:1]};
        end
    end
end

assign mispredict = (predict_pc_reg == train_pc_reg) && predict_valid && train_valid;
assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_reg;
assign train_pc_reg = train_pc;

endmodule
