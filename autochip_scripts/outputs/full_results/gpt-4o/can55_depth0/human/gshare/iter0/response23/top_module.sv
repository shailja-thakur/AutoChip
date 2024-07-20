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

    // PHT entry states (2-bit saturating counters)
    reg [1:0] PHT[127:0]; // 128-entry table of 2-bit counters

    // 7-bit global branch history register
    reg [6:0] global_history; 

    wire [6:0] predict_index;
    wire [6:0] train_index;

    // Compute indexes using XOR of PC and history
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Prediction (combinational logic)
    always @(*) begin
        if (predict_valid) begin
            predict_taken = PHT[predict_index][1]; // MSB of the counter
            predict_history = global_history;
        end
        else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Update logic
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset all entries and global history
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b00;
        end
        else begin
            if (train_valid) begin
                // Update PHT entry for training
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11)
                        PHT[train_index] <= PHT[train_index] + 1;
                end
                else begin
                    if (PHT[train_index] > 2'b00)
                        PHT[train_index] <= PHT[train_index] - 1;
                end

                // Recover global history if there was misprediction
                if (train_mispredicted)
                    global_history <= {global_history[5:0], train_taken};
            end
            
            // Update global history register for the predicted branch
            if (predict_valid && !train_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
