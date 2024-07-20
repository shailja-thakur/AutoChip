module top_module(
    input clk,
    input areset,

    // Prediction interface
    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    // Training interface
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    reg [1:0] PHT [127:0]; // Pattern history table with 128 entries of 2-bit counters
    reg [6:0] global_history; // Global branch history register

    wire [6:0] predict_index = predict_pc ^ global_history; // Index for prediction
    wire [6:0] train_index = train_pc ^ train_history; // Index for training

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly not taken
            end
        end else begin
            if (predict_valid && !train_mispredicted && !train_valid) begin
                // Update global history register based on prediction
                global_history <= {global_history[5:0], predict_taken};
            end
            if (train_valid) begin
                // Update PHT based on actual outcome
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
                // Recover the branch history register if there was a misprediction
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end
            end
        end
    end

    always @(*) begin
        // Prediction
        if (predict_valid) begin
            predict_history = global_history;
            case (PHT[predict_index])
                2'b00: predict_taken = 0;
                2'b01: predict_taken = 0;
                2'b10: predict_taken = 1;
                2'b11: predict_taken = 1;
                default: predict_taken = 0;
            endcase
        end else begin
            predict_taken = 0;
            predict_history = global_history;
        end
    end

endmodule
