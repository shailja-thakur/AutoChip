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

    // 7-bit global history register
    reg [6:0] global_history;
    // 128-entry table of two-bit saturating counters
    reg [1:0] PHT[127:0];

    integer i;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the PHT and global history register
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize to weakly not taken (01) state
            end
        end else begin
            // Training takes precedence over prediction
            if (train_valid) begin
                // Compute the index using XOR of PC and history
                integer train_index = train_pc ^ train_history;

                // Update the PHT entry based on actual branch outcome
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1; // Increment counter
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1; // Decrement counter
                    end
                end

                // Update the global history register
                if (train_mispredicted) begin
                    global_history <= {global_history[5:0], train_taken};
                end

            end else if (predict_valid) begin
                // Compute the index using XOR of PC and global history
                integer predict_index = predict_pc ^ global_history;

                // Predict the branch outcome based on the PHT entry
                if (PHT[predict_index][1] == 1'b1) begin
                    predict_taken <= 1'b1;
                end else begin
                    predict_taken <= 1'b0;
                end

                // Provide the state of the branch history register
                predict_history <= global_history;

                // Update the global history register
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
