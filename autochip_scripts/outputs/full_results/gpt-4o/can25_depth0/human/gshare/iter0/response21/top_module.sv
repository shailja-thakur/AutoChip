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
    reg [1:0] PHT[0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] GBHR; // 7-bit global branch history register

    wire [6:0] predict_index;
    wire [6:0] train_index;

    // XOR the pc with the global history to get the index
    assign predict_index = predict_pc ^ GBHR;
    assign train_index = train_pc ^ train_history;

    // Predict logic
    always @(*) begin
        if (predict_valid) begin
            predict_history = GBHR;
            predict_taken = (PHT[predict_index] >= 2'b10);
        end else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Update the GBHR for prediction 
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GBHR <= 0;
        end else if (predict_valid && !train_valid) begin
            GBHR <= {GBHR[5:0], predict_taken};
        end else if (train_valid && train_mispredicted) begin
            GBHR <= {train_history[5:0], train_taken};
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize to weakly not taken
            end
        end else if (train_valid) begin
            if (train_taken) begin
                if (PHT[train_index] < 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end
            end else begin
                if (PHT[train_index] > 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end
            end
        end
    end
endmodule
