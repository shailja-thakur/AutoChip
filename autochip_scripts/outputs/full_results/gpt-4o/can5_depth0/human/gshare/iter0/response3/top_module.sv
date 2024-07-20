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
    reg [1:0] PHT [127:0];  // 128-entry table of two-bit saturating counters

    // Define the training logic: Modify the PHT based on the actual outcome
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;  // Initialize the PHT counters to weakly taken
            end
        end else if (train_valid) begin
            integer index = train_history ^ train_pc;
            if (train_taken) begin
                if (PHT[index] != 2'b11)
                    PHT[index] <= PHT[index] + 1;
            end else begin
                if (PHT[index] != 2'b00)
                    PHT[index] <= PHT[index] - 1;
            end

            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= { global_history[5:0], train_taken };
            end
        end else if (predict_valid) begin
            global_history <= { global_history[5:0], predict_taken };
        end
    end

    // Prediction logic: Read the PHT and update the output accordingly
    always @(*) begin
        integer index = global_history ^ predict_pc;
        predict_taken = (PHT[index] >= 2'b10) ? 1'b1 : 1'b0;
        predict_history = global_history;
    end

endmodule
