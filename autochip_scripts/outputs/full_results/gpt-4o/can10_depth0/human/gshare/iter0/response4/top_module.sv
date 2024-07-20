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

    reg [1:0] PHT [0:127]; // Pattern History Table with 128 entries of 2-bit counters
    reg [6:0] GHR; // Global History Register

    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1)
            PHT[i] = 2'b01; // Weakly not taken initial state
        GHR = 7'b0;
    end

    wire [6:0] predict_index = predict_pc ^ GHR;
    wire [6:0] train_index = train_pc ^ train_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            GHR <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01;
        end else begin
            if (train_valid) begin
                // Handle training of the branch predictor
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11)
                        PHT[train_index] <= PHT[train_index] + 1;
                end else begin
                    if (PHT[train_index] != 2'b00)
                        PHT[train_index] <= PHT[train_index] - 1;
                end

                // Recover branch history register if mispredicted
                if (train_mispredicted) begin
                    GHR <= {train_history[5:0], train_taken};
                end else begin
                    GHR <= {GHR[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update history register for the predicted branch
                GHR <= {GHR[5:0], PHT[predict_index][1]};
            end
        end
    end

    always @(*) begin
        // Prediction logic is combinational
        if (predict_valid) begin
            predict_history = GHR;
            predict_taken = PHT[predict_index][1];
        end else begin
            predict_history = GHR;
            predict_taken = 1'b0;
        end
    end

endmodule
