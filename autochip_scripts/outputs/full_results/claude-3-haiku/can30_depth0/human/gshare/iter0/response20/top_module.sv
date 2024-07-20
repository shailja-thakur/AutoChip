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

// 7-bit PC and 7-bit global history, hashed (using xor) into a 7-bit index
wire [6:0] index = predict_pc ^ predict_history;

// 128-entry table of two-bit saturating counters
reg [1:0] pht [127:0];

// Update the branch history register on a prediction
always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 7'b0;
    end
    else if (predict_valid) begin
        predict_history <= {predict_history[5:0], predict_taken};
    end
end

// Generate the prediction
always @(*) begin
    if (predict_valid) begin
        predict_taken = (pht[index] >= 2'b10);
    end
    else begin
        predict_taken = 1'b0;
    end
end

// Train the branch predictor
always @(posedge clk or posedge areset) begin
    if (areset) begin
        pht[index] <= 2'b01;
    end
    else if (train_valid) begin
        // Update the pattern history table (PHT)
        if (train_mispredicted) begin
            // Misprediction, update PHT entry
            if (train_taken) begin
                pht[index] <= (pht[index] == 2'b00) ? 2'b01 : (pht[index] + 2'b01);
            end
            else begin
                pht[index] <= (pht[index] == 2'b11) ? 2'b10 : (pht[index] - 2'b01);
            end

            // Recover the branch history register
            predict_history <= train_history;
        end
        else begin
            // Correct prediction, update PHT entry
            if (train_taken) begin
                pht[index] <= (pht[index] == 2'b11) ? 2'b11 : (pht[index] + 2'b01);
            end
            else begin
                pht[index] <= (pht[index] == 2'b00) ? 2'b00 : (pht[index] - 2'b01);
            end
        end
    end
end

endmodule
