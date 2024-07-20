module gshare_predictor(
    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc,
    input clk,
    input areset
);
    // Parameters
    parameter HISTORY_SIZE = 7;
    parameter INDEX_SIZE = 7;
    parameter TABLE_SIZE = 128;
    
    // Registers
    reg [HISTORY_SIZE-1:0] branch_history_register;
    reg [INDEX_SIZE-1:0] index;
    reg [1:0] prediction;
    reg [2:0] pattern_history_table [0:TABLE_SIZE-1];
    
    // Combinal Logic
    
    // Index Calculation
    wire [INDEX_SIZE-1:0] index_calculated = predict_pc ^ branch_history_register;
    
    // Output Calculation
    assign predict_taken = (prediction == 2'b01) ? 1'b1 : 1'b0;
    assign predict_history = branch_history_register;
    
    // Predict/Register Update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            branch_history_register <= 0;
        end else if (predict_valid) begin
            index <= index_calculated;
            prediction <= pattern_history_table[index];
        end else if (train_valid) begin
            pattern_history_table[index] <= (train_mispredicted) ? 
                (pattern_history_table[index] - 1) : (pattern_history_table[index] + 1);
            branch_history_register <= {branch_history_register[HISTORY_SIZE-2:0], train_taken};
        end
    end
    
endmodule
