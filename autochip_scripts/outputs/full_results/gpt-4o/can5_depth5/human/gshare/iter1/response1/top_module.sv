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

    // Define a 7-bit Global History Register (GHR)
    reg [6:0] GHR;

    // Define a 128-entry Pattern History Table (PHT) of 2-bit saturating counters 
    reg [1:0] PHT [127:0];

    // Initialize GHR and PHT
    integer i;
    initial begin
        GHR = 7'b0;
        for (i = 0; i < 128; i = i + 1) 
            PHT[i] = 2'b01; // weakly not taken
    end
    
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            for (i = 0; i < 128; i = i + 1) 
                PHT[i] <= 2'b01; // weakly not taken
        end else begin
            if (train_valid) begin
                // Training logic
                integer index;
                index = train_pc ^ train_history;
                if (train_taken) begin
                    if (PHT[index] < 2'b11)
                        PHT[index] <= PHT[index] + 1;
                end else begin
                    if (PHT[index] > 2'b00)
                        PHT[index] <= PHT[index] - 1;
                end
                
                // Update GHR
                if (train_mispredicted) 
                    GHR <= {train_history[5:0], train_taken};
                else 
                    GHR <= {GHR[5:0], train_taken};
                
            end else if (predict_valid) begin
                // Update GHR for predictions
                GHR <= {GHR[5:0], predict_taken};
            end
        end
    end

    // Prediction combinational logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_taken <= 1'b0;
            predict_history <= 7'b0;
        end else if (predict_valid) begin
            predict_history <= GHR;
            predict_taken <= (PHT[predict_pc ^ GHR] >= 2'b10) ? 1'b1 : 1'b0;
        end
    end
    
endmodule
