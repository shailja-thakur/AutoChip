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
    reg [1:0] PHT [0:127];
    integer i;

    // Initialize the predictor state
    always @(posedge areset) begin
        global_history <= 7'b0;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] <= 2'b01; // Weakly not taken
        end
    end

    // Predict logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken <= 1'b0;
            predict_history <= 7'b0;
        end else if (predict_valid) begin
            // Get the index by xoring PC and global history
            // Note this is happening in the same cycle, all results should be registered outputs
            predict_history <= global_history;
            case (PHT[predict_pc ^ global_history])
                2'b00, 2'b01: predict_taken <= 1'b0;
                2'b10, 2'b11: predict_taken <= 1'b1;
            endcase
            // Update the history register
            global_history <= {global_history[5:0], predict_taken};
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else if (train_valid) begin
            // Get the index by xoring PC and train_history
            reg [6:0] index;
            index = train_pc ^ train_history;
            // Update the PHT
            case ({train_taken, PHT[index]})
                3'b000: PHT[index] <= 2'b00;
                3'b001: PHT[index] <= 2'b00;
                3'b010: PHT[index] <= 2'b01;
                3'b011: PHT[index] <= 2'b10;
                3'b100: PHT[index] <= 2'b01;
                3'b101: PHT[index] <= 2'b10;
                3'b110: PHT[index] <= 2'b11;
                3'b111: PHT[index] <= 2'b11;
            endcase
            // Recover the history register if there was a misprediction
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end
    end

endmodule
