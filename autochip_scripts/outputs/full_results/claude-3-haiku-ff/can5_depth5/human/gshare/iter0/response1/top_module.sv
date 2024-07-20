module gshare_predictor (
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

    // 7-bit global history register
    reg [6:0] global_history;

    // 128-entry Pattern History Table (PHT)
    reg [1:0] pht [127:0];

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            // Hash PC and global history to get PHT index
            integer index = predict_pc ^ global_history;
            // Make prediction based on PHT entry
            predict_taken = (pht[index[6:0]] >= 2'b10);
            predict_history = global_history;
        end else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (integer i = 0; i < 128; i++) begin
                pht[i] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                // Hash PC and global history to get PHT index
                integer index = train_pc ^ train_history;

                // Update PHT entry based on actual branch outcome
                if (train_taken) begin
                    pht[index[6:0]] <= (pht[index[6:0]] == 2'b11) ? 2'b11 : pht[index[6:0]] + 1'b1;
                end else begin
                    pht[index[6:0]] <= (pht[index[6:0]] == 2'b00) ? 2'b00 : pht[index[6:0]] - 1'b1;
                end

                // Update global history register
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
        end
    end
endmodule
