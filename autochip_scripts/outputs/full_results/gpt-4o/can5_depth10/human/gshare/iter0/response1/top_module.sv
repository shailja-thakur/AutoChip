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

    reg [1:0] PHT [127:0];
    reg [6:0] global_history;

    integer i;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initial value for the saturating counters
            end
        end else begin
            if (train_valid) begin
                // Get the index using xor of train_pc and train_history
                reg [6:0] index;
                index = train_pc ^ train_history;
                
                if (train_taken) begin
                    if (PHT[index] < 2'b11) begin
                        PHT[index] <= PHT[index] + 1;
                    end
                end else begin
                    if (PHT[index] > 2'b00) begin
                        PHT[index] <= PHT[index] - 1;
                    end
                end
                
                // Update global history register
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken}; // Recover to the state after mispredicted branch
                end else begin
                    global_history <= {global_history[5:0], train_taken}; // Normal update
                end
            end

            if (predict_valid) begin
                // Get the index using xor of predict_pc and global_history
                reg [6:0] index;
                index = predict_pc ^ global_history;
                
                // Predict based on the counter value in the PHT
                predict_taken <= (PHT[index] >= 2'b10);
                predict_history <= global_history;

                // Update global history register speculatively (will be overwritten by accurate training if needed)
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end
endmodule
