module top_module(
    input clk,
    input areset, 

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,    // Added reg keyword
    output reg [6:0] predict_history, // Added reg keyword

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);

reg [6:0] global_history;           // Declare global history register
reg [6:0] pht_index;                // Declare PHT index

reg [6:0] predict_pc_reg;           // PC register for prediction
reg [6:0] train_pc_reg;             // PC register for training

reg pht_entry_train;                // PHT entry for training
reg [1:0] pht_entry_predict;        // PHT entry for prediction

reg [1:0] pht[0:127];               // PHT table

wire reset;                        // Reset wire

assign reset = ~areset;             // Assign areset to reset wire

always @(posedge clk or posedge reset) begin
    if (reset) begin               // Reset block
        global_history <= 0;
        pht_index <= 0;
        predict_taken <= 0;
        predict_history <= 0;
        pht_entry_train <= 0;
        pht_entry_predict <= 0;
        pht <= 0;
    end else begin                 // Non-reset block
        if (train_valid) begin     // Training block
            train_pc_reg <= train_pc;
            pht_entry_train <= pht[pht_index];
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            pht[pht_index] <= train_taken ? pht[pht_index] < 3 ? pht[pht_index] + 1 : 3 : pht[pht_index] > 0 ? pht[pht_index] - 1 : 0;
        end else if (predict_valid) begin  // Prediction block
            predict_pc_reg <= predict_pc;
            predict_taken <= pht[pht_index][1];
            predict_history <= global_history;
            pht_entry_predict <= pht[pht_index];
        end
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        global_history <= 0;
        pht_index <= 0;
    end else begin
        if (train_valid || predict_valid) begin
            pht_index <= {predict_pc_reg, global_history} ^ 7'd127;
        end
        if (train_valid) begin
            global_history <= train_taken ? {global_history[5:0], 1} : {global_history[5:0], 0};
        end
    end
end

endmodule
