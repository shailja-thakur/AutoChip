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

    reg [1:0] pht [127:0]; // 128-entry table of two-bit saturating counters
    reg [6:0] global_history; // 7-bit global branch history register
    wire [6:0] predict_index;
    wire [6:0] train_index;

    // Hash function using XOR
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Asynchronous active-high reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01; // weakly not-taken state
            end
        end else begin
            // If training is valid, update the PHT
            if (train_valid) begin
                // Train the PHT
                if (train_taken) begin
                    if (pht[train_index] != 2'b11)
                        pht[train_index] <= pht[train_index] + 2'b01;
                end else begin
                    if (pht[train_index] != 2'b00)
                        pht[train_index] <= pht[train_index] - 2'b01;
                end

                // Update the global history on misprediction
                if (train_mispredicted) begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end

            // Update the global history for prediction
            if (predict_valid && (train_valid == 0 || !train_mispredicted)) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            predict_taken = pht[predict_index][1];
        end else begin
            predict_history = 7'b0;
            predict_taken = 1'b0;
        end
    end
endmodule
