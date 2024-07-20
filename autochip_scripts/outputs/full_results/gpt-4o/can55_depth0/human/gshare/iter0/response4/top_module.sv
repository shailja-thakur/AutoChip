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
    reg [1:0] PHT[127:0]; // 128-entry table of two-bit saturating counters

    // Initialize PHT and global_history on asynchronous reset
    integer i;
    always @(posedge areset) begin
        global_history <= 7'b0;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] <= 2'b01; // Initialize to weakly taken
        end
    end

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    // Prediction logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken <= 1'b0;
            predict_history <= 7'b0;
        end else if (predict_valid) begin
            predict_taken <= PHT[predict_index][1]; // MSB of the counter indicates prediction
            predict_history <= global_history;
            // Update global history register on next positive clock edge, unless being overwritten by training
            if (!train_valid) begin
                global_history <= {global_history[5:0], PHT[predict_index][1]};
            end
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            // Update the pattern history table (PHT)
            case ({train_taken, PHT[train_index]})
                3'b000: PHT[train_index] <= 2'b00;
                3'b001: PHT[train_index] <= 2'b00;
                3'b010: PHT[train_index] <= 2'b01;
                3'b011: PHT[train_index] <= 2'b01;
                3'b100: PHT[train_index] <= 2'b10;
                3'b101: PHT[train_index] <= 2'b10;
                3'b110: PHT[train_index] <= 2'b11;
                3'b111: PHT[train_index] <= 2'b11;
            endcase

            // If branch was mispredicted, recover the global history
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end

endmodule
