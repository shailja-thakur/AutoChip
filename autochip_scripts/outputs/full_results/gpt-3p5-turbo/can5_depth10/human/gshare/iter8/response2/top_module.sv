module top_module(
    input clk,
    input areset,
    
    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,         // Change to reg
    output reg [6:0] predict_history, // Change to reg
    
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
    end else begin
        // Update the prediction history register
        predict_history_reg <= global_history;
        
        // Update the pattern history table
        if (predict_valid) begin
            predict_taken_reg <= (pht[predict_pc_reg ^ predict_history_reg] > 1'b1);
        end
        
        // Update the pattern history table
        if (train_valid) begin
            pht[train_pc ^ train_history] <= train_taken ? (pht[train_pc ^ train_history] == 2'b00 ? 2'b01 : (pht[train_pc ^ train_history] == 2'b11 ? 2'b11 : (pht[train_pc ^ train_history] == 2'b10 ? 2'b11 : 2'b10))) : (pht[train_pc ^ train_history] == 2'b00 ? 2'b00 : (pht[train_pc ^ train_history] == 2'b11 ? 2'b10 : 2'b01));
            
            // Update the global history register
            if (train_mispredicted) begin
                global_history <= {1'b0, global_history[6:1]};
            else begin
                global_history <= {1'b0, global_history[6:1]};
            end
        end
        
        // Assign the outputs
        predict_taken <= predict_taken_reg;        // Added
        predict_history <= predict_history_reg;    // Added
    end
end

assign predict_pc_reg = predict_valid ? predict_pc : 7'b0;

endmodule
