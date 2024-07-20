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

    reg [1:0] PHT [0:127];     // Pattern History Table with two-bit saturating counters
    reg [6:0] GHR;            // Global History Register

    // Two-bit saturating counter states
    localparam STRONGLY_NOT_TAKEN = 2'b00;
    localparam WEAKLY_NOT_TAKEN   = 2'b01;
    localparam WEAKLY_TAKEN       = 2'b10;
    localparam STRONGLY_TAKEN     = 2'b11;

    // PHT index calculation using GHR and PC
    wire [6:0] pht_index = predict_pc ^ GHR;
    wire [6:0] train_index = train_pc ^ train_history;

    // Predict logic
    always @(*) begin
        if (predict_valid) begin
            case (PHT[pht_index])
                STRONGLY_TAKEN, WEAKLY_TAKEN: predict_taken = 1'b1;
                default: predict_taken = 1'b0;
            endcase
            predict_history = GHR;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Train logic - handled at positive clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= WEAKLY_NOT_TAKEN; // Initialize counters to weakly not taken
            end
        end else begin
            if (train_valid) begin
                // Update the PHT entry
                case (PHT[train_index])
                    STRONGLY_NOT_TAKEN: PHT[train_index] <= train_taken ? WEAKLY_NOT_TAKEN : STRONGLY_NOT_TAKEN;
                    WEAKLY_NOT_TAKEN: PHT[train_index] <= train_taken ? WEAKLY_TAKEN : STRONGLY_NOT_TAKEN;
                    WEAKLY_TAKEN: PHT[train_index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_NOT_TAKEN;
                    STRONGLY_TAKEN: PHT[train_index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_TAKEN;
                endcase

                // Recover the GHR if there was a misprediction
                if (train_mispredicted) begin
                    GHR <= train_history;
                end else begin
                    // Update GHR with the actual outcome if no misprediction
                    GHR <= {GHR[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update GHR for the predicted branch
                GHR <= {GHR[5:0], predict_taken};
            end
        end
    end
endmodule
