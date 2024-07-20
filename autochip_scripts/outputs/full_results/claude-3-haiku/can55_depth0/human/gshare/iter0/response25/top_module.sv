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

// 7-bit PC and global history, hashed (using XOR) into a 7-bit index
wire [6:0] index = predict_pc ^ predict_history;

// 128-entry table of 2-bit saturating counters
reg [1:0] pht [127:0];

// Update branch history register on prediction
always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 7'b0;
    end
    else if (predict_valid) begin
        predict_history <= {predict_history[5:0], predict_taken};
    end
end

// Predict branch direction
always @* begin
    if (predict_valid) begin
        predict_taken = (pht[index] >= 2'b10);
    end
    else begin
        predict_taken = 1'b0;
    end
end

// Train branch predictor
always @(posedge clk or posedge areset) begin
    if (areset) begin
        pht[index] <= 2'b01;
    end
    else if (train_valid) begin
        if (train_mispredicted) begin
            // Recover branch history register
            predict_history <= train_history;
        end
        // Update pattern history table
        case (pht[index])
            2'b00: pht[index] <= (train_taken) ? 2'b01 : 2'b00;
            2'b01: pht[index] <= (train_taken) ? 2'b10 : 2'b00;
            2'b10: pht[index] <= (train_taken) ? 2'b11 : 2'b01;
            2'b11: pht[index] <= (train_taken) ? 2'b11 : 2'b10;
        endcase
    end
end

endmodule
