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
    reg [1:0] PHT [127:0];  // Pattern History Table with 128 entries

    integer i;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b10; // Initialize PHT counters to weakly taken (10)
            end
        end else begin
            if (train_valid) begin
                // Compute index for training and read the current counter value
                integer train_index = train_pc ^ train_history;
                reg [1:0] current_counter = PHT[train_index];

                // Update the counter based on actual branch outcome
                if (train_taken) begin
                    if (current_counter < 2'b11)
                        PHT[train_index] <= current_counter + 1;
                end else begin
                    if (current_counter > 2'b00)
                        PHT[train_index] <= current_counter - 1;
                end

                // When a misprediction occurs, recover the branch history
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    // Update global history register
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Prediction based on current PC and global history
                integer predict_index = predict_pc ^ global_history;
                predict_history <= global_history;

                // Predict branch taken or not taken
                case(PHT[predict_index])
                    2'b00, 2'b01: predict_taken <= 1'b0;  // Not Taken
                    2'b10, 2'b11: predict_taken <= 1'b1;  // Taken
                endcase
                
                // Update global history register after prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
