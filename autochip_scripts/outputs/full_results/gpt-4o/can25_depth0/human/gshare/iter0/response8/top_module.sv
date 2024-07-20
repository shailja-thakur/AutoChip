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
    // 128-entry table of 2-bit saturating counters
    reg [1:0] PHT[127:0];
    // 7-bit global branch history register
    reg [6:0] BHR;

    integer i;

    // Asynchronous reset
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            BHR <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01; // Initialize PHT counters to weakly not taken (01)
        end else begin
            if (train_valid) begin
                // Train the predictor
                if (train_taken) begin
                    if (PHT[train_pc ^ train_history] < 2'b11)
                        PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
                end else begin
                    if (PHT[train_pc ^ train_history] > 2'b00)
                        PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
                end
                if (train_mispredicted) begin
                    // Recover the branch history register if there was a misprediction
                    BHR <= {BHR[5:0], train_taken};
                end
            end
            if (predict_valid) begin
                // Update branch history register
                BHR <= {BHR[5:0], predict_taken};
            end
        end
    end

    always @(*) begin
        if (predict_valid) begin
            // Create the prediction
            predict_history = BHR;
            case (PHT[predict_pc ^ BHR])
                2'b00, 2'b01: predict_taken = 0; // Weakly/Strongly Not Taken
                2'b10, 2'b11: predict_taken = 1; // Weakly/Strongly Taken
            endcase
        end
    end
    
endmodule
