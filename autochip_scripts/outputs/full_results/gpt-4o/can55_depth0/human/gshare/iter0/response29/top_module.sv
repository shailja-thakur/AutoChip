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
    // 128-entry pattern history table with 2-bit saturating counters
    reg [1:0] pht[127:0];
    // 7-bit global history register
    reg [6:0] bhr;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the BHR and the PHT
            bhr <= 7'd0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01; // Weakly not taken
            end
        end else begin
            if (train_valid) begin
                // Update the PHT entry
                integer index = train_pc ^ train_history;
                if (train_taken) begin
                    if (pht[index] < 2'b11) pht[index] <= pht[index] + 1;
                end else begin
                    if (pht[index] > 2'b00) pht[index] <= pht[index] - 1;
                end

                // Update the BHR if the branch was mispredicted
                if (train_mispredicted) begin
                    bhr <= {bhr[5:0], train_taken};
                end
            end

            // Update the BHR for the predicted branch
            if (predict_valid && !train_valid) begin
                bhr <= {bhr[5:0], predict_taken};
            end
        end
    end

    // Predict branch direction based on PHT entry
    always @(*) begin
        if (predict_valid) begin
            integer index = predict_pc ^ bhr;
            predict_taken = (pht[index] >= 2'b10);
            predict_history = bhr;
        end else begin
            predict_taken = 1'b0;
            predict_history = bhr;
        end
    end

endmodule
