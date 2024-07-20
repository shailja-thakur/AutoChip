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
    // Two-bit Saturating Counter States
    localparam STRONG_TAKEN = 2'b11;
    localparam WEAK_TAKEN = 2'b10;
    localparam WEAK_NOT_TAKEN = 2'b01;
    localparam STRONG_NOT_TAKEN = 2'b00;

    // Pattern History Table (PHT) and Global History Register (GHR)
    reg [1:0] PHT [0:127];
    reg [6:0] GHR;

    wire [6:0] predict_index = predict_pc ^ GHR;
    wire [6:0] train_index = train_pc ^ train_history;

    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = WEAK_NOT_TAKEN;
        end
        GHR = 7'b0;
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
        end else begin
            if (train_valid) begin
                // Update PHT according to the training outcome
                case (PHT[train_index])
                    STRONG_TAKEN:    PHT[train_index] <= train_taken ? STRONG_TAKEN : WEAK_TAKEN;
                    WEAK_TAKEN:      PHT[train_index] <= train_taken ? STRONG_TAKEN : WEAK_NOT_TAKEN;
                    WEAK_NOT_TAKEN:  PHT[train_index] <= train_taken ? WEAK_TAKEN : STRONG_NOT_TAKEN;
                    STRONG_NOT_TAKEN: PHT[train_index] <= train_taken ? WEAK_NOT_TAKEN : STRONG_NOT_TAKEN;
                endcase
                if (train_mispredicted) begin
                    GHR <= {GHR[5:0], train_taken};
                end else begin
                    GHR <= {GHR[5:0], ~train_taken};
                end
            end else if (predict_valid) begin
                // Update GHR based on the prediction
                GHR <= {GHR[5:0], PHT[predict_index][1]};
            end
        end
    end

    always @(*) begin
        if (predict_valid) begin
            predict_taken = (PHT[predict_index] == STRONG_TAKEN || PHT[predict_index] == WEAK_TAKEN);
            predict_history = GHR;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end
endmodule
