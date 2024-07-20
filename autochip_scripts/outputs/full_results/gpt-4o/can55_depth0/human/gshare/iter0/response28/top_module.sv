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

    reg [1:0] PHT [0:127]; // 128-entry table of 2-bit saturating counters
    reg [6:0] branch_history_reg;

    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            branch_history_reg <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initializing to weakly taken
            end
        end else if (train_valid) begin
            // Index calculated by XORing pc and global history
            integer index;
            index = train_pc ^ train_history;

            // Update PHT based on the actual outcome
            if (train_taken) begin
                if (PHT[index] != 2'b11)
                    PHT[index] <= PHT[index] + 1;
            end else begin
                if (PHT[index] != 2'b00)
                    PHT[index] <= PHT[index] - 1;
            end

            // Recover history if misprediction
            if (train_mispredicted) begin
                branch_history_reg <= train_history;
            end else begin
                // Update history for the trained branch
                branch_history_reg <= {branch_history_reg[5:0], train_taken};
            end
        end else if (predict_valid) begin
            // Index calculated by XORing pc and global history
            integer index;
            index = predict_pc ^ branch_history_reg;

            // Make prediction
            predict_taken <= (PHT[index] >= 2'b10);
            predict_history <= branch_history_reg;
            
            // Update branch history register on prediction
            branch_history_reg <= {branch_history_reg[5:0], predict_taken};
        end
    end

endmodule
