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

localparam PHT_SIZE = 128;
reg [1:0] pht [PHT_SIZE-1:0];
reg [6:0] global_history;

always @(*) begin
    // Prediction logic
    if (predict_valid) begin
        // Hash PC and global history to get PHT index
        predict_history = global_history;
        predict_taken = pht[predict_pc ^ global_history][1];
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b01;
        end
    end else begin
        // Training logic
        if (train_valid) begin
            // Update PHT based on actual branch outcome
            pht[train_pc ^ train_history][1] <= train_taken;
            pht[train_pc ^ train_history][0] <= train_taken;

            // Update global history register
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= (global_history << 1) | train_taken;
            end
        end

        // Update global history register for predicted branch
        if (predict_valid) begin
            global_history <= (global_history << 1) | predict_taken;
        end
    end
end

endmodule
