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

    reg [1:0] PHT[0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] GHR; // 7-bit global history register

    // Generate index for PHT
    wire [6:0] predict_index = predict_pc ^ GHR;
    wire [6:0] train_index = train_pc ^ train_history;

    integer i;
    
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize counter to weakly not taken
            end
        end else begin
            // Training takes precedence over prediction if both happen in the same cycle
            if (train_valid) begin
                // Update the saturating counter in PHT based on actual outcome
                case (PHT[train_index])
                    2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00;
                    2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00;
                    2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01;
                    2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10;
                endcase

                // Recover GHR if misprediction occurred
                if (train_mispredicted)
                    GHR <= train_history;
                else
                    GHR <= {GHR[5:0], train_taken};
            end

            // Update GHR for prediction if no training or if not a misprediction
            if (predict_valid && !(train_valid && train_mispredicted)) begin
                GHR <= {GHR[5:0], predict_taken};
            end
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_history = GHR;
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken = 0; // weakly or strongly not taken
                2'b10, 2'b11: predict_taken = 1; // weakly or strongly taken
            endcase
        end else begin
            predict_taken = 0;
            predict_history = 7'b0;
        end
    end

endmodule
