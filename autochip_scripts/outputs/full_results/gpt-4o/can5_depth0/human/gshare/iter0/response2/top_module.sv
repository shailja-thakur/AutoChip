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
    
    reg [1:0] PHT[127:0];  // 128-entry table of two-bit saturating counters
    reg [6:0] GHR;         // 7-bit global branch history register
    
    wire [6:0] predict_index;
    wire [6:0] train_index;
    
    assign predict_index = predict_pc ^ GHR;
    assign train_index = train_pc ^ train_history;
    
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b10;  // Initialize to weakly taken (assuming 2'b10 represents weakly taken)
            end
        end else begin
            if (train_valid) begin
                // Update branch history register if mispredicted
                if (train_mispredicted) begin
                    GHR <= {GHR[5:0], train_taken};
                end else if (!predict_valid) begin  // Ensure no conflict with prediction update
                    GHR <= {GHR[5:0], train_taken};
                end
                
                // Update the PHT entry
                case (PHT[train_index])
                    2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00;
                    2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00;
                    2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01;
                    2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10;
                endcase
            end else if (predict_valid) begin
                // Update global history register only if no training happens to avoid conflict
                GHR <= {GHR[5:0], PHT[predict_index][1]};
            end
        end
    end

    always @(*) begin
        if (predict_valid) begin
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken = 0;  // Predict not taken
                2'b10, 2'b11: predict_taken = 1;  // Predict taken
            endcase
            predict_history = GHR;
        end else begin
            predict_taken = 0;
            predict_history = 7'b0;
        end
    end

endmodule
