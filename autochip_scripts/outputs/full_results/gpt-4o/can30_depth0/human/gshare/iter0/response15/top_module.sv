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
    reg [6:0] global_history;

    integer i;

    // Initialize the PHT and global_history
    always @(posedge areset) begin
        global_history <= 7'd0;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] <= 2'b01; // Weakly not taken
        end
    end

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    // Prediction logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken <= 1'b0;
            predict_history <= 7'd0;
        end
        else if (predict_valid) begin
            predict_history <= global_history;
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken <= 1'b0;
                2'b10, 2'b11: predict_taken <= 1'b1;
            endcase
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            case (PHT[train_index])
                2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00;
                2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00;
                2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01;
                2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10;
            endcase

            if (train_mispredicted) begin
                global_history <= {global_history[5:0], train_taken}; // Recover history
            end else begin
                global_history <= {global_history[5:0], predict_taken}; // Update history
            end
        end else if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken}; // Update history for prediction
        end
    end
endmodule
