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
localparam HIST_SIZE = 7;

reg [1:0] pht [PHT_SIZE-1:0];
reg [HIST_SIZE-1:0] global_history;

// Prediction logic
wire [HIST_SIZE-1:0] predict_hash = predict_pc ^ global_history;
always @(*) begin
    if (predict_valid) begin
        predict_taken = pht[predict_hash][1];
        predict_history = global_history;
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

// Training logic
wire [HIST_SIZE-1:0] train_hash = train_pc ^ train_history;
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b01;
        end
    end else begin
        if (train_valid) begin
            // Update the global history
            global_history <= (global_history << 1) | train_taken;

            // Update the PHT
            if (train_mispredicted) begin
                pht[train_hash] <= (train_taken) ? 2'b10 : 2'b01;
            end else begin
                pht[train_hash] <= (train_taken) ? 2'b11 : 2'b00;
            end

            // Recover global history on misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end
    end
end

endmodule
