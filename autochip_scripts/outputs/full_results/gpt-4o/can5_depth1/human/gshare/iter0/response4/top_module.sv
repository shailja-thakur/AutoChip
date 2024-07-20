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

    reg [1:0] PHT [127:0]; // 128-entry table of two-bit saturating counters
    reg [6:0] GHR; // Global History Register

    wire [6:0] predict_index = predict_pc ^ GHR;
    wire [6:0] train_index = train_pc ^ train_history;

    wire [1:0] predict_counter;
    assign predict_counter = PHT[predict_index];

    wire [1:0] train_counter;
    assign train_counter = PHT[train_index];

    // Predict logic
    always @(*)
    begin
        if (predict_valid)
        begin
            predict_taken = (predict_counter[1] == 1);
            predict_history = GHR;
        end
    end

    // Train logic
    always @(posedge clk or posedge areset)
    begin
        if (areset)
        begin
            GHR <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01; // Initialize to weakly not taken
        end
        else
        begin
            if (train_valid) // Update PHT based on actual outcome
            begin
                if (train_taken)
                begin
                    PHT[train_index] <= (train_counter != 2'b11) ? train_counter + 1 : train_counter;
                end
                else
                begin
                    PHT[train_index] <= (train_counter != 2'b00) ? train_counter - 1 : train_counter;
                end
            end

            if (train_valid && train_mispredicted) // Recover GHR if misprediction
            begin
                GHR <= {GHR[5:0], train_taken};
            end
            else if (predict_valid) // Update GHR for prediction
            begin
                GHR <= {GHR[5:0], predict_taken};
            end
        end
    end
endmodule
