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

    // 128-entry Pattern History Table (PHT) containing 2-bit saturating counters
    reg [1:0] PHT [0:127];
    
    // 7-bit Global Branch History Register
    reg [6:0] GHR;

    // Asynchronous reset
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            // Initialize PHT to weakly taken state (01)
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                // Training the PHT
                reg [6:0] index;
                index = train_pc ^ train_history;

                // Update PHT based on train_taken
                if (train_taken) begin
                    if (PHT[index] < 2'b11) PHT[index] <= PHT[index] + 1;
                end else begin
                    if (PHT[index] > 2'b00) PHT[index] <= PHT[index] - 1;
                end

                // Recover GHR if mispredicted
                if (train_mispredicted) begin
                    GHR <= {train_history[5:0], train_taken};
                end else begin
                    GHR <= {GHR[5:0], predict_taken};
                end
            end else if (predict_valid) begin
                // Update GHR for the predicted branch
                GHR <= {GHR[5:0], predict_taken};
            end
        end
    end

    // Prediction Interface
    always @ (*) begin
        predict_history = GHR;
        if (predict_valid) begin
            reg [6:0] index;
            index = predict_pc ^ GHR;
            predict_taken = PHT[index] >= 2'b10;  // Taken if saturating counter is 2 or 3
        end else begin
            predict_taken = 1'b0;
        end
    end

endmodule
