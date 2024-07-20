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

reg [1:0] pht [127:0]; // 128-entry 2-bit saturating counter PHT
reg [6:0] global_history; // 7-bit global history register

always @(*) begin
    // Compute the PHT index using the XOR hash of PC and global history
    integer pht_index = predict_pc ^ global_history;

    // Make the prediction based on the PHT entry
    predict_taken = (pht[pht_index][1]); // MSB of the 2-bit counter
    predict_history = global_history;
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b01; // Initialize PHT to weakly not-taken
        end
    end
    else begin
        // Training
        if (train_valid) begin
            integer train_index = train_pc ^ train_history;
            // Update the PHT entry
            if (train_taken) begin
                pht[train_index] <= (pht[train_index] == 2'b11) ? 2'b11 : pht[train_index] + 1'b1; // Saturating increment
            end
            else begin
                pht[train_index] <= (pht[train_index] == 2'b00) ? 2'b00 : pht[train_index] - 1'b1; // Saturating decrement
            end

            // Update the global history register
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                global_history <= (global_history << 1) | train_taken;
            end
        end
        // Prediction
        else if (predict_valid) begin
            global_history <= (global_history << 1) | predict_taken;
        end
    end
end

endmodule
