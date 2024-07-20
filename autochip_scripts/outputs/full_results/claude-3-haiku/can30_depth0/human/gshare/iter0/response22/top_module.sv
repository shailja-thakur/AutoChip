module top_module (
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

    // 128-entry pattern history table (PHT)
    reg [1:0] pht [127:0];

    // Hash function to get index into PHT
    function [6:0] hash(input [6:0] pc, input [6:0] history);
        hash = pc ^ history;
    endfunction

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_taken = pht[hash(predict_pc, global_history)][1];
            predict_history = global_history;
        end else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b01; // Initialize PHT to weakly not-taken
            end
        end else begin
            if (train_valid) begin
                // Update PHT
                if (train_taken) begin
                    pht[hash(train_pc, train_history)][1] <= 1'b1; // Strongly taken
                end else begin
                    pht[hash(train_pc, train_history)][1] <= 1'b0; // Strongly not-taken
                end

                // Update global history register
                if (train_mispredicted) begin
                    // Recover global history register to the state immediately after the mispredicted branch
                    global_history <= train_history;
                end else begin
                    // Update global history register with the correct branch direction
                    global_history <= (global_history << 1) | train_taken;
                end
            end
        end
    end

endmodule
