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

// 128-entry table of 2-bit saturating counters
reg [1:0] PHT [0:127];

// 7-bit global branch history register
reg [6:0] global_history;

// initialize PHT and global_history on reset or misprediction
always @(posedge clk or posedge areset) begin
    if (areset) begin
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] <= 2'b01; // weakly not taken (01)
        end
        global_history <= 7'b0;
    end else if (train_valid && train_mispredicted) begin
        global_history <= train_history; // recover global history
    end else if (predict_valid) begin
        global_history <= {global_history[5:0], predict_taken}; // shift in the prediction result
    end
end

// Prediction logic
wire [6:0] predict_index = predict_pc ^ global_history;

always @(*) begin
    if (predict_valid) begin
        case (PHT[predict_index])
            2'b00, 2'b01: predict_taken = 0; // predict not taken
            2'b10, 2'b11: predict_taken = 1; // predict taken
        endcase
        predict_history = global_history;
    end else begin
        predict_taken = 0;
        predict_history = 7'b0;
    end
end

// Training logic
wire [6:0] train_index = train_pc ^ train_history;

always @(posedge clk) begin
    if (train_valid) begin
        case (PHT[train_index])
            2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00;
            2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00;
            2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01;
            2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10;
        endcase
    end
end

endmodule
