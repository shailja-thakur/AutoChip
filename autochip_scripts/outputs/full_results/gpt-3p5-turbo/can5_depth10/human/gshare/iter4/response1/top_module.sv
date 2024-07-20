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

reg [1:0] pht [0:127];
reg [6:0] global_history = 0;
reg [6:0] predict_history_reg;
reg predict_taken_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset all the registers
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b00;
        end
        global_history <= 7'b0;
    end else begin
        // Update the prediction history and taken signals
        if (predict_valid) begin
            predict_history_reg <= global_history;
            predict_taken_reg <= (pht[global_history ^ predict_pc] > 1'b1);
        end
        
        // Update the pattern history table and global history
        if (train_valid) begin
            pht[train_history ^ train_pc] <= train_taken ? (pht[train_history ^ train_pc] == 2'b00 ? 2'b01 : (pht[train_history ^ train_pc] == 2'b11 ? 2'b11 : 2'b10)) : (pht[train_history ^ train_pc] == 2'b00 ? 2'b00 : (pht[train_history ^ train_pc] == 2'b11 ? 2'b10 : 2'b01));
            
            global_history <= {global_history[5:0], train_taken};
            
            // Flush the pipeline if the branch was mispredicted
            if (train_mispredicted) begin
                global_history <= {1'b0, global_history[6:1]};
            end
        end
    end
end

always @(posedge clk) begin
    // Assign the updated values to the output registers
    if (predict_valid) begin
        predict_taken <= predict_taken_reg;
        predict_history <= predict_history_reg;
    end
end

endmodule
