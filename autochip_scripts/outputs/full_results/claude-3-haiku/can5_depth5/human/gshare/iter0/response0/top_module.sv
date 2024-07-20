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

// 7-bit PC and 7-bit global history
reg [6:0] global_history;

// 128-entry table of two-bit saturating counters
reg [1:0] pht [127:0];

// Hash the PC and global history to get the PHT index
wire [6:0] pht_index = predict_pc ^ global_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01; // Initialize PHT to weakly not taken
        end
    end
    else begin
        // Prediction logic
        if (predict_valid) begin
            predict_taken <= (pht[pht_index] >= 2'b10); // Predict taken if counter is >= 2
            predict_history <= global_history;
            global_history <= {global_history[5:0], predict_taken}; // Update global history
        end

        // Training logic
        if (train_valid) begin
            // Update PHT
            pht[pht_index] <= (train_taken) ? (pht[pht_index] < 2'b11 ? pht[pht_index] + 1 : 2'b11) :
                                              (pht[pht_index] > 2'b00 ? pht[pht_index] - 1 : 2'b00);

            // Recover global history on misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end
end

endmodule
