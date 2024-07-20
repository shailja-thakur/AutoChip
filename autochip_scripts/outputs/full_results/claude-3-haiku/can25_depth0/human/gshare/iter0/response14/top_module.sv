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

    reg [1:0] pht [127:0]; // Pattern History Table with 128 2-bit saturating counters
    reg [6:0] ghr; // Global History Register

    // Prediction Logic
    always @(*) begin
        if (predict_valid) begin
            // Hash the PC and global history to get the PHT index
            predict_taken = (pht[predict_pc ^ ghr][1]);
            predict_history = ghr;
        end
        else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Training Logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ghr <= 0;
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 0;
            end
        end
        else begin
            if (train_valid) begin
                // Update the PHT based on the actual branch outcome
                if (train_taken) begin
                    if (pht[train_pc ^ train_history] != 2'b11)
                        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1;
                end
                else begin
                    if (pht[train_pc ^ train_history] != 2'b00)
                        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1;
                end

                // Update the global history register
                if (train_mispredicted) begin
                    ghr <= train_history;
                end
                else begin
                    ghr <= (ghr << 1) | train_taken;
                end
            end
        end
    end

endmodule
