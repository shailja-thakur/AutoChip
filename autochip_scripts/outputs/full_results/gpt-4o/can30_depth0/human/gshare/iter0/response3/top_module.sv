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

    integer i;
    reg [1:0] pht [127:0]; // pattern history table with 2-bit saturating counters
    reg [6:0] global_history; // 7-bit global history register

    // 2-bit saturating counter definitions
    localparam STRONGLY_NOT_TAKEN = 2'b00,
               WEAKLY_NOT_TAKEN   = 2'b01,
               WEAKLY_TAKEN       = 2'b10,
               STRONGLY_TAKEN     = 2'b11;

    // Combination logic to compute index
    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            case (pht[predict_index])
                STRONGLY_NOT_TAKEN, WEAKLY_NOT_TAKEN: predict_taken = 0;
                WEAKLY_TAKEN, STRONGLY_TAKEN: predict_taken = 1;
                default: predict_taken = 0;
            endcase
        end else begin
            predict_taken = 0;
            predict_history = global_history;
        end
    end

    // Sequential logic for branch predictor training and updating global history
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= WEAKLY_NOT_TAKEN;
            end
            global_history <= 7'b0;
        end else if (train_valid) begin
            // Update PHT
            case (pht[train_index])
                STRONGLY_NOT_TAKEN: pht[train_index] <= train_taken ? WEAKLY_NOT_TAKEN : STRONGLY_NOT_TAKEN;
                WEAKLY_NOT_TAKEN:   pht[train_index] <= train_taken ? WEAKLY_TAKEN : STRONGLY_NOT_TAKEN;
                WEAKLY_TAKEN:       pht[train_index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_NOT_TAKEN;
                STRONGLY_TAKEN:     pht[train_index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_TAKEN;
            endcase

            // Update global history based on misprediction
            if (train_mispredicted) begin
                global_history <= {global_history[5:0], train_taken};
            end else begin
                if (!predict_valid) begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
        end else if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
    end
endmodule
