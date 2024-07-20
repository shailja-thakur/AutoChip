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

parameter PHT_SIZE = 128;
parameter HISTORY_SIZE = 7;

reg [1:0] pht[PHT_SIZE-1:0]; // Pattern History Table
reg [HISTORY_SIZE-1:0] global_history;

// Prediction logic
always @(*) begin
    if (predict_valid) begin
        // Hash PC and global history to get PHT index
        integer index = predict_pc ^ global_history;
        index = index[HISTORY_SIZE-1:0];

        // Make prediction based on PHT entry
        predict_taken = (pht[index] >= 2'b10);
        predict_history = global_history;
    end else begin
        predict_taken = 1'b0;
        predict_history = 7'b0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (integer i = 0; i < PHT_SIZE; i = i + 1) begin
            pht[i] <= 2'b01;
        end
    end else begin
        if (train_valid) begin
            // Hash PC and history to get PHT index
            integer index = train_pc ^ train_history;
            index = index[HISTORY_SIZE-1:0];

            // Update PHT entry based on actual branch outcome
            if (train_taken) begin
                pht[index] <= (pht[index] == 2'b11) ? 2'b11 : pht[index] + 2'b01;
            end else begin
                pht[index] <= (pht[index] == 2'b00) ? 2'b00 : pht[index] - 2'b01;
            end

            // Update global history register
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= {global_history[HISTORY_SIZE-2:0], train_taken};
            end
        end
    end
end

endmodule
