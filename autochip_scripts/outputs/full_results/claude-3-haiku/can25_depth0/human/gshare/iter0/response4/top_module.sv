module gshare_predictor (
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

    // 128-entry 2-bit saturating counter PHT
    reg [1:0] pht [127:0];

    // Initialize global history register and PHT
    initial begin
        global_history = 0;
        for (int i = 0; i < 128; i++) begin
            pht[i] = 2'b10;
        end
    end

    // Asynchronous reset
    always @(posedge areset) begin
        global_history <= 0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b10;
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            // Hash PC and global history to get PHT index
            predict_history = global_history;
            predict_taken = (pht[predict_pc ^ global_history][1]);
        end else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            // Update PHT based on actual branch outcome
            if (train_taken) begin
                if (pht[train_pc ^ train_history] != 2'b11)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1;
            end else begin
                if (pht[train_pc ^ train_history] != 2'b00)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1;
            end

            // Recover global history register if misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end

endmodule
