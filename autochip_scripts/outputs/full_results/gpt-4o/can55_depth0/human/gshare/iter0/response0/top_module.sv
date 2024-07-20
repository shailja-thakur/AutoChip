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

    reg [1:0] PHT [0:127]; // Pattern History Table with 128 entries of 2-bit saturating counters
    reg [6:0] GBR; // Global Branch History Register
    
    wire [6:0] predict_index;
    wire [6:0] train_index;
    wire [1:0] predict_pht_entry;
    reg [1:0] train_pht_entry;
    
    // Calculate indices by XORing PC and the global history or provided history
    assign predict_index = predict_pc ^ GBR;
    assign train_index = train_pc ^ train_history;
    
    // Get the PHT entry for prediction
    assign predict_pht_entry = PHT[predict_index];
    
    always @(*) begin
        case (predict_pht_entry)
            2'b00, 2'b01: predict_taken = 0; // Taken if state is 2 or 3
            2'b10, 2'b11: predict_taken = 1; // Not taken if state is 0 or 1
        endcase
        predict_history = GBR; // Output the current state of the global branch history register
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GBR <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize PHT to weakly not taken state (arbitrary choice)
            end
        end
        else begin
            if (train_valid) begin
                // Update the PHT entry for training
                train_pht_entry = PHT[train_index];
                if (train_taken) begin
                    if (train_pht_entry != 2'b11) train_pht_entry <= train_pht_entry + 1; // Strongly taken state
                end
                else begin
                    if (train_pht_entry != 2'b00) train_pht_entry <= train_pht_entry - 1; // Strongly not taken state
                end
                PHT[train_index] <= train_pht_entry;
                
                // Update GBR based on training
                if (train_mispredicted) GBR <= {train_history[5:0], train_taken};
            end
            else if (predict_valid) begin
                // Update GBR for next prediction. If training takes precedence, this part is ignored.
                GBR <= {GBR[5:0], predict_taken};
            end
        end
    end

endmodule
