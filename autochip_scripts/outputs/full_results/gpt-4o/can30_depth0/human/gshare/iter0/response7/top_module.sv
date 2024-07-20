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
    reg [6:0] GBHR; // 7-bit global branch history register
    
    integer i;
    
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GBHR <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b10; // Initialize the PHT counters to weakly taken (10)
            end
        end
        else begin
            if (train_valid) begin
                if (train_taken) begin
                    if (PHT[train_pc ^ train_history] < 2'b11)
                        PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
                end else begin
                    if (PHT[train_pc ^ train_history] > 2'b00)
                        PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
                end

                if (train_mispredicted)
                    GBHR <= {GBHR[5:0], train_taken}; // Update global history register after misprediction
            end

            if (predict_valid) begin
                predict_history <= GBHR;
                predict_taken <= PHT[predict_pc ^ GBHR][1]; // predict taken if MSB of counter is 1
                GBHR <= {GBHR[5:0], predict_taken}; // Update global history register for prediction
            end
        end
    end

endmodule
