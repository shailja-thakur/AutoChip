module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // PHT entry: 2-bit saturating counter
    reg [1:0] PHT [127:0];
    reg [6:0] global_history;
    reg [1:0] prediction_counter;
    integer i;

    assign predict_history = global_history;

    // Determine PHT index and counter for prediction
    wire [6:0] predict_index = predict_pc ^ global_history;
    assign predict_taken = (prediction_counter >= 2'b10);

    // Determine PHT index for training
    wire [6:0] train_index = train_pc ^ train_history;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly not taken by default
            end
            global_history <= 7'b0;
        end else begin
            if (train_valid) begin
                // Update PHT with actual branch outcome
                if (train_taken) begin
                    PHT[train_index] <= (PHT[train_index] < 2'b11) ? (PHT[train_index] + 1) : 2'b11;
                end else begin
                    PHT[train_index] <= (PHT[train_index] > 2'b00) ? (PHT[train_index] - 1) : 2'b00;
                end
                // Update global history
                if (train_mispredicted) begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Predict branch
                prediction_counter <= PHT[predict_index];
                // Update global history for prediction
                global_history <= {global_history[5:0], (prediction_counter >= 2'b10)};
            end
        end
    end

endmodule
