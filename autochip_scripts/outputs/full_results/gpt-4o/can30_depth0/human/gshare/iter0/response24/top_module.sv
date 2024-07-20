module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // Local parameters
    localparam SIZE = 128;
    
    // State Variables
    reg [1:0] PHT [0:SIZE-1]; // Pattern History Table (2-bit saturating counters)
    reg [6:0] GHR;            // Global History Register
    reg [6:0] predict_pc_latched;
    
    // Indices
    wire [6:0] predict_index;
    wire [6:0] train_index;
    
    // Prediction Index Calculation
    assign predict_index = predict_pc ^ GHR;
    assign train_index = train_pc ^ train_history;
    
    // Output
    assign predict_taken = PHT[predict_index] >= 2'b10;
    assign predict_history = GHR;
    
    integer i; // For reset loop
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            GHR <= 7'b0;
            for (i = 0; i < SIZE; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize to weakly not taken
            end
        end else begin
            if (train_valid) begin
                // Train the PHT
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end

                // Update global history register based on training
                if (train_mispredicted) begin
                    GHR <= train_history;
                end else begin
                    GHR <= {GHR[5:0], train_taken};
                end
                
            end else if (predict_valid) begin
                // Update history on prediction
                GHR <= {GHR[5:0], predict_taken};
            end
        end
    end

endmodule
