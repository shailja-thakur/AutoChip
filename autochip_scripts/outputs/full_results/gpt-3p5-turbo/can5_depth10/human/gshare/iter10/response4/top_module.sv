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
reg [6:0] global_history = 7'b0;
reg [6:0] predict_history_reg;
reg predict_taken_reg;
reg [6:0] predict_pc_reg;
reg [6:0] train_pc_reg;
wire predict_taken_next;
wire [6:0] predict_history_next;

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
        predict_history_reg <= predict_history_next;
        
        // Update the pattern history table
        if (predict_valid) begin
            predict_taken_reg <= predict_taken_next;
        end
        
        // Update the pattern history table
        if (train_valid) begin
            pht[train_pc_reg ^ train_history] <= train_taken ? (pht[train_pc_reg ^ train_history] == 2'b00 ? 2'b01 : (pht[train_pc_reg ^ train_history] == 2'b11 ? 2'b11 : 2'b10)) : (pht[train_pc_reg ^ train_history] == 2'b00 ? 2'b00 : (pht[train_pc_reg ^ train_history] == 2'b11 ? 2'b10 : 2'b01));
            
            // Update the global history register
            if (train_mispredicted) begin
                global_history <= {train_taken, global_history[6:1]};
            end else begin
                global_history <= {1'b0, global_history[6:1]};
            end
        end
        
        // Assign the outputs
        predict_taken <= predict_valid ? predict_taken_reg : 1'b0;
        predict_history <= predict_valid ? predict_history_reg : 7'b0;
    end
end

assign predict_pc_reg = predict_valid ? predict_pc : 7'b0;
assign train_pc_reg = train_valid ? train_pc : 7'b0;

assign predict_taken_next = (pht[predict_pc_reg ^ predict_history_reg] > 1'b1);
assign predict_history_next = predict_history_reg ^ predict_taken_reg;

endmodule
