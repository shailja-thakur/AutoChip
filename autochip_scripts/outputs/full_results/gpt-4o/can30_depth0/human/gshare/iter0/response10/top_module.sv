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
    reg [1:0] PHT [0:127]; // Pattern History Table with 2-bit saturating counters
    reg [6:0] global_history; // Global History Register

    integer i;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset Global History Register and PHT
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly taken state
            end
        end else begin
            if (train_valid) begin
                // Update the PHT based on the training signal
                if (train_taken) begin
                    if (PHT[{train_history ^ train_pc}] < 2'b11)
                        PHT[{train_history ^ train_pc}] <= PHT[{train_history ^ train_pc}] + 1;
                end else begin
                    if (PHT[{train_history ^ train_pc}] > 2'b00)
                        PHT[{train_history ^ train_pc}] <= PHT[{train_history ^ train_pc}] - 1;
                end

                // If there's a misprediction, recover the global history
                if (train_mispredicted) begin
                    global_history <= {train_history, train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history for prediction
                global_history <= {global_history[5:0], PHT[{global_history ^ predict_pc}][1]};
            end
        end
    end

    always @(*) begin
        if (predict_valid) begin
            // Predict branch taken or not and provide current global history
            predict_history = global_history;
            predict_taken = PHT[{global_history ^ predict_pc}][1];
        end else begin
            predict_history = 7'b0;
            predict_taken = 1'b0;
        end
    end

endmodule
