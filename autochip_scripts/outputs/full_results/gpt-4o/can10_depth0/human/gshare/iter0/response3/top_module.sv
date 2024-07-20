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

    // Global branch history
    reg [6:0] global_history;

    // 128-entry Pattern history table with 2-bit counters
    reg [1:0] PHT [0:127];

    // Initialize or reset logic
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b10; // Weakly taken (initialize to middle state)
            end
        end else begin
            if (train_valid) begin
                // Compute index based on train_pc and train_history
                integer train_index;
                train_index = train_pc ^ train_history;

                // Update PHT based on training
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end

                // Update global history
                if (train_mispredicted) begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history for prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Combination logic for prediction
    always @(*) begin
        if (predict_valid) begin
            // Compute index based on predict_pc and global_history
            integer predict_index;
            predict_index = predict_pc ^ global_history;

            // Determine branch prediction
            predict_taken = (PHT[predict_index] >= 2'b10);
            predict_history = global_history;
        end else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

endmodule
