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

    // PHT (Pattern History Table) - 128 entries of 2-bit saturating counters
    reg [1:0] PHT [0:127];
    
    // Global Branch History Register - 7-bit
    reg [6:0] global_history_reg;

    // XOR to create the index from pc and history
    wire [6:0] predict_index = predict_pc ^ global_history_reg;
    wire [6:0] train_index = train_pc ^ train_history;

    // PHT update logic: 2-bit saturating counter
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            integer i;
            global_history_reg <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly taken state (arbitrary initialization)
            end
        end else if (train_valid) begin
            // Update the PHT based on the actual outcome
            if (train_taken) begin
                if (PHT[train_index] < 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end
            end else begin
                if (PHT[train_index] > 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end
            end

            // Update the global history register
            if (train_mispredicted) begin
                global_history_reg <= train_history;
            end
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken <= 0;
            predict_history <= 7'b0;
        end else if (predict_valid) begin
            predict_history <= global_history_reg;

            // Prediction is based on the current state of the PHT
            case(PHT[predict_index])
                2'b00, 2'b01: predict_taken <= 0; // Not taken
                2'b10, 2'b11: predict_taken <= 1; // Taken
            endcase

            // Update the global history register with the prediction
            global_history_reg <= {global_history_reg[5:0], predict_taken};
        end
    end

endmodule
