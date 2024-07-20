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
// Define constants
parameter INDEX_SIZE = 7;
parameter PC_SIZE = 7;
parameter HISTORY_SIZE = 7;
parameter COUNTER_SIZE = 2;
parameter TABLE_ENTRIES = 128;

// Define signals and registers
reg [INDEX_SIZE-1:0] index;
reg [HISTORY_SIZE-1:0] history;
reg [PC_SIZE-1:0] pc;

reg [1:0] counter[TABLE_ENTRIES-1:0];
reg taken;

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset all registers and counters
        index <= 0;
        history <= 0;
        pc <= 0;
        counter <= 0;
        taken <= 0;
    end else begin
        if (train_valid) begin
            if (train_mispredicted) begin
                // Reset history for mispredicted branch
                history <= train_history;
            end
            
            // Update counter based on train_taken
            counter[train_pc ^ history] <= (train_taken) ? counter[train_pc ^ history] + 1 : counter[train_pc ^ history] - 1;
        end
    end
end

// Prediction logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset prediction signals
        predict_taken <= 0;
        predict_history <= 0;
    end else begin
        if (predict_valid) begin
            // Get index from hashed pc and history
            index <= predict_pc ^ history;
            
            // Get predicted taken value based on counter value
            predict_taken <= (counter[index] >= 2);
            
            // Output current history
            predict_history <= history;
        end
    end
end

endmodule
