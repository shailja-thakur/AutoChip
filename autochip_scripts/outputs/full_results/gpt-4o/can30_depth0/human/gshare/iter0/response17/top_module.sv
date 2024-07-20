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
    reg [1:0] PHT[127:0]; // 128-entry table with 2-bit saturating counters

    // Initialize PHT and global history on reset
    integer i;
    always @(posedge areset) begin
        global_history <= 7'b0;
        for (i = 0; i < 128; i = i + 1)
            PHT[i] <= 2'b01; // initialize all counters to 'weakly not taken'
    end

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    // Update states on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else begin
            if (train_valid) begin
                // Train the predictor
                if (train_taken & PHT[train_index] != 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end else if (~train_taken & PHT[train_index] != 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end

                if (train_mispredicted) begin
                    // Recover global history
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    // Update global history
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history for prediction
                global_history <= {global_history[5:0], PHT[predict_index] >= 2'b10};
            end
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            predict_taken = (PHT[predict_index] >= 2'b10); // taken if the counter is in the upper half
        end else begin
            predict_history = 7'b0;
            predict_taken = 1'b0;
        end
    end
endmodule
