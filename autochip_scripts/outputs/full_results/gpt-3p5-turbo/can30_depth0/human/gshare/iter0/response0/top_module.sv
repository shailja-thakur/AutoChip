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

    reg [2:0] pattern_history_table [0:127];
    reg [6:0] global_branch_history_register;
    reg [6:0] current_predict_pc;
    reg predict_taken_internal;
    reg [6:0] predict_history_internal;
    reg train_pc_internal;
    reg train_taken_internal;
    reg train_history_internal;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (int i = 0; i <= 127; i = i + 1) begin
                pattern_history_table[i] <= 0; // Initialize all entries in PHT to 0
            end
            global_branch_history_register <= 0; // Initialize global branch history register to 0
        end else begin
            // Update prediction result and predicted branch history based on predict_valid signal
            if (predict_valid) begin
                current_predict_pc <= predict_pc; // Store the current PC for prediction
                
                // Generate index from PC and global branch history register
                reg [6:0] index;
                index = {predict_pc[6:0]} ^ {global_branch_history_register[6:0]};
                
                // Make prediction based on current state of the pattern history table
                predict_taken_internal <= (pattern_history_table[index] >= 2);
                predict_history_internal <= global_branch_history_register;
            end
            
            // Update branch history register based on training signal
            if (train_valid) begin
                train_pc_internal <= train_pc; // Store the current PC for training
                train_taken_internal <= train_taken; // Store the current branch outcome for training
                train_history_internal <= train_history; // Store the current branch history register value for training
                
                // Update pattern history table based on training outcome and history
                if (train_mispredicted) begin
                    pattern_history_table[index] <= pattern_history_table[index] - 1; // Decrease counter for mispredicted branch
                    global_branch_history_register[6:0] <= train_history[6:0]; // Recover branch history register to state after misprediction
                else begin
                    pattern_history_table[index] <= pattern_history_table[index] + 1; // Increase counter for correctly predicted branch
                end
            end
        end
    end
    
    assign predict_taken = predict_taken_internal;
    assign predict_history = predict_history_internal;
        
endmodule
