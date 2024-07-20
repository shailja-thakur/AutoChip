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

    // Define parameters and registers
    reg [1:0] PHT [0:127]; // 128-entry table of 2-bit counters
    reg [6:0] global_history;

    // Asynchronous reset or initialization block
    integer i;
    always @(posedge areset or posedge clk) begin
        if (areset) begin
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // initialize counters to weakly taken state
            end
            global_history <= 7'b0;
        end else begin
            if (train_valid) begin
                // Index computation for training
                integer train_index = train_pc ^ train_history;
                
                // Update PHT based on the result
                if (train_taken) begin
                    // Increment counter if branch was taken
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 2'b01;
                    end
                end else begin
                    // Decrement counter if branch was not taken
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 2'b01;
                    end
                end

                // Update global history register after misprediction
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Use the existing global_history to make predictions
                global_history <= {global_history[5:0], PHT[predict_pc ^ global_history][1]};
            end
        end
    end

    // Predictions block
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            predict_taken = PHT[predict_pc ^ global_history][1];
        end else begin
            predict_history = 7'b0;
            predict_taken = 1'b0;
        end
    end
endmodule
