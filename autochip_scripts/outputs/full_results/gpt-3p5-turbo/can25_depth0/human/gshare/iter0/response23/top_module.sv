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
    /* This module implements a gshare branch predictor with a 7-bit pc and 7-bit global history.
       The global history is hashed into a 7-bit index, which accesses a 128-entry table of 
       two-bit saturating counters.
       
       The module has two sets of interfaces: one for predictions and one for training.
       
       The prediction interface is used in the Fetch stage of the processor to request branch direction predictions
       for the instructions being fetched. When a prediction is requested (predict_valid = 1),
       the module produces the predicted branch direction and the state of the branch history register
       used to make the prediction. The branch history register is then updated (at the next positive clock edge)
       for the predicted branch.
       
       The training interface is used to train the branch predictor with the actual branch outcomes
       once the true outcomes of the branches become known. When training for a branch is requested (train_valid = 1),
       the module is given the pc and branch history register value for the branch being trained, 
       as well as the actual branch outcome and whether the branch was mispredicted (needing a pipeline flush).
       The pattern history table (PHT) is updated to train the branch predictor to predict this branch more accurately
       next time. If the branch being trained is mispredicted, the branch history register is also recovered
       to the state immediately after the mispredicting branch completes execution.
    
       If training for a misprediction and a prediction (for a different, younger instruction) occurs in the same cycle,
       training takes precedence because the predicted branch will be discarded. If training and prediction of the same
       PHT entry happen at the same time, the prediction sees the PHT state before training, as training only modifies
       the PHT at the next positive clock edge.
       
       Reset is asynchronous active-high.
    */
    
    // Define constants for module parameters
    parameter PC_BITS = 7;
    parameter HISTORY_BITS = 7;
    parameter INDEX_BITS = 7;
    parameter COUNTER_BITS = 2;
    parameter TABLE_SIZE = 128;
    
    // Define module internal signals and registers
    reg [PC_BITS-1:0] prediction_pc_reg;
    reg [HISTORY_BITS-1:0] prediction_history_reg;
    reg [INDEX_BITS-1:0] prediction_index;
    reg [COUNTER_BITS-1:0] prediction_counter;
    reg predict_taken_reg;
    
    reg [HISTORY_BITS-1:0] history_register;
    reg [INDEX_BITS-1:0] train_index;
    reg [COUNTER_BITS-1:0] train_counter;
    
    reg [INDEX_BITS-1:0] train_index_reg;
    reg [COUNTER_BITS-1:0] train_counter_reg;
    reg [HISTORY_BITS-1:0] train_history_reg;
    reg train_taken_reg;
    reg train_mispredicted_reg;
    
    wire [INDEX_BITS-1:0] train_index_prev;
    
    // Declare internal signals for branch predictor table
    reg [COUNTER_BITS-1:0] table [0:TABLE_SIZE-1];
    
    // Initialization/reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            prediction_counter <= 0;
            predict_taken_reg <= 0;
            prediction_pc_reg <= 0;
            prediction_history_reg <= 0;
            train_index_reg <= 0;
            train_counter_reg <= 0;
            train_history_reg <= 0;
            train_taken_reg <= 0;
            train_mispredicted_reg <= 0;
            history_register <= 0;
        end else begin
            prediction_pc_reg <= predict_pc;
            prediction_history_reg <= history_register;
        end
    end
    
    // Branch predictor logic
    always @(posedge clk) begin
        prediction_index <= prediction_pc_reg ^ prediction_history_reg;
        prediction_counter <= table[prediction_index];
        predict_taken_reg <= (prediction_counter > 1) ? 1 : 0;
    end
    
    // Training logic
    always @(posedge clk) begin
        train_index <= train_pc ^ train_history_reg;
        train_counter <= table[train_index];
        
        if (train_valid) begin
            table[train_index_prev] <= train_counter_reg + (train_taken_reg ? 1 : -1);
            if (train_mispredicted_reg) begin
                history_register <= train_history_reg;
            end
        end
    end
    
    // Output logic
    always @(posedge clk) begin
        if (predict_valid) begin
            predict_taken <= predict_taken_reg;
            predict_history <= prediction_history_reg;
        end
    end
    
    always @(posedge clk) begin
        if (train_valid) begin
            train_index_prev <= train_index;
            train_counter_reg <= train_counter;
            train_index_reg <= train_index;
            train_history_reg <= train_history;
            train_taken_reg <= train_taken;
            train_mispredicted_reg <= train_mispredicted;
        end
    end
    
endmodule
