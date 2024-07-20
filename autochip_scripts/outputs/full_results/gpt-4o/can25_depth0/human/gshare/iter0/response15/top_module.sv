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

    reg [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] global_history_register;

    // Initialize the PHT on reset
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize counters to weakly not taken state
            end
            global_history_register <= 7'b0;
        end else begin
            if (train_valid) begin
                // Update the PHT for training
                if (train_taken) begin
                    if (PHT[train_pc ^ train_history] < 2'b11)
                        PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
                end else begin
                    if (PHT[train_pc ^ train_history] > 2'b00)
                        PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
                end
                
                // Update global history register after misprediction
                if (train_mispredicted)
                    global_history_register <= train_history;
            end
            
            // Update global history register after prediction
            if (predict_valid && !train_valid) begin
                global_history_register <= {global_history_register[5:0], predict_taken};
            end
        end
    end

    // Prediction logic
    always @(posedge clk) begin
        if (predict_valid) begin
            predict_history <= global_history_register;
            predict_taken <= (PHT[predict_pc ^ global_history_register] >= 2'b10);
        end
    end

endmodule
