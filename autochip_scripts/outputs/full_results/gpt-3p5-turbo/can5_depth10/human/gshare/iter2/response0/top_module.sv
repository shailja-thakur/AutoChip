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

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset all the registers
        for (int i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b00;
        end
        global_history <= 7'b0;
        
        // Clear the output registers
        predict_history_reg <= 7'b0;
        predict_taken_reg <= 1'b0;
    end else begin
        // Update the prediction history register
        if (predict_valid) begin
            predict_history_reg <= global_history;
            predict_taken_reg <= (pht[global_history ^ predict_pc] > 1);
        end
        
        // Update the pattern history table
        if (train_valid) begin
            pht[train_history ^ train_pc] <= train_taken ? (pht[train_history ^ train_pc] == 2'b00 ? 2'b01 : (pht[train_history ^ train_pc] == 2'b11 ? 2'b11 : 2'b10)) : (pht[train_history ^ train_pc] == 2'b00 ? 2'b00 : (pht[train_history ^ train_pc] == 2'b11 ? 2'b10 : 2'b01));
            
            // Update the global history register
            global_history <= train_taken ? {global_history[6:1], 1'b1} : {global_history[6:1], 1'b0};
            
            // Flush the pipeline if the branch was mispredicted
            if (train_mispredicted) begin
                global_history <= {1'b0, global_history[5:0]};
            end
        end
    end
end

assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_reg;

endmodule
