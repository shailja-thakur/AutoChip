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

    // Saturating counter states
    localparam ST = 2'b11; // Strongly Taken
    localparam WT = 2'b10; // Weakly Taken
    localparam WN = 2'b01; // Weakly Not taken
    localparam SN = 2'b00; // Strongly Not taken

    // Global Branch History Register
    reg [6:0] g_history;

    // Pattern History Table (128-entry table of 2-bit counters)
    reg [1:0] pht [0:127];

    // PC XOR Global History to form the index
    wire [6:0] pht_index;
    assign pht_index = predict_pc ^ g_history;

    // Predict Branch Direction based on PHT value
    always @(*) begin
        if (predict_valid) begin
            predict_history = g_history;
            case (pht[pht_index])
                ST, WT: predict_taken = 1'b1; // predict taken
                WN, SN: predict_taken = 1'b0; // predict not taken
            endcase
        end
    end

    // Update logic for branch history and PHT
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            g_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= WN; // Initialize to weakly not taken
            end
        end else begin
            // Train the PHT
            if (train_valid) begin
                case (pht[train_pc ^ train_history])
                    ST: if (!train_taken) pht[train_pc ^ train_history] <= WT;
                    WT: pht[train_pc ^ train_history] <= train_taken ? ST : WN;
                    WN: pht[train_pc ^ train_history] <= train_taken ? WT : SN;
                    SN: if (train_taken) pht[train_pc ^ train_history] <= WN;
                endcase

                // Update or recover global branch history
                if (train_mispredicted) begin
                    g_history <= {train_history[5:0], train_taken};
                end else begin
                    g_history <= {g_history[5:0], predict_taken};
                end
            end else if (predict_valid) begin
                g_history <= {g_history[5:0], predict_taken};
            end
        end
    end
endmodule
