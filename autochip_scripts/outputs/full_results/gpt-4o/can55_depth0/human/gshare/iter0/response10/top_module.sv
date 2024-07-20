module top_module(
    input clk,
    input areset,

    // Prediction interface
    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    // Training interface
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // 128-entry pattern history table (PHT) with two-bit saturating counters
    reg [1:0] PHT [127:0];

    // 7-bit global branch history register
    reg [6:0] global_history;

    // Local variables
    wire [6:0] predict_index;
    wire [6:0] train_index;
    integer i;

    // Compute index by XOR-ing PC with global history
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize to weakly taken
            end
        end
        else begin
            // Training takes precedence over prediction
            if (train_valid) begin
                // Update the PHT entry based on the actual branch outcome
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11)
                        PHT[train_index] <= PHT[train_index] + 1;
                end else begin
                    if (PHT[train_index] > 2'b00)
                        PHT[train_index] <= PHT[train_index] - 1;
                end

                // Recover global history register if there was a misprediction
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
            // Update the history register if prediction was made and no training
            else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            // Fetch the state of the PHT entry
            case (PHT[predict_index])
                2'b00: predict_taken = 0;       // Strongly not taken
                2'b01: predict_taken = 0;       // Weakly not taken
                2'b10: predict_taken = 1;       // Weakly taken
                2'b11: predict_taken = 1;       // Strongly taken
                default: predict_taken = 0;
            endcase
            // Return the current history register used for this prediction
            predict_history = global_history;
        end else begin
            predict_taken = 0;
            predict_history = 7'b0;
        end
    end
endmodule
