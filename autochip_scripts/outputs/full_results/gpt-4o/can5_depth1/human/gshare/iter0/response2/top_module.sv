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

    reg [1:0] PHT [127:0];  // Pattern History Table with 128 entries, each 2-bits
    reg [6:0] global_history; // Global history register

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    // Initialize PHT and global history
    integer i;
    always @(posedge areset) begin
        global_history <= 7'b0;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] <= 2'b01;  // Initialize to weakly not-taken state (01)
        end
    end

    // Prediction logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken <= 0;
            predict_history <= 7'b0;
        end else if (predict_valid) begin
            predict_history <= global_history;
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken <= 0;  // Strongly not-taken or weakly not-taken
                2'b10, 2'b11: predict_taken <= 1;  // Weakly taken or strongly taken
            endcase
            global_history <= {global_history[5:0], predict_taken}; // Update global history with prediction
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else if (train_valid) begin
            // Update PHT based on actual branch outcome
            case (PHT[train_index])
                2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00; // Strongly not-taken -> weakly not-taken if taken
                2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00; // Weakly not-taken -> weakly taken or strongly not-taken
                2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01; // Weakly taken -> strongly taken or weakly not-taken
                2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10; // Strongly taken -> weakly taken if not taken
            endcase
            
            // Recover global history if misprediction occurs
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end
endmodule
