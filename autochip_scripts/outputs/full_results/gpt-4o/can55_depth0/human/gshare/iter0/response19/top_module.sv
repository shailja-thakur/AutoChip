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

    reg [1:0] PHT [0:127]; // 128-entry table of 2-bit saturating counters
    reg [6:0] global_history;

    integer i;

    // Asynchronous reset
    always @(posedge areset or posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01; // Initialize PHT counters to weakly not taken (01)
        end
        else begin
            // Global History Register update only if not training
            if (!train_valid && predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Predict branch
    always @(posedge clk) begin
        if (predict_valid) begin
            predict_history <= global_history;
            case (PHT[predict_pc ^ global_history])
                2'b00, 2'b01: predict_taken <= 0; // predict not taken for 00, 01
                2'b10, 2'b11: predict_taken <= 1; // predict taken for 10, 11
                default: predict_taken <= 0; // default not taken
            endcase
        end
    end

    // Train branch predictor
    always @(posedge clk) begin
        if (train_valid) begin
            if (train_taken) begin
                if (PHT[train_pc ^ train_history] != 2'b11)
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
            end else begin
                if (PHT[train_pc ^ train_history] != 2'b00)
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
            end

            // On misprediction, update global history register
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken}; // Recovered state
            end else begin
                // Normally update global history register
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end

endmodule
