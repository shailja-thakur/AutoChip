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

    // Pattern History Table (PHT) - 128 entries of 2-bit saturating counters
    reg [1:0] PHT [0:127];
    
    // 7-bit Global History Register (GHR)
    reg [6:0] GHR;
    
    // Calculate index using xor of pc and GHR
    wire [6:0] predict_index = predict_pc ^ GHR;
    wire [6:0] train_index = train_pc ^ train_history;

    // Two-bit saturating counter states
    localparam STRONGLY_NOT_TAKEN = 2'b00;
    localparam WEAKLY_NOT_TAKEN = 2'b01;
    localparam WEAKLY_TAKEN = 2'b10;
    localparam STRONGLY_TAKEN = 2'b11;

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            // Use the PHT state to predict branch direction
            case (PHT[predict_index])
                STRONGLY_TAKEN, WEAKLY_TAKEN: predict_taken = 1'b1;
                default: predict_taken = 1'b0;
            endcase
        end else begin
            predict_taken = 1'b0;
        end
        predict_history = GHR;
    end

    // Update and training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            GHR <= 7'b0;
            // Initialize all PHT entries to weakly not taken
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= WEAKLY_NOT_TAKEN;
            end
        end else if (train_valid) begin
            // Training logic
            if (train_taken) begin
                // Update the PHT entry based on the actual branch outcome
                if (PHT[train_index] < STRONGLY_TAKEN) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end
            end else begin
                if (PHT[train_index] > STRONGLY_NOT_TAKEN) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end
            end

            // If a misprediction occurred, recover the GHR
            if (train_mispredicted) begin
                GHR <= {train_history[5:0], train_taken};
            end else begin
                // Update GHR normally
                GHR <= {GHR[5:0], train_taken};
            end
        end else if (predict_valid) begin
            // Update GHR if a prediction occurred
            GHR <= {GHR[5:0], predict_taken};
        end
    end

endmodule
