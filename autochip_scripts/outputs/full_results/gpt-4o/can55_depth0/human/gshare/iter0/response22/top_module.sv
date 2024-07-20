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
    // Define the global branch history register
    reg [6:0] global_history;
    // Define the 128-entry Pattern History Table (PHT) with 2-bit saturating counters
    reg [1:0] PHT [127:0];

    // XOR function to perform hashing
    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;
    
    // Define the output register
    reg predict_taken_reg;
    reg [6:0] predict_history_reg;
    
    assign predict_taken = predict_taken_reg;
    assign predict_history = predict_history_reg;

    // Initialize the PHT
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01; // Weakly not taken
        end
    end

    // Prediction logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else if (predict_valid) begin
            predict_taken_reg = PHT[predict_index][1];
            predict_history_reg = global_history;
            global_history <= {global_history[5:0], predict_taken_reg};
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else if (train_valid) begin
            // Update the PHT entry for the trained branch
            case (PHT[train_index])
                2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00;
                2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00;
                2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01;
                2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10;
            endcase
            
            // Recover the global history if there was a misprediction
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end
endmodule
