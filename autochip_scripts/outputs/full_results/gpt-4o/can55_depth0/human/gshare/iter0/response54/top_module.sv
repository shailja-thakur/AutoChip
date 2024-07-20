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

    // 128-entry table of two-bit saturating counters
    reg [1:0] PHT[127:0];

    // 7-bit global history register
    reg [6:0] global_history;

    // XOR to hash pc and global history into a 7-bit index
    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    // Asynchronous reset
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;  // Weakly taken initial state
            end
        end else begin
            if (train_valid) begin
                // Update PHT based on the actual branch outcome
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 2'b01;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 2'b01;
                    end
                end
                
                // Update global history based on misprediction or actual outcome
                if (train_mispredicted) begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history with predicted outcome
                global_history <= {global_history[5:0], (PHT[predict_index] >= 2'b10)};
            end
        end
    end

    // Prediction logic
    always @ (*) begin
        if (predict_valid) begin
            predict_taken = (PHT[predict_index] >= 2'b10);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

endmodule
