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

    // PHT: Pattern History Table, 128 entries of 2-bit saturating counters
    reg [1:0] PHT [0:127];

    // 7-bit Global History Register
    reg [6:0] GHR;

    wire [6:0] predict_index;
    wire [6:0] train_index;

    // Hash function using xor
    assign predict_index = predict_pc ^ GHR;
    assign train_index = train_pc ^ train_history;

    integer i;

    // Initial reset of PHT and GHR
    always @(posedge areset or posedge clk) begin
        if(areset) begin
            GHR <= 7'b0;
            for(i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly Not Taken (01)
            end
        end else begin
            // Prediction updates GHR (on next positive clock edge)
            if(predict_valid && !train_valid) begin
                GHR <= {GHR[5:0], predict_taken};
            end
            // Training updates PHT (on next positive clock edge)
            if(train_valid) begin
                // Update PHT
                if(train_taken) begin
                    if(PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if(PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end

                // Recover GHR to state after the mispredicting branch
                if(train_mispredicted) begin
                    GHR <= {train_history[5:0], train_taken};
                end
            end        
        end
    end

    // Combinational logic for the prediction
    always @(*) begin
        if (predict_valid) begin
            case (PHT[predict_index])
                2'b00: predict_taken = 0;
                2'b01: predict_taken = 0;
                2'b10: predict_taken = 1;
                2'b11: predict_taken = 1;
                default: predict_taken = 0;
            endcase
        end else begin
            predict_taken = 0;
        end

        predict_history = GHR;
    end

endmodule
