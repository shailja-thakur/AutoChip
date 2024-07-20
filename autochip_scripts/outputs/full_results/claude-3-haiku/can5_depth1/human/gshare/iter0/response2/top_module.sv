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

    // 7-bit PC and 7-bit global history, hashed using XOR to a 7-bit index
    wire [6:0] index = predict_pc ^ predict_history;

    // 128-entry table of 2-bit saturating counters
    reg [1:0] pht [127:0];

    initial begin
        for (int i = 0; i < 128; i++) begin
            pht[i] = 2'b01; // Initialize all entries to weakly not-taken
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_taken = pht[index][1]; // MSB of the counter is the prediction
            predict_history = predict_history; // Maintain the current history
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b01; // Reset all entries to weakly not-taken
            end
            predict_history <= 7'b0; // Reset the global history register
        end else begin
            if (train_valid) begin
                // Update the pattern history table
                case (pht[train_pc ^ train_history])
                    2'b00: if (train_taken) pht[train_pc ^ train_history] <= 2'b01; // Weakly not-taken to weakly taken
                    2'b01: if (train_taken) pht[train_pc ^ train_history] <= 2'b11; // Weakly not-taken to strongly taken
                                    else pht[train_pc ^ train_history] <= 2'b00; // Weakly not-taken to strongly not-taken
                    2'b10: if (train_taken) pht[train_pc ^ train_history] <= 2'b11; // Weakly taken to strongly taken
                                    else pht[train_pc ^ train_history] <= 2'b01; // Weakly taken to weakly not-taken
                    2'b11: if (!train_taken) pht[train_pc ^ train_history] <= 2'b10; // Strongly taken to weakly taken
                endcase

                // Update the branch history register
                if (train_mispredicted) begin
                    predict_history <= train_history; // Recover the branch history register
                end else begin
                    predict_history <= (predict_history << 1) | train_taken; // Update the branch history register
                end
            end
        end
    end

endmodule
