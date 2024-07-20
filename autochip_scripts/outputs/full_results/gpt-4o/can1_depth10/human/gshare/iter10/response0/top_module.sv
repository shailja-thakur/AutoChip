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

    reg [1:0] PHT[0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] global_history;
    wire [6:0] predict_index;
    wire [6:0] train_index;

    // Calculate the indexes for prediction and training using xor
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Initialize the PHT to weakly not taken for all entries
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01; // Weakly not taken
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else begin
            if (train_valid) begin
                // Update the PHT entry for training
                case (PHT[train_index])
                    2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00; // Strongly not taken
                    2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00; // Weakly not taken
                    2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01; // Weakly taken
                    2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10; // Strongly taken
                endcase

                // Recover the branch history register if mispredicted
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update the branch history register for prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    always @(*) begin
        // Handle prediction
        predict_history = global_history;
        if (predict_valid) begin
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken = 0; // Not taken
                2'b10, 2'b11: predict_taken = 1; // Taken
                default: predict_taken = 0;
            endcase
        end else begin
            predict_taken = 0;
        end
    end
endmodule
