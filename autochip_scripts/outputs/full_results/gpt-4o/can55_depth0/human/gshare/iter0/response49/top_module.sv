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

    // Define the 128-entry Pattern History Table (PHT) of 2-bit counters
    reg [1:0] PHT [127:0];
    reg [6:0] global_history;

    // Initialize the PHT and global history on reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b10;  // Weakly taken initial state
            end
            global_history <= 7'b0;
        end
        else if (train_valid) begin
            // Train the PHT
            integer idx;
            idx = train_pc ^ train_history;
            if (train_taken && PHT[idx] < 2'b11)
                PHT[idx] <= PHT[idx] + 1'b1 ;
            else if (!train_taken && PHT[idx] > 2'b00)
                PHT[idx] <= PHT[idx] - 1'b1;

            // Update global history
            if (train_mispredicted) begin
                global_history <= {global_history[5:0], train_taken};
            end

        end else if (predict_valid) begin
            // Update global history for prediction
            global_history <= {global_history[5:0], predict_taken};
        end
    
    end

    always @(*) begin
        // Default values
        predict_taken = 0;
        predict_history = global_history;

        // Predict logic
        if (predict_valid) begin
            integer idx;
            idx = predict_pc ^ predict_history;
            predict_taken = PHT[idx][1]; // MSB of PHT entry indicates ‘taken’
        end
    end

endmodule
