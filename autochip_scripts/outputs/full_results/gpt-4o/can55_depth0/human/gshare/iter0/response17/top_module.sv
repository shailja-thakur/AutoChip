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
    reg [6:0] global_history;
    reg [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters
    
    // Initializing PHT and global history register on reset
    integer i;
    always @(posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Starting with weakly not taken (01)
            end
        end
    end
    
    // Combine PC and global history to form the index into PHT
    wire [6:0] index = (predict_pc ^ global_history);

    // Prediction logic
    always @(posedge clk) begin
        if (predict_valid) begin
            case (PHT[index])
                2'b00: predict_taken = 0;
                2'b01: predict_taken = 0;
                2'b10: predict_taken = 1;
                2'b11: predict_taken = 1;
            endcase
            predict_history <= global_history;
        end

        if (predict_valid && !train_valid) begin
            // Update branch history register for the predicted branch
            global_history <= {global_history[5:0], predict_taken};
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            // Combine PC and given history to form the index
            wire [6:0] train_index = (train_pc ^ train_history);
            
            // Train the PHT
            if (train_taken) begin
                if (PHT[train_index] < 2'b11) PHT[train_index] <= PHT[train_index] + 1;
            end else begin
                if (PHT[train_index] > 2'b00) PHT[train_index] <= PHT[train_index] - 1;
            end

            // Update the branch history if a misprediction happened
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end

endmodule
