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
    reg [1:0] PHT [127:0]; // 128-entry table of 2-bit saturating counters
    reg [6:0] global_history; // 7-bit global branch history register

    integer i;

    // Initialize/reset the PHT and global history register
    always @(posedge areset or posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01; // Weakly not taken
        end
    end

    wire [6:0] predict_index = predict_pc ^ global_history; // XOR to compute the index
    wire [6:0] train_index = train_pc ^ train_history;     // XOR to compute the index for training

    // Prediction logic
    always @(posedge clk) begin
        if (predict_valid && !areset && !train_valid) begin
            case(PHT[predict_index])
                2'b00: predict_taken <= 0;
                2'b01: predict_taken <= 0;
                2'b10: predict_taken <= 1;
                2'b11: predict_taken <= 1;
            endcase
            predict_history <= global_history;
            global_history <= {global_history[5:0], predict_taken}; // Update global history
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid && !areset) begin
            case (PHT[train_index])
                2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00;
                2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00;
                2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01;
                2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10;
            endcase

            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end
endmodule
