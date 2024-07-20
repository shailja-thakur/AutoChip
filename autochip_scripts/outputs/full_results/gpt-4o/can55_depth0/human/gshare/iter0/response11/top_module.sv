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

    reg [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] global_history; // 7-bit global branch history register

    integer i;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize counters to weakly not taken
            end
        end else begin
            if (train_valid) begin
                // Update PHT entry based on actual outcome
                if (train_taken) begin
                    if (PHT[train_pc ^ train_history] < 2'b11)
                        PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
                end else begin
                    if (PHT[train_pc ^ train_history] > 2'b00)
                        PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
                end
                // Update global history on misprediction
                if (train_mispredicted) begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history register for branch prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            case (PHT[predict_pc ^ global_history])
                2'b00, 2'b01: predict_taken = 0; // Strongly or weakly not taken
                2'b10, 2'b11: predict_taken = 1; // Weakly or strongly taken
            endcase
        end else begin
            predict_taken = 0;
            predict_history = global_history;
        end
    end

endmodule
