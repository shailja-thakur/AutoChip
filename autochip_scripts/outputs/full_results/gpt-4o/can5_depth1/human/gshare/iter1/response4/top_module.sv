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

    reg [6:0] global_history;
    reg [1:0] PHT [127:0]; // 128-entry table of two-bit saturating counters

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    // Initialize PHT and global history
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize to weakly not taken
            end
        end
    end

    // Prediction logic
    always @(posedge clk) begin
        if (predict_valid) begin
            predict_history <= global_history;
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken <= 1'b0; // Weakly/Strongly not taken
                2'b10, 2'b11: predict_taken <= 1'b1; // Weakly/Strongly taken
            endcase

            if (!train_valid || !train_mispredicted) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            // Update the PHT entry based on actual branch outcome
            if (train_taken) begin
                if (PHT[train_index] != 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end
            end else begin
                if (PHT[train_index] != 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end
            end

            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else if (predict_valid && (train_pc != predict_pc)) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
