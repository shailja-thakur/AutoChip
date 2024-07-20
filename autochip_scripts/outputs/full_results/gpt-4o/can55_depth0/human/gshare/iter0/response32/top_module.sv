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

    // 7-bit branch history register
    reg [6:0] global_history;

    // 128-entry pattern history table (PHT) with 2-bit saturating counters
    reg [1:0] PHT [0:127];

    // Extract index using XOR of pc and global history
    wire [6:0] predict_index = predict_pc ^ global_history;

    // Output values for predictions
    always @(*) begin
        if (predict_valid) begin
            // Check the state of the PHT entry to set predict_taken
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken = 0; // Predict Not Taken
                2'b10, 2'b11: predict_taken = 1; // Predict Taken
            endcase

            // Pass current global history for the prediction
            predict_history = global_history;
        end else begin
            predict_taken = 0;
            predict_history = 7'b0;
        end
    end

    // Update global history register and PHT on positive clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0; // Reset global history
            // Initialize PHT entries to weakly not taken (01) state
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                // Update PHT entry for training
                case (PHT[train_pc ^ train_history])
                    2'b00: PHT[train_pc ^ train_history] <= train_taken ? 2'b01 : 2'b00; // weakly not taken
                    2'b01: PHT[train_pc ^ train_history] <= train_taken ? 2'b10 : 2'b00; // transition to taken or strongly not taken
                    2'b10: PHT[train_pc ^ train_history] <= train_taken ? 2'b11 : 2'b01; // transition to strongly taken or not taken
                    2'b11: PHT[train_pc ^ train_history] <= train_taken ? 2'b11 : 2'b10; // strongly taken or transition to weakly taken
                endcase

                if (train_mispredicted) begin
                    // Recover the branch history register to the state after the mispredicting branch
                    global_history <= {train_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history register with the predicted branch outcome
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
